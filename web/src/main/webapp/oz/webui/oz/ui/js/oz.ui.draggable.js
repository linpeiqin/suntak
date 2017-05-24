(function($) {

OZ.widget("OZ.Draggable", OZ.Mouse, {
	$type: "draggable",
	eventPrefix: "drag",
	options: {
		addClasses: true,
		appendTo: "parent",
		axis: false,
		cursor: "auto",
		handle: false,
		helper: "original",
		iframeFix: false,
		opacity: false,
		revert: false,
		revertDuration: 500,
		scroll: true,
		scrollSensitivity: 20,
		scrollSpeed: 20,
		stack: false,
		zIndex: false
	},
	_render: function() {

		if (this.options.helper == 'original' && !(/^(?:r|a|f)/).test(this.element.css("position"))){
			this.element[0].style.position = 'relative';
		}
		(this.options.addClasses && this.element.addClass("ui-draggable"));
		(this.options.disabled && this.element.addClass("ui-draggable-disabled"));

		this._mouseInit();

	},

	destroy: function() {
		if(!this.element.data('widget-draggable')){
			return;
		}
		this.element
			.removeData("draggable")
			.unbind(".draggable")
			.removeClass("ui-draggable  ui-draggable-dragging  ui-draggable-disabled");
		this._mouseDestroy();

		return this;
	},

	_mouseCapture: function(event) {
		var o = this.options;

		// among others, prevent a drag on a resizable-handle
		if (this.helper || o.disabled || $(event.target).is('.ui-resizable-handle')){
			return false;
		}

		//Quit if we're not on a valid handle
		this.handle = this._getHandle(event);
		if (!this.handle){
			return false;
		}

		return true;

	},

	_mouseStart: function(event) {

		var o = this.options;

		//Create and append the visible helper
		this.helper = this._createHelper(event);

		//Cache the helper size
		this._cacheHelperProportions();

		//If ddmanager is used for droppables, set the global draggable
		if(OZ.ddmanager){
			OZ.ddmanager.current = this;
		}

		//Cache the margins of the original element
		this._cacheMargins();

		//Store the helper's css position
		this.cssPosition = this.helper.css("position");
		this.scrollParent = this.helper.scrollParent();

		//The element's absolute position on the page minus margins
		this.offset = this.positionAbs = this.element.offset();
		this.offset = {
			top: this.offset.top - this.margins.top,
			left: this.offset.left - this.margins.left
		};

		$.extend(this.offset, {
			click: { //Where the click happened, relative to the element
				left: event.pageX - this.offset.left,
				top: event.pageY - this.offset.top
			},
			parent: this._getParentOffset(),
			relative: this._getRelativeOffset() //This is a relative to absolute position minus the actual position calculation - only used for relative positioned helper
		});

		//Generate the original position
		this.originalPosition = this.position = this._generatePosition(event);
		this.originalPageX = event.pageX;
		this.originalPageY = event.pageY;

		//Trigger event + callbacks
		if(this._trigger("start", event) === false) {
			this._clear();
			return false;
		}

		//Recache the helper size
		this._cacheHelperProportions();

		//Prepare the droppable offsets
		if (OZ.ddmanager && !o.dropBehaviour){
			OZ.ddmanager.prepareOffsets(this, event);
		}

		this.helper.addClass("ui-draggable-dragging");
		this._mouseDrag(event, true); //Execute the drag once - this causes the helper not to be visible before getting its correct position
		return true;
	},

	_mouseDrag: function(event, noPropagation) {

		//Compute the helpers position
		this.position = this._generatePosition(event);
		this.positionAbs = this._convertPositionTo("absolute");

		//Call plugins and callbacks and use the resulting position if something is returned
		if (!noPropagation) {
			var ui = this._uiHash();
			if(this._trigger('drag', event, ui) === false) {
				this._mouseUp({});
				return false;
			}
			this.position = ui.position;
		}

		if(!this.options.axis || this.options.axis != "y"){
			this.helper[0].style.left = this.position.left+'px';
		}
		if(!this.options.axis || this.options.axis != "x"){
			this.helper[0].style.top = this.position.top+'px';
		}
		if(OZ.ddmanager){
			OZ.ddmanager.drag(this, event);
		}
		return false;
	},

	_mouseStop: function(event) {

		//If we are using droppables, inform the manager about the drop
		var dropped = false;
		if (OZ.ddmanager && !this.options.dropBehaviour){
			dropped = OZ.ddmanager.drop(this, event);
		}

		//if a drop comes from outside (a sortable)
		if(this.dropped) {
			dropped = this.dropped;
			this.dropped = false;
		}
		
		//if the original element is removed, don't bother to continue
		if(!this.element[0] || !this.element[0].parentNode){
			return false;
		}

		if((this.options.revert == "invalid" && !dropped) || (this.options.revert == "valid" && dropped) || this.options.revert === true || ($.isFunction(this.options.revert) && this.options.revert.call(this.element, dropped))) {
			var self = this;
			$(this.helper).animate(this.originalPosition, parseInt(this.options.revertDuration, 10), function() {
				if(self._trigger("stop", event) !== false) {
					self._clear();
				}
			});
		} else {
			if(this._trigger("stop", event) !== false) {
				this._clear();
			}
		}

		return false;
	},
	
	cancel: function() {
		
		if(this.helper.is(".ui-draggable-dragging")) {
			this._mouseUp({});
		} else {
			this._clear();
		}
		
		return this;
		
	},

	_getHandle: function(event) {

		var handle = !this.options.handle || !$(this.options.handle, this.element).length ? true : false;
		$(this.options.handle, this.element)
			.find("*")
			.andSelf()
			.each(function() {
				if(this == event.target){
					handle = true;
				}
			});

		return handle;

	},

	_createHelper: function(event) {

		var o = this.options;
		var helper = $.isFunction(o.helper) ? $(o.helper.apply(this.element[0], [event])) : (o.helper == 'clone' ? this.element.clone() : this.element);

		if(!helper.parents('body').length){
			helper.appendTo((o.appendTo == 'parent' ? this.element[0].parentNode : o.appendTo));
		}

		if(helper[0] != this.element[0] && !(/(fixed|absolute)/).test(helper.css("position"))){
			helper.css("position", "absolute");
		}

		return helper;

	},

	_getParentOffset: function() {

		//Get the offsetParent and cache its position
		this.offsetParent = this.helper.offsetParent();
		var po = this.offsetParent.offset();

		// This is a special case where we need to modify a offset calculated on start, since the following happened:
		// 1. The position of the helper is absolute, so it's position is calculated based on the next positioned parent
		// 2. The actual offset parent is a child of the scroll parent, and the scroll parent isn't the document, which means that
		// the scroll is included in the initial calculation of the offset of the parent, and never recalculated upon drag
		if(this.cssPosition == 'absolute' && this.scrollParent[0] != document && $.ui.contains(this.scrollParent[0], this.offsetParent[0])) {
			po.left += this.scrollParent.scrollLeft();
			po.top += this.scrollParent.scrollTop();
		}

		if((this.offsetParent[0] == document.body) ||//This needs to be actually done for all browsers, since pageX/pageY includes this information
			(this.offsetParent[0].tagName && this.offsetParent[0].tagName.toLowerCase() == 'html' && $.browser.msie)) //Ugly IE fix
			{
				po = { top: 0, left: 0 };
			}

		return {
			top: po.top + (parseInt(this.offsetParent.css("borderTopWidth"),10) || 0),
			left: po.left + (parseInt(this.offsetParent.css("borderLeftWidth"),10) || 0)
		};

	},

	_getRelativeOffset: function() {

		if(this.cssPosition == "relative") {
			var p = this.element.position();
			return {
				top: p.top - (parseInt(this.helper.css("top"),10) || 0) + this.scrollParent.scrollTop(),
				left: p.left - (parseInt(this.helper.css("left"),10) || 0) + this.scrollParent.scrollLeft()
			};
		} else {
			return { top: 0, left: 0 };
		}

	},

	_cacheMargins: function() {
		this.margins = {
			left: (parseInt(this.element.css("marginLeft"),10) || 0),
			top: (parseInt(this.element.css("marginTop"),10) || 0)
		};
	},

	_cacheHelperProportions: function() {
		this.helperProportions = {
			width: this.helper.outerWidth(),
			height: this.helper.outerHeight()
		};
	},
	_convertPositionTo: function(d, pos) {
		if(!pos) {
			pos = this.position;
		}
		var mod = d == "absolute" ? 1 : -1;
		var o = this.options, scroll = this.cssPosition == 'absolute' && !(this.scrollParent[0] != document && OZ.contains(this.scrollParent[0], this.offsetParent[0])) ? this.offsetParent : this.scrollParent, scrollIsRootNode = (/(html|body)/i).test(scroll[0].tagName);

		return {
			top: (
				pos.top	+ 
				this.offset.relative.top * mod	+ 
				this.offset.parent.top * mod - 
				($.browser.safari && $.browser.version < 526 && this.cssPosition == 'fixed' ? 0 : ( this.cssPosition == 'fixed' ? -this.scrollParent.scrollTop() : ( scrollIsRootNode ? 0 : scroll.scrollTop() ) ) * mod)
			),
			left: (
				pos.left + 
				this.offset.relative.left * mod	+ 
				this.offset.parent.left * mod - 
				($.browser.safari && $.browser.version < 526 && this.cssPosition == 'fixed' ? 0 : ( this.cssPosition == 'fixed' ? -this.scrollParent.scrollLeft() : scrollIsRootNode ? 0 : scroll.scrollLeft() ) * mod)
			)
		};

	},

	_generatePosition: function(event) {
		var o = this.options, scroll = this.cssPosition == 'absolute' && !(this.scrollParent[0] != document && OZ.contains(this.scrollParent[0], this.offsetParent[0])) ? this.offsetParent : this.scrollParent, scrollIsRootNode = (/(html|body)/i).test(scroll[0].tagName);
		var pageX = event.pageX;
		var pageY = event.pageY;

		return {
			top: (
				pageY - 
				this.offset.click.top - 
				this.offset.relative.top - 
				this.offset.parent.top + 
				($.browser.safari && $.browser.version < 526 && this.cssPosition == 'fixed' ? 0 : ( this.cssPosition == 'fixed' ? -this.scrollParent.scrollTop() : ( scrollIsRootNode ? 0 : scroll.scrollTop() ) ))
			),
			left: (
				pageX - // The absolute mouse position
				this.offset.click.left - 
				this.offset.relative.left - 
				this.offset.parent.left	+									// The offsetParent's offset without borders (offset + border)
				($.browser.safari && $.browser.version < 526 && this.cssPosition == 'fixed' ? 0 : ( this.cssPosition == 'fixed' ? -this.scrollParent.scrollLeft() : scrollIsRootNode ? 0 : scroll.scrollLeft() ))
			)
		};

	},

	_clear: function() {
		this.helper.removeClass("ui-draggable-dragging");
		if(this.helper[0] != this.element[0] && !this.cancelHelperRemoval){
			this.helper.remove();
		}
		//if(OZ.ddmanager) OZ.ddmanager.current = null;
		this.helper = null;
		this.cancelHelperRemoval = false;
	},

	// From now on bulk stuff - mainly helpers

	_trigger: function(type, event, ui) {
		ui = ui || this._uiHash();
		this._call(type, [event, ui]);
		if(type == "drag"){
			this.positionAbs = this._convertPositionTo("absolute"); //The absolute position has to be recalculated after plugins
		}
		return this.base(type, event, ui);
	},

	_uiHash: function(event) {
		return {
			helper: this.helper,
			position: this.position,
			originalPosition: this.originalPosition,
			offset: this.positionAbs
		};
	}

});

$.extend(OZ.Draggable, {
	version: "1.0.0"
});


OZ.Draggable.plugin("cursor", {
	start: function(event, ui) {
		var t = $('body'), o = $(this).data('widget-draggable').options;
		if(!o.cursor){
			return;
		}
		if (t.css("cursor")){
			o._cursor = t.css("cursor");
		}
		t.css("cursor", o.cursor);
	},
	stop: function(event, ui) {
		var o = $(this).data('widget-draggable').options;
		if(!o.cursor){
			return;
		}
		if (o._cursor){
			$('body').css("cursor", o._cursor);
		}
	}
});

OZ.Draggable.plugin("iframeFix", {
	start: function(event, ui) {
		var o = $(this).data('widget-draggable').options;
		$(o.iframeFix === true ? "iframe" : o.iframeFix).each(function() {
			$('<div class="ui-draggable-iframeFix" style="background: #fff;"></div>')
			.css({
				width: this.offsetWidth+"px", height: this.offsetHeight+"px",
				position: "absolute", opacity: "0.001", zIndex: 1000
			})
			.css($(this).offset())
			.appendTo("body");
		});
	},
	stop: function(event, ui) {
		$("div.ui-draggable-iframeFix").each(function() { this.parentNode.removeChild(this); }); //Remove frame helpers
	}
});

OZ.Draggable.plugin("opacity", {
	start: function(event, ui) {
		var t = $(ui.helper), o = $(this).data('widget-draggable').options;
		if(t.css("opacity")){
			o._opacity = t.css("opacity");
		}
		t.css('opacity', o.opacity);
	},
	stop: function(event, ui) {
		var o = $(this).data('widget-draggable').options;
		if(o._opacity){
			$(ui.helper).css('opacity', o._opacity);
		}
	}
});

OZ.Draggable.plugin("stack", {
	start: function(event, ui) {
		var o = $(this).data("draggable").options;
		var group = $.makeArray($(o.stack)).sort(function(a,b) {
			return (parseInt($(a).css("zIndex"),10) || 0) - (parseInt($(b).css("zIndex"),10) || 0);
		});
		if (!group.length) { return; }
		
		var min = parseInt(group[0].style.zIndex , 10) || 0;
		$(group).each(function(i) {
			this.style.zIndex = min + i;
		});

		this[0].style.zIndex = min + group.length;

	}
});

OZ.Draggable.plugin("zIndex", {
	start: function(event, ui) {
		var t = $(ui.helper), o = $(this).data("draggable").options;
		if(t.css("zIndex")){
			o._zIndex = t.css("zIndex");
		}
		t.css('zIndex', o.zIndex);
	},
	stop: function(event, ui) {
		var o = $(this).data("draggable").options;
		if(o._zIndex){
			$(ui.helper).css('zIndex', o._zIndex);
		}
	}
});


})(jQuery);
