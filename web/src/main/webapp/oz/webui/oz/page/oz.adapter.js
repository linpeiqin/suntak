/**
 * oz主页函数适配器，对话框，窗口，日志都使用首页的窗口的对象
 * <p>
 * 包含一下的工具类：ozWindow,ozLog,ozMsg,ozDlg,
 * </p>
 * 版本: 5.1
 * 作者：dragon 2010-07-21
 * 修改 : KingChen 2012-03-31
 */
(function(){
	var root,ozWindow;
	
	root = this;
	
	root.OZ = root.OZ || {};
	/**
	 * @Deprecated 在以后不要用下面的函数，直接使用ozWindow来操作一些方法。
	 */
	$.extend(root.OZ,{
		/**
		 * 打开一个窗口，如果指定的窗口已经存在则激活该窗口
		 */
		openWindow : function(config){
			top.ozWindow.open(config);
		},
		/** 关闭当前页面窗口一个窗口 */
		closeWindow : function(){
			top.ozWindow.close(window);
		},
		/** 更新当前窗口的url */
		reLocationWindow : function(newUrl){
			top.ozWindow.update(newUrl);
		},
		/** 更新当前窗口的Title */
		updateWindowTitle : function(title){
			if(window.frameElement){
				top.ozWindow.updateTitle(window,$("title").text());
			}
		},
		findById : function(id){
			return top.ozWindow.findById(id);
		},
		/** 获取当前激活页签的id*/
		getActiveId : function(){
			return top.ozWindow.getActiveId();
		},
		getActivePanel : function(){
			return top.ozWindow.getActivePanel();
		},
		getCurrentWin : function(){
			return top.ozWindow.getCurrentWin(window);
		}
	});
	
	
	if(root != top){
		//ozWindow的托管
		root.ozWindow = root.ozWindow || {};
		
		$.extend(root.ozWindow,{
			/**
			 * 打开页面
			 */
			open:function(config){
				top.ozWindow.open(config);
			},
			/**
			 * 关闭当前页面
			 */
			close:function(){
				top.ozWindow.close(window);
			},
			/**
			 * 关闭活动的页面
			 */
			closeActive:function(){
				top.ozWindow.closeActive();
			},
			/**
			 * 更新页签标题
			 */
			updateTitle : function(title){
				if(window.frameElement){
					top.ozWindow.updateTitle(window,title || $("title").text());
				}
			},
			/**
			 * 重定位url
			 */
			reLocation : function(newUrl){
				top.ozWindow.reLocation(window,newUrl);
			},
			/**
			 * 获取当前活动的窗口
			 */
			getActive : function(){
				return top.ozWindow.getActivePanel();
			},
			/**
			 * 获取当前窗口,一般没特殊情况,没必要用.
			 */
			getCurrent : function (){
				return top.ozWindow.getCurrentWin(window);
			},
			/**
			 * 获取当前窗口ID
			 */
			getId : function(){
				var tab = this.getCurrentWin(window);
				if (tab) {
					return tab.tabPanel("option", "id");
				}
				return null;
			},
			/**
			 * 获取当前活动窗口的ID
			 */
			getActiveId : function(){
				return top.ozWindow.getActiveId();
			},
			/**
			 * 查找指定ID窗口
			 */
			findById : function(id){
				return top.ozWindow.findById(id);
			},
			/**
			 * 获取窗口的参数信息
			 */
			option : function(name,value){
				var tab = this.getCurrent(window);
				if(tab){
					if(value){
						tab.tabPanel("option", name, value);
						return tab;
					}
					return tab.tabPanel("option", name);
				}
				return null;
			}
		});

		/** 控制台：相应函数的说明看oz.log.js */
		if(top.ozlog && top.ozlog !== ozlog){
			var ozLog;
			ozLog = root.ozLog =root.ozlog = {};
			$.each(top.ozlog,function(key,value){
				if(jQuery.isFunction(value)){
					ozLog[key] = function(){
						return top.ozlog[key].apply(this,arguments);
				    };
				}else{
					ozLog[key] = value;
				}
			});
		}
		
		/** 消息框：相应函数的说明看oz.messager.js */
		if(top.OZ.Msg && top.OZ.Msg !== OZ.Msg){
			root.ozMsg = OZ.Msg = root.OZ.Msg = {};
			$.each(top.OZ.Msg,function(key,value){
				if(jQuery.isFunction(value)){
					OZ.Msg[key] = function(){
						return top.OZ.Msg[key].apply(this,arguments);
				    };
				}else{
					OZ.Msg[key] = value;
				}
			});
		}

		/** 对话框：相应函数的说明看oz.index.js */
		if(top.OZ.Dlg && top.OZ.Dlg !== OZ.Dlg){
			root.ozDlg = OZ.Dlg = root.OZ.Dlg = {};
			$.each(top.OZ.Dlg,function(key,value){
				if(jQuery.isFunction(value)){
					OZ.Dlg[key] = function(){
						return top.OZ.Dlg[key].apply(this,arguments);
				    };
				}else{
					OZ.Dlg[key] = value;
				}
			});
		}
		
		$(document).click(function(){
			if(top.documentClick){
				top.documentClick();
			}
		});
	}
})();