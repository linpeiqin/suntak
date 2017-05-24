(function(oz, pluginName) {
	var $ = oz.query;

	var plugin = oz[pluginName] = function(element, options) {

		/**
		 * 默认
		 */
		plugin.defaults = {
			foo : 'bar',
			onFoo : function() {
			}
		}

		var seft = this;

		seft.settings = {}

		var $element = $(element), element = element;

		seft.init = function() {
			seft.settings = $.extend({}, plugin.defaults, options);
		}

		seft.show = function() {
			showmessage();
		}

		var showmessage = function() {
			alert(1);
		}
		seft.init();
	}


	$.fn[pluginName] = function(options) {
		return this.each(function() {
			if (undefined == $(this).data(pluginName)) {
				var plugin = new $[pluginName](this, options);
				$(this).data(pluginName, plugin);
			}
		});
	}
})(oz, "datagrid");