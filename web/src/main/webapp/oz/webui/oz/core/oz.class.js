/////////////////////////////////////////////////////////////////////////////////////////
//实现继承的核心
//var NewClass = Class.extend({});
//构造出来的NewClass可以继承构造函数和基本属性函数的添加;
//var classObj = new Class();
//obj.extend({}) 只是单纯属性的添加。
(function($) {
	
	var flexSetter = function(fn) {
        return function(a, b) {
            var k, i;
            if (a === null) {
                return this;
            }
            if (typeof a !== 'string') {
                for (k in a) {
                    if (a.hasOwnProperty(k)) {
                        fn.call(this, k, a[k]);
                    }
                }
            } else {
                fn.call(this, a, b);
            }

            return this;
        };
    };
	
	var Class,
		initializing = false;
	
	OZ.Class = Class = function() {
//		if (!initializing) {
//			return this.constructor.apply(this, arguments);
//		}else{
//			return Class.extend.apply(this,arguments);
//		}
	};
	
	// 初始化基类
	OZ.extend(Class,{
		ancestor: Object,
		version: "1.0.0",
		preprocessors: {},
		registerPreprocessor: function(name, fn, always) {
			   this.preprocessors[name] = {
				   name: name,
				   always: always ||  false,
				   fn: fn
			   };
			   return this;
		}, 
		getPreprocessor: function(name) {
			return this.preprocessors[name];
		},
		getPreprocessors: function() {
			return this.preprocessors;
		},
		getDefaultPreprocessors: function() {
			return this.defaultPreprocessors || [];
		},
		setDefaultPreprocessors: function(preprocessors) {
			this.defaultPreprocessors = OZ.toArray(preprocessors);
			return this;
		},
		/**
		 * 类的继承
		 * @param _instance 实例对象方法
		 * @param _static 类的静态方法
		 */
		extend : function(_instance) {
			var extend = Class.prototype.extend;
			
			//创建属性(prototype)
			var proto,_constructor;
			
			//的构造函数
			var klass = function() {
				//在实现extend的过程是不是用下面方法，即上面的new this。
				if (!initializing) {
					return this.constructor.apply(this, arguments);
				}
			};
			
			klass.extend = Class.extend;
			klass.implement = Class.implement;
			klass.ancestor = this;
			
			//处理特殊属性
			var preprocessorStack = _instance.preprocessors || Class.getDefaultPreprocessors(),
			registeredPreprocessors = Class.getPreprocessors(),
			preprocessors = [],preprocessor,process,index = 0;
			
			delete _instance.preprocessors;

			for (j = 0, ln = preprocessorStack.length; j < ln; j++) {
				preprocessor = preprocessorStack[j];
				if (typeof preprocessor === 'string') {
					preprocessor = registeredPreprocessors[preprocessor];
					if (!preprocessor.always) {
						if (_instance.hasOwnProperty(preprocessor.name)) {
							preprocessors.push(preprocessor.fn);
						}
					}
					else {
						preprocessors.push(preprocessor.fn);
					}
				}
				else {
					preprocessors.push(preprocessor);
				}
			}
			
			process = function(cls, data) {
				preprocessor = preprocessors[index++];
				if (!preprocessor) {
					return;
				}
				if (preprocessor.call(this, cls, data, process) !== false) {
					process.apply(this, arguments);
				}
			};

			process.call(this, klass, _instance);
			return klass;
		},
		implement: function() {
			for (var i = 0; i < arguments.length; i++) {
				if (typeof arguments[i] == "function") {
					arguments[i](this.prototype);
				} else {
					this.prototype.extend(arguments[i]);
				}
			}
			return this;
		},
		toString: function() {
			return String(this.valueOf());
		}
	});
	
	
	Class.registerPreprocessor("extend",function(cls,data){
		delete data.extend;
		initializing = true;
		var proto = new this();
		Class.prototype.extend.call(proto, data);
		cls.prototype = proto;
		initializing = false;
		//proto.constructor = cls;
	},true);
	
	Class.registerPreprocessor("implement",function(cls,dta){
		delete data.implement;
	});
	
	Class.registerPreprocessor("options",function(cls,data){
		cls.options = OZ.extend(true,{},cls.options,data.options);
		delete data.options;
	});
	
	Class.registerPreprocessor("statics",function(cls,data){
		OZ.extend(cls,data.statics);
		delete data.statics;
	});
	
	Class.setDefaultPreprocessors(["extend","options","statics"]);
	
	Class.prototype = {
		constructor: function() {
			this.extend(arguments[0]);
		},
		extend: function(source, value) {
			if (arguments.length > 1) { // 复制key/value
				var ancestor = this[source];
				//比较valueOf()，如果已经复制过，则不再次构造function避开死循环
				if (ancestor && (typeof value == "function") && (!ancestor.valueOf || ancestor.valueOf() != value.valueOf())) {
					//获取原方法
					var method = value.valueOf();
					//复写函数,使函数可以使用base来调用父类的属性(可以是函数也可以是属性)
					value = function() {
						var previous = this.base || Class.prototype.base;
						this.base = ancestor;
						var returnValue = method.apply(this, arguments);
						this.base = previous;
						return returnValue;
					};
					// 指向原始的方法
					value.valueOf = function(type) {
						return (type == "object") ? value : method;
					};
					value.toString = Class.toString;
				}
				//特殊处理options的属性，使用深度复制。
				if(source == "options"){
					this[source] = $.extend(true,{},this[source],value);
				}else{
					this[source] = value;
				}
			} else if (source) { // extending with an object literal
				var extend = Class.prototype.extend;
				
				// 如果是一个普通的继承，使用本身的方法
				if (!initializing && typeof this != "function") {
					extend = this.extend || extend;
				}
				//原始属性不复制列表
				var proto = {toSource: null},
					hidden = ["constructor", "toString", "valueOf"],
					key,
					i = initializing ? 0 : 1;
				while (!!(key = hidden[i++])) {
					if (source[key] != proto[key]) {
						extend.call(this, key, source[key]);
					}
				}
				//复制属性到对象中
				for (key in source) {
					if (!proto[key]){
						extend.call(this, key, source[key]);
					}
				}
			}
			return this;
		},
		base:OZ.emptyFn
	};
	
	var Base = OZ.Base = Class.extend({
		version: "1.0.0",
		$className: 'OZ.Base',	
	    $class: Base,
	    self:Base,
		constructor:function(options){
			$.extend(this,options);
			return this;
		},
		initConfig: function(config) {
		    if (!this.$configInited) {
		        this.config = OZ.extend(true,{}, this.config || {}, config || {} );
		
		        this.applyConfig(this.config);
		
		        this.$configInited = true;
		    }
		    return this;
		},
        setConfig: function(config) {
            this.applyConfig(config || {});

            return this;
        },
        applyConfig: flexSetter(function(name, value) {
            var setter = 'set' + OZ.String.capitalize(name);
            if (typeof this[setter] === 'function') {
                this[setter].call(this, value);
            }
            return this;
        }),
		addEvent:function(type,data,fn){
			// Handle object literals
			if ( typeof type === "object" ) {
				for ( var key in type ) {
					this.addEvent(key, data, type[key], fn);
				}
				return this;
			}
			if ( arguments.length === 2 || data === false ) {
				fn = data;
				data = undefined;
			}
			$.event.add(this,type,fn,data);
		},
		removeEvent:function(type,handle){
			$.event.remove(this,type,handle);
		},
		fireEvent:function(type, data, defaultFunction){
			var event = $.Event(type);
			$.event.trigger(event,data,this);
			if (defaultFunction && !event.isDefaultPrevented()) {
				defaultFunction(event);
			}
		},
		implement: function(members) {
			 var prototype = this.prototype,
			 	name, i, member;
	         for (name in members) {
	             if (members.hasOwnProperty(name)) {
	                 member = members[name];
	                 if (typeof member === 'function') {
	                     member.$owner = this;
	                     member.$name = name;
	                 }
	                 prototype[name] = member;
	             }
	         }
			return this;
		},
		toString: function() {
			return String(this.valueOf());
		}
	});
	
	var Manager = OZ.ClassManager = {
        classes: {},
        maps: {
            alternateToName: {},
            aliasToName: {},
            nameToAliases: {}
        },
        existCache: {},
        createNamespaces: function() {
            var root = OZ.global,
                parts, part, i, j, ln, subLn;

            for (i = 0, ln = arguments.length; i < ln; i++) {
                parts = this.parseNamespace(arguments[i]);

                for (j = 0, subLn = parts.length; j < subLn; j++) {
                    part = parts[j];
                    if (typeof part !== 'string') {
                        root = part;
                    } else {
                        if (!root[part]) {
                            root[part] = {};
                        }
                        root = root[part];
                    }
                }
            }
            return root;
        },
        parseNamespace: function(namespace) {
        	var parts=[], root = OZ.global;;
			parts.push(root);
			parts = parts.concat(namespace.split('.'));
			return parts;
        },
        setNamespace: function(name, value) {
            var root = OZ.global,
                parts = this.parseNamespace(name),
                leaf = parts.pop(),
                i, ln, part;
            for (i = 0, ln = parts.length; i < ln; i++) {
                part = parts[i];

                if (typeof part !== 'string') {
                    root = part;
                } else {
                    if (!root[part]) {
                        root[part] = {};
                    }
                    root = root[part];
                }
            }
            root[leaf] = value;
            return root[leaf];
        }, 
        set: function(name, value) {
            var targetName = this.getName(value);
            this.classes[name] = this.setNamespace(name, value);
            if (targetName && targetName !== name) {
                this.maps.alternateToName[name] = targetName;
            }
            return this;
        },
        get:function(name){
        	 if (this.classes.hasOwnProperty(name)) {
                 return this.classes[name];
             }
             var root = OZ.global,
                 parts = this.parseNamespace(name),
                 part, i, ln;

             for (i = 0, ln = parts.length; i < ln; i++) {
                 part = parts[i];

                 if (typeof part !== 'string') {
                     root = part;
                 } else {
                     if (!root || !root[part]) {
                         return null;
                     }
                     root = root[part];
                 }
             }
             return root;
        },
        getName: function(object) {
            return object && object.$className || '';
        },
        create:function(newClass,classData){
    		var baseCls;
    		if(classData.extend){
    			baseCls = OZ.ClassManager.get(classData.extend);
    			delete classData.extend;
    		}
    		if(!baseCls){
    			baseCls = Base;
    		}
    		
    		var clazz = baseCls.extend(classData);
    		
    		clazz.implement({
    			$name: newClass,
    		    $class: clazz,
    		    self:clazz
    		})
    		
    		OZ.ClassManager.set(newClass,clazz);
    	}
	}
	
	OZ.define = OZ.ClassManager.create;
	OZ.ns = OZ.ClassManager.createNamespaces;
})(jQuery);	