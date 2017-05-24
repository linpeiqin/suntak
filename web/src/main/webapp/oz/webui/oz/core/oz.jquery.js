/**
 * oz对jquery的相关扩展处理
 * 
 * 版本: 1.0 
 * 依赖：jquery 1.4 +
 * 作者：dragon 2010-07-21
 */
var rselectTextarea = /select|textarea/i;
var rinput = /color|date|datetime|email|hidden|month|number|password|range|search|tel|text|time|url|week/i;
(function($){
//参数传统化	
jQuery.ajaxSettings.traditional=true;

$.fn.extend({
	/** JQuery serialize方法的扩展
	 * @param getHash [可选]是否返回json格式，默认为false,返回字符串格式
	 */
	serialize: function(getHash) {
		if(getHash !== true){
			return jQuery.param(this.serializeArray());
		}else{
			return this.serializeArray();
		}
	},
	/** 将对象序列化为json对象格式，参考prototype的From.serialize方法
	 * @param includeDisabled [可选]是否序列化被禁用的元素，默认为false
	 * @param excludeNames [可选]要排除序列化的控件名称数组
	 * @param autoSelectedIds [可选]序列化前需要自动预先选中全部选项的select控件id数组
	 */
	serializeJson: function() {
		var result={},_obj,key,value,i;
		this.map(function() {
			return this.elements ? jQuery.makeArray(this.elements) : this;
		})
		.filter(function() {
			return this.name && !this.disabled &&
				(this.checked || rselectTextarea.test(this.nodeName) ||
					rinput.test(this.type));
		}).each(function(index,elem){
			key = elem.name;
			value = $(elem).val();
			if(value == null) {
				return;
			}
			//parent.elog.debug("index="+index+";key="+key+";value="+Egd.encode(value));
			if (key in result) {
				//parent.elog.debug("key in result");
				// a key is already present; construct an array of values
				if (!jQuery.isArray(result[key])){
					result[key] = [result[key]];
				}
				if (!jQuery.isArray(value)){
					result[key].push(value);
				}else{
					for(i=0;i<value.length;i++){
						result[key].push(value[i]);
					}
				}
			}
			else{
				result[key] = value;
			}
		});
		return result;
	},
	/** 
	 * serializeArray方法的扩展
	 * 设置DOM属性serialize=true时则强制序列化该元素，不管元素是否已禁用；
	 * 设置DOM属性serialize=false时则强制排除该元素不序列化；
	 * 对于多选select控件，若要强制将所有项目的值(不管是否已选择)序列化，可以设置serializeAll=true。
	 */
	serializeArray: function() {
		return this.map(function() {
			return this.elements ? jQuery.makeArray(this.elements) : this;
		})
		.filter(function() {
			var forceExclude=false,forceIncludeDisabled = false;
			
			//获取serialize的属性配置
			var serialize = $.data(this,"serialize");
			if(!serialize){//没有配置serialize属性
				if(/select/i.test(this.nodeName) && this.multiple){//多选select控件
					serialize = $.data(this,"serializeAll");
				}
			}
			if(serialize == "false"){
				forceExclude = true;//强制排序序列化
			}else if(serialize == "true"){
				forceIncludeDisabled = true;//强制序列化
			}
			
			return !forceExclude && this.name && (forceIncludeDisabled || !this.disabled) &&
				(this.checked || rselectTextarea.test(this.nodeName) ||
					rinput.test(this.type));
		})
		.map(function( i, elem ) {
			var val;
			if(/select/i.test(this.nodeName) && this.multiple){//多选select控件的特殊处理
				var serializeAll = $.data(this,"serializeAll") == "true";
				if(serializeAll){ //没有选中的元素也将包含进去
					var options=elem.options;
						val=[];
					for (var j=0;j<options.length;j++){
						val.push(jQuery(options[j]).val());
					}
				}else{
					val = jQuery(this).val();	//原jquery的处理
				}
			}else{
				val = jQuery(this).val();		//原jquery的处理
			}

			return val == null ?
				null :
				jQuery.isArray(val) ?
					jQuery.map( val, function( val, i ) {
						return { name: elem.name, value: val };
					}) :
					{ name: elem.name, value: val };
		}).get();
	},
	hoverClass:function(className){
		this.hover(function(){
			$(this).addClass(className);
		},function(){
			$(this).removeClass(className);
		})
	}
});
jQuery.each( [ "get", "post" ], function( i, method ) {
	jQuery[ "sync" + method ] = function( url, data, callback, type ) {
		// shift arguments if data argument was omitted
		if ( jQuery.isFunction( data ) ) {
			type = type || callback;
			callback = data;
			data = undefined;
		}

		return jQuery.ajax({
			type: method,
			url: url,
			data: data,
			success: callback,
			dataType: type,
			async:false
		});
	};
});
})(jQuery);