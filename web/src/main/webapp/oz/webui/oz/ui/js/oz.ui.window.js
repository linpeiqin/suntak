(function($) {
OZ.widget("OZ.window.Window",OZ.panel.Panel,{
	$type: "window",
	baseCls:"oz-window",
	statics: {
		zIndex: 9000
	},
	options: {
		draggable: true,
		resizable: true,
		shadow: true,
		modal: false,
		title: 'New Window',
		collapsible: true,
		minimizable: true,
		maximizable: true,
		closable: true,
		closed: false,
		border: false,
		doSize: true,	
		headerCls: 'oz-window-header',
		bodyCls: 'oz-window-body'
	},
	_render:function(){
		this.base();
		this.el.removeClass(this.baseCls);
		this.panel.addClass("oz-window");
		var opts = this.options,self = this;
		if (opts.modal === true){
			var maskDiv = '<div class="oz-window-mask"></div>';
			if($.browser.msie){
				maskDiv = '<iframe border=0 class="oz-window-iframe-mask"></iframe>'+maskDiv;
			}
			this.mask = $(maskDiv).appendTo('body');
			this.mask.css({
				'z-index': OZ.window.Window.zIndex++,
				display:'none',
				width: this.getPageArea().width,
				height: this.getPageArea().height
			});
		}else{
			this.mask = $([]);
		}
		
		if (opts.shadow === true){
			this.shadow = $('<div class="oz-window-shadow"></div>').insertAfter(this.panel);
			this.shadow.css({
				'z-index': OZ.window.Window.zIndex++,
				display:'none'
			});
		}else{
			this.shadow = $([]);
		}

		var events = {"close":function(){
			self.mask.hide();
			self.shadow.hide();
		},"resize":function(){
			self.shadow.css({
				left: self.options.left,
				top: self.options.top,
				width: self.panel.outerWidth(),
				height: self.panel.outerHeight()
			});
		},"move":function(){
			self.shadow.css({
				left: self.options.left,
				top: self.options.top
			});
		},"open":function(){
			self.mask.show();
			self.shadow.css({
				display:'block',
				left: self.options.left,
				top: self.options.top,
				width: self.panel.outerWidth(),
				height: self.panel.outerHeight()
			});
		},"beforedestroy":function(){
			self.mask.remove();
			self.shadow.remove();
		},"minimize":function(){
			self.mask.hide();
			self.shadow.hide();
		},"collapse":function(){
			self.shadow.hide();
		},"expand":function(){
			self.shadow.show();
		}};
		
		var newEvents = {};
		$.each(events,function(key,v){
			newEvents[self.$type + key+"."+self.$type] = v;
		});

		this.element.bind(newEvents);
		this.panel.css('z-index', OZ.window.Window.zIndex++);
	},
	_init:function(){
		var opts = this.options,self = this;
		this.base();
		if(this.options.resizable && OZ.resizable){
			this.fit = false;
			this.panel.resizable({zIndex:OZ.window.Window.zIndex++,helper:"oz-window-proxy","resizeEnd":function(e,data){
				var size = data.size;
				self.resize(size);
			}});
		}
		if(this.options.draggable && OZ.Draggable){
			this.header.find(".oz-panel-title").css("cursor", "move");
			this.panel.draggable({
				handle:">.oz-panel-header",
				"start":function(e){
					self.shadow.hide();
					self.body.append("<div class='oz-window-body-mask'></div>"); 
					if (opts.modal !== true){
						self.panel.css('z-index', OZ.window.Window.zIndex++);
					}
				},
				"stop":function(e,data){
					var position = data.position;
					self.move(position.left,position.top);
					self.shadow.show();
					self.body.find(".oz-window-body-mask").remove();
				}
			});
		}
		if (opts.left == null){
			var width = opts.width;
			if (isNaN(width)){
				width = this.panel.outerWidth();
			}
			opts.left = ($(window).width() - width) / 2 + $(document).scrollLeft();
		}
		if (opts.top == null){
			var height = opts.height;
			if (isNaN(height)){
				height = this.panel.outerHeight();
			}
			opts.top = ($(window).height() - height) / 2 + $(document).scrollTop();
		}
		this.move();
		if (opts.closed === false){
			this.open();
			this.shadow.show();
			this.mask.show();
		}
		$(window).resize(function(){
			$('.oz-window-mask').css({
				width: $(window).width(),
				height: $(window).height()
			});
			setTimeout(function(){
				$('.oz-window-mask').css({
					width: self.getPageArea().width,
					height: self.getPageArea().height
				});
			}, 50);
		});
	},
	getPageArea :function () {
		if (document.compatMode == 'BackCompat') {
			return {
				width: Math.max(document.body.scrollWidth, document.body.clientWidth),
				height: Math.max(document.body.scrollHeight, document.body.clientHeight)
			};
		} else {
			return {
				width: Math.max(document.documentElement.scrollWidth, document.documentElement.clientWidth),
				height: Math.max(document.documentElement.scrollHeight, document.documentElement.clientHeight)
			};
		}
	},
	window:function(){
		return this.panel;
	}
});
})(jQuery);
