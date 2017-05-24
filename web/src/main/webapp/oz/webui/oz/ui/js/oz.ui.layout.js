(function($) {
	
var parseMargins = function(v){
	var ms = v.split(' ');
	var len = ms.length;
	if(len == 1){
		ms[1] = ms[0];
		ms[2] = ms[0];
		ms[3] = ms[0];
	}
	if(len == 2){
		ms[2] = ms[0];
		ms[3] = ms[1];
	}
	return {
		top:parseInt(ms[0], 10) || 0,
		right:parseInt(ms[1], 10) || 0,
		bottom:parseInt(ms[2], 10) || 0,
		left:parseInt(ms[3], 10) || 0
	};
};
var POS = {
	VERTICAL : 1,
	HORIZONTAL : 2,
	LEFT : 1,
	RIGHT :2,
	TOP : 3,
	BOTTOM: 4
};
function getPercentWidth($region){
	var p = $region.layoutRegion("option","pwidth") || null;
	if(p){
		p = parseFloat(p) || null;
	}
	return p;
}
function getPercentHeight($region){
	var p = $region.layoutRegion("option","pheight") || null;
	if(p){
		p = parseFloat(p) || null;
	}
	return p;
}

OZ.widget("OZ.layout.Splitbar",OZ.Mouse,{
	$type: "splitbar",
	options:{
		collapsible:true,
		resize:true
	},
	_render:function(){
		var self = this, o = this.options;
		this.target = o.target;
		this.orientation = o.orientation;
		this.placement = o.placement;
		this.width = o.width||5;
		this.maxSize = o.maxSize||500;
		this.minSize = o.minSize||10;
		
		this.element.addClass("oz-layout-split oz-layout-split-"+o.region).disableSelection();
				
		if(o.collapsible){
			this.collEl = $("<div/>").appendTo(this.element).addClass("oz-layout-mini oz-layout-mini-"+o.region).html("&#160;");
			this.collEl.hoverClass('oz-layout-mini-over');
			this.collEl.bind("click",{obj:this},this._onClick);
		}
		
		if(o.resize){
			//设置方向样式
			if(this.orientation == POS.HORIZONTAL){
				this.element.addClass("oz-layout-split-h");
			}else{
				this.element.addClass("oz-layout-split-v");
			}
			
			//创建代理
			var cls = 'oz-layout-split-proxy' ;
			this.proxy = $("<div/>").insertBefore(this.element)
			.addClass(cls + " " +(o.orientation == POS.HORIZONTAL ? cls +'-h' : cls + '-v'))
			.disableSelection().css({visibility:"hidden",display: "none"});
			this._mouseInit();
		}
	},
	_mouseStart: function(event) {
		var  o = this.options;
		//显示代理
		this.proxy.css(this.element.position()).css({visibility:"visible",display: "block"})
		.width(this.element.width()).height(this.element.height());
		//显示遮罩
		this.mark = $("<div></div>").addClass("oz-layout-mask oz-drag-overlay").insertAfter(this.element).disableSelection()
		.css({visibility:"visible",display: "block",width:$(window).width(),height: $(window).height()})
		.show();
		//记录其实位置
		this.originalMousePosition = {x: event.pageX, y: event.pageY};
		this.proxyPosition = this.proxy.position();
		if(o.orientation == POS.HORIZONTAL){
			this.oldSize = o.target.element.width();
		}else{
			this.oldSize = o.target.element.height();
		}
		
		if(this.placement == POS.RIGHT || this.placement == POS.BOTTOM){
			this.activeMinSize = this.oldSize - this.maxSize;
			this.activeMaxSize = this.oldSize - this.minSize;
		}else{
			this.activeMinSize = this.minSize - this.oldSize;
			this.activeMaxSize = this.maxSize - this.oldSize;
		}
	},
	_mouseDrag: function(e) {
		var pos = {x:e.pageX,y:e.pageY},
			smp = this.originalMousePosition,
			size;
		if(this.options.orientation == POS.HORIZONTAL){
			size = (pos.x - smp.x);
			if(this.activeMinSize > size || this.activeMaxSize < size){
				return;
			}
			this.size = size;
			this.proxy.css("left",this.proxyPosition.left + this.size);
		}else{
			size = (pos.y - smp.y);
			if(this.activeMinSize > size || this.activeMaxSize < size){
				return;
			}
			this.size = size;
			this.proxy.css("top",this.proxyPosition.top+ this.size);
		}
	},
	_mouseStop: function(e) {
		if(this.placement == POS.RIGHT || this.placement == POS.BOTTOM){
			this.size = -(this.size);
		}
		if(this.options.orientation == POS.HORIZONTAL){
			this.target.options.width = this.target.options.width+this.size;
			this.target.resize({layout:true});
		}else{
			this.target.options.height = this.target.options.height+this.size;
			this.target.resize({layout:true});
		}
		this.setPosition();
		this.proxy.css({visibility:"hidden",display: "none"});
		if(this.mark){this.mark.remove();}
	},
	setPosition:function(){
		var o = this.target.options;
		var h = o.height,w = o.width,l = o.left||0,t = o.top||0,pos;
		if(this.orientation == POS.HORIZONTAL){
			if(this.placement == POS.LEFT){
				pos={width:this.width,height:h,top:t,left:l+w};
			}else{
				pos={width:this.width,height:h,top:t,left:l-this.width};
			}				
		}else{
			if(this.placement == POS.TOP){
				pos={width:w,height:this.width,top:t+h,left:l};
			}else{
				pos={width:w,height:this.width,top:t-this.width,left:l};
			}				
		} 
		this.element.css(pos);
	},
	disable:function(){
		if(this.options.disabled === true){
			return;
		}
		this._mouseDestroy();
		this.base();
	},
	enable:function(){
		if(this.options.disabled !== true){
			return;
		}
		this._mouseInit();
		this.base();
	},
	_mapping:{
		north :"south",
		south : "north",
		east : "west",
		west : "east"
	},
	_onClick:function(e){
		var obj = e.data.obj;
		obj.collEl.swapClass("oz-layout-mini-"+obj.options.region,"oz-layout-mini-"+obj._mapping[obj.options.region]);
		if(obj.isCollapsed === true){
			obj.isCollapsed = false;
			obj.target.expand();
			obj.enable();
		}else{
			obj.isCollapsed = true;
			obj.target.collapse();
			obj.disable();
		}
	}
});

OZ.widget("OZ.layout.Region",OZ.panel.Panel,{
	$type: "layoutRegion",
	options:{
		margins:"0 0 0 0",
		cmargins:"0 0 0 0",
		maxSize:5000,
		minSize:30,
		split:false,
		collapsible:false
	},
	_render: function() {
		var self = this, o = this.options;
		o.fit = false;
		var c= o.collapsible;
		o.collapsible = false;
		this.base();
		o.collapsible = c;
		this.margins = parseMargins(o.margins);
		this.cmargins = parseMargins(o.cmargins);
		this.panel.addClass("oz-layout-region");
		this.layout = o.layout;
		
		if(o.split === true || o.collapsible === true){
			this.splitbar = $('<div></div>');
			this.splitbar.insertAfter(this.panel).splitbar($.extend(this._splitSettings[o.region],
					{maxSize:o.maxSize,minSize:o.minSize,region:o.region,target:this,collapsible:o.collapsible,resize:o.split}));
			this.element.bind("layoutregionresize",function(){
				self.splitbar.splitbar("setPosition");
			});
		}
	},
	resize:function(args){
		this.base(args);
		if(args && args.layout === true){
			this.layout.resize();
		}
	},
	getMargins:function(){
		return this.isCollapsed && this.cmargins ? this.cmargins : this.margins;
	},
	_splitSettings : {
		north : {
			orientation: POS.VERTICAL,
			placement: POS.TOP
		},
		south : {
			orientation: POS.VERTICAL,
			placement: POS.BOTTOM
		},
		east : {
			orientation: POS.HORIZONTAL,
			placement: POS.RIGHT
		},
		west : {
			orientation: POS.HORIZONTAL,
			placement: POS.LEFT
		}
	},
	collapse:function (){
		var o = this.options;
		o.original = {
				width: o.width,
				height: o.height
			};
		if(this._splitSettings[o.region].orientation == POS.HORIZONTAL){
			o.width = 0;
		}else{
			o.height = 0;
		}
		this.panel.css("visibility","hidden");
		this.resize({layout:true});
		o.collapsed = true;
		this._trigger("collapse");
	},		
	expand:function (){
		var o = this.options;
		var original = o.original;
		o.width = original.width;
		o.height = original.height;
		this.panel.css("visibility","visible");
		this.resize({layout:true});
		o.collapsed = false;
		this._trigger("expand");
	}
});
OZ.widget("OZ.layout.Border",{
	$type: "layout",
	options: {
		fit:false
	},
	_render: function() {
		var self = this, o = this.options,el = this.element;
		if (el[0].tagName == "BODY") {
			$("html").css({
				height: "100%",
				overflow: "hidden"
			});
			$("body").css({
				height: "100%",
				border: "none"
			});
		}
		el.addClass("oz-layout oz-layout-body");
		el.css({
			position:"relative",
			overflow:"hidden"
		});
		this.regions = {
			center:  $(">.oz-layout-center:first",el).layoutRegion({region:"center",layout:this}),
			north : $(">.oz-layout-north:first",el).layoutRegion({region:"north",layout:this}),
			south : $(">.oz-layout-south:first",el).layoutRegion({region:"south",layout:this}),
			east : $(">.oz-layout-east:first",el).layoutRegion({region:"east",layout:this}),
			west : $(">.oz-layout-west:first",el).layoutRegion({region:"west",layout:this})
		};
		
		if (el[0].tagName == "BODY") {
			$(window).resize(function(){
				self.resize();
			});
		}else{
			if (o.fit === true) {el.bind("_resize."+this.$type,function() {self.resize();return false;});}
		}
	},
	_init:function(){
		this.resize();
	},
	resize:function(){
		var o = this.options;
		if (o.fit === true){
			var p = this.element.parent();
			this.element.width(p.width()).height(p.height());
		}
		
		var width = this.element.width(), height = this.element.height();
		var centerW = width, centerH = height, centerY = 0, centerX = 0;
		var $north = this.regions.north, $south = this.regions.south, $west = this.regions.west, $east = this.regions.east, $center = this.regions.center;

		var size,margins,percentHeight,percentWidth,totalWidth;
		//北		
		if ($north.length) {
			size = $north.layoutRegion("getSize");
			margins = $north.layoutRegion("getMargins");
			size.width = width - (margins.left+margins.right);
			size.left = margins.left;
			size.top = margins.top;
			
			//计算百分比高度
			percentHeight = getPercentHeight($north);
			if(percentHeight) {size.height = height * percentHeight;}
			
			centerY = size.height + margins.top + margins.bottom;
			centerH -= centerY;
			$north.layoutRegion("resize",size);
		}		
		//南	
		if ($south.length) {
			size = $south.layoutRegion("getSize");
			margins = $south.layoutRegion("getMargins");
			size.width = width - (margins.left+margins.right);
			size.left = margins.left;
			
			//计算百分比高度
			percentHeight = getPercentHeight($south);
			if(percentHeight){
				size.height = height * percentHeight;
			}
			
			var totalHeight = (size.height + margins.top + margins.bottom);
			size.top = height - totalHeight + margins.top;
			centerH -= totalHeight;
			$south.layoutRegion("resize",size);
		}
		//西
		if ($west.length) {
			size = $west.layoutRegion("getSize");
			margins = $west.layoutRegion("getMargins");
			size.height = centerH - (margins.top+margins.bottom);
			size.left = margins.left;
			size.top = centerY + margins.top;
			
			//计算百分比宽度
			percentWidth = getPercentWidth($west);
			if(percentWidth){
				size.width = width * percentWidth;
			}
			
			totalWidth = (size.width + margins.left + margins.right);
			centerX += totalWidth;
			centerW -= totalWidth;
			$west.layoutRegion("resize",size); 
		}		
		//东
		if ($east.length) {
			size = $east.layoutRegion("getSize");
			margins = $east.layoutRegion("getMargins");
			size.height = centerH - (margins.top+margins.bottom);
			
			//计算百分比宽度
			percentWidth = getPercentWidth($east);
			if(percentWidth){
				size.width = width * percentWidth;
			}
			
			totalWidth = (size.width + margins.left + margins.right);
			size.left = width - totalWidth + margins.left;
			size.top = centerY + margins.top;
			centerW -= totalWidth;
			$east.layoutRegion("resize",size);		
		}
		//中
		if ($center.length) {
			margins = $center.layoutRegion("getMargins");
			var centerBox = {
				left: centerX + margins.left,
				top: centerY + margins.top,
				width: centerW - (margins.left+margins.right),
				height: centerH - (margins.top+margins.bottom)
			};
		   $center.layoutRegion("resize",centerBox);		
		}
		
		this._trigger("resize");
	}
});	

})(jQuery);