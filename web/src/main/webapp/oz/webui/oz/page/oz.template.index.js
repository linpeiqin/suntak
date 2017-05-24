(function(){
	oz.page = oz.page || {};
	oz.page.index = {
		pageMaxWidth : "auto",
		init : function() {
			this.setMaxWidth(window.indexMaxWidth);

			this.setProcess("0%");

			// 布局
			$("#mainPage").layout();
			this.setProcess("5%");

			// 调整布局
			this.resize();

			// 加载主页面
			this.initAppTab();

			this.setProcess("40%");

			// 加载导航权限
			this.initNavTree();

			// 初始化右键菜单
			this.initAppTabMenu();

			this.setProcess("80%");

			// 初始化切换用户操作
			this.initSwitchUser();

			// 初始化Tab的辅助操作
			this.initAppTabHelper();

			// 定义窗口调整方法
			$(window).resize(this.resize);

			this.setProcess("100%");

			$("#loadingCover").fadeOut(1500);
			
			// 打开初始的页面
			this.openInitTab();
			
		},
		
		setProcess : function(width) {
			$("#loadingBar").width(width);
			$("#loadingTips").text(width);
		},
		
		/**
		 * 调整页签中的内容区域大小
		 */
		resize : function() {
			$("#mainPage").layout("resize");
		},
		
		setMaxWidth : function(width) {
			$("#mainPage").css("maxWidth", width || this.pageMaxWidth);
		},
		
		_urlProcess :function(href,config){
			if(!href || href=="_blank"){
				return null;
			}
			if(href.charAt(0) == "^"){
				return href.substring(1,href.lenght);
			}
			if(/^\/\//ig.test(href)){
				return href.substring(1,href.lenght);
			}
			if(href.charAt(0) == "/"){
				return contextPath + href;
			}
			if((href.indexOf("http") === 0  && href.indexOf("self=false") != -1)){
				config.openWindow = true;
			}
			return href;
		},
		
		/**
		 * 加载功能导航树
		 */
		initNavTree : function(options) {
			var self = this;
			var defaults = {
				animate:true,accordion:true,
				url : contextPath + '/security/permissionAction.do?action=getPermissionTree4Nav&timeStamp=' + new Date().getTime(),
				click : function(e, data) {
					var url = self._urlProcess(data.href,data);
					if (url) {
						self.pos = false;
						ozWindow.open({
							id : data.code,
							title : data.text,
							url : url,
							permissionId : data.id,
							openWindow:data.openWindow
						});
						self.pos = true;
					} else if (data.fn) {
						$("#mainTabs").tabs(data.fn);
					} else {
						$("#permissionTree").tree("toggle", $(data.target));
					}
				},
				dblclick : function(e, data) {
					$("#permissionTree").tree("toggle", $(data.target));
				},
				beforeselected : function(e, data) {
					if (!$("#permissionTree").tree("isLeaf", data.target)) {
						return false;
					}
				},
				onLoadSuccess : function(){
					self.openInitTab(true);
				}
			};
			var permissionConfig = $.extend({},defaults,options)
			$('#permissionTree').tree(permissionConfig);
		},
		
		initAppTab : function() {
			var self = this;
			this.contextTabMenu = function(e, data) {
				var targetTab = $("#mainTabs").tabs("findById", data.tab);
				if (targetTab.tabPanel("option", "closable") === true) {
					self.menu.find(".closeMenu").removeClass("disabled");
				} else {
					self.menu.find(".closeMenu").addClass("disabled");
				}
				
				var pos = {
					left : data.x,
					top : data.y
				};				
				var ppos = self.menu.parent().offset();
				pos.top -= ppos.top;
				pos.left -= ppos.left;
				self.menu.data("targetTab", targetTab).css(pos).show().focus();
			};
			
			var tabsConfig = {
				active : function(e, data) {
					var id = (data.tab.tabPanel("option", "permissionId"));
					if (typeof id == "string") {
						var tree = $("#permissionTree");
						if(tree.size()>0){
							var node = tree.find("div.oz-tree-node[node-id=" + id + "]");
							tree.tree("selectNode", node,true);
							if (self.pos && $(node).length){
								var p = ($(node).offset().top - tree.offset().top);
								tree.parent().parent().scrollTop(p);
							}
						}
					}
				},
				beforeclose : ozWindow.onBeforeClose,
				close : ozWindow.onClose,
				contextbmenu : this.contextTabMenu,
				tabWidth : 0
			};
			$("#mainTabs").tabs(tabsConfig);
		},
		
		firstPage : {
			id: "firstPage",
			title : "个人应用",
			iconCls:"oz-icon-firstTab",
			url : contextPath + "/module/portalAction.do?action=homePage&timeStamp=" + new Date().getTime()
		},
		
		openInitTab : function(foce) {
			var self = this;
			if(self.tabInit){
				return;
			}
			
			if(!foce && window._tabs && _tabs!=""){
				return;
			}
			
			/* 加载首页 */
			var openTabs = [];
			openTabs.push({
				closable : false,
				fit : true,
				border : false,
				id : this.firstPage.id,
				title : this.firstPage.title,
				iconCls : this.firstPage.iconCls,
				content : '<iframe scrolling="auto" frameborder="0" src="' + this.firstPage.url + '" style="width:100%;height:100%;"></iframe>'
			});
			
			if (_redirectUrl != "" && _redirectUrl != "null") {
				openTabs.push({
					closable : true,
					fit : true,
					border : false,
					id : "2ndPage",
					title : "新窗口",
					content : '<iframe scrolling="auto" frameborder="0" src="' + _redirectUrl + '" style="width:100%;height:100%;"  onload="ozWindow.updateTitleByIframe(this)"></iframe>'
				});
			}
			
			if(window._tabs && _tabs!=""){
				var tree = $("#permissionTree");
				var nodes = tree.find("div.oz-tree-node");
				nodes.each(function(){
					var data = $.data(this, 'tree-node');
					var tabs = _tabs.split("$$");
					$.each(tabs,function(){
						if(data && data.href && data.code == this){
							openTabs.push({
								closable : true,
								fit : true,
								border : false,
								id : data.code,
								title : data.text,
								permissionId : data.id,
								content : '<iframe scrolling="auto" frameborder="0" src="' +((data.href.indexOf("/") == 0) ? contextPath + data.href : data.href) + '" style="width:100%;height:100%;"></iframe>'
							});
						}
					});
				})
			}
			if(window._urls && _urls!=""){
				var urls = _urls.split("$$");
				var tiles = _titles.split("$$");
				$.each(urls,function(index){
					var urlCfg = this.split("||");
					var url = urlCfg[0];
					var tabTitile = urlCfg[1]||tiles[0];
					var tabId = (urlCfg[2]||"INIT_TABS")+index;
					openTabs.push({
						closable : true,
						fit : true,
						border : false,
						id : tabId||"INIT_TABS",
						title : tabTitile||"新窗口",
						content : '<iframe scrolling="auto" frameborder="0" src="' 	+((url.indexOf("/") == 0) ? contextPath + url : url) + '" style="width:100%;height:100%;" '	+(tabTitile?'':' onload="ozWindow.updateTitleByIframe(this)"')+'></iframe>'
					});
				})
			}
			$("#mainTabs").tabs("add", openTabs);
			this.tabInit  = true;
		},
		
		/* 多页签的右键菜单 */
		initAppTabMenu : function() {
			var menu = this.menu = $("#menu");

			$(document).click(function() {
				$("#menu").hide();
			});

			// Hover events
			menu.find('A').mouseover(function() {
				menu.find('LI.hover').removeClass('hover');
				$(this).parent().addClass('hover');
			}).mouseout(function() {
				menu.find('LI.hover').removeClass('hover');
			});

			// When items are selected
			menu.find('A').unbind('click');
			menu.find('A').click(function() {
				if ($(this).parent().hasClass("disabled")) {
					return false;
				}
				menu.hide();
				var fun = $(this).attr('href').substr(1);
				var targetTab = menu.data("targetTab");
				$("#mainTabs").tabs(fun, targetTab);
				return false;
			});

			menu.bind("contextmenu", function() {
				return false;
			});
		},
		
		initAppTabHelper : function() {
			// FIXME 只有在Debug状态下才可以使用
			var oldvalue = "";
			$(document).keyup(function(evt) {
				var openUrl = function(url) {
					oldvalue = url;
					ozWindow.open({
						id : "a" + (new Date().getTime()),
						title : "测试页签",
						url : contextPath + url
					});
				}
				if (evt.which == 35 && evt.metaKey) { // 切换显示隐藏：Ctrl(metaKey) + End(35)
					OZ.Messager.prompt("请输入链接地址,确定后打开新页签.", openUrl, null, oldvalue, false, "调试工具");
				}
			});
		},
		
		initSwitchUser : function(pos) {
			if($("#useraddrcontainer").length == 0)
				return;

			var allwidth = 0;
			if(pos == "right") 
				allwidth = $("#accountList").width() + 12 - $("#useraddrcontainer").width();
			
			// 绑定切换用户操作
			$("#useraddrcontainer").click(function() {
				var pos = $(this).offset();
				pos.top += 20;
				var ppos = $("#accountList").parent().offset();
				pos.top -= ppos.top;
				pos.left -= ppos.left;
				pos.left -= allwidth;
				$("#accountList").css(pos).slideDown(100, function() {
					$(document).bind("click.cont", function() {
						$(document).unbind("click.cont");
						$("#accountList").slideUp(100, function() {});
					});
				}).focus();
			});
		}
	}
})();

/*切换身份*/
function switchIdentity(ouId) {
	var strUrl = contextPath + "/loginAction.do?action=switchIdentity&ouId=" + ouId + "&timeStamp=" + new Date().getTime();
	$.getJSON(strUrl, function(json){
		if (json.result == true) {
			window.location.reload();
		}
	});
	return false;
}

function editPersonalInfo(){
	ozWindow.open({
		id:"modifyUserinfo",
		title:'个人信息',
		url:contextPath + "/organize/userInfoAction.do?action=editPersonal&timeStamp=" + new Date().getTime(),
		refresh:true
	});
}