/**
 * Panel类
 * 依赖 oz-core
 * @author king
 */
(function($) {
	
	OZ.widget("OZ.panel.Header",{
		$type: "panelheader",
		_render: function(){
			this.element.append("<span/>")
		},
		setTitle: function(title){
			this.element.find("span").text(title);
		}
	});
	
	OZ.widget("OZ.panel.Panel",{
		$type: "panel",
		options : {
			title : null,
			iconCls : null,
			width : "auto",
			height : "auto",
			left : null,
			top : null,
			cls : null,
			headerCls : null,
			bodyCls : null,
			style : {},
			cache : true,
			fit : false,// Boolean|Object({width:true|false,height:true|false})
			border : true,
			doSize : true,
			noheader : false,
			content : null,
			collapsed : false,
			minimized : false,
			maximized : false,
			closed : false,
			tools : [],
			href : null,
			loadingMessage : "Loading..."
		},
		_parseDomOptions:function(){
			var t = this.element[0];
			return {
				width: (parseInt($.style(t,'width'),10) || undefined),
				height: (parseInt($.style(t,'height'),10) || undefined),
				left: (parseInt($.style(t,'left'),10) || undefined),
				top: (parseInt($.style(t,'top'),10) || undefined),
				title : ($.attr(t,'title')|| undefined)
			};
		},
		_render: function() {
			var self = this,
				el = this.element,
				opts = this.options;
			
			this.panel = this.element
								.addClass("oz-panel-body")
								.wrap('<div class="oz-panel"></div>')
								.parent()
									.css(opts.style)
									.addClass(opts.cls);
			this.body = this.element
								.addClass(opts.bodyCls);
			if (opts.title && !opts.noheader){
				var header = $('<div class="oz-panel-header"><div class="oz-panel-title"></div></div>')
								.addClass(opts.headerCls)
								.prependTo(this.panel);
				
				header.find('>div.oz-panel-title').html(opts.title);
				
				if (opts.iconCls){
					header.find('>.oz-panel-title').addClass('oz-panel-with-icon');
					$('<div class="oz-panel-icon"/>').addClass(opts.iconCls).appendTo(header);
				}
				
				var tool = $('<div class="oz-panel-tool"/>').appendTo(header);
				if (opts.tools){
					for(var i=0; i<opts.tools.length; i++){
						var t = $('<div/>').addClass(opts.tools[i].iconCls).appendTo(tool);
						var htype = typeof(opts.tools[i].handler);
						if (htype  == "function"){
							t.bind('click.'+this.$type, $.proxy(opts.tools[i].handler,this));
						}else if (htype  == "string"){//增加对函数延时定义的支持
							t.attr("handler",opts.tools[i].handler);//将函数名记录到按钮的属性中
							t.bind('click.'+this.$type, $.proxy(function(e){
								return window[$(e.target).attr("handler")].apply(this,arguments);
							},this));
						}
						
						//增加按钮的tip提示支持
						if(opts.tools[i].title){
							t.attr("title",opts.tools[i].title);
						}
					}
				}
				tool.find('>div').hoverClass('oz-panel-tool-over');
				this.body.removeClass('oz-panel-body-noheader');
			} else {
				this.body.addClass('oz-panel-body-noheader');
			}
			
			this.header = this.panel.find(">div.oz-panel-header");	
			
			if (opts.border === true){
				this.header.removeClass('oz-panel-header-noborder');
				this.body.removeClass('oz-panel-body-noborder');
			} else {
				this.header.addClass('oz-panel-header-noborder');
				this.body.addClass('oz-panel-body-noborder');
			}
		},
		_init:function(){
			var opts = this.options;
			var self = this;
			if (opts.fit === true || typeof(opts.fit) == "object"){
				this.panel.bind('_resize.'+this.$type, function(){
					self.resize();
				});
			}
			if (opts.doSize === true){
				this.panel.css('display','block');
				this.resize();
			}
			if (opts.closed === true){
				this.isLoaded = false;
				this.panel.hide();
			} else {
				this.open();
				this._loadData();
			}
		},
		resize:function(param){
			var opts = this.options;
			var panel = this.panel;
			var pheader = this.header;
			var pbody = this.body;
			var parent;
			if (param){
				if (param.width){ opts.width = param.width;}
				if (param.height){ opts.height = param.height;}
				if (param.left !== null){ opts.left = param.left;}
				if (param.top !== null){ opts.top = param.top;}
			}
			
			if (opts.fit === true){
				parent = this.panel.parent();
				opts.width = parent.width();
				opts.height = parent.height();
			}else if (typeof(opts.fit) == "object"){
				//独立控制宽度和高度的自适应
				parent = this.panel.parent();
				if(opts.fit.width === true){opts.width = parent.width();}
				if(opts.fit.height === true){opts.height = parent.height();}
			}
			
			panel.css({
				left: opts.left,
				top: opts.top
			});
			if (!isNaN(opts.width)){
				if ($.boxModel === true){
					panel.width(opts.width - (panel.outerWidth() - panel.width()));
					pheader.width(panel.width() - (pheader.outerWidth() - pheader.width()));
					pbody.width(panel.width() - (pbody.outerWidth() - pbody.width()));
				} else {
					panel.width(opts.width);
					pheader.width(panel.width());
					pbody.width(panel.width());
				}
			} else {
				panel.width('auto');
				pbody.width('auto');
			}
			if (!isNaN(opts.height)){
				if ($.boxModel === true){
					panel.height(opts.height - (panel.outerHeight() - panel.height()));
					pbody.height(panel.height() - pheader.outerHeight() - (pbody.outerHeight() - pbody.height()));
				} else {
					panel.height(opts.height);
					pbody.height(panel.height() - pheader.outerHeight());
				}
			} else {
				pbody.height('auto');
			}
			panel.css('height', null);
			this._trigger("resize",null,{target:this});
			$(">div",this.body).triggerHandler('_resize');
		},
		setTitle:function(title){
			var oldTitle = this.options.title;
			if(oldTitle != title){
				this.options.title = title;
				this.header.find('>div.oz-panel-title').html(title);
				this._trigger("titlechange");
			}
		},
		getSize:function(){
			var o = this.options;
			return {
				left:o.left,
				top:o.top,
				width:o.width,
				height:o.height
			};
		},
		move:function(left,top){
			var o = this.options;
	        var el = this.panel;
            if (left) {
                o.left = left;
            }
            if (top) {
                o.top = top;
            }
	        el.css({
	            left: o.left,
	            top: o.top
	        });
	        this._trigger("move",null,{left:o.left,top:o.top});
		},
		collapse:function (){
			var opts = this.options;
			if (opts.collapsed === true) {return true;}
			if (this._trigger("boforecollapse") === false){ return false;}
			this.body.hide();
			opts.collapsed = true;
			this._trigger("collapse",null,{target:this});
			return true;
		},		
		expand:function (){
			var opts = this.options;
			if (opts.collapsed === false) {return true;}
			if (this._trigger("beforeexpand") === false) {return false;}
			this.body.show();
			opts.collapsed = false;
			this._trigger("expand",null,{target:this});
			this._loadData();
			return true;
		},
		maximize:function (){
			var opts = this.options;
			if (opts.maximized === true && opts.minimized === false) {return true;}
			this.options.original = {
				width: opts.width,
				height: opts.height,
				left: opts.left,
				top: opts.top,
				fit: opts.fit
			};
			opts.left = 0;
			opts.top = 0;
			opts.fit = true;
			this.resize();
			opts.minimized = false;
			opts.maximized = true;
			this._trigger("maximize",null,{target:this});
			return true;
		},		
		minimize : function (){
			var opts = this.options;
			this.panel.hide();
			opts.minimized = true;
			opts.maximized = false;
			this._trigger("minimize",null,{target:this});
			return true;
		},	
		restore:function (){
			var opts = this.options;
			if (opts.maximized === false && opts.minimized === false){ return true;}
			this.panel.show();
			var original = opts.original;
			opts.width = original.width;
			opts.height = original.height;
			opts.left = original.left;
			opts.top = original.top;
			opts.fit = original.fit;
			this.resize();
			opts.minimized = false;
			opts.maximized = false;
			this._trigger("restore");
			return true;
		},
		close :function (forceClose){
			var opts = this.options;
			if(opts.closed === true){return true;}
			if (forceClose !== true){
				if (this._trigger("beforeclose",null,{target:this}) === false) {return false;}
			}
			this.panel.hide();
			opts.closed = true;
			this._trigger("close");
			return true;
		},
		open:function (forceOpen){
			var opts = this.options;
			if(opts.closed === false){
				return;
			}
			if (forceOpen !== true){
				if (this._trigger("beforeopen",null,{target:this}) === false) {return;}
			}
			this.panel.show();
			opts.closed = false;
			this._trigger("open");
			if (opts.maximized === true){ this.maximize();}
			if (opts.minimized === true){ this.minimize();}
			if (opts.collapsed === true){ this.collapse();}
			if (!opts.collapsed){
				this._loadData();
			}
		},
		destroy:function (forceDestroy){
			var opts = this.options;
			if (forceDestroy !== true){
				if (this._trigger("beforedestroy",null,{target:this}) === false){ return;}
			}
			this.base();
			this.panel.remove();
		},
		widget:function(){
			return this.panel;
		},
		_loadData:function(){
			var opts = this.options;
			if ((!this.isLoaded || !opts.cache)){
				if(opts.href){
					var self = this;
					this.isLoaded = false;
					var pbody = this.body;
					pbody.html($('<div class="oz-panel-loading"></div>').html(opts.loadingMessage));
					pbody.load(opts.href, null, function(){
						self._trigger("loaded",null,{args:arguments});
						self.isLoaded = true;
					});
				}else{
					if (opts.content){
						this.body.html(opts.content);
					}
					this.isLoaded = true;
				}
			}
		}
	});
	
	//设置版本
	$.extend(OZ.panel.Panel, {
		version: '1.0.0'
	});
	
	
	//扩展选项配置
	OZ.widget.options(OZ.panel.Panel,{
		collapsible: false,
        minimizable: false,
        maximizable: false,
        closable: false
    });
	
	//扩展工具配置
	OZ.panel.Panel.implement({
		_render:function(){
			var opts = this.options;
			if (opts.title && !opts.noheader){
				if (opts.closable){
					opts.tools.push({
						iconCls:"oz-panel-tool-close",
						handler:function(e){
							this.close();
							return false;
						}
					});
				}
				if (opts.maximizable){
					opts.tools.push({
						iconCls:"oz-panel-tool-max",
						handler:function(e){
							if ($(e.target).hasClass('oz-panel-tool-restore')){
								this.restore()&&($(e.target).removeClass('oz-panel-tool-restore'));
							} else {
								this.maximize()&&($(e.target).addClass('oz-panel-tool-restore'));
							}
							return false;
						}
					});
				}
				if (opts.minimizable){
					opts.tools.push({
						iconCls:"oz-panel-tool-min",
						handler:function(e){
							this.minimize();
							return false;
						}
					});
				}
				if (opts.collapsible){
					opts.tools.push({
						iconCls:"oz-panel-tool-collapse",
						title: this.options.collapsed ? "展开" : "折叠",
						handler:function(e){
							var btn = $(e.target);
							if (btn.hasClass('oz-panel-tool-expand')){
								this.expand(true) && (btn.removeClass('oz-panel-tool-expand'));
								btn.attr("title","折叠");
							} else {
								this.collapse(true) && (btn.addClass('oz-panel-tool-expand'));
								btn.attr("title","展开");
							}
							return false;
						}
					});
				}
			}
			this.base();
		}
	});
	
	OZ.widget("OZ.panel.ozPanel",{
		$type: "ozpanel",
		statics:{

		},
		options: {
		},
		_render:function(){
			var me = this,
				options = me.options;
			if(options.header){
				me.header = me.el.add("<div/>");
				me.header.addClass("x");
			}
		},
		_init:function(){
			
		}
	});
})(jQuery);