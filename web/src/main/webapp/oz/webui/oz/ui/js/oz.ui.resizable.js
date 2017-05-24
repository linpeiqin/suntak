
(function($) {
	OZ.widget("OZ.Resizable",OZ.Mouse, {
		$type: "resizable",
		options: {
			handles: "e,s,se",
			helper: false,
			maxHeight: null,
			maxWidth: null,
			minHeight: 10,
			minWidth: 10,
			zIndex: 1000
		},
		_render:function(){
			var self = this, o = this.options;
			this.element.addClass("oz-resizable");
			
			$.extend(this, {
				originalElement: this.element,
				_helper: o.helper
			});
			
			this.handles = o.handles || (!$('.oz-resizable-handle', this.element).length ? "e,s,se" : { n: '.oz-resizable-n', e: '.oz-resizable-e', s: '.oz-resizable-s', w: '.oz-resizable-w', se: '.oz-resizable-se', sw: '.oz-resizable-sw', ne: '.oz-resizable-ne', nw: '.oz-resizable-nw' });
			if(this.handles.constructor == String) {

				if(this.handles == 'all') {this.handles = 'n,e,s,w,se,sw,ne,nw';}
				var n = this.handles.split(","); this.handles = {};

				for(var i = 0; i < n.length; i++) {
					var handle = $.trim(n[i]), hname = 'oz-resizable-'+handle;
					var axis = $('<div class="oz-resizable-handle ' + hname + '"></div>');
					if(/sw|se|ne|nw/.test(handle)){ axis.css({ zIndex: ++o.zIndex });}
					if ('se' == handle) {
						//axis.addClass('oz-icon oz-icon-gripsmall-diagonal-se');
					}
					this.handles[handle] = '.oz-resizable-'+handle;
					this.element.append(axis);
				}

			}
			
			this._renderAxis = function(target) {
				target = target || this.element;
				for(var i in this.handles) {
					if(this.handles[i].constructor == String){
						this.handles[i] = $(this.handles[i], this.element).show();
					}
					if(!$(this.handles[i]).length){
						continue;
					}
				}
			};

			this._renderAxis(this.element);

			this._handles = $('.oz-resizable-handle', this.element).disableSelection();
			
			this._handles.mouseover(function() {
				if (!self.resizing) {
					var axis;
					if (this.className){
						axis = this.className.match(/oz-resizable-(se|sw|ne|nw|n|e|s|w)/i);
					}
					self.axis = axis && axis[1] ? axis[1] : 'se';
				}
			});
			
			this._mouseInit();
		},
		destroy: function() {
			this._mouseDestroy();
			var _destroy = function(exp) {
				$(exp).removeClass("oz-resizable oz-resizable-disabled oz-resizable-resizing")
					.removeData("resizable").unbind(".resizable").find('.oz-resizable-handle').remove();
			};
			this.originalElement.css('resize', this.originalResizeStyle);
			_destroy(this.originalElement);
			return this;
		},
		_mouseCapture: function(event) {
			var handle = false;
			for (var i in this.handles) {
				if ($(this.handles[i])[0] == event.target) {
					handle = true;
				}
			}
			return !this.options.disabled && handle;
		},
		_mouseStart: function(event) {
			var o = this.options, iniPos = this.element.position(), el = this.element;

			this.resizing = true;
			this.documentScroll = { top: $(document).scrollTop(), left: $(document).scrollLeft() };

			// bugfix for http://dev.jquery.com/ticket/1749
			if (el.is('.oz-draggable') || (/absolute/).test(el.css('position'))) {
				el.css({ position: 'absolute', top: iniPos.top, left: iniPos.left });
			}

			//Opera fixing relative position
			if ($.browser.opera && (/relative/).test(el.css('position'))){
				el.css({ position: 'relative', top: 'auto', left: 'auto' });
			}
			this._renderProxy();

			var curleft = num(this.helper.css('left')), curtop = num(this.helper.css('top'));

			//Store needed variables
			this.offset = this.helper.offset();
			this.position = { left: curleft, top: curtop };
			this.size = this._helper ? { width: el.outerWidth(), height: el.outerHeight() } : { width: el.width(), height: el.height() };
			this.originalSize = this._helper ? { width: el.outerWidth(), height: el.outerHeight() } : { width: el.width(), height: el.height() };
			this.originalPosition = { left: curleft, top: curtop };
			this.sizeDiff = { width: el.outerWidth() - el.width(), height: el.outerHeight() - el.height() };
			this.originalMousePosition = { left: event.pageX, top: event.pageY };

		    var cursor = $('.oz-resizable-' + this.axis).css('cursor');
		    $('body').css('cursor', cursor == 'auto' ? this.axis + '-resize' : cursor);

			el.addClass("oz-resizable-resizing");
			return true;
		},

		_mouseDrag: function(event) {
			//Increase performance, avoid regex
			var el = this.helper, o = this.options, props = {},self = this, smp = this.originalMousePosition, a = this.axis;

			var dx = (event.pageX-smp.left)||0, dy = (event.pageY-smp.top)||0;
			var trigger = this._change[a];
			if (!trigger){ return false;}
			
			// Calculate the attrs that will be change
			var data = trigger.apply(this, [event, dx, dy]), ie6 = $.browser.msie && $.browser.version < 7, csdif = this.sizeDiff;

			data = this._respectSize(data, event);
			
			el.css({
				top: this.position.top + "px", left: this.position.left + "px",
				width: this.size.width + "px", height: this.size.height + "px"
			});

			this._updateCache(data);
			
			this._trigger('resizeIng', event, this.ui());
			
			return false;
		},
		_mouseStop: function(event) {
			this.resizing = false;
			var o = this.options, self = this;

			if(this._helper) {
				var	soffseth = self.sizeDiff.height,soffsetw = self.sizeDiff.width;

				var s = { width: (self.size.width - soffsetw), height: (self.size.height - soffseth) },
					left = (parseInt(self.element.css('left'), 10) + (self.position.left - self.originalPosition.left)) || null,
					top = (parseInt(self.element.css('top'), 10) + (self.position.top - self.originalPosition.top)) || null;

				this.element.css($.extend(s, { top: top, left: left }));
				
				self.helper.height(self.size.height);
				self.helper.width(self.size.width);
			}

			$('body').css('cursor', 'auto');

			this.element.removeClass("oz-resizable-resizing");
			
			if (this._helper){ this.helper.remove();}
			
			this._trigger('resizeEnd', event, this.ui());
			
			return false;
		},

		_updateCache: function(data) {
			var o = this.options;
			this.offset = this.helper.offset();
			if (isNumber(data.left)){ this.position.left = data.left;}
			if (isNumber(data.top)){ this.position.top = data.top;}
			if (isNumber(data.height)) {this.size.height = data.height;}
			if (isNumber(data.width)){ this.size.width = data.width;}
		},

		_respectSize: function(data, event) {

			var el = this.helper, o = this.options, a = this.axis,
					ismaxw = isNumber(data.width) && o.maxWidth && (o.maxWidth < data.width), ismaxh = isNumber(data.height) && o.maxHeight && (o.maxHeight < data.height),
						isminw = isNumber(data.width) && o.minWidth && (o.minWidth > data.width), isminh = isNumber(data.height) && o.minHeight && (o.minHeight > data.height);

			if (isminw){ data.width = o.minWidth;}
			if (isminh){ data.height = o.minHeight;}
			if (ismaxw){ data.width = o.maxWidth;}
			if (ismaxh){ data.height = o.maxHeight;}

			var dw = this.originalPosition.left + this.originalSize.width, dh = this.position.top + this.size.height;
			var cw = /sw|nw|w/.test(a), ch = /nw|ne|n/.test(a);

			if (isminw && cw){ data.left = dw - o.minWidth;}
			if (ismaxw && cw){ data.left = dw - o.maxWidth;}
			if (isminh && ch){ data.top = dh - o.minHeight;}
			if (ismaxh && ch){ data.top = dh - o.maxHeight;}

			// fixing jump error on top/left - bug #2330
			var isNotwh = !data.width && !data.height;
			if (isNotwh && !data.left && data.top){
				data.top = null;
			}else if (isNotwh && !data.top && data.left){
				data.left = null;
			}
			return data;
		},
		_renderProxy: function() {
			var el = this.element, o = this.options;
			this.elementOffset = el.offset();
			if(this._helper) {

				this.helper = this.helper || $('<div style="overflow:hidden;"></div>');

				// fix ie6 offset TODO: This seems broken
				var ie6 = $.browser.msie && $.browser.version < 7, ie6offset = (ie6 ? 1 : 0),
				pxyoffset = ( ie6 ? 2 : -1 );

				this.helper.addClass(this._helper).css({
					width: this.element.outerWidth() + pxyoffset,
					height: this.element.outerHeight() + pxyoffset,
					position: 'absolute',
					left: this.elementOffset.left - ie6offset +'px',
					top: this.elementOffset.top - ie6offset +'px',
					zIndex: ++o.zIndex
				});

				this.helper
					.appendTo("body")
					.disableSelection();

			} else {
				this.helper = this.element;
			}
		},
		_change: {
			e: function(event, dx, dy) {
				return { width: this.originalSize.width + dx };
			},
			w: function(event, dx, dy) {
				var o = this.options, cs = this.originalSize, sp = this.originalPosition;
				return { left: sp.left + dx, width: cs.width - dx };
			},
			n: function(event, dx, dy) {
				var o = this.options, cs = this.originalSize, sp = this.originalPosition;
				return { top: sp.top + dy, height: cs.height - dy };
			},
			s: function(event, dx, dy) {
				return { height: this.originalSize.height + dy };
			},
			se: function(event, dx, dy) {
				return $.extend(this._change.s.apply(this, arguments), this._change.e.apply(this, [event, dx, dy]));
			},
			sw: function(event, dx, dy) {
				return $.extend(this._change.s.apply(this, arguments), this._change.w.apply(this, [event, dx, dy]));
			},
			ne: function(event, dx, dy) {
				return $.extend(this._change.n.apply(this, arguments), this._change.e.apply(this, [event, dx, dy]));
			},
			nw: function(event, dx, dy) {
				return $.extend(this._change.n.apply(this, arguments), this._change.w.apply(this, [event, dx, dy]));
			}
		},
		ui: function() {
			return {
				originalElement: this.originalElement,
				element: this.element,
				helper: this.helper,
				position: this.position,
				size: this.size,
				originalSize: this.originalSize,
				originalPosition: this.originalPosition
			};
		}
	});
	var num = function(v) {
		return parseInt(v, 10) || 0;
	};

	var isNumber = function(value) {
		return !isNaN(parseInt(value, 10));
	};
})(jQuery);
