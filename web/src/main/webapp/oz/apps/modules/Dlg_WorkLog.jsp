<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" attachment="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.worklog"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<style type="text/css">
		form{margin:5px;}
		input,textarea{width:100%;}
		.label{margin:10px 0 2px 0;}
	</style>
</head>
<body class="oz-body">
<html:form action="module/workLogAction.do">
	<ul>
		<li class="label"><oz:messageSource code="oz.mdu.worklog.fields.subject"/>：</li>
		<li><html:text property="subject" styleId="subject" styleClass="oz-form-btField" style="height:22px;"/></li>
		<li class="label"><oz:messageSource code="oz.mdu.worklog.fields.logcontent"/>：</li>
		<li><html:textarea property="logContent" styleId="logContent" styleClass="oz-form-field" style="height:100px;"/></li>
		<li>
			<div style="border:1px solid #ccc;height:144px;_height:135px;overflow: auto;margin-top:5px;">
				<oz:attachment id="attachment"/>
			</div>
		</li>
	</ul>
	<html:hidden property="uuid"/>
	<html:hidden property="id" styleId="id"/><html:hidden property="createdDateTime"/>
	<html:hidden property="author.id"/><html:hidden property="author.ouId"/>
	<html:hidden property="author.name"/><html:hidden property="author.ouName"/>
	<html:hidden property="parentId"/><html:hidden property="type"/>
	<html:hidden property="hasAttachment" styleId="hasAttachment"/>
</html:form>
</body>
<oz:js/>
<script type="text/javascript">
var result = false;
function ozDlgOkFn(){
	if(result) 
		return result;

	// 表单验证
	var subject = $("#subject").val();	
	if(subject == null || subject.length == 0){
		OZ.Msg.info('<oz:messageSource code="oz.core.exception.field.isempty"/> <oz:messageSource code="oz.mdu.worklog.fields.subject"/>');
        return false;
    }
	if(null != subject && OZ.getStringActualLen(subject) > 70){
		OZ.Msg.info('<oz:messageSource code="oz.core.exception.too.long01"/><oz:messageSource code="oz.mdu.worklog.fields.subject"/><oz:messageSource code="oz.core.exception.too.long02"/>');
		return false;
	}
    var logContext = $("#logContext").val();
    if(null != logContext && OZ.getStringActualLen(logContext) > 600){
    	OZ.Msg.info('<oz:messageSource code="oz.core.exception.too.long01"/><oz:messageSource code="oz.mdu.worklog.fields.logcontent"/><oz:messageSource code="oz.core.exception.too.long02"/>');
		return false;
    }

    // 保存
    var formData = $.param($("form").serializeArray());
	$.ajax({
		type: "POST",
		dataType: "json",
		data: formData,
		url: contextPath + "/module/workLogAction.do?action=save",
		success: function(json, _status){
	        if (json.result == true){
	        	result = true;
	        	OZ.Dlg.fireButtonEvent(0, "DlgAddWorkLog");
	        }else{
				OZ.Msg.warn(json.msg);
	        }
		},
		error: function(xhr, errorMsg, errorThrown){
			OZ.Msg.error("Unknown error!");
		}
	});
    return false;
}
</script>
</html>