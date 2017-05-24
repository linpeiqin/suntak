/**
 * 联动下拉框组件
 * 
 * 版本: 1.0 
 * 依赖：jquery 1.4
 * 作者：dragon 2010-08-23
 */
 
/* 下拉框选择的联动组件构造函数
 * @param {Object|Array} config 配置项，如果为Array类型则相当于只配置selectList属性
 * @config {String} [可选]method ajax提交请求时使用的方法'get'或'post',默认为'get'
 * @config {String} [可选]emptyText 空白项显示的值
 * @config {String} [可选]emptyValue 空白项的值
 * @config {Object} [可选]mapping 选项的映射配置，默认为{text:"text",value:"value"}
 * @config {Boolean} [可选]addTimeStamp 是否在url后添加时间挫(默认为false)
 * @config {Boolean} [可选]addEmptyOption 是否在下拉选项中添加空白选项
 * @config {Boolean} [可选]lazy 是否延时加载，也就是需要手动调用init函数进行初始化，默认为false
 * @config {Function} [可选]loadException 加载数据出现异常时调用的函数，上下文为当前OZ.LinkSelect
 *	  的实例，第一个参数为服务器返回的transport对象，第二个参数为发生异常的select控件
 * 
 * @config {Array} selectList 要联动的下拉框的配置列表，每个元素item的格式为
 *	   {
 *		id:theID,						// {String} select控件的id值
 *		url:theUrl,						// {String} 获取select控件选项的url
 * 
 *		// {Function} (可选)select控件选中值变动后的回调函数，上下文为当前select控件对象，
 *		// 第一个参数为当前选中项的值，第二个参数为选中值对应的详细参数对象
 *		afterChanged:theCallback,	
 *	
 *		// {Function} (可选)select控件选项列表加载完毕后的回调函数，上下文为当前select控件对象，
 *		// 第一个参数为服务器返回的json对象，第二个参数为服务器返回的transport对象
 *		afterLoadOptions:theCallback,	
 *	
 *		labelFieldId:"",				// {String} (可选)select控件选中值变动后其选中选项的显示值填充到的控件的id值
 *		valueFieldId:"",				// {String} (可选)select控件选中值变动后其选中选项的值填充到的控件的id值
 *		parameters:"",					// {String} (可选)ajax提交该url请求时附加的参数字符串
 *	   }
 * 
 * @return {Object} 联动组件的实例
 */
OZ.LinkSelect = function (_config){
	if(_config instanceof Array){
		_config = {selectList:_config};
	}
	this.config = $.extend(this.defaultConfig,_config);
	
	// 为每个selectList项添加parameters属性
	var selectList = this.config.selectList;
	for(var i = 0; i < selectList.length; i++){
		if(typeof selectList[i].parameters == "undefined"){
			selectList[i].parameters = "";
		}
		selectList[i].url = OZ.getAbsoluteUrl(selectList[i].url);
	}
	
	if(this.config.lazy !== true){
		this.init();//即时初始化
		this.hadInit = true;
	}else{
		this.hadInit = false;
	}
};
 
