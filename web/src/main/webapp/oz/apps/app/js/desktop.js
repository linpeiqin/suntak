/**
 * 添加浏览器的样式
 */
!function($, window, document, undefined) {
	$.app = {};

	$(function() {
		var htmlClassName = [];
		if (jQuery.browser.webkit) {
			htmlClassName += 'webkit'
		}
		if (jQuery.browser.msie) {
			htmlClassName += 'msie'
		}
		if (jQuery.browser.opera) {
			htmlClassName += 'opera'
		}
		if (jQuery.browser.mozilla) {
			htmlClassName += 'mozilla'
		}
		$("html").addClass(htmlClassName);
	});

}(jQuery, window, document);

/**
 * DesktopManager 桌面管理
 * 
 * @version 5.2.0
 * @author ken
 * @since 5.2.0
 */
!function($, window, document, undefined) {
	var defaults = {
		items : [],
		gridster : {
			widget_margins : [ 14, 14 ],
			widget_base_dimensions : [ 130, 130 ],
			min_cols : 6,
			min_rows : 20,
			serialize_params: function($w, wgd) {
	            return {
	            	uiComponentId : $w.data("uid"),
	            	left: wgd.col,
	            	top: wgd.row
	            };
	        }
		}
	};

	/**
	 * 桌面对象
	 */
	function DesktopManager(options) {
		this.options = $.extend(true, defaults, options);
		this.$el = $("#desktop");
		this.$navbar = $("#navbar");
		this.$desktopWrapper = $("#desktopWrapper");
		this.$desktops = $([]);
		this.init();
	}

	var fn = DesktopManager.prototype;
	fn.init = function() {
		this.$desktopsContainer = $('<div id="desktopsContainer" class="desktopsContainer"></div>').appendTo(this.$desktopWrapper);
		this.initDesktops();
		this.initNav();
		this.calculate_positions();
		$(window).bind('resize', throttle($.proxy(this.calculate_positions, this), 200));
		this.setCurrentDesktop(2);
	};

	function onIndicatorClick(event) {
		var target = event.currentTarget;
		if ($(target).attr("cmd") == "switch") {
			this.setCurrentDesktop($(target).attr("index"));
		}
		if ($(target).attr("cmd") == "edit") {
			this.toggleEdit();
		}
		return false;
	}

	fn.initDesktops = function() {
		for (var index = 0; index < 5; index++) {
			var appDesktop = $('<div></div>').appendTo(this.$desktopsContainer);
			appDesktop.desktop({
				index : index,
				items : this.options.items[index] || [],
				gridster : this.options.gridster
			});
		}
		this.$desktops = this.$desktopsContainer.children();
	};

	fn.initNav = function() {
		this.$nav = this.$el.find("#navbar");
		this.$nav.find(".indicator").click($.proxy(onIndicatorClick, this));
	};

	/**
	 * 显示指定的桌面
	 */
	fn.setCurrentDesktop = function(index) {
		this.$desktops.removeClass("desktop-current");
		$(this.$desktops[index]).addClass("desktop-current");
		this.$nav.find(".indicator").removeClass("nav-current");
		this.$nav.find(".indicator[index="+index+"]").addClass("nav-current");
	};

	/**
	 * 计算桌面的位置
	 */
	fn.calculate_positions = function() {
		var height = $(window).height();
		var width = $(window).width();
		$("body").height(height);
		this.$desktopsContainer.height(height).width(width);
		this.$desktops.height(height).width(width);
	};

	/**
	 * 切换编辑状态
	 */
	fn.toggleEdit = function() {
		this.$el.toggleClass("editing");
		if (this.$el.hasClass("editing")) {
			this.setEdit(true);
		} else {
			this.setEdit(false);
			this.save();
		}
	};

	fn.setEdit = function(editable) {
		if(editable){
			if(!this.$el.hasClass("editing"))
				this.$el.addClass("editing");	
			$(".indicator-edit").attr("title", "保存");
		}else{
			this.$el.removeClass("editing");
			$(".indicator-edit").attr("title", "编辑");
		}		
		
		var self = this;
		$.each(this.$desktops, function(i, applist) {
			$(this).desktop().edit(editable);
		});
	};

	fn.save = function() {
		var self = this;
		var data = [];
		$.each(this.$desktops, function(i, applist) {
			data.push($(this).desktop().getData());
		});
		
		// 保存
		var saveUrl = contextPath + "/app/desktopAction.do?action=save&timeStamp=" + new Date().getTime();		
		$.post(
			saveUrl,
			{personal:"true", datas:$.toJSON(data)},
			function(json){			
				if(json.result === true){
					OZ.Msg.slide(json.msg || "信息保存成功！");	
				}else{
					OZ.Msg.slide(json.msg || "信息保存失败！");
				}
			},
			"json"
		);
	};

	$.app.desktopManager = DesktopManager;
}(jQuery, window, document);

