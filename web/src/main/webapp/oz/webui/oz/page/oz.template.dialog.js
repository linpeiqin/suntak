(function() {
	var root, ozWindow;

	root = this;

	root.isDialog = true;

	if (root != top) {
		// ozWindow的托管
		root.ozWindow = root.ozWindow || {};

		$.extend(root.ozWindow, {
			getId : function() {
				var tab = this.getCurrent();
				if (tab) {
					return tab.parent().dialog("option", "id");
				}
				return null;
			},
			/**
			 * 获取窗口的参数信息
			 */
			option : function(name, value) {
				var tab = this.getCurrent();
				if (tab) {
					if (value) {
						tab.parent().dialog("option", name, value);
						return tab;
					}
					return tab.parent().dialog("option", name);
				}
				return null;
			},
			/**
			 * 获取窗口的参数信息
			 */
			getEl : function() {
				var tab = this.getCurrent();
				if (tab) {
					return tab.parent().dialog("getEl");
				}
				return null;
			}
		});
	}
})();