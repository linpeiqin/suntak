
//扩展JQuery对象的方法
(function($,undefined){
	
	var
		spacesRe = /\s+/,
	    wordsRe = /\w/g,
	    PADDING = 'padding',
	    MARGIN = 'margin',
	    BORDER = 'border',
	    LEFT = 'Left',
	    RIGHT = 'Right',
	    TOP = 'Top',
	    BOTTOM = 'Bottom',
	    WIDTH = 'Width',
	    // special markup used throughout Ext when box wrapping elements
	    borders = {l: BORDER + LEFT + WIDTH, r: BORDER + RIGHT + WIDTH, t: BORDER + TOP + WIDTH, b: BORDER + BOTTOM + WIDTH},
	    paddings = {l: PADDING + LEFT, r: PADDING + RIGHT, t: PADDING + TOP, b: PADDING + BOTTOM},
	    margins = {l: MARGIN + LEFT, r: MARGIN + RIGHT, t: MARGIN + TOP, b: MARGIN + BOTTOM},
	    position = {l:"left",r:"right",t:"top",b:"bottom"}
    
	
	// 设置浏览器信息
	$(function(){
		$.browser.msie && $.browser.version=="6.0" && $("body").addClass("oz-ie");
		//$.browser.msie && ($.browser.version=="6.0" || $.browser.version=="7.0") ? $("html").addClass("oz-strict") : $("html").addClass("oz-border-box");
		//$("body").addClass("oz-reset");
		
	});
	//@privite
	var addStyles = function(el, sides, styles){
	        var totalSize = 0,
	        sidesArr = sides.match(wordsRe),
	        i = 0,
	        len = sidesArr.length,
	        side, size;
	    for (; i < len; i++) {
	        side = sidesArr[i];
	        size = side && parseInt(el.css(styles[side]), 10);
	        if (size) {
	            totalSize += MATH.abs(size);
	        }
	    }
	    return totalSize;
	}
	
	//@privite
	var getStyles = function(el,styles){
		var result = {};
		$.each(position,function(n,v){
			result[v] = parseFloat(el.css(styles[n]));
		});
		return result;
	}
	
	//jQuery plugins
	$.fn.extend({
		_remove : $.fn.remove,
		remove : function( selector, keepData ) {
			var seft = this;
			return this.each(function() {
				if ( !keepData ) {
					if ( !selector || $.filter( selector, [ this ] ).length ) {
						$( "*", this ).add( this ).each(function() {
							$( this ).triggerHandler( "remove" );
						});
					}
				}
				return seft._remove.call( $(this), selector, keepData );
			});
		},		
		enableSelection: function() {
			return this.each(function () {
				if ($.browser.msie || $.browser.safari) $(this).unbind('selectstart');
				else if ($.browser.mozilla) $(this).css('MozUserSelect', 'inherit');
				else if ($.browser.opera) $(this).unbind('mousedown');
				else $(this).removeAttr('unselectable', 'on');
			});
		},
		disableSelection: function() {
			return this.each(function () {
				if ($.browser.msie || $.browser.safari) $(this).bind('selectstart', function () {
					return false;
				});
				else if ($.browser.mozilla) {
					$(this).css('MozUserSelect', 'none');
					$('body').trigger('focus');
				} else if ($.browser.opera) $(this).bind('mousedown', function () {
					return false;
				});
				else $(this).attr('unselectable', 'on');
			});
		},
		scrollParent: function() {
			var scrollParent;
			if (($.browser.msie && (/(static|relative)/).test(this.css('position'))) || (/absolute/).test(this.css('position'))) {
				scrollParent = this.parents().filter(function() {
					return (/(relative|absolute|fixed)/).test($.curCSS(this,'position',1)) && (/(auto|scroll)/).test($.curCSS(this,'overflow',1)+$.curCSS(this,'overflow-y',1)+$.curCSS(this,'overflow-x',1));
				}).eq(0);
			} else {
				scrollParent = this.parents().filter(function() {
					return (/(auto|scroll)/).test($.curCSS(this,'overflow',1)+$.curCSS(this,'overflow-y',1)+$.curCSS(this,'overflow-x',1));
				}).eq(0);
			}

			return (/fixed/).test(this.css('position')) || !scrollParent.length ? $(document) : scrollParent;
		},
		zIndex: function( zIndex ) {
			if ( zIndex !== undefined ) {
				return this.css( "zIndex", zIndex );
			}

			if ( this.length ) {
				var elem = $( this[ 0 ] ), position, value;
				while ( elem.length && elem[ 0 ] !== document ) {
					// Ignore z-index if position is set to a value where z-index is ignored by the browser
					// This makes behavior of this function consistent across browsers
					// WebKit always returns auto if the element is positioned
					position = elem.css( "position" );
					if ( position === "absolute" || position === "relative" || position === "fixed" ) {
						// IE returns 0 when zIndex is not specified
						// other browsers return a string
						// we ignore the case of nested elements with an explicit value of 0
						// <div style="z-index: -10;"><div style="z-index: 0;"></div></div>
						value = parseInt( elem.css( "zIndex" ) );
						if ( !isNaN( value ) && value != 0 ) {
							return value;
						}
					}
					elem = elem.parent();
				}
			}

			return 0;
		},
		hoverClass: function(className) {
			className = className || "hover";
			return this.hover(function() {
				$(this).addClass(className);
			}, function() {
				$(this).removeClass(className);
			});
		},
		swapClass: function(c1, c2) {
			var c1Elements = this.filter('.' + c1);
			this.filter('.' + c2).removeClass(c2).addClass(c1);
			c1Elements.removeClass(c1).addClass(c2);
			return this;
		},
		offsetsTo:function(el){
			var o = this.position();
			var e = el.position();
			return [o.left-e.left,o.top-e.top];
		},
		margin: function(){
			return getStyles(this,margins);
		},
		padding: function(){
			return getStyles(this,paddings);
		},
		border: function(){
			return getStyles(this,borders);
		},
		getBorderWidth : function(side){
	        return addStyles(this,side, borders);
        },
        getPadding : function(side){
            return addStyles(this,side, paddings);
        },
        getMargin : function(side){
            return addStyles(this,side, margins);
        },
		id: function(prefix){
			var ids = this.map(function(){
				var el = this;
		        if (el === document) {
		            el.id = OZ.documentId;
		        }
		        else if (el === window) {
		            el.id = OZ.windowId;
		        }
		        if (!el.id) {
		            el.id = (prefix || "oz-gen") + (++OZ.idSeed);
		        }
		        return el.id;
			});
			if(ids.size() == 1){
				return ids[0];
			}
			return ids;
		}
	});
	
	$.each( [ "Width", "Height" ], function( i, name ) {
		var side = name === "Width" ? [ "Left", "Right" ] : [ "Top", "Bottom" ],
			type = name.toLowerCase(),
			orig = {
				innerWidth: $.fn.innerWidth,
				innerHeight: $.fn.innerHeight,
				outerWidth: $.fn.outerWidth,
				outerHeight: $.fn.outerHeight
			};

		function reduce( elem, size, border, margin ) {
			$.each( side, function() {
				size -= parseFloat( $.css( elem, "padding" + this, true) ) || 0;
				if ( border ) {
					size -= parseFloat( $.css( elem, "border" + this + "Width", true) ) || 0;
				}
				if ( margin ) {
					size -= parseFloat( $.css( elem, "margin" + this, true) ) || 0;
				}
			});
			return size;
		}

		$.fn[ "inner" + name ] = function( size ) {
			if ( size === undefined ) {
				return orig[ "inner" + name ].call( this );
			}

			return this.each(function() {
				$.style( this, type, reduce( this, size ) + "px" );
			});
		};

		$.fn[ "outer" + name] = function( size, margin ) {
			if ( typeof size !== "number" ) {
				return orig[ "outer" + name ].call( this, size );
			}

			return this.each(function() {
				$.style( this, type, reduce( this, size, true, margin ) + "px" );
			});
		};
		
		$.fn[ "real" + name ] = function( size ) {
			if ( size === undefined ) {
				return orig[ type ].call( this );
			}

			return this.each(function() {
				$.style( this, type, reduce( this, size, true) + "px" );
			});
		};
	});
	

	//添加额外的JQuery选择器
	function visible( element ) {
		return !$( element ).parents().andSelf().filter(function() {
			return $.curCSS( this, "visibility" ) === "hidden" ||
				$.expr.filters.hidden( this );
		}).length;
	}

	$.extend( $.expr[ ":" ], {
		data: function( elem, i, match ) {
			return !!$.data( elem, match[ 3 ] );
		},

		focusable: function( element ) {
			var nodeName = element.nodeName.toLowerCase(),
				tabIndex = $.attr( element, "tabindex" );
			if ( "area" === nodeName ) {
				var map = element.parentNode,
					mapName = map.name,
					img;
				if ( !element.href || !mapName || map.nodeName.toLowerCase() !== "map" ) {
					return false;
				}
				img = $( "img[usemap=#" + mapName + "]" )[0];
				return !!img && visible( img );
			}
			return ( /input|select|textarea|button|object/.test( nodeName )
				? !element.disabled
				: "a" == nodeName
					? element.href || !isNaN( tabIndex )
					: !isNaN( tabIndex ))
				// the element and all of its ancestors must be visible
				&& visible( element );
		},

		tabbable: function( element ) {
			var tabIndex = $.attr( element, "tabindex" );
			return ( isNaN( tabIndex ) || tabIndex >= 0 ) && $( element ).is( ":focusable" );
		}
	});
})(jQuery,OZ);