/**
 * Desktop 桌面对象,<br>
 * 包含widget和shutcut对象,并有布局管理
 * 
 * @version 5.2.0
 * @author ken
 * @since 5.2.0
 */
!function($, window, document, undefined) {
	var defaults = {
		items : []
	};
	
	/**
	 * 点击图标的操作
	 */
	function onDesktopItemClick(event) {
		if (this.editing) {
			event.preventDefault();
			if ($(event.target).hasClass("app-widget-delete") || $(event.target).hasClass("app-shortcut-delete")) {
				this.gridster.remove_widget(event.currentTarget);
			}
		} 
//		else {
//			event.preventDefault();
//			var url = $(event.currentTarget).data("url");
//			if (url) {
//				var name = $(event.currentTarget).data("name");
//				var strUrl = contextPath + url; 
//				OZ.openWindow({
//					id: $(event.currentTarget).data("uid"),
//					title: $(event.currentTarget).data("name") || "未命名标题",
//					url: strUrl, 
//					refresh: true,
//					beforeCloseFnName: "oz_Win_BeforeClose"
//				});	
//			}
//		}
	}

	// 动作处理函数 =====================================================================
	function onUIComponentAdd_Clicked(event){
		var self = this;
		var strUrl = contextPath + "/app/desktopAction.do?action=openAppDlg&timeStamp=" + new Date().getTime();
		new OZ.Dlg.create({
			id:"Dlg_AddUIComponent", 
			width:700, height:480,
			title:"添加应用",
			url: strUrl,
			onOk:function(result){
				strUrl = contextPath + "/app/desktopAction.do?action=loadUIComponentData&timeStamp=" + new Date().getTime();
				$.getJSON(
					strUrl,
					{cmpnIds:result},
					function(cmpns){
						$.each(cmpns,function(i,item){
							self.addItem(item);
						})
						$.desktopManager.setEdit(true);
					}					
				);
			},
			onCancel:function(result){
				
			}
		});
	}
	/**
	 * 桌面对象
	 */
	function Desktop(el, options) {
		this.options = $.extend(true, {}, defaults, options);
		this.$el = $(el);
		this.init();
	}

	var fn = Desktop.prototype;
	fn.init = function() {
		this.$container = $('<ul></ul>').addClass("appListContainer").appendTo(this.$el);
		this.render();
		this.gridster();
		this.initEvent();
	};
	fn.render = function() {
		var self = this;
		var items = this.options.items;

		this.$el.attr("data-index", this.options.index).addClass("gridster desktopContainer");

		items.sort(function(a,b){
			if(a.row==b.row){
				return a.col - b.col;
			}
			return a.row - b.row;
		});
		
		$.each(items, function(i, option) {
			var option = $.extend({},option,{desktop:self});
			if (option.type == "widget") {
				var $c = $("<li/>").appendTo(self.$container);
				$c.widget(option);
			}
			if (option.type == "shortcut") {
				var $c = $("<li/>").appendTo(self.$container);
				$c.shortcut(option);
			}
		});

		// TODO 需要判断是否已经布满，如果布满则不添加该按钮
		html = '';
		html += '<li data-row="1" data-col="1" data-sizex="1" class="addComponent" data-sizey="1">';
		html += '	<div class="app-shortcut shortcut-bg-box7">';
		html += '		<div class="app-shortcut-icon"><i class="shortcut-icon-0101"></i></div>';
		html += '		<div class="app-shortcut-name" title="添加">添加</div>';
		html += '	</div>';
		html += '</li>';
		this.$container.append(html);
	};

	fn.addItem = function(option){
		var self = this;
		option = $.extend({},option,{desktop:this});
		if (option.type == "widget") {
			var $c = $("<li/>");
			$c.widget(option);
			this.gridster.add_widget($c,option.sizex,option.sizey);
		}
		if (option.type == "shortcut") {
			var $c = $("<li/>");
			$c.shortcut(option);
			this.gridster.add_widget($c);
		}
	};
	
	/**
	 * 初始化桌面排列
	 */
	fn.gridster = function() {
		var self = this;
		var gridster_options = $.extend(true, {}, this.options.gridster, {
			draggable:{
				start:function(){
					self.$el.off(".desktop");
				},
				stop:function(event){
					self.initEvent();
				}
			}
		});
		this.gridster = this.$container.gridster(gridster_options).data('gridster');
	};

	fn.edit = function(editable) {
		if (editable) {
			this.editing = true;
			this.gridster.enable();
		} else {
			this.editing = false;
			this.gridster.disable();
		}
	};

	fn.initEvent = function() {
		this.$el.on("click.desktop", "li.gs_w", $.proxy(onDesktopItemClick, this));
		this.$el.on("mouseup.desktop", "li.addComponent", $.proxy(onUIComponentAdd_Clicked, this));
	};

	fn.getData = function() {
		var pageDate = {};
		pageDate.pageIndex = this.options.index;
		pageDate.items = this.gridster.serialize();
		return pageDate;
	};

	$.app.desktop = Desktop;
	$.fn.desktop = function() {
		if (this.data('desktop')) {
			return this.data('desktop');
		}
		var ins = new Desktop(this, arguments[0]);
		this.data('desktop', ins);
		return ins;
	};

}(jQuery, window, document);

/**
 * Widget组件
 * 
 * @version 5.2.0
 * @author ken
 * @since 5.2.0
 */
!function($, window, document, undefined) {
	var root=window,widget_id_seq = 0,tabIndexId=0;
	
	var defaults = {
		row : 1,
		col : 1,
		sizex : 1,
		sizey : 1
	};

	/**
	 * 小窗口对象
	 */
	function Widget(el, options) {
		this.options = $.extend(true, {}, defaults, options);
		this.$el = $(el);
		this.init();
	}

	var fn = Widget.prototype;
	fn.init = function() {
		this.widgetId = "desktopWidget"+(widget_id_seq++);
		
		this.render();
		
		this.initEvent();
		
		this.load();
		
	};

	fn.render = function() {
		var item = this.options;
		this.$el.attr({
			"data-row" : item.row,
			"data-col" : item.col,
			"data-sizex" : item.sizex,
			"data-sizey" : item.sizey,
			"data-uid" : item.uid
		});

		html = '';
		html += '	<div class="app-widget">';
		html += '		<div class="widget-outer">';
		html += '			<div class="widget-inner">';

		// 背景
		html += '<div class="widget-bg-container" style="display: none; ">';
		html += '	<div class="widget-bg widget-center"></div>';
		html += '	<div class="widget-bg widget-t"></div>';
		html += '	<div class="widget-bg widget-rt"></div>';
		html += '	<div class="widget-bg widget-r"></div>';
		html += '	<div class="widget-bg widget-rb"></div>';
		html += '	<div class="widget-bg widget-b"></div>';
		html += '	<div class="widget-bg widget-lb"></div>';
		html += '	<div class="widget-bg widget-l"></div>	';
		html += '	<div class="widget-bg widget-lt"></div>';
		html += '</div>';

		html += '<div class="widget-content">';

		// 标题栏
		html += '	<div class="widget-titleBar app-bg-color1">';
		html += '		<div class="widget-toolButtonBar"></div>';
		html += '		<div class="widget-titleButtonBar">';
		if(item.showMore)
			html += '			<a class="ui-button widget-action-button widget-max" hidefocus="" title="更多" href="###" style="display: block;"></a>';
		if(item.showRefresh)
			html += '			<a class="ui-button widget-action-button widget-refresh" hidefocus="" title="刷新" href="###" style="display: block; "></a>';
		html += '		</div>';
		html += '		<div class="widget-title titleText">';
		if(item.icon){
			html += '		<i class="widget-icon-'+item.icon+'"></i>&nbsp;';
		}
		html += '' + item.name + '<span class="subTitle"></span></div>';
		html += '	</div>';

		html += '	<div class="widget-bodyOuter">';
		html += '		<div class="widget-bodyArea">';
		html += '			<div class="widget-loading">';
		html += '			    <span class="loading">&nbsp;</span>';
		html += '			           系统正在努力加载...';
		html += '			</div>';
		html += '		</div>';
		html += '	</div>';

		html += '</div>';

		html += '			</div>';
		html += '		</div>';
		html += '		<div class="app-widget-delete" title="卸载应用"></div>';
		html += '	</div>';

		this.$el.html(html);
	};

	fn.resize = function() {
		this.$el.find(".widget-bodyOuter").height();
	};

	fn.initEvent = function(event){
		var self  = this;
		this.$el.on("click",".ui-button",function(event){
			event.preventDefault();
			if($(this).hasClass("widget-refresh")){
				self.load();
				return false;
			}
			if($(this).hasClass("widget-max")){
				self.openMore();
				return false;
			}
		});
		this.$el.on("click",'a[target="_page"]',function(event){
			event.preventDefault();
			self.openLink($(this));
		});
	};
	
	/**
	 * 加载组件内容
	 */
	fn.load = function() {
		var self = this;
		var $el = this.$el;
		var options = this.options;
		var widgetId = this.widgetId;
		//是否已经执行初始化。
		var initialize = $el.data("initialize");
		if(initialize){
			//如果初始化过，进行卸载操作
			root[widgetId] && root[widgetId].unload && root[widgetId].unload(this, widgetId,options);
		}
		//查找内容区域
		var content = $el.find(".widget-bodyArea");
		//加载提示消息
		var msg ='<div class="widget-loading"><span class="loading">&nbsp;</span>系统正在努力加载...</div>';
		content.html(msg);
		
		var param = $.extend({
			widgetId : widgetId,
			ts : new Date().getTime()
		}, options.param);
		content.load(contextPath+options.url, param, function() {
			//将自身的设置到组件的对象中，供页面中直接调用到组件
			root[widgetId].widget = self;
			//如果没有初始化过，则初始化，只会初始化一次。
			if(!initialize){
				root[widgetId] && root[widgetId].initialize && root[widgetId].initialize(this, widgetId,options);
				$el.data("initialize",true);
			}
			root[widgetId] && root[widgetId].onload && root[widgetId].onload(this, widgetId,options);
			//初始化页面中的链接
			//OZ.Portlet.initLink(widgetId);
		});
	};

	/**
	 * 打开更多
	 */
	fn.openMore = function(){
		var options = this.options;
		if(options.showMore){
			if(options.moreHref && options.moreHref.charAt(0)=="/"){
				var strUrl = contextPath + options.moreHref; 
				OZ.openWindow({
					id: options.uid + "More",
					title: options.name,
					url: strUrl, 
					refresh: true
				});	
			}else{
				root[moduleId] && root[moduleId].more && root[moduleId].more(options.name);
			}
		}
	}
	/**
	 * 打开链接
	 */
	fn.openLink = function(a){
		var widgetId = this.widgetId;
		var url = $(a).attr("href");
		if(!url){
			return false;
		}
		url = url +(url.indexOf("?")>-1?"&":"?")+"timeStamp=" + new Date().getTime();
		OZ.openWindow({
			id : widgetId + (tabIndexId++),
			title : $.trim($(a).text() || $(a).attr("title")),
			url : url ,
			refresh : true,
			widgetId : widgetId,
			widgetUid : this.options.uid
		});
		return false;
	}
	
	/**
	 * 设置副标题
	 */
	fn.subtitle = function(countInfo){
		var portletTitle = this.$el.find(".subTitle");
		if (portletTitle.length == 0) {
			this.$el.find(".titleText").after("<span class='subTitle'></span>");
			portletTitle = this.$el.find(".subTitle");
		}
		portletTitle.text(countInfo);
	}
	
	$.app.widget = Widget;
	$.fn.widget = function() {
		if (this.data('widget')) {
			return this.data('widget');
		}
		var ins = new Widget(this, arguments[0]);
		this.data('widget', ins);
		return ins;
	};

}(jQuery, window, document);

/**
 * Shortcut组件
 * 
 * @version 5.2.0
 * @author ken
 * @since 5.2.0
 */
!function($, window, document, undefined) {
	var defaults = {
		row : 1,
		col : 1,
		sizex : 1,
		sizey : 1
	};

	/**
	 * 点击操作
	 */
	var onShortcutClick = function(event){
		//编辑状态,不做任何操作
		if(this.desktop.editing){
			return;
		}
		event.preventDefault();
		this.open();
	};
	
	
	/**
	 * 小窗口对象
	 */
	function Shortcut(el, options) {
		this.options = $.extend(true, {}, defaults, options);
		this.$el = $(el);
		this.desktop = options.desktop;
		this.init();
	}

	var fn = Shortcut.prototype;
	fn.init = function() {
		this.render();
		this.initEvent();
	};

	fn.render = function() {
		var item = this.options;

		this.$el.attr({
			"data-row" : item.row,
			"data-col" : item.col,
			"data-sizex" : item.sizex,
			"data-sizey" : item.sizey,
			"data-uid" : item.uid,
			"data-name" : item.name,
			"data-url" : item.url
		});

		html = '';
		html += '	<div class="app-shortcut shortcut-bg-' + item.bg + '" title="' + item.name + '" >';
		html += '		<div class="app-shortcut-icon"><i class="shortcut-icon-' + item.icon + '"></i></div>';
		html += '		<div class="app-shortcut-name">' + item.name + '</div>';
		html += '		<div class="app-shortcut-delete" title="卸载应用"></div>';
		html += '	</div>';
		this.$el.html(html);
	};

	/**
	 * 初始化事件
	 */
	fn.initEvent = function(){
		this.$el.on("click",$.proxy(onShortcutClick,this));
	};
		
	/**
	 * 打开自己
	 */
	fn.open = function(){
		var self =this,options = 	this.options;
		if (options.url) {
			var name = options.name;
			var strUrl = contextPath + options.url; 
			OZ.openWindow({
				id: options.uid,
				title: name || "未命名标题",
				url: strUrl, 
				refresh: true
			});	
		}
	};
	
	$.app.shortcut = Shortcut;
	
	$.fn.shortcut = function() {
		if (this.data('shortcut')) {
			return this.data('shortcut');
		}
		var ins = new Shortcut(this, arguments[0]);
		this.data('shortcut', ins);
		return ins;
	};
	
}(jQuery, window, document);
