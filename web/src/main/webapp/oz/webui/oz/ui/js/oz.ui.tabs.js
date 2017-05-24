(function($) {
	var tabId = 1000;
	
	function getNextTabId(){
		return ++tabId;
	}
	
	OZ.widget("OZ.tab.Panel",OZ.panel.Panel,{
		$type: "tabPanel",
		options:{
			id: null,
			iconCls:'',
			title: "无标题",
			refresh: false,
			selected:false,
			noheader:true,
			closable: false,
			closed:true
		}
	});
	
	OZ.widget("OZ.tab.Tabs",{
		$type: "tabs",
		options:{
			width: "auto",
			height: "auto",
			border:true,
			maxtab:25,
			pos:"top",
			enableTabScroll:true,
			tabWidth:100,
			scrollIncrement:0,
			plain:false
		},
		_parseDomOptions:function(){
			var t = this.element;
			return {
				width: (parseInt(t.css('width'),10) || undefined),
				height: (parseInt(t.css('height'),10) || undefined)
			};
		},
		_render: function() {
			var el = this.element;
			var o = this.options;
			var self = this;
			this.tabs = [];
			
			this.tbctBaseCls = o.pos=="top"?"header":"footer";
			this.element.addClass("oz-tabs-panel").wrapInner('<div class="oz-tabs-body oz-tabs-body-'+o.pos+'"></div>');
			this.body = this.element.find(">div.oz-tabs-body");	
			
			this.tbct = $("<div class='oz-tabs-"+this.tbctBaseCls+"'><div class='oz-tabs-scroller-left'></div><div class='oz-tabs-scroller-right'></div><div class='oz-tabs-strip-wrap'><ul class='oz-tabs-strip oz-tabs-strip-"+o.pos+"'><li class='oz-tabs-edge'/><div class='oz-clear'/></ul></div></div>");
			
			if(o.pos=="top"){
				this.body.before(this.tbct);
			}else{
				this.body.after(this.tbct);
			}
			
			if(o.plain){
				this.tbct.addClass("oz-tabs-"+this.tbctBaseCls+"-plain");
			}
			if (o.border === true){
				this.tbct.removeClass('oz-tabs-'+this.tbctBaseCls+'-noborder');
				this.body.removeClass('oz-tabs-body-noborder');
			} else {
				this.tbct.addClass('oz-tabs-'+this.tbctBaseCls+'-noborder');
				this.body.addClass('oz-tabs-body-noborder');
			}
			this.stripWrap = $(".oz-tabs-strip-wrap",this.tbct);
			if(o.pos=="top"){
				this.stripWrap.after("<div class='oz-tabs-strip-spacer'/>");
			}else{
				this.stripWrap.before("<div class='oz-tabs-strip-spacer'/>");
			}
			this.stripSpacer = $(".oz-tabs-strip-spacer",this.tbct);
			this.strip = $(".oz-tabs-strip",this.stripWrap);
			this.edge =$(".oz-tabs-edge",this.strip);
			this.rendered = true;
			
			
			this.scrollLeft = $(".oz-tabs-scroller-left",this.tbct).disableSelection().hoverClass("oz-tabs-scroller-left-over")
			.bind("click."+this.$type,$.proxy(this,"_onScrollLeft"));
			this.scrollRight = $(".oz-tabs-scroller-right",this.tbct).disableSelection().hoverClass("oz-tabs-scroller-right-over")
			.bind("click."+this.$type,$.proxy(this,"_onScrollRight"));
			
			if (o.fit === true){
				this.element.bind('_resize.'+this.$type, function(){
					self.resize();
					return false;
				});
			}
		},
		_init:function(){
			var self = this,o = this.options;
			this.element.css('display','block');
			this.resize();
			$(">div", this.body).each(function() {
				var pp = $(this);
				self.tabs.push(pp);
				self._createTab(pp,pp.data("tabPanel"));
			});
		},
		resize:function(param){
			var o = this.options;
			var panel = this.element;
			var tbct = this.tbct;
			var body = this.body;
			if (param){
				if (param.width){ o.width = param.width;}
				if (param.height){ o.height = param.height;}
				if (param.left != null){ o.left = param.left;}
				if (param.top != null){ o.top = param.top;}
			}
			if (o.fit === true){
				var p = panel.parent();
				o.width = p.width();
				o.height = p.height();
			}
			if (!isNaN(o.width)){
//				if ($.boxModel === true){
					panel.width(o.width - (panel.outerWidth() - panel.width()));
					tbct.width(panel.width() - (tbct.outerWidth() - tbct.width()));
					body.width(panel.width() - (body.outerWidth() - body.width()));
//				} else {
//					panel.width(o.width);
//					tbct.width(panel.width());
//					body.width(panel.width());
//				}
			} else {
				panel.width('auto');
				body.width('auto');
			}
			if (!isNaN(o.height)){
//				if ($.boxModel === true){
					panel.height(o.height - (panel.outerHeight() - panel.height()));
					body.height(panel.height() - tbct.outerHeight() - (body.outerHeight() - body.height()));
//				} else {
//					panel.height(o.height);
//					body.height(panel.height() - tbct.outerHeight());
//				}
			} else {
				body.height('auto');
			}
			panel.css('height', null);
			
			var f = this.getActive();
			for ( var i = 0; i < this.tabs.length; i++) {
				var tab = this.tabs[i];
				if(f == tab){
					tab.tabPanel('resize');
				}else{
					tab.tabPanel("option","doResize",true);
				}
			}
			
			this._autoScrollTabs();
		},
		add:function(config){
			var self = this,o = this.options;
			if( $.isArray(config)){
				$.each(config,function(){
					this.active = false;
					self.add(this);
				});
				self.activeTab(config[config.length-1].id);
				return;
			}
			if(config.id){			
				var tab = this.activeTab(config.id);
				if(tab){return;}
			}
			// 判断是否可以新建一个窗口
			if(o.maxtab == -1 || this.tabs.length >= o.maxtab){
				//TODO  添加事件
				//this.fireEvent("maxtab",this,config);
				return;
			}
			var panel = $('<div></div>').attr('title', config.title).appendTo(this.body);
			this.tabs.push(panel);
			this._createTab(panel,config);
		},
		_createTab:function(panel,config){
			config = $.extend({active:true},config);
			var self  = this,o = this.options;
			var act = this.getActive();
			var fit={width:true,height:true};
			if(o.width=="auto"){
				fit.width=false;
			}
			if(o.height=="auto"){
				fit.height=false;
			}
			config.fit = fit;
			
			config.id = config.id || 'gen-tabs-panel' + getNextTabId();
			
			config.opener = act?act.tabPanel("option","id"):null;
					
			var tabHtml =['<li><a class="oz-tabs-strip-close" onclick="return false;"></a>',
							'<a class="oz-tabs-right" href="javascript:void(0)" onclick="return false;"><em class="oz-tabs-left">',
							'<span class="oz-tabs-strip-inner"><span class="oz-tabs-strip-text '+config.iconCls+'\">'+config.title+'</span></span>',
							'</em></a></li>'].join("");
			var tab = $(tabHtml).attr({title:config.tabTip||config.title}).insertBefore($("li:last",this.strip));
			
			if(config.iconCls){
				tab.addClass("oz-tabs-with-icon");
			}
			if(config.closable){
				tab.addClass("oz-tabs-strip-closable");
				$(".oz-tabs-strip-close",tab).bind("click."+this.$type,function(){
					self.close(config.id);
				});
			}
			tab.hoverClass("oz-tabs-strip-over");
			
			if(o.tabWidth > 0){
//				if ($.boxModel === true) {
					tab.width(o.tabWidth - (tab.outerWidth(true) - tab.width()));
//				}else{
//					tab.width(o.tabWidth);
//				}
			}
			
			$.data(tab[0],"tabs.id",config.id);
			
			tab.bind("click."+this.$type,function(ev){
				self.activeTab(panel);
			});
					
			tab.bind("contextmenu."+this.$type,function(ev){
				self._trigger("contextbmenu",ev,{tab:config.id,x:ev.pageX,y:ev.pageY});
				return false;
			});
			
			panel.tabPanel($.extend(config,{
				open:function(){
					tab.addClass("oz-tabs-strip-active");
					if(panel.tabPanel("option","doResize")){
						panel.tabPanel('resize');
						panel.tabPanel("option","doResize",false);
					}
					if(self.scrolling){
						self.scrollToTab(panel);
					}
				},
				close:function(){tab.removeClass("oz-tabs-strip-active");},
				beforedestroy:function(){tab.remove();self._autoScrollTabs();},
				disable:function(){tab.addClass("oz-item-disabled");},
				enable:function(){tab.removeClass("oz-item-disabled");},
				titlechange:function(){$(".oz-tabs-strip-inner>span",tab).text($(this).tabPanel("option","title"));},
				tab:tab
			}));
			if(!act || config.active){
				this.activeTab(panel);
			}
			this._autoScrollTabs();
			if(this.tabs.length==1){
				this.resize();
			}
		},
		close:function(o){
			var tabs  = this.tabs;
			if(typeof o =="string"){ o = this.findById(o);}
			if(o){
				if(this._trigger("beforeclose",null,{tabs:this,tab:o}) === false){
					return o;
				}
				var curr = this.getActive();
				var currentId = curr.tabPanel("option","id");
				var closeId = o.tabPanel("option","id")
				this.findById(closeId,true);
				if(currentId == closeId){
					var op,d;
					(d = o.tabPanel("option","opener"))&& d && (op = this.activeTab(d));
					!op && tabs.length > 0 && this.activeTab(tabs[0]);
				}
				this._trigger("close",null,{tabs:this,tab:o});
				o.remove();
			}
		},
		findById:function(tabId,remove){
			var self = this;
			return this.find(function(tab,i,tabs){
				var f = tab.tabPanel("option","id")==tabId;
				f&&remove&&tabs.splice(i, 1);
				return f;
			});
		},
		activeTab:function(tab){
			if(typeof tab =="string"){ tab = this.findById(tab);}
			if(typeof tab =="number"){ tab = this.tabs[0];}
			if(tab){
				if(this._trigger("beforeactive",null,{tabs:this,tab:tab}) === false){
					return tab;
				}
				var a = this.getActive();
				a&&a.tabPanel("close");
				var result = tab.tabPanel("open");
				this._trigger("active",null,{tabs:this,tab:tab});
				return result;
			}
			return null;
		},
		getActive:function(){
			return this.find(function(tab){
				return tab.tabPanel("option","closed") !== true;
			});
		},
		find:function(fn){
			var tabs = this.tabs;
			for ( var i = 0; i < tabs.length; i++) {
				var tab = tabs[i];
				if(fn(tab,i,tabs)){
					return tab;
				}
			}
			return null;
		},
		scrollToTab : function(item){
			if(!item){ return; }
			var tab = item.tabPanel("option","tab");
			var pos = this._getScrollPos(), area = this._getScrollArea();
			var left = tab.position().left + pos;
			var right = left + tab.outerWidth(true);
			if(left < pos){
				this._scrollTo(left);
			}else if(right > (pos + area)){
				this._scrollTo(right - area);
			}
		},
		_autoScrollTabs : function(){
			var count = this.tabCount;
			var ow = this.tbct.outerWidth();
			var tw = this.tbct.width();
			var stripWrap = this.stripWrap;
			var cw = stripWrap.outerWidth();
			var pos = this._getScrollPos();
			var l = this.edge.position().left + pos;
			if(l <= tw){
				stripWrap.scrollLeft(0);
				stripWrap.width(tw);
				if(this.scrolling){
					this.scrolling = false;
					this.tbct.removeClass('oz-tabs-scrolling');
				}
			}else{
				if(!this.scrolling){
					this.tbct.addClass('oz-tabs-scrolling');
				}
				stripWrap.width(tw-this.scrollLeft.width()-this.scrollRight.width());
				this.scrolling = true;
				if(pos > (l-tw)){
					stripWrap.scrollLeft(l-tw);
				}else{
					this.scrollToTab(this.getActive());
				}
				this._updateScrollButtons();
			}
		},
		_getScrollWidth : function(){
			return this.edge.position().left + this._getScrollPos();
		},
		_getScrollPos : function(){
			return this.stripWrap.scrollLeft();
		},
		_getScrollArea : function(){
			return this.stripWrap.width();
		},
		_getScrollIncrement : function(){
			var o  = this.options;
			return o.scrollIncrement || o.tabWidth || this.lastTabWidth || 100;
		},
		_scrollTo : function(pos){
			this.stripWrap.scrollLeft(pos);
			this._updateScrollButtons();
		},
		_onScrollRight : function(){
			if(this.scrollRight.hasClass("oz-tabs-scroller-right-disabled")){ return;}
			var sw = this._getScrollWidth()-this._getScrollArea();
			var pos = this._getScrollPos();
			var s = Math.min(sw, pos + this._getScrollIncrement());
			if(s != pos){
				this._scrollTo(s);
			}
		},
		_onScrollLeft : function(){
			if(this.scrollLeft.hasClass("oz-tabs-scroller-left-disabled")){ return;}
			var pos = this._getScrollPos();
			var s = Math.max(0, pos - this._getScrollIncrement());
			if(s != pos){
				this._scrollTo(s);
			}
		},
		_updateScrollButtons : function(){
			var pos = this._getScrollPos();
			this.scrollLeft[pos === 0 || pos == 1 ? 'addClass' : 'removeClass']('oz-tabs-scroller-left-disabled');
			this.scrollRight[pos >= (this._getScrollWidth()-this._getScrollArea()) ? 'addClass' : 'removeClass']('oz-tabs-scroller-right-disabled');
		}
	});
	
	//实现其他的方法
	OZ.tab.Tabs.implement({
		//关闭所有窗口
		closeAll:function(){
			var tabs  = this.tabs;
			for (var i = tabs.length-1; i>=0 ; i--) {
				var tab = tabs[i];
				if(tab.tabPanel("option","closable")===true){
					tabs.splice(i, 1);
					tab.remove();
				}
			}
			tabs.length > 0 && this.activeTab(tabs[0]);
		},
		//关闭其他所有窗口
		closeOther:function(closeTab){
			var tabs  = this.tabs;
			closeTab = closeTab || this.getActive();
			if(typeof closeTab =="string"){ closeTab = this.findById(closeTab);}
			for (var i = tabs.length-1; i>=0 ; i--) {
				var tab = tabs[i];
				if(tab.tabPanel("option","closable")===true && tab!=closeTab){
					tabs.splice(i, 1);
					tab.remove();
				}
			}
			closeTab && this.activeTab(closeTab) ;
		},
		//关闭当前窗口
		closeActive:function(){
			var a = this.getActive();
			if(a){
				this.close(a);
			}
		}
	});
})(jQuery);