OZ.LinkSelect.prototype = {
	/* 默认配置 */
	defaultConfig : {
		addEmptyOption:true,
		emptyText:"==请选择==",
		emptyValue:"",
		selectList:[],
		addTimeStamp:false,
		method:"get",
		mapping:{text:"text",value:"value"},
		parentKey:"parent",
		lazy:false
	},
	
	/* 初始化 */
	init:function(){
		var selectList = this.config.selectList;
		if (selectList.length === 0) {
			ozlog.error("错误：OZ.LinkSelect的构造函数参数中没有配置selectList！");
			return;
		}
		
		// 对每个选项控件添加事件处理
		var oThis = this;
		for(var i = 0;i < selectList.length;i++){
			var selObj = $("#"+selectList[i].id).get(0);
			selObj.onchange = function(){
				
				// 加载下一个选项控件的列表
				var index = oThis.getIndex(this.id);
				var selObj = $("#"+selectList[index].id).get(0);
				if(selObj.selectedIndex==-1){
					return;
				}
				// 清空下一级select控件的值
				oThis.resetNext(oThis.getIndex(this.id));
				
				if (oThis.config.emptyValue!=this.value && index < selectList.length - 1){
					oThis.loadOptions.call(oThis,index + 1,this.value,null);
				}

				var _value = selObj.value;
				var _t = selObj.options[selObj.selectedIndex].text;
				var _label = (_t != oThis.config.emptyText ? _t : "");
				
				// 填充值到指定的域
				var valueFieldId = selectList[index].valueFieldId;
				if (valueFieldId){
					$("#"+valueFieldId).val(_value);
				}
				var labelFieldId = selectList[index].labelFieldId;
				if (labelFieldId){
					$("#"+labelFieldId).val(_label);
				}
				
				// 调用回调函数
				if (typeof selectList[index].afterChanged == "function"){
					selectList[index].afterChanged.call(selObj,_value,oThis.getDetailOption(index,_value));
				}
			};
		}
		
		// 加载第一个select控件的选项
		var selectItem = selectList[0];
		var selectedValue = (selectItem.valueFieldId ? $("#"+selectItem.valueFieldId).val() : null);
		ozlog.debug("selectedValue=" + selectedValue);
		this.loadOptions.call(this,0,null,selectedValue);
	},
	
	/* 获取指定值的选项 */
	getDetailOption : function(index,_value){
		var options = this.config.selectList[index].options;
		var valueMappingName = this.config.mapping.value;
		if (options){
			for(var i = 0;i < options.length;i++){
				if (_value == options[i][valueMappingName]){
					return options[i];
				}
			}
		}
		return null;
	},
	
	/* 重置各选项控件 */
	reset : function(){
		var selectList = this.config.selectList;
		for(var i = 0;i < selectList.length;i++){
			var selObj = $("#"+selectList[i].id).get(0);
			if (i === 0){
				selObj.value = "";
			}else{
				selObj.options.length = 0;
			}
			
			// 清空指定域
			var valueFieldId = selectList[i].valueFieldId;
			if (valueFieldId){
				$("#"+valueFieldId).val("");
			}
			var labelFieldId = selectList[i].labelFieldId;
			if (labelFieldId){
				$("#"+labelFieldId).val("");
			}
		}
	},
	
	/* 重置所有下级选项控件 */
	resetNext : function(index){
		var selectList = this.config.selectList;
		for(var i = index + 1;i < selectList.length;i++){
			var selObj = $("#"+selectList[i].id).get(0);
			selObj.value = "";
			selObj.options.length = 0;
			
			// 清空指定域
			var valueFieldId = selectList[i].valueFieldId;
			if (valueFieldId){
				$("#"+valueFieldId).val("");
			}
			var labelFieldId = selectList[i].labelFieldId;
			if (labelFieldId){
				$("#"+labelFieldId).val("");
			}
		}
	},
	
	/* 重新加载各选项控件 */
	reload : function(){
		this.hadInit = false;
		this.init();
	},
	
	/* 
	 * private 加载选项框的列表值
	 * @param {Number} index 要处理的选项控件的索引号
	 * @param {String} parentValue 前一选项控件当前选中的值
	 * @param {String} selectedValue 加载完毕后要选中的值s
	 */
	loadOptions: function(index,parentValue,selectedValue){		
		var strUrl = this.config.selectList[index].url;
		if(!!!strUrl){ return; }
		if (this.config.addTimeStamp === true) { strUrl = OZ.addTimeStamp(strUrl);}
		var oThis = this;
		var curSelectControlConfig = this.config.selectList[index];
		var curSelectControl = $("#"+curSelectControlConfig.id).get(0);
		
		var parameters = curSelectControlConfig.parameters + (parentValue != null ? "&"+curSelectControlConfig.parentKey+"=" + encodeURIComponent(parentValue) : "");
		if(ozlog.debugEnable){
			ozlog.debug("开始初始化" + curSelectControl.id + "的下拉选项列表：url=" + 
					strUrl + ";parameters=" + parameters + ";selectedValue=" + selectedValue + ";index=" + index);
		}
		$.ajax({
			type: this.config.method,
			dataType: "json",
			url: strUrl,
			data:parameters,
			success: function(optionArray, _status){
				// 填充选项列表
				oThis.fillOptions.call(oThis,index,optionArray);
	
				// 如果是处于初始化状态则确定当前选中的值
				var valueFieldId = curSelectControlConfig.valueFieldId;
				var _parentValue = null;
				ozlog.debug("--" + valueFieldId);
				if (valueFieldId){
					var _options = curSelectControl.options;
					for(var i = 0; i < _options.length; i++){
						ozlog.debug(""+_options[i].value + ";" + selectedValue);
						if(_options[i].value == selectedValue){
							_options[i].selected = true;
							_parentValue = _options[i].value;
							break;
						}
					}
				}
				
				// 调用afterLoadOptions回调函数
				if (typeof curSelectControlConfig.afterLoadOptions == "function"){
					curSelectControlConfig.afterLoadOptions.call(curSelectControl,optionArray);
				}
				
				// 根据当前选中的值填充下一个选项控件
				if (_parentValue != null && _parentValue.length > 0 &&
					index < oThis.config.selectList.length - 1){
					var nextSelectControlConfig = oThis.config.selectList[index + 1];
					//var nextSelectControl = $F(nextSelectControlConfig.id);
					var _selectedValue = (nextSelectControlConfig.valueFieldId ? $("#"+nextSelectControlConfig.valueFieldId).val() : null);
					oThis.loadOptions.call(oThis,index + 1,_parentValue,_selectedValue);
				}
				
				// 所有控件都初始化完毕处理
				if(index == oThis.config.selectList.length - 1){
				   oThis.hadInit = true;
				}
				
				if(oThis.config.debug === true){
					ozlog.debug("完成" + oThis.config.selectList[index].id + "的下拉选项列表的初始化。");
				}
			},
			error: function(xhr, errorMsg, errorThrown){
				if(oThis.config.debug === true){
					ozlog.error("初始化" + oThis.config.selectList[index].id + "的下拉选项列表出现异常。");
				}
				if (typeof oThis.config.loadException == "function"){
					oThis.config.loadException.call(oThis,xhr,curSelectControl, errorMsg, errorThrown);
				}
			}
		});
	},

	/* private 填充选项列表,并清空下级选项的列表 */
	fillOptions : function(index,optionArray){
		//alert("fillOptions:" + optionArray.length);
		var selObj = $("#"+this.config.selectList[index].id).get(0);
		this.config.selectList[index].options = optionArray;//记录选项的详细信息
		var oldValue = selObj.value;
		// 填充自己
		if (!selObj || !optionArray) { return; }
		var _options = selObj.options;
		_options.length = 0;
		var j = 0;	
		if (this.config.addEmptyOption === true){
			_options[0] = new Option(this.config.emptyText,this.config.emptyValue);
			j++;
		}
		var valueMappingName = this.config.mapping.value,
			labelMappingName = this.config.mapping.text,
			i;
		for(i = 0;i < optionArray.length;i++){
			_options[i + j] = new Option(optionArray[i][labelMappingName],optionArray[i][valueMappingName]);
		}
		
		// 清空下级
		var selectList = this.config.selectList;
		for(i = index + 1;i < selectList.length;i++){
			$("#"+selectList[i].id).get(0).options.length = 0;
			selectList[i].options = [];//清除已记录的选项详细信息
		}
	},

	/* private 获取选项控件的索引值 */
	getIndex : function(selId){
		var selectList = this.config.selectList;
		for(var i = 0;i < selectList.length;i++){
			if(selectList[i].id == selId){
				return i;
			}
		}
		return -1;
	}
 };

//自动初始化联动组件的函数
OZ.autoLinkSelect = function(){
	//获取配置并分好组
	var groups = {};
	$(".oz-linkSelect").each(function(){
		var $this = $(this);
		var $metadata = $this.metadata();
		$metadata.url=$metadata.url.replace("$contextPath",contextPath);
		var group = $metadata.group || "defaultGroup";//没有配置group的统一到默认分组中
		if(!groups[group]){
			groups[group] = {selectList:[]};
		}
		groups[group].selectList.push($.extend({id:this.id},$metadata));
	});
	
	//初始化
	for(var group in groups){
		ozlog.info("toJSON=" + $.toJSON(group));
		var select = new OZ.LinkSelect(groups[group]);
	}
};