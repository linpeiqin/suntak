/**
 * OZ通用工具方法
 * 
 * @class oz
 * @singleton
 * 
 * @author KingChen
 * @author dragon
 * 
 * @date 2010-07-21
 * @depend none
 */
(function() {
  var $ = (typeof this.global === 'object') ? this.global : this;
  $.OZ = $.OZ || {};
  OZ.ENV = $;
})();

(function($,window, undefined) {
	var global = this,
	objectPrototype = Object.prototype,
	toString = Object.prototype.toString;
	
	if (typeof oz === 'undefined') {
		 global.oz = {};
	}
	
	oz.global = global;	
	oz.query = $;
	oz.extend = $.extend;
	
	var scrollWidth = null;

	oz.extend({
		/**
		 * 版本信息
		 */
		version:'1.0',
		ready: $.ready,
		isFunction: $.isFunction,
		isArray: $.isArray,
		isWindow: $.isWindow,
		isNaN: $.isNaN,
		type: $.type,
		isPlainObject: $.isPlainObject,
		isEmpty: $.isEmptyObject,
		isObject: (toString.call(null) === '[object Object]') ?
				function(value) {
					return value !== null && value !== undefined && toString.call(value) === '[object Object]' && value.nodeType === undefined;
				} :
				function(value) {
					return toString.call(value) === '[object Object]';
				},
		isNumber: function(value) {
					return typeof value === 'number' && isFinite(value);
				},
		parseJSON: $.parseJSON,
		parseXML: $.parseXML,
		noop: $.noop,
		toArray: $.makeArray,
		inArray: $.inArray
	});
	
	/** 调试控制台的幻象，实际的控制台见oz.log.js */
	global.ozlog = {
		debugEnable: false,
		infoEnable:false,
		warnEnable:	false,
		profileEnable: false,
		clear:oz.noop,
		debug:oz.noop,
		info:oz.noop,
		warn:oz.noop,
		error:oz.noop,
		profile:oz.noop,
		enable:oz.noop,
		disabled:oz.noop,
		show:oz.noop
	};
	
	
	oz.extend({
		/**
		 * ID种子
		 */
		idSeed:1000,
		/**
		 * 系统根路径
		 */
		rootPath: (typeof contextPath == "string" ? contextPath : "..") + "/",
		emptyFn: function(){},	
		getScrollBarWidth:function(force){
			if(!jQuery.isReady){
				return 0;
			}
			if(force === true || scrollWidth === null){
				var div = $('<div style="width:50px;height:100px;overflow:hidden;"><hr width="200"></div>').appendTo('body');
				var h1 = div[0].clientHeight;
				div.css('overflow', 'auto');
				var h2 = div[0].clientHeight;
				div.remove();
				scrollWidth = h1 - h2;
			}
			return scrollWidth;
		},
		
		/**
		 * 向指定的url路径末端添加参数
		 * 
		 * @param url url路径
		 * @param keyValue 名值对，格式为“key=value”
		 * @return 添加参数/值后的url
		 */
		addParamToUrl: function(url,keyValue)  
		{
			if (url == null || !keyValue) {
				return url;
			}
			var hasParam = (url.indexOf("?") != -1);
			return url + (hasParam?"&":"?") + keyValue;
		},
		
		/**
		 * 返回指定的url添加一个时间挫参数后的url
		 * 
		 * @param strUrl 要处理的url
		 */
		addTimeStamp: function(strUrl){
			if (strUrl.indexOf("timeStamp") == -1){
				if(strUrl.indexOf("?") != -1){
					return strUrl + "&timeStamp=" + new Date().getTime();
				}else{
					return strUrl + "?timeStamp=" + new Date().getTime();
				}
			}else{
				return strUrl;
			}
		},
		
		getCheckBoxValue:function(checkBoxName){
			var checkBoxes = document.getElementsByName(checkBoxName);
			var values = [];
			for(var i = 0; i < checkBoxes.length; i++){
				if(checkBoxes[i].checked){
					values.push(checkBoxes[i].value);
				}
			}
			return values;
		},
		
		getSelectedRadio:function(radioName){
			var radios = document.getElementsByName(radioName);
			for(var i = 0; i < radios.length; i++){
				if(radios[i].checked){
					return radios[i];
				}
			}
			return null;
		},
		
		getRadioValue:function(radioName){
			var radio = oz.getSelectedRadio(radioName);
			return radio ? radio.value : null;
		},
		
		/** 获取元素的值：增加对多选select元素的特殊处理 */
		getValue:function(element){
			var val;
			if(/select/i.test(element.nodeName) && element.multiple){// 多选select控件的特殊处理
				var serializeAll = $(element).data("serializeAll") == "true";
				if(serializeAll){ // 没有选中的元素也将包含进去
					var options=element.options;
						val=[];
					for (var j=0;j<options.length;j++){
						val.push(jQuery(options[j]).val());
					}
				}else{
					val = jQuery(element).val();	// 原jquery的处理
				}
			}else{
				val = jQuery(element).val();		// 原jquery的处理
			}
			return val;
		},
		
		/** 获取指定url加上绝对路径后的url */
		getAbsoluteUrl: function(sourceUrl){
			if(!sourceUrl) {
				return "";
			}
			if(sourceUrl.indexOf("/") === 0 || sourceUrl.indexOf("../") === 0 || sourceUrl.indexOf("http") === 0)  
			{  
				return sourceUrl;
			}else{
				return oz.rootPath + sourceUrl;
			}
		},
		
		/** ie关闭iframe后内存溢出的处理 */
		destroyIframe: function($iframeParent){
			if($iframeParent.length){
				$iframeParent.find("iframe").each(function(){
					if(ozlog.infoEnable){
						ozlog.info("destroyIframe:src=" + this.src);
					}
					this.src = "javascript:false";
					return this;
				});
			}
		},
		
		/** 得到字符串的真实长度（双字节换算为两个单字节） */
		getStringActualLen: function(sourceString){  
			return sourceString.replace(/[^\x00-\xff]/g,"xx").length;  
		},
		
		/** 截取固定长度子字符串 */
		getShortString: function(sourceString, maxLen, useEllipsis){  
			if(sourceString.replace(/[^\x00-\xff]/g,"xx").length <= maxLen){
				return sourceString;  
			}
		
			var str = "";  
			var l = 0;  
			var schar; 
			if(useEllipsis !== false){
				maxLen = maxLen - 3;
			}
			for(var i=0; ; schar=sourceString.charAt(i),i++){  
				str += schar;  
				l += (schar.match(/[^\x00-\xff]/) != null ? 2 : 1);  
				if(l >= maxLen)  
				{  
					break;  
				}  
			}  
			return (useEllipsis !== false ? (str + "...") : str);  
		},
		/** 获取当前日期，格式为yyyy-MM-dd */
		getCurrentDate: function(){
			var date = new Date();
			var y = date.getFullYear();
			var m = date.getMonth()+1;
			var d = date.getDate();
			return y+'-'+(m<10?'0'+m:m)+'-'+(d<10?'0'+d:d);
		},
		/** 获取使用符号"."连接的嵌套对象,如a.b.c返回window[a][b][c]或eval(a.b.c) */
		getNested: function(nestedName){
			var names = nestedName.split(".");
			var result = window[names[0]];
			for(var i=1;i<names.length;i++){
				result = result[names[i]];
			}
			return result;
		},
		/** 多方法尝试运行 */
		Try: {
			these: function() {
				var returnValue;
				for (var i = 0, length = arguments.length; i < length; i++) {
				var lambda = arguments[i];
				try {
					returnValue = lambda();
					break;
				} catch (e) {}
				}
				return returnValue;
			},
			parent:function(){
				var arg = jQuery.makeArray(arguments);
				var fun = arg.shift();
				oz.Try.these(
					function() {return parent[fun].apply(null,arg);},
					function() {return parent.parent[fun].apply(null,arg);},
					function() {return parent.parent.parent[fun].apply(null,arg);}
				);
			}
		}
	});
	
	
	

	/**
	 * @class oz.array
	 *
	 * 定义数组的静态方法
	 * 
	 * @singleton
	 */
	oz.array =oz.Array = {
			from: $.makeArray,
			toArray: $.makeArray,
			removeItem : function ( array, item ) {
	            var k = array.length;
	            if ( k ) while ( k -- ) {
	                if ( array[k] === item ) {
	                    array.splice(k, 1);
	                    break;
	                }
	            }
	        }
	};


	/**
	 * @class oz.string
	 *
	 * 定义String的静态方法
	 * 
	 * @singleton
	 */
	oz.string = oz.String = {
		/**
		 * 首字母转换为大写
		 * 
		 * @param {String} 转换的字符串
		 */
		capitalize: function(string) {
			return string.charAt(0).toUpperCase() + string.substr(1);
		},
		/**
		 * 普通的字符串格式化函数
		 * 
		 * <li class="{1}">{0}</li>
		 * '.format('test0','test1') 的结果为'
		 * <li class="test1">test0</li>'
		 * 
		 * @param {String} 转换的字符串
		 */
		format: function(string){
			var args = oz.Array.toArray(Array.prototype.slice.call(arguments, 1));		
			return string.replace(/\{(\d+)\}/g, function(m, i){
				return args[i];
			});
		},
		escape: function(string) {
			return string.replace(/('|\\)/g, "\\$1");
		},
		/**
		 * 在字符串左边添加指定个数的字符串
		 * @param {String} 被替换的字符串
		 * @param {Integer} 个数
		 * @param {String} 替换的字符
		 */
		leftPad: function (val, size, ch) {
			var result = ""+val;
			if(ch === null || ch === undefined || ch === '') {
				ch = " ";
			}
			while (result.length < size) {
				result = ch + result;
			}
			return result;
		},
		/**
		 * 简单的模版操作
		 * str: hello {name}
		 * data:  {"name":"king"}
		 * return:  hello king
		 * 
		 * @param str {String} 替换的字符串
		 * @param data {Object} 替换的对象
		 */
		tpl: function(str, data) {
			return str.replace(/[\r\t\n]/g, " ").replace(/\{([^}]*)}/g, function(all,p){
				if(typeof data[p] === 'undefined'){
					return "";
				}
				return data[p];
			});
		}
	};
	/**
	 * @class oz.number 数字工具类
	 */
	oz.number = oz.Number = {
		/**
		 * 限制数值为两个数值之间
		 * 
		 * @param number 限制的数值
		 * @param min 左区间的值
		 * @param max 右区间的值 
		 */
		constrain: function(number, min, max) {
	        number = parseFloat(number);

	        if (!isNaN(min)) {
	            number = Math.max(number, min);
	        }
	        if (!isNaN(max)) {
	            number = Math.min(number, max);
	        }
	        return number;
	    },
	    
	    /**
	     * 解析为Float
	     */
	    parseFloat:function(float, length){
	    	if (isNaN(parseFloat(float))) {
	            return 0.0;
	        }
	    	return parseFloat(float);
	    },

	    /**
	     * 解析为Int
	     */
	    parseInt:function(int){
	    	if (isNaN(parseInt(int))) {
	            return 0;
	        }
	    	return parseInt(int);
	    },

	    /**
	     * 格式化Float
	     */
	    formatFloat:function(float, length){
	    	var num = new Number(0);
	    	if (isNaN(parseFloat(float))) {
	            // return 0.0;
	        }else{
	        	num = new Number(float)
	        }
	    	return num.toFixed(length);
	    }
	}
	
	window.oz = oz;
	window.OZ=oz;
	
})(jQuery,window);	

(function(){
	var r20 = /%20/g,
	rbracket = /\[\]$/;
	oz.extend({
		// Serialize an array of form elements or a set of
		// key/values into a query string
		param: function( a ) {
			var s = [],
				add = function( key, value ) {
					// If value is a function, invoke it and return its value
					value = jQuery.isFunction( value ) ? value() : value;
					s[ s.length ] = encodeURIComponent( key ) + "=" + encodeURIComponent( value );
				};
		
			// If an array was passed in, assume that it is an array of form elements.
			if ( jQuery.isArray( a ) || ( a.jquery && !jQuery.isPlainObject( a ) ) ) {
				// Serialize the form elements
				jQuery.each( a, function() {
					add( this.name, this.value );
				});
	
			} else {
				// If traditional, encode the "old" way (the way 1.3.2 or older
				// did it), otherwise encode params recursively.
				for ( var prefix in a ) {
					buildParams( prefix, a[ prefix ], add );
				}
			}
	
			// Return the resulting serialization
			return s.join( "&" ).replace( r20, "+" );
		}
	});
	function buildParams( prefix, obj, add ) {
		if ( jQuery.isArray( obj ) ) {
			jQuery.each( obj, function( i, v ) {
				add( prefix, v );
			});

		} else if (obj != null && typeof obj === "object" ) {
			// Serialize object item.
			for ( var name in obj ) {
				buildParams( prefix + "." + name, obj[ name ], add );
			}

		} else {
			// Serialize scalar item.
			add( prefix, obj );
		}
	}	
})();

function isRadio(fieldId){
	return $(":radio[name='" + fieldId + "']").size() > 0; 
}

// 常用函数
function val(fieldId, fieldVal){
	if(isRadio(fieldId)){
		if(typeof(fieldVal) != "undefined"){
			$(":radio[name='" + fieldId + "']").each(function(){
				if($(this).val() == fieldVal)
					$(this).attr("checked",'checked');
			});
		}else{
			return $("input[name='" + fieldId + "']:checked").val();
		}
	}else{
		if(typeof(fieldVal) != "undefined"){
			return $("#" + fieldId).val(fieldVal);
		}else{
			return $("#" + fieldId).val();
		}
	}
}

function floatVal(fieldId, fieldVal){
	if(isRadio(fieldId)){
		if(typeof(fieldVal) != "undefined"){
			$(":radio[name='" + fieldId + "']").each(function(){
				if($(this).val() == fieldVal)
					$(this).attr("checked",'checked');
			});
		}else{
			return oz.Number.parseFloat($("input[name='" + fieldId + "']:checked").val());
		}
	}else{
		if(typeof(fieldVal) != "undefined"){
			return $("#" + fieldId).val(fieldVal);
		}else{
			return oz.Number.parseFloat($("#" + fieldId).val());
		}
	}
}

function sum(fieldIds){
	if(null == fieldIds || fieldIds.length == 0)
		return 0;
	
	var val = 0;
	for(var i = 0; i < fieldIds.length; i++){
		val += oz.Number.parseInt($("#" + fieldIds[i]).val());
	}
	return val;
}

function sumFloat(fieldIds, len){
	if(null == fieldIds || fieldIds.length == 0)
		return oz.Number.formatFloat(0.0, len);
	
	var val = 0.0;
	for(var i = 0; i < fieldIds.length; i++){
		val += oz.Number.parseFloat($("#" + fieldIds[i]).val());
	}
	return oz.Number.formatFloat(val, len);
}

function getCheckBoxValus(fieldName, symbol){
	var values = "";
	symbol = symbol || ",";
	$("input[type='checkbox'][name='" + fieldName + "']").each(function(){
		if(this.checked){
			if(values.length > 0)
				values += symbol;
			values += this.value;
		}
	});
	return values;
}

function setCheckBoxStatus(fieldName, values){
	if(null == values || values.length == 0)
		return;
	
	$("input[type='checkbox'][name='" + fieldName + "']").each(function(){
		for(var i = 0; i < values.length; i++){
			if(this.value == values[i]){
				this.checked = true;
				break;
			}
		} 
	});
}

function addTS(strUrl){
	if (strUrl.indexOf("timeStamp") == -1){
		if(strUrl.indexOf("?") != -1){
			return strUrl + "&timeStamp=" + new Date().getTime();
		}else{
			return strUrl + "?timeStamp=" + new Date().getTime();
		}
	}else{
		return strUrl;
	}
}

function openWindow(strUrl, title, refresh, winId){
	var windowsTitle = "新窗口";
	var refreshParent = true;
	var windowsId = ""; 
	if(typeof(title) != "undefined")
		windowsTitle = title;
	if(typeof(refresh) != "undefined")
		refreshParent = refresh;
	if(typeof(winId) != "undefined")
		windowsId = winId;
	else{
		if(typeof(oz_grid_config) != "undefined")
			windowsId = oz_grid_config.id + (new Date().getTime());
		else
			windowsId = "ozWindows_" + (new Date().getTime());
	}
	
	OZ.openWindow({
		id: windowsId,
		title: windowsTitle,
		url: addTS(strUrl), 
		refresh: refreshParent,
		beforeCloseFnName: "oz_Win_BeforeClose"
	});	
}