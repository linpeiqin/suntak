(function($) {
	$.fn.oTabs = function(options) {
		// 默认配置
		var settings = {
			current : 0,
			nav : '.ui-tab-trigger li',
			nav_box : '.ui-tab-container>div',
			selectedClass : 'current',
			hoverClass : 'hover',
			lazy:true
		};
		
		var self = this;

		// 主函数
		var init = function() {
			var triggers = self.find(settings.nav);
			var views = self.find(settings.nav_box);
			self.current = settings.current;

			var view = views.eq(self.current).addClass(settings.selectedClass);
			var trigger = triggers.eq(self.current).addClass(settings.selectedClass);
			self.trigger("select", [ self.current ,trigger,view]);

			function selectTab(index) {
				if (index == self.current) {
					return;
				}
				if (self.trigger("beforeSelect", [ index ]) === false) {
					return;
				}
				var ct = self.find(".ui-tab-container");
				// 记录滚动位置
				triggers.eq(self.current).removeClass(settings.selectedClass);
				views.eq(self.current).removeClass(settings.selectedClass).data("scrollTop", ct.scrollTop());

				var trigger = triggers.eq(index).addClass(settings.selectedClass);
				var view = views.eq(index).addClass(settings.selectedClass);
				// 还原滚动位置
				var navTabScrollTop = view.data("scrollTop");
				if (navTabScrollTop) {
					ct.scrollTop(navTabScrollTop);
				}
				self.current = index;
				self.trigger("select", [ index , trigger ,view ]);
			}

			triggers.click(function() {
				var index = triggers.index(this);
				selectTab(index);
			}).hover(function() {
				// 鼠标移入
				$(this).addClass(settings.hoverClass);
				$(this).siblings().removeClass(settings.hoverClass);
			}, function() {
			});
		}
		
		if (options) {
			$.extend(settings, options);
		}
		if(settings.lazy === true){
			$(init);
		}else{
			init();
		}
		return this;
	};
})(jQuery);