/**
 * 插件的核心
 */
(function($) {
	OZ.baseCSSPrefix = "oz-";
	
	OZ.ComponentManager = {
			components:{},
			get:function(id){
				if(id in components){
					return this.components[id];
				}
				return null;
			},
			register:function(cmp){
				this.components[cmp.getId()] = cmp;
			}
		};
	
	OZ.define("OZ.Component",{
		statics: {
			AUTO_ID:0
		},
		isComponent: true,
		getAutoId: function() {
			return ++OZ.Component.AUTO_ID;
		},
		renderTpl: null,
		disabledCls: OZ.baseCSSPrefix + 'item-disabled',
	    disabled: false,
	    draggable: false,
	    rendered: false,
		constructor: function(config) {
			var me = this,
	            i, len;

	        config = config || {};
	        me.initialConfig = config;
	        $.extend(me, config);
	        
	        me.getId();

	        me.mons = [];
	        me.additionalCls = [];
	        me.renderData = me.renderData || {};
	        me.renderSelectors = me.renderSelectors || {};
	        
	        if (me.plugins) {
	            me.plugins = [].concat(me.plugins);
	            for (i = 0, len = me.plugins.length; i < len; i++) {
	                me.plugins[i] = me.constructPlugin(me.plugins[i]);
	            }
	        }
	        
	        me.initComponent();
	        OZ.ComponentManager.register(me);
	        
	        if (me.plugins) {
	            me.plugins = [].concat(me.plugins);
	            for (i = 0, len = me.plugins.length; i < len; i++) {
	                me.plugins[i] = me.initPlugin(me.plugins[i]);
	            }
	        }
	        
	        if (me.renderTo) {
	            me.render(me.renderTo);
	        }

	        if (me.autoShow) {
	            me.show();
	        }
			return me;
		},
		initComponent: OZ.noop,
	    show: OZ.noop,
	    constructPlugin: function(plugin) {
	        if (plugin.ptype && typeof plugin.init != 'function') {
	            plugin.cmp = this;
	            plugin = Ext.PluginManager.create(plugin);
	        }
	        else if (typeof plugin == 'string') {
	            plugin = Ext.PluginManager.create({
	                ptype: plugin,
	                cmp: this
	            });
	        }
	        return plugin;
	    },
	    initPlugin : function(plugin) {
	        plugin.init(this);

	        return plugin;
	    },
	    getId: function(){
			 return this.id || (this.id = 'oz-cmp-' + (this.getAutoId()));
		}
	});
	
	/**
	 * 插件对象管理
	 */
	OZ.WidgetManager = {
			widgets:{},
			getWidget:function(id){
				if(id in widgets){
					return this.widgets[id];
				}
				return null;
			},
			regWidget:function(id,widget){
				this.widgets[id] = widget;
			}
		};
	
	/**
	 * 插件基类，后面实现的插件，都会继承插件的方法
	 */
	OZ.define("OZ.Widget",{
		statics: {
			AUTO_ID:0
		},
		options: {
			disabled: false
		},
		$type: "widget",
		baseCls: "oz-widget",
		eventPrefix: "oz-",
		/**
		 * 构造方法
		 * 
		 * @param options 属性
		 * @param element 渲染的对象
		 */
		constructor: function(options) {
			var me = this;
			me.el = $( options.el );
			me.el.dom = me.el[0];
			
			//无效
			me.element = me.el;
			me.dom = me.el.dom;
			
			me._parseOptions(options);
			me._initWidget();
			me._render();
			me._init();
			return me;
		},
		instance:function(){
			return this;
		},
		_initWidget:function(){
			var me = this;
			me.el.data( "widget-"+ me.$type, me );
			me.data = me.el.data();
			me.getId();
			OZ.WidgetManager.regWidget(me.getId(),me);
			me.el.hasClass(me.baseCls) || me.el.addClass(me.baseCls);
			me.el.bind( "remove." + me.$type, function() {
				me.destroy();
			});
		},
		getAutoId: function() {
			return ++OZ.Widget.AUTO_ID;
		},
		getId: function(){
			 return this.id || (this.id = 'oz-widget-' + (this.getAutoId()));
		},
		_parseOptions:function(options){
			var me = this;
			me.options = OZ.extend(true,{},me.options,me._parseDomOptions(),options );
		},
		_parseDomOptions:function(){return {};},
		_render: OZ.noop,
		_init: OZ.noop,
		/**
		 * 销毁做的操作，移除对象所有绑定的事件和数据
		 */
		destroy: function() {
			this.el
				.unbind( "." + this.$type )
				.removeData( this.$type );
			this.widget()
				.unbind( "." + this.$type )
				.removeAttr( "aria-disabled" )
				.removeClass(
					this.baseCls + "-disabled " +
					"ui-state-disabled" );
		},
		/**
		 * 获取对象的Dom Element对象 
		 */
		getDom: function(){
			return this.dom;
		},
		getEl: function(){
			return this.el;
		},
		/**
		 * 返回Jquery对象
		 */
		widget: function() {
			return this.el;
		},
		/**
		 * 设置对象的参数。
		 * 
		 * @param key 属性名称
		 * @param value 属性值
		 */
		option: function( key, value ) {
			var options = key,
				self = this;
			//无参数返回所有参数
			if ( arguments.length === 0 ) {
				// don't return a reference to the internal hash
				return OZ.extend( {}, self.options );
			}
			//字符：没有传值，返回对于值，传值，设置值。
			if  (typeof key === "string" ) {
				if ( value === undefined ) {
					return this.options[ key ];
				}
				options = {};
				options[ key ] = value;
			}
			//对象：设置属性到选项中。
			$.each( options, function( key, value ) {
				self._setOption( key, value );
			});

			return self;
		},
		//内部设置属性方法
		_setOption: function( key, value ) {
			this.options[ key ] = value;

			if ( key === "disabled" ) {
				this.widget()
					[ value ? "addClass" : "removeClass"](
						this.baseCls + "-disabled" + " " +
						"oz-state-disabled" )
					.attr( "aria-disabled", value );
			}

			return this;
		},
		/**
		 * 启用属性
		 */
		enable: function() {
			this._trigger("enable");
			return this._setOption( "disabled", false );
		},
		/**
		 * 禁用对象
		 */
		disable: function() {
			this._trigger("disable");
			return this._setOption( "disabled", true );
		},
		setSize: function(width,height){
			 var me = this,
	            layoutCollection;

	        // support for standard size objects
	        if (OZ.isObject(width)) {
	            height = width.height;
	            width  = width.width;
	        }

	        // Constrain within configured maxima
	        if (OZ.isNumber(width)) {
	            width = OZ.Number.constrain(width, me.minWidth, me.maxWidth);
	        }
	        if (OZ.isNumber(height)) {
	            height = OZ.Number.constrain(height, me.minHeight, me.maxHeight);
	        }
			this.el.width(width).height(height);
		},
		/**
		 * 触发事件
		 * 
		 * @param type 事件名称
		 * @param event 根源事件
		 * @param data 事件传递过去的数据
		 */
		_trigger: function( type, event, data ) {
			//options是否有事件配置
			var callback = this.options[ type ];
			
			event = $.Event( event );
			event.type = ( type === this.eventPrefix ? type : this.eventPrefix + type ).toLowerCase();
			data = data || {};
			
			if ( event.originalEvent ) {
				for ( var i = $.event.props.length, prop; i; ) {
					prop = $.event.props[ --i ];
					event[ prop ] = event.originalEvent[ prop ];
				}
			}

			this.el.trigger( event, data );
			
			data = $.makeArray(data);
			data.unshift( event );
			return !( $.isFunction(callback) && callback.apply( this.dom , data ) === false || event.isDefaultPrevented() );
		},
		toString: function() {
			return String(this.$name + "=" + this.valueOf());
		},
		plugins:{},
		_call:function(action, args) {
			var set = this.plugins[action];
			if(!set || !this.dom.parentNode) { 
				return; 
			}
			for (var i = 0; i < set.length; i++) {
				if (this.options[set[i][0]]) {
					set[i][1].apply(this.el, args);
				}
			}
		}
	});

	/**
	 * 构造插件的方法类
	 * @param className 插件的名称
	 * @param base 集成的插件类
	 * @param prototype 实现的新的方法
	 */
	OZ.widget = function(className, superClass, prototype ) {
		var widgetClass;
		if ( !prototype ) {
			prototype = superClass;
			superClass = OZ.Widget;
		}
		
		var $type = prototype.$type || (className.replace(/[\\.]/g,"").toLowerCase);
		
		//附加一些插件需要用到的属性
		var classData = OZ.extend(true,prototype,{
			extend:superClass.$name,
			$name: className,
			baseCls: "oz-" + $type,
			eventPrefix : prototype.eventPrefix || $type
		});
		
		//创建空间中的插件
		widgetClass = superClass.extend(classData);
		
		OZ.ClassManager.setNamespace(className,widgetClass);
		
		widgetClass.plugin  = function(name, set) {
			var proto = this.prototype;
			for(var action in set) {
				proto.plugins[action] = proto.plugins[action] || [];
				proto.plugins[action].push([name, set[action]]);
			}
		}
		
		//jquery fn
		if($type){
			// 添加该插件的选择器，eg：$("div:oz-layout");
			$.expr[ ":" ][ $type ] = function( elem ) {
				return !!$.data( elem, "widget-"+$type );
			};
			OZ.widget.jqueryBridge($type, widgetClass,"widget-"+$type);
		}
		
		return widgetClass;
	};

	/**
	 * 构建JQuery的插件的代理方法
	 * 在使用的时候，可以通过$("id").widgetName("funcName",arguments);
	 */
	OZ.widget.jqueryBridge = function( name, cls ,dataName) {
		$.fn[ name ] = function( options ) {
			var isMethodCall = typeof options === "string",
				args = Array.prototype.slice.call( arguments, 1 ),
				returnValue = this;

			if ( isMethodCall ) {
				var methodName = options;
				// 防止调用内部函数
				if (methodName.substring( 0, 1 ) === "_" || methodName === "constructor") {
					return returnValue;
				}
				this.each(function() {
					var instance = $.data( this, dataName ),
						methodValue = instance && $.isFunction( instance[methodName] ) ?
							instance[ methodName ].apply( instance, args ) :
							instance;
					if(methodName=="option"){
						returnValue = methodValue;
						return false;
					}
					if (methodValue !== instance && methodValue !== undefined ) {
						returnValue = methodValue;
						return false;
					}
				});
			} else {
				// 允许多个对象参数，汇总到一个options中
				options = args.length ?	OZ.extend.apply( null, [ true, options ].concat(args) ) : options;
				this.each(function() {
					var instance = $.data( this, dataName );
					//如果已经创有实例，则再次设置参数来初始化对象。
					//如果没有，则创建具体实例。
					if ( instance ) {
						if ( options ) {
							instance.option( options );
						}
						instance._init();
					} else {
						var data = $(this).data() || {};
						var widgetDate = data[name];
						if(typeof widgetDate == "string"){
							widgetDate = eval("(" + widgetDate + ")");
						}
						var metadata = {};
//						if($.metadata){
//							metadata = $.metadata.get(this)[name] || $.metadata.get(this,{single:"metadata-"+name,type:name,name:name});
//						}
						var newoptions =  {el: this};
						OZ.extend(true,newoptions,metadata,widgetDate,options);
						$.data( this, dataName, new cls(newoptions) );
					}
				});
			}
			return returnValue;
		};
	};
	
	/**
	 * 修改插件默认值
	 * @param clazz 扩展的类名
	 * @param options 设置的参数信息
	 * @param deep 是否深度复制，在复制对象的时候考虑
	 */
	OZ.widget.options = function(clazz,options,deep){
		clazz.implement(function(p){
			OZ.extend(deep||false,p.options,options);
		});
	};
		
	
})(jQuery);