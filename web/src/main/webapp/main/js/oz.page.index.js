(function(){
	/**
	 * 调整页签中的内容区域大小
	 */
/*	oz.page.index.resize = function(theight) {
		var theight = theight || 0;
		$("#mainPage").layout("resize");
		var vheight = $(".oz-layout-west").height() - $(".ui-tab-trigger").height()+theight;
		$("#views").height(vheight);
	};*/
	/**
	 * 初始化页签
	 */
	oz.page.index.initNavTab = function() {
		this.navTab = $(".ui-tab");
		this.triggers = $("#triggers .ui-tab-trigger-item");
		this.views = $("#views .ui-tab-container-item");
		var self = this;
		this.triggers.click(function() {
			var index = self.triggers.index(this);
			self.showNavTab(index);
		});
		// 切换到第一个菜单
		this.showNavTab(0);
	};
	/**
	 * 显示指定页签
	 * 
	 * @param index 页签的索引
	 */
	oz.page.index.showNavTab = function(index,title) {
		if (index == this.currentIndex) {
			return;
		}
		var ct  = this.navTab.find(".ui-tab-container");
		
		var navTabScrollTop = ct.scrollTop();
		
		this.triggers.eq(this.currentIndex).removeClass("current");
		this.views.eq(this.currentIndex).removeClass("current").data("scrollTop",navTabScrollTop);
		
		this.triggers.eq(index).addClass("current").show();
		if(title){
			this.triggers.eq(index).find("span").text(title);
		}
		var t = this.views.eq(index);
		t.addClass("current");
		var navTabScrollTop =  t.data("scrollTop");
		
		if(navTabScrollTop){
			ct.scrollTop(navTabScrollTop);
		}
		
		this.navTabScrollTop =  navTabScrollTop;
		this.currentIndex = index;
	};
	oz.page.index.initNavMenu = function() {
		var self = this;
		//第一个的收缩，不影响其他的。
		var dts = $(".nav-menu .nav-first").children("dt:eq(0)").click(function(){
			var par = $(this).parent();
			if (par.hasClass("close")) {
				par.removeClass("close");
			} else {
				par.addClass("close");
			}
			return false;
		});
		
		// 绑定左边办公共导航的切换,如果全部相互影响，去掉下面的“:gt(0)”
		var dts = $(".nav-menu .nav-first").children("dt:gt(0)");
		dts.click(function() {
			$(this).parent().siblings("dl:gt(0)").addClass("close");
			var par = $(this).parent();
			if (par.hasClass("close")) {
				par.removeClass("close");
			} else {
				par.addClass("close");
			}
			return false;
		});
		
		var dt2s = $(".nav-menu-two dt");
		dt2s.click(function() {
			$(this).parent().siblings("dl").filter(":not('.close')").addClass("close");
			var par = $(this).parent();
			if (par.hasClass("close")) {
				par.removeClass("close");
			} else {
				par.addClass("close");
			}
		});
		
		var items = $(".nav-menu dd div.permission");
		items.click(function() {
			var id = $("a", this).data('id');
			var text = ($("a", this).text()||"").replace("·","");
			var leaf =  $("a", this).data("leaf");
			var href = $("a", this).data('href');
			if(leaf === false || leaf =="false"){
				var tree = $("#permissionTree");
				tree.tree("option","url",contextPath + '/security/permissionAction.do?action=getPermissionTree4Nav&parentId='+id+'&timeStamp=' + new Date().getTime());
				tree.tree("reload");
				self.showNavTab(1,text);
			}
			if (href) {
				//self.showNavTab(1);
				//self.pos = true;
				ozWindow.open({
					id : "" + id,
					title : text,
					url : (href.indexOf("/") == 0) ? contextPath + href : href
				});
			} else {
				
			}
		})
	};
})();
/*
 * Timer类
 * 方法:
 * 		1) 构造函数: Timer(间隔(单位为毫秒), 回调函数);
 *		2) clear(): 清除 .
 *
 * 使用示例: var timer = new Timer(200, function(t) {alert('timer'); t.clear();} );    
 */
function Timer(interval, functor) {
	this.id = 'ozTimer_' + Math.ceil(Math.random() * 900000000 + 100000000);
	eval(this.id + ' = this;');
	this.tid = setInterval(this.id + '.callback()', interval)
	this.functor = functor;
	this.callback = function(){
		this.functor(this);
	}
	
	this.clear = function(){
		clearInterval(this.tid);
	}
}

function goIndexPage() {
	var mainPage = contextPath + '/?ts=' + new Date().getTime();
	window.open(mainPage, "_self");
}