//Gird
(function($) {
	OZ.widget("OZ.Scroller", {
		$type: "scroller",
		options: {
			url:null,
			data:null,
			page:0
		},
		_render: function(){
			var scroller = this,
				box = this.element,
				width = box.width(),
				height = box.height(),
				scrollWidth = this.dom.scrollWidth,
				scrollHeight = this.dom.scrollHeight,
				scrollBarWidth = OZ.getScrollBarWidth(),
				boxWrap = this.element.wrap(("<div><div/></div>")).parent(),
				container = boxWrap.parent();
				
			this.container = container;
			
//			container
//				.addClass(box.attr('class'))
//				.attr('style', box.attr('style') || '')
//				.attr('title', box.attr('title') || '');
			
			//设置容器为实际对象的高和宽
			container.width(width).height(height);
			boxWrap.width(width).height(height);
			
			box
				.css("overflow","hidden")
				.css("width",scrollWidth)
				.css("height",scrollHeight)
				.css("borderWidth",0);
			
			boxWrap
				.addClass("oz-panel-body");


			//垂直滚动条
			var vb = $("<div class='oz-scroller-vertical oz-docked x-docked-right'><div class='oz-stretcher'>\u00A0</div></div>")
					.hide()
					.width(scrollBarWidth)
					.height(0)
					.insertAfter(boxWrap);
			
			//水平滚动条
			var hb = $("<div class='oz-scroller-horizontal oz-docked x-docked-bottom'><div class='oz-stretcher'>\u00A0</div></div>")
					.hide()
					.height(scrollBarWidth)
					.width(0)
					.insertAfter(boxWrap);
			
			//设置滚动条位置
			vb.css({
				top: container.offset().top,
				left: container.offset().left + container.outerWidth() - scrollBarWidth
			});
			
			hb.css({
				top: container.offset().top + container.outerHeight() - scrollBarWidth,
				left: container.offset().left
			});
			
			var oldScroll = -99999;
			
			var doScroll = function(event){
				
			};
			
			
			var didScroll = false;
			
			vb.scroll(function(event){
				if (!didScroll) {
					didScroll = true;
					var b = this;
					window.setTimeout(function() {
						scroller._trigger("bodyscroll",event);
						boxWrap.scrollTop(b.scrollTop);
						didScroll = false;
					}, 10);
				}
			});
			hb.scroll(function(event){
				if (!didScroll) {
					didScroll = true;
					var b = this;
					window.setTimeout(function() {
						scroller._trigger("bodyscroll",event);
						boxWrap.scrollLeft(b.scrollLeft);
						didScroll = false;
					}, 10);
				}
			});
			
			box.mousewheel(function(event,delta, deltaX, deltaY){
				var old = vb.scrollTop();
				vb.scrollTop(vb.scrollTop() - delta * 20);
				if(delta > 0){
					return old === 0;
				}else{
					return vb.scrollTop() == old;
				}
			});
			
			if(scrollWidth > width){
				boxWrap.width(width-scrollBarWidth);
				boxWrap.addClass("oz-vertical-scroller-present");
				vb.find(".oz-stretcher").height(scrollHeight);
				vb.show();
			}else{
				boxWrap.removeClass("oz-vertical-scroller-present");
				boxWrap.width(width);
				vb.hide();
			}
			
			if(scrollHeight > height){
				boxWrap.height(height-scrollBarWidth);
				boxWrap.addClass("oz-horizontal-scroller-present");
				hb.find(".oz-stretcher").width(scrollWidth);
				hb.show();
			}else{
				boxWrap.removeClass("oz-horizontal-scroller-present");
				boxWrap.height(height);
				hb.hide();
			}
			
			hb.width(boxWrap.width());
			vb.height(boxWrap.height());
		},
		invalidate:function(){
			var width = box.width(),
			height = box.height(),
			scrollWidth = this.dom.scrollWidth,
			scrollHeight = this.dom.scrollHeight;
		},
		getViewSize:function(){
			
		},
		destroy: function(){
			this.element.width(this.container.width());
			this.element.height(this.container.height());
			this.container.find(".oz-docked").remove();
			this.element.unwrap().unwrap();
			return this.base();
		}
	});
})(jQuery);