/**
 * oz表单函数
 * 
 * 版本: 1.0.0
 * 作者：dragon 2010-07-30
 */
//---------------- Form页面变量的定义 ----------------

//---------------- Form的按钮的事件响应函数 ----------------
// 关闭窗口前的处理,返回false将禁止关闭窗口

function oz_DefaultWin_BeforeClose(data,tabId){
	// 未保存的检测提示处理
	if(OZ.Form.checkChanged() && !OZ.Form.isSaved()){
		return window.confirm("文档信息已经改变，确认不保存修改而直接关闭页签吗？");
	}
}

function oz_Win_BeforeClose(data){
	if((typeof onWin_BeforeClose) == "function"){
		return onWin_BeforeClose.call(this,data);
	}else{
		return oz_DefaultWin_BeforeClose(data);
	}
}
//---------------- 页面初始化调用函数 ----------------
jQuery(function($){
	//必须的初始化：窗口大小的自动调整
	if($("#page-center").length){
		OZ.Form.resize();
		$(window).resize(OZ.Form.resize);
	}

	if((typeof onPage_Init) == "function"){
		onPage_Init.call(this);
	}else{
		if($(OZ.Form.id).length){
			OZ.Form.init();
		}
	}
});

/** Form处理函数 */
OZ.Form = {
	resize: function(){
		$("#page-center").height($(window).height()-$("#page-top").height());
	},	
	id:"#ozForm",	
	defaultCheckChanged:false,
	defaultAutoSave:false,
	htmlEditors:[],
	/** 是否允许未保存提示 */
	checkChanged:function(){
		var checkChanged = $(OZ.Form.id).data("checkChanged");
		if(!checkChanged){
			checkChanged = OZ.Form.defaultCheckChanged;
		}
		checkChanged = (checkChanged == 'true' || checkChanged === true);
		if(ozlog.infoEnable){
			ozlog.info("checkChanged=" + checkChanged);
		}
		return checkChanged;
	},
	/** 是否启用自动保存 TODO */
	autoSave:function(){
		var autoSave = $(OZ.Form.id).data("autoSave");
		if(!autoSave) {
			autoSave = OZ.Form.defaultAutoSave;
		}
		if(ozlog.infoEnable){
			ozlog.info("autoSave=" + autoSave);
		}
		return autoSave;
	},
	/** 内置的表单初始化函数 */
	init:function(){
		// 记录表单的原始数据
		if(OZ.Form.checkChanged()){
			OZ.Form.markFormOriginData($(OZ.Form.id).get(0));
		}
		
		// 绑定日期时间域
		OZ.Form.bindDateTime();
		
		// 绑定自动完成组件
		OZ.Form.bindAutoComplete();
		
		// 绑定联动组件
		OZ.Form.bindAutoLinkSelect();
		
		// 绑定RichInput组件，为简化单位/部门等选择使用
		OZ.Form.bindRichInput4Unit();
				
		// 绑定HtmlEditor组件
		OZ.Form.bindHtmlEditor();
		
		//其他自定义的初始化
		if(typeof(afterFormInit) == "function"){
			afterFormInit.call();
		}
	},
	/** 
	 * 过滤出表单需要提交到服务器的元素
	 */
	getElements:function(form){
		return $(form).map(function() {//表单所有元素
			return this.elements ? jQuery.makeArray(this.elements) : this;
		})
		.filter(function() {//过滤出其数据需要提交到服务器的元素
			var forceExclude=false,forceIncludeDisabled = false;
			
			//获取serialize的属性配置
			var serialize = $(this).data("serialize");
			if(!serialize){//没有配置serialize属性
				if(/select/i.test(this.nodeName) && this.multiple){//多选select控件
					serialize = $(this).data("serializeAll");
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
		});
	},
	
	/** 
	 * 记录表单每个元素的原始数据
	 */
	markFormOriginData:function(form){
		var formElements = OZ.Form.getElements(form);
		$(form).data("ozOriginValue",formElements.length);
		formElements.each(function(){
			OZ.Form.markElementOriginData(this);
		});
	},
	
	/** 
	 * 记录表单域的原始数据
	 */
	markElementOriginData:function(element){
		var value = OZ.getValue(element);
		$(element).data("ozOriginValue",value);
		if(ozlog.debugEnable){
			ozlog.debug(element.nodeName + "|" + element.name + "|" + value);
		}
	},
	/** 
	 * 判断表单的数据是否已被修改过还没保存
	 * 已保存没有改变返回true，否则返回false
	 */
	isSaved:function(form){
		if(!form){
			form = $(OZ.Form.id);
		}
		var isSaved = true;
		var formElements = OZ.Form.getElements(form);
		var formOriginValue = $(form).data("ozOriginValue");
		if(formOriginValue != formElements.length){
			isSaved = false;
		}else{
			formElements.each(function(){
				var originValue = $(this).data("ozOriginValue");
				var newValue = OZ.getValue(this);
				if($.isArray(originValue)){
					originValue = originValue.join(",");
				}
				if($.isArray(newValue)){
					newValue = newValue.join(",");
				}
				var notEqual = (originValue != newValue);
				if(ozlog.debugEnable){
					ozlog.debug(this.nodeName + "|" + this.name + "|" + !notEqual + "|old:" + originValue + "|new:" + newValue);
				}
				if(notEqual){
					isSaved = false;
					return false;//终止循环
				}
			});
		}
		if(ozlog.infoEnable){
			ozlog.info("isSaved=" + isSaved);
		}
		return isSaved;
	},
	
	/** 表单ajax提交。
	 *  如果要强制某些元素的数据不提交到服务器，可设置其自定义属性serialize=false；
	 *  如果元素被禁用，但需要将其数据提交到服务器，可设置其自定义属性serialize=true；
	 *  如果多选select控件的所有值都需要提交（包括未选中条目的值），可设置自定义属性serializeAll=true。
	 */
	save:function(config){
		//构建配置
		if(typeof config == "string") {
			config = {url:config};
		}
		
		config = jQuery.extend({
			showMsg: true,
			form: OZ.Form.id,
			callback: (typeof onBtnSave_Success == "function") ? onBtnSave_Success : jQuery.noop
		},config);
		
		// 调用用户定义的保存函数
		if(typeof beforeSave == "function"){
			if(beforeSave(config) === false) {
				return false;//保存前的自定义处理
			}
		}
		
		// 同步HtmlEditor的数据
		OZ.Form.synchHtmlEditor();
		
		// 表单验证
		if(!OZ.Form.validate()) {
			return false;
		}
		
		// 保存
		$.post(
			config.url + "&timeStamp=" + new Date().getTime(), 
			OZ.Form.serializeForm(config.form),
			function(json){
				// 保存成功
				if(json.result === true){
					if(json.id){
						// 更新id的值
						$("#id").val(json.id);
					}
					
					// 设为false将禁止显示内置的信息提示
					if(config.showMsg){
						OZ.Msg.slide(json.msg || "文档保存成功！");
					}
					
					if(typeof config.callback == "function"){
						config.callback.call(this, json);
					}
				}else{
					// 保存失败
					OZ.Msg.warn(json.msg || "信息保存失败！");
				}
			},
			"json"
		);
	},
	
	/** 
	 * 表单ajax提交。
	 *  如果要强制某些元素的数据不提交到服务器，可设置其自定义属性serialize=false；
	 *  如果元素被禁用，但需要将其数据提交到服务器，可设置其自定义属性serialize=true；
	 *  如果多选select控件的所有值都需要提交（包括未选中条目的值），可设置自定义属性serializeAll=true。
	 */
	submit:function(url){
		return OZ.Form.save({url:url, showMsg:false});
	},
	getIdValue:function(){
		return $("#id").val();
	},
	/** 
	 * 验证表单数据
	 */
	validate:function(){
		if($.validationEngine){
			if(!$('#ozForm').validationEngine({returnIsValid:true})){
				OZ.Msg.info("请检查必填项");
				return false;
			}				
		}else{
			// 系统默认的验证
			if(!OZ.Form.validateBtField(null, true)){
				return false;
			}
		}
		
		// 自定义的验证 -- 不推荐使用该函数，请使用下面那个函数
		if(typeof afterValidate == "function"){
			if(afterValidate() === false)
				return false;
		}
		
		// 自定义的验证
		if(typeof validateForm == "function"){
			if(validateForm() === false)
				return false;
		}
		
		return true;
	},
	
	// 验证指定的域是否填写
	// @param fieldIDs 所要验证的域列表，域之间使用分号进行分割
	// @param autoValidateFormBtField 是否自动验证表单中以bt开头的样式的域，默认为true
	validateBtField : function(fieldIDs, autoValidateFormBtField){
		// 首先验证系统内部的必填域
		if(autoValidateFormBtField){
			if(!OZ.Form.validateBTFieldByClazz()){
				return false;
			}
		}
		return OZ.Form.validateBtFieldByFields(fieldIDs);
	},
	
	// 通过设定的样式对Form中的字段进行必填验证
	validateBTFieldByClazz : function(){
		var txtBtField = [];
		var numberBtField = [];
		var dateBtField = [];	
		$(".oz-form-btField:visible").each(function(){
			if(!OZ.Form.validateValue(this)){				
				OZ.Form.addFieldCn(txtBtField,this);
			}
		});
			
		$(".oz-form-btNumberField:visible").each(function(){
			var value = $(this).val();
			if(!(/^[0-9]+([.]{0}|[.]{1}[0-9]+)$/.test(value))){
				OZ.Form.addFieldCn(numberBtField,this);
			}
		});	
		
		$(".oz-form-btIntField:visible").each(function(){
			var value = $(this).val();
			if(!(/^[0-9]*$/.test(value))){
				OZ.Form.addFieldCn(numberBtField,this);
			}
		});
		
		$(".oz-form-btDateField:visible").each(function(){
			if($.trim($(this).val()) == ""){
				OZ.Form.addFieldCn(dateBtField,this);
			}
		});
		return OZ.Form.alterErrMsg(txtBtField, numberBtField, dateBtField);
	},
	addFieldCn:function(msgs,field){
		try{
			msgs.push($(field).parents(".oz-property:eq(0)").prev().text().replace(/(\s|：|\xa0)/g,""));
		}catch(e){
			
		}
	},
	// 验证指定的字段是否填写必填信息
	validateBtFieldByFields : function(fieldIDs){
		if(null == fieldIDs || fieldIDs.length === 0){
			return true;
		}
			
		var txtBtField = [];
		var numberBtField = [];
		var dateBtField = [];
		var fieldArray = fieldIDs.split(";");
		for(var i = 0; i < fieldArray.length; i++){
			element = $(fieldArray[i]); 
			if(!OZ.Form.validateValue(element)){				
				OZ.Form.addFieldCn(txtBtField,element);
			}
		}
		return OZ.Form.alterErrMsg(txtBtField, numberBtField, dateBtField);
	},
	
	// 提示用户有哪些字段没有填写
	alterErrMsg : function(txtBtFields, numberBtFields, dateBtFields){
		// 提示用户
		var msg = "";
		if(txtBtFields.length > 0){
			msg = "请填写以下字段的值：<br>&nbsp;&nbsp;&nbsp;&nbsp;" + txtBtFields;
		}
		if(numberBtFields.length>0){
			if(msg.length > 0){
				msg += "<br>";
			}
			msg += "以下字段的值必须是整数：<br>&nbsp;&nbsp;&nbsp;&nbsp;" + numberBtFields;
		}
		if(dateBtFields.length>0){
			if(msg.length > 0){
				msg += "<br>";
			}
			msg += "以下字段的值必须是日期：<br>&nbsp;&nbsp;&nbsp;&nbsp;" + dateBtFields;
		}
		if(msg.length > 0){
			OZ.Msg.info(msg);
			return false;
		}else{
			return true;
		}
	},

	validateValue : function(element){	
		var elem = $(element);
		if ( elem && elem.size() ) {
			var sel = elem[0];
			if ( $.nodeName( sel, "select" ) ) {
				var index = sel.selectedIndex,
					options = sel.options,
					one = sel.type == "select-one";
				if(one){
					var value = $.trim(elem.val());
					return (index > -1 && value!="" && value!= -1);
				}else{
					return options.length > 0;
				}
			}
			
			if ( elem.attr("type")=="radio" || elem.attr("dataType")=="radio"){
				return $("input[name='"+elem.attr("name")+"']:checked").val()!=null;	
			}
			
			if ( elem.attr("type")=="checkbox" || elem.attr("dataType")=="checkbox"){
				var size=$("input[name='"+elem.attr("name")+"']:checked").size();
				if (size>0)
					return true;
				else
					return false;	
			}						
			
			return $.trim(elem.val()) != "";
		}
		return false;
	},
	
	/**
	 * 序列化表单的数据
	 * @param 所要序列化表单的Id 
	 */
	serializeForm : function(formId){
		return jQuery.param($(formId).serializeArray())
	},
	
	/**
	 * 绑定日期时间输入框
	 */
	bindDateTime:function(){
		// 判断是否自定义了时间日期控件的绑定
		if(typeof bindDataTimeCtrl == "function"){
			bindDataTimeCtrl.call(this);
			return;
		}
		
		if($.datepicker){
			$(".oz-dateField[readonly!='readonly']").datepicker({
				showAnim:'',
				showButtonPanel: false,
				changeMonth: true,
				changeYear: true,
				showTime: false
			});
			$(".oz-dateTimeField[readonly!='readonly']").datepicker({
				showAnim:'',
				showButtonPanel: true,
				changeMonth: true,
				changeYear: true,
				showTime: true
			});
		}
	},

	/**
	 * 绑定自动完成组件
	 */
	bindAutoComplete:function(){		
		if($.ui && $.ui.autocomplete){
			$(".oz-autoComplete").each(function(){
				var $this = $(this);
				$this.autocomplete($.evalJSON($.toJSON($this.metadata()).replace("$contextPath",contextPath)));
			});
		}
	},
	
	/**
	 * 绑定联动组件
	 */
	bindAutoLinkSelect:function(){		
		if(OZ.autoLinkSelect){
			// 在oz.linkSelect.js中定义的函数
			OZ.autoLinkSelect();
		}
	},

	/**
	 * 绑定RichInput组件，为简化单位/部门等选择使用
	 */
	bindRichInput4Unit:function(){		
		$(".oz-richinput4unit").each(function(){
			var richInputId = this.id;
			$("#" + richInputId).richinput({
				onchange:OZ.Organize.onChange4Unit,
				displayFormat:OZ.Organize.richInputFormat4Unit
			});
			OZ.Organize.onRichInputInit4Unit(richInputId);
		});
	},

	/**
	 * 绑定HtmlEditor
	 */
	bindHtmlEditor:function(){
		$(".ueditor").each(function(){
			var ueditor = new baidu.editor.ui.Editor();
			ueditor.render($(this).attr("id"));
			ueditor.setContent($("#" + $(this).attr("dataField")).val());
			OZ.Form.htmlEditors[$(this).attr("dataField")] = ueditor;
		});
	},
	
	/**
	 * 同步HtmlEditor中内容 
	 */
	synchHtmlEditor:function(){
		$(".ueditor").each(function(){			
			var ueditor = OZ.Form.htmlEditors[$(this).attr("dataField")];
			if(null != ueditor){
				$("#" + $(this).attr("dataField")).val(ueditor.getContent());
			}
		});
	}
};

document.onkeypress=onkeydown;  
//禁止后退键  作用于IE、Chrome  
document.onkeydown=onkeydown;

function onkeydown()
{
	if ((event.keyCode==8) ) //屏蔽退格删除键  
	{   
	
	  if (window.event.srcElement.tagName.toUpperCase()!="INPUT" && window.event.srcElement.tagName.toUpperCase()!="TEXTAREA" && window.event.srcElement.tagName.toUpperCase()!="TEXT")  
	  {
	    event.keyCode=0;
	    event.returnValue=false;
	  }
	}
}