/**
 * 首页可以使用的对象工具类
 * <p>
 * ozWindow,ozDlg,
 * </p>
 * 
 * 版本: 1.0.0 作者：dragon 2010-07-30
 */

(function() {
	var root;
	root = this;
	root.OZ = root.OZ || {};

	function subTitle(title){
		if (title.length > 6) {
			title = title.substr(0, 6) + "...";
		}
		return title;
	}
	
	root.ozWindow = {
		open : function(config) {
			// 判断是否是下载文件
			if (config.download === true) {
				window.open(config.url, config.target || '_blank');
				return;
			}
			
			config.tabTip = config.title;
			
			//标题处理
			var title = config.title || "未标题";
			config.title = subTitle(title);
			
			if (config.openWindow) { // 新窗口
				// 附加当前人员的SSO加密数据到所链接系统的url后
				config.url = ozWindow.addSSOParam(config.url);
				window.open(config.url, "_blank");
			} else { // 新页签
                var valId =  new Date().getTime();
				config.content = '<iframe class="tab_frame" id="tabFrame_' + valId + '" scrolling="auto" frameborder="0"  src="' + config.url + '" style="width:100%;height:100%;"'
						+ (config.updateTitle === true ? ' onload="ozWindow.updateTitleByIframe(this)"' : "") + '></iframe>';

				var parentId = ozWindow.getActiveId();
				if (typeof (parentId) == "string") {
					config.parentId = parentId;
				}
				$("#mainTabs").tabs("add", $.extend({
					id : valId,
					title : "(无)",
					closable : true,
					border : false
				}, config));

                /*=====================================================================================================================
                === 平台在低版本的IE浏览器（IE6）上存在一个Bug：新建Tab页时，可能显示空白页面，需要用户手工刷新一次才可以还显示。
                === 针对这种情况，使用以下的逻辑来确定IE的版本和页面是否已经正常加载，如果没有正常加载，则自动刷新一次页面。
                === add by HimuraKenShin 20111120
                 */
                var isIE = !!window.ActiveXObject;  //判断是否为IE浏览器
                var isIE6 = isIE && !window.XMLHttpRequest; //判断是否为IE6浏览器
                if(isIE){
                    if(isIE6){  //如果用户所使用的浏览器为IE6，则可能触发Bug，需要判断并重载URL
                        setTimeout("reLoadPage(" + valId +");", 2000);//为保证在低配置的电脑上不会因为页面载入过慢而出现误判断的现象，这里设置延时2秒后再进行判断
                    }
                }
			}
		},
		close : function(win) {
			if (win && win.frameElement) {
				$("#mainTabs").tabs("close", $(win.frameElement).parent());
				return;
			} 
			try {
				window.close();
			} catch (e) {
			}
		},
		closeById : function(id) {
			$("#mainTabs").tabs("close", id);
		},
		closeActive : function() {
			$("#mainTabs").tabs("closeActive");
		},
		closeOther : function() {
			$("#mainTabs").tabs("closeOther");
		},
		closeAll : function() {
			$("#mainTabs").tabs("closeAll");
		},
		reLocation : function(win,newUrl) {
			if(!win){
				OZ.Messager.into("非系统子窗口。");
				return;
			}
			if (win.frameElement) {
				$(win.frameElement).attr("src", newUrl);
			}
		},
		updateTitle : function(win, title) {
			if(!win){
				OZ.Messager.into("非系统子窗口。");
				return;
			}
			if (win.frameElement) {
				$(win.frameElement).parent().tabPanel("setTitle", subTitle(title));
			}
		},
		updateTitleByIframe : function(iframe) {
			if (iframe) {
				var title = $.trim($("title", $(iframe).contents()).text());
				if (title) {
					$(iframe).parent().tabPanel("setTitle", subTitle(title));
				}
			}
		},
		findById : function(id) {
			var tab = $("#mainTabs").tabs("findById", id);
			return tab;
		},
		getActiveId : function() {
			var tab = this.getActivePanel();
			if (tab) {
				return tab.tabPanel("option", "id");
			}
			return null;
		},
		getActivePanel : function() {
			return $("#mainTabs").tabs("getActive");
		},
		getCurrentWin : function(win){
			if(!win){
				OZ.Messager.into("非系统子窗口。");
				return null;
			}
			if (win.frameElement) {
				return $(win.frameElement).parent();
			}
			return null;
		},
		getCurrentWinId : function(win){
			if(!win){
				OZ.Messager.into("非系统子窗口。");
				return null;
			}
			var tab = this.getCurrentWin(win);
			if (tab) {
				return tab.tabPanel("option", "id");
			}
			return null;
		},
		/** 关闭页签前的处理 */
		onBeforeClose : function(e, data) {
			var close = true;
			var tab = data.tab, tabs = data.tabs;
			tab.find("iframe").each(function() {
                try{
                    // 调用额外的关闭前处理函数（注意这个函数是在iframe内定义的）
                    var fn = this.contentWindow["ozBeforeClose"] || this.contentWindow["beforeWindowClose"] || this.contentWindow["beforeClose"];
                    if (typeof fn == "function") {
                        var result = fn.call(null, data);
                        if (result === false) {
                            close = false;// 禁止关闭页签
                            return false;//返回
                        }
                    }
                }catch (e){

                }
				return false;
			});
			ozlog.debug("close=" + close);
			return close;
		},
		onClose:function(e,data){
			var tab = data.tab, tabs = data.tabs,option= tab.tabPanel("option");
			// 判断是否刷新父页签
			var refresh = option.refresh;
			if (refresh === true) {
				var parentTabId = option.parentId;
				var parentTab = tabs.findById(parentTabId);
				if (parentTab) {
					parentTab.find("iframe").each(function() {
						// 调用刷新函数刷新页签的内容
						var fn = this.contentWindow["ozRefresh"] || this.contentWindow["refreshWindow"] || this.contentWindow["refresh"];
						if (typeof fn == "function") {
							fn.call(null, option);
						} else {
							$(this).attr("src", (OZ.addTimeStamp($(this).attr("src")) || ""));
						}
						return false;
					});
				}
			}
			OZ.destroyIframe(tab);
			return true;
		},
		/** 退出系统 */
		logout : function() {
			// var strUrl = contextPath + "/logoutAction.do?ts=" + new
			// Date().getTime();
			// window.open(strUrl,"_top");
			var logoutClosePage = false;
			if (logoutClosePage) {
				window.opener = null;
				window.open("", "_self");
				window.close();
			} else {
				var strUrl = contextPath + "/logoutAction.do";
				top.location.href = strUrl;
			}
		},
		/** 附加SSO加密数据到指定的url */
		addSSOParam : function(url) {
			return OZ.addParamToUrl(url, "ozssodata=" + (window.OZ_SSO_DATA || ""));
		}
	};

	/** 对话框 */
	root.ozDlg = root.OZ.Dlg = {
		/**
		 * 创建iframe交互对话框
		 * 
		 * @param {Object}
		 *            config 对话框配置
		 * @config {String} title 对话框标题
		 * @config {String} url 对话框内容的url
		 * @config {String} html 对话框内容的html,与url参数互斥
		 * @config {Number} width 对话框宽度
		 * @config {Number} height 对话框高度
		 * @config {Boolean} modal 是否为模式对话框，默认为true
		 * @param {Function}
		 *            onOk 可选参数：回调函数，函数的第一个参数为点击确认按钮所执行函数的返回值
		 */
		create : function(config) {
			return new window.top.OZ.Dialog(config);
		},
		/**
		 * 关闭对话框
		 * 
		 * @param {String}
		 *            dlgId 可选参数：对话框ID,默认为defaultDlgId
		 */
		close : function(dlgId) {
			top.$('#' + dlgId).dialog("destroy");
		},
		/**
		 * 引发对话框按钮的点击处理事件
		 * 
		 * @param {Number}
		 *            btnIndex 按钮的索引号
		 * @param {String}
		 *            dlgId 可选参数：对话框ID,默认为defaultDlgId
		 */
		fireButtonEvent : function(btnIndex, dlgId) {
			var buttons = top.$('#' + dlgId).dialog("option", "buttons");
			if (buttons.length < btnIndex + 1) {
				top.ozlog.error("error button index:" + btnIndex);
				return false;
			}
			return buttons[btnIndex].handler.call(null, dlgId);
		}
	};
})();

function documentClick() {
	$(document).click();
}

function reLoadPage(valId){
    $('#tabFrame_' + valId).ready(
        function(){
            if (window.frames["tabFrame_" + valId].document.body.innerHTML.length == 0){
                $('#tabFrame_' + valId).attr('src', $('#tabFrame_' + valId).attr('src'));
            }
        }
    );
}