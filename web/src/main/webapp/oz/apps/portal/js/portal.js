(function(){
	var root = this , tabIndexId = 0;
	var generate_random_char = function() {
		var chars, newchar, rand;
		chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZ";
		rand = Math.floor(Math.random() * chars.length);
		return newchar = chars.substring(rand, rand + 1);
	};
	var generate_random_id = function() {
		var string;
		string = "module" + generate_random_char() + generate_random_char() + generate_random_char();
		while ($("#" + string).length > 0) {
			string += generate_random_char();
		}
		return string;
	};

	OZ.Portlet={
		desginMode:false,
		modules : [],
		setDesginMode:function(mode){
			OZ.Portlet.desginMode = mode;
			if(mode){
				$("#modeConfigButtons").buttonset().bind("click.button",function(){
					var value = $(this).find("label.ui-state-active").prev().val();
					if(!value) return;
					OZ.Portlet.setMode(value);
				});
				
				$("#alignConfigButtons").buttonset().bind("click.button",function(){
					var value = $(this).find("label.ui-state-active").prev().val();
					if(!value) return;
					OZ.Portlet.setAlign(value)
				});
				
				$("#layoutsButtons").buttonset().bind("click.button",function(){
					var value = $(this).find("label.ui-state-active").prev().val();
					if(!value) return;
					OZ.Portlet.switchLayout(value)
				});
				/**
				 * $(".moduleIcon","#moduleList").disableSelection().draggable({
				 * distance: 10,revert: 'invalid',appendTo:'body',
				 * helper:function(){return $(this).clone().disableSelection()} })
				 */
				$("body").disableSelection();
				$("#mainContainer").addClass("desginClass");
				$("#desginPanel").show();
			}else{
				$("#mainContainer").removeClass("desginClass");
				$("#desginPanel").hide();
			}
		},
		/*
		 * 加载配置信息
		 */
		loadPage : function(_configData) {
			if(!_configData){
				return;
			}
			OZ.Portlet.modules = _configData.modules || _configData.parts || [];
			OZ.Portlet.setMode(_configData.mode);
			OZ.Portlet.setAlign(_configData.align);
			OZ.Portlet.setLayout(_configData.layoutId);
		},
		
		switchLayout:function(id){
			// 设计模式,在切换时,必须把之前的配置设置回去
			if(OZ.Portlet.desginMode){
// OZ.Portlet.modules = $("#mainContainer .moduleItem").map(function(){
// var part = $(this).data("module");
// return part;
// });
				OZ.Portlet.modules = [];
			}
			OZ.Portlet.setLayout(id);
		},
		setMode : function(mode) {
			if (!mode) {
				// 如果没传参数,取第一个
				mode = $("#modeConfigButtons :radio:eq(0)").attr("value");
			}
			if (OZ.Portlet.desginMode) {
				if ($("#" + mode + "_mode").attr("checked") != true) {
					// 切换按钮
					$("#" + mode + "_mode").attr("checked", true);
					$("#modeConfigButtons").buttonset("refresh");
				}
			}
			$("#mainContainer").removeClass("full-mode wide-mode petty-mode");
			$("#mainContainer").addClass(mode + "-mode");
		},
		setAlign : function(mode) {
			if (!mode) {
				// 如果没传参数,取第一个
				mode = $("#alignConfigButtons :radio:eq(0)").attr("value");
			}
			// 设计模式
			if (OZ.Portlet.desginMode) {
				if ($("#" + mode + "_align").attr("checked") != true) {
					$("#" + mode + "_align").attr("checked", true);
					$("#alignConfigButtons").buttonset("refresh");
				}
			}
			$("#mainContainer").removeClass("center-align left-align right-align");
			$("#mainContainer").addClass(mode + "-align");
		},
		setLayout:function(id){
			// 如果没传参数，取第一个布局
			if(!id){
				id  = $("#layoutsButtons :radio:eq(0)").attr("value");
			}
			
			if($("#layout_" + id).attr("checked") != true){
				//$(".layoutRegion").droppable("destroy");
				$("#mainContainer").load(contextPath + "/module/portalAction.do?action=loadLayout",{id:id}, function(){
					var layoutRegions =$("#mainContainer").find(".layoutRegion");
					
		    		if(OZ.Portlet.desginMode){
		    			$("#mainContainer").disableSelection();
		    			
		    			// 切换按钮
	    				$("#layout_" + id).attr("checked", true);
	    				$("#layoutsButtons").buttonset("refresh");
	    				
	    				// 模块放置区
			    		/*
						 * layoutRegions.droppable({ accept: '.moduleIcon',
						 * hoverClass: 'custom-droppable-state-hover',
						 * activeClass: 'custom-droppable-state-active', drop:
						 * function(ev, ui) { var portletId =
						 * ui.draggable.data("portletId"); var regionId =
						 * $(this).attr("id"); OZ.Portlet.addPortlet(regionId,
						 * portletId,false); } });
						 */
			    		
			    		// 初始化模块的放下区域的模块排序
	    				layoutRegions.sortable({ 
			    			// distance:10,
			    			// tolerance:"pointer",
			    			// cusor:'move',
			    			placeholder: 'custom-sortable-placeholder',
			    			// appendTo:'body',
			    			// connectWith: '.layoutRegion',
			    			handle:'.dragdrop-handle',
			    			stop:function(ev,ui){
			    				ui.item.siblings().filter(".oz-add-portlet").each(function(){
			    					var parent = $(this).parent();
			    					$(this).appendTo(parent);
			    				});
			    				ui.item.hide().show(1);
			    			}
			    		});
		    		}
		    		
		    		if(OZ.Portlet.modules){
			    		$.each(OZ.Portlet.modules, function(index, module){
							OZ.Portlet.addModule(module);
						});
		    		}
                    if(OZ.Portlet.desginMode){
		    		    // 放置添加按钮
		    		    layoutRegions.append($("#tpl_AddPortlet").html());
                    }

		    	});
			}
		},
		addPortlet : function(regionId, portletId,isAddPortlet) {
			var module = {portletId:portletId,regionId:regionId}
			OZ.Portlet.addModule(module, isAddPortlet);
		},
		addModule : function(module, isAddPortlet) {
			module = module || {};
			
			module.portletId = module.portletId || module.partId;
			module.regionId = module.regionId || module.containter;
			delete module.partId;
			delete module.containter;
			
			if(!((module.portletId || module.portlet) && module.regionId)){
				return;
			}
			
			var region = $("#mainContainer #" + (module.regionId ||  module.containter));
			if(region.length == 0)
				return;
			
			var portlet =  module.portlet = module.portlet || {} ;
			
			if(module.portletId){
				var portletIdKey = "m" + module.portletId;
				if (!(portletIdKey in _modules)) {
					alert(module.portletId + "未找到");
					return;
				}
				$.extend(module.portlet,_modules[portletIdKey]);
			}
			
			var moduleId = generate_random_id();
			var divId = moduleId + "Div";
			// 根据配置参数生成相应的DOM
			var module_jq = $("#module_temp").clone();
			module_jq.attr("id", divId);
			module_jq.addClass("moduleItem oz-portlet-expanded " + moduleId + "Class").data("moduleId",moduleId).data("module",module);

			// 设计模式或者显示标题头的情况
			if (OZ.Portlet.desginMode || !("N" == portlet.showHead || "n" == portlet.showHead)) {
				module_jq.find(".title").text(portlet.title);
				if (portlet.icon) {
					module_jq.find(".oz-icon").addClass(portlet.icon);
				} else {
					module_jq.find(".oz-portlet-icon").hide();
				}
				var moreBtn = module_jq.find(".more");
				if(moreBtn.length){
					if (portlet.hrefMore) {
						if(portlet.hrefMore.charAt(0)=="/"){
							moreBtn.html('<a href="javascript:void(0);">更多...</a>').find("a").click(function() {
								OZ.Portlet.openTab(moduleId,moduleId+"More",portlet.title,contextPath + portlet.hrefMore);
							});
						}else{
							moreBtn.html('<a href="javascript:void(0);">更多...</a>').find("a").click(function() {
								root[moduleId] && root[moduleId].more && root[moduleId].more(portlet.title,portlet.hrefMore);
							});
						}
						module_jq.addClass("oz-portlet-hasmore");
					} else {
						moreBtn.hide();
					}
				}
			} else {
				module_jq.addClass("oz-portlet-nohead");
			}

			if (isAddPortlet) {
				$(_addPortletBtnObj).before(module_jq);
			} else {
				module_jq.appendTo(region);
			}

			module_jq.show();

			OZ.Portlet.loadContent(module_jq);
			OZ.Portlet.rejustRegion(region);
		},
		removeModule : function(obj) {
			var parent = $(obj);
			while (parent && !parent.hasClass("moduleItem")) {
				parent = parent.parent();
			}
			if (parent) {
				var ct = parent.parent();
				parent.remove();
				OZ.Portlet.rejustRegion(ct);
			}
		},
		/**
		 * 加载模版
		 */
		loadContent : function(modules_jq) {
			if (modules_jq.length) {
				modules_jq.each(function(){
					var module_jq = $(this);
					var module = module_jq.data("module");
					var initialize = module_jq.data("initialize");
					if (module) {
						var moduleId = module_jq.data("moduleId");
						if(initialize){
							root[moduleId] && root[moduleId].unload && root[moduleId].unload(this, moduleId,module);
						}
						var content = module_jq.find(".oz-portlet-body");
						var msg = '<div class="loading-msg"><img src="'+contextPath+'/oz/webui/oz/images/loading.gif"/></div>';
						content.html(msg);
						var ctwidth = content.width();
						var param = $.extend({
							moduleId : moduleId,
							width : ctwidth,
							isDesgin:OZ.Portlet.desginMode,
							ts : new Date().getTime()
						}, module.param);
						content.load(contextPath+module.portlet.url, param, function() {
							if(!initialize){
								root[moduleId] && root[moduleId].initialize && root[moduleId].initialize(this, moduleId,module);
								module_jq.data("initialize",true);
							}
							root[moduleId] && root[moduleId].onload && root[moduleId].onload(this, moduleId,module);
							OZ.Portlet.initLink(moduleId);
						});
					}
				})
			}
		},
		refreshModule:function(obj){
			var parent = $(obj);
			while (parent && !parent.hasClass("moduleItem")) {
				parent = parent.parent();
			}
			if (parent) {
				OZ.Portlet.loadContent(parent)
			}
		},
		toggleModule:function(obj){
			var parent = $(obj);
			while (parent && !parent.hasClass("moduleItem")) {
				parent = parent.parent();
			}
			if (parent) {
				var module_jq = parent;//$("#" + moduleId + "Div");
				
				if(module_jq.hasClass("oz-portlet-expanded")){
					module_jq.removeClass("oz-portlet-expanded");
					module_jq.addClass("oz-portlet-collapsed");
					module_jq.find(".oz-portlet-body").hide();
				}else{
					module_jq.removeClass("oz-portlet-collapsed");
					module_jq.addClass("oz-portlet-expanded");
					module_jq.find(".oz-portlet-body").show();
				}
			}
		},
		rejustRegion : function(containter) {
			// 使用按钮添加方式，不需要调整了。
			return;
			// 设计模式下调整空区域的高度，方便拖拽模块
			if (OZ.Portlet.desginMode == true) {
				var ct = $(containter);
				var num = ct.find(".moduleItem").size();
				if (num == 0) {
					ct.height(100);
				} else {
					ct.height("auto");
				}
			}
		},
		setSubtitle : function(moduleId, countInfo) {
			var portletTitle = $("#" + moduleId + "Div").find(".subtitle");
			if (portletTitle.length == 0) {
				$("#" + moduleId + "Div").find(".title").after("<span class='subtitle'></span>");
				portletTitle = $("#" + moduleId + "Div").find(".subtitle");
			}
			portletTitle.text(countInfo);
		},
		openTab : function(moduleId, tabId, title, url) {
			OZ.openWindow({
				id : moduleId+tabId,
				title : title || "《未命名文档》",
				url : url +(url.indexOf("?")>-1?"&":"?")+"timeStamp=" + new Date().getTime(),
				refresh : true,
				moduleId : moduleId
			});
		},
		initLink:function(moduleId){
			// 设置打开的链接是打开Tab
			$("#" + moduleId + "Div").find("a.opentab").click(function(e) {
				var url = $(this).data("href");
				OZ.openWindow({
					id : moduleId + (tabIndexId++),
					title : $(this).text()||$(this).attr("title"),
					url : url +(url.indexOf("?")>-1?"&":"?")+"timeStamp=" + new Date().getTime(),
					refresh : true,
					moduleId : moduleId
				});
				return false;
			});
		}
	};
})();