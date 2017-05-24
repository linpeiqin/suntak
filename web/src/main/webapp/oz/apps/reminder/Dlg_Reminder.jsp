<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="form" timePicker="true" formValidator="true"/>

<%@page import="java.util.List"%>
<%@page import="cn.oz.NameValuePair"%><html>
<head>
	<title><oz:messageSource code="oz.mdu.reminder"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css />
</head>
<body style="background-color: #FFF;height:100%;width:100%;overflow:hidden;border:none;margin: 0px;padding: 0px;">
	<html:form action="module/reminderAction.do" styleId="ozForm" styleClass="oz-form">
		<table width="100%" style="background-color:#FFFFFF" cellspacing="2px" >
			<tr class="oz-form-emptyTR"> 
				<td width="80px"></td>
				<td width="320px"></td>
			</tr>
			<tr>
				<td class="oz-form-label"><oz:messageSource code="oz.mdu.reminder.fields.reminderdate"/>：</td>
				<td class="oz-property">
					<html:text property="reminderDateTime" styleId="reminderDateTime" styleClass="validate[required] oz-form-btField oz-dateTimeField" style="width:160px"/>
				</td>
			</tr>
			<tr>
				<td class="oz-form-label"><oz:messageSource code="oz.mdu.reminder.fields.recipienter"/>：</td>
				<td class="oz-property">
					<html:text property="recipienter.name" styleId="recipienter_name" styleClass="oz-form-btField" style="width:160px" readonly="true"/>
					&nbsp;<button type="button" class="oz-form-button" id="btnSelectRecipienter" style="width:62px;height:21px;" onclick="OZ.Organize.selectUserInfo(afterSelectRecipienter)">选择...</button>
				</td>
			</tr>
			<tr>
				<td class="oz-form-topLabel"><oz:messageSource code="oz.mdu.reminder.fields.content"/>：</td>
				<td class="oz-property">
					<html:textarea property="content" styleId="content" styleClass="oz-form-field" rows="4"/>
				</td>
			</tr>
			<tr>
				<td class="oz-form-label"><oz:messageSource code="oz.mdu.reminder.fields.remindtype"/>：</td>
				<td>
					<%
						List<NameValuePair> canUsedSendActions = (List<NameValuePair>)request.getAttribute("sendActions");
						if(null != canUsedSendActions && canUsedSendActions.size() > 0){
							NameValuePair sendAction = null;
							for(int i = 0; i < canUsedSendActions.size(); i++){
								sendAction = canUsedSendActions.get(i);
					%>
					<input id="chk_<%= sendAction.getValue() %>" class="oz-sendaction" type="checkbox" value="<%= sendAction.getValue() %>"><label for="chk_<%= sendAction.getValue() %>" style="cursor:pointer"><%= sendAction.getName() %></label>
					<%
							}
					   	}
					%>
				</td>
			</tr>
		</table>
		<html:hidden property="id" styleId="id"/><html:hidden property="srcFileId" styleId="srcFileId"/>
		<html:hidden property="status" styleId="status"/><html:hidden property="subject" styleId="subject"/>
		<html:hidden property="remindType" styleId="remindType"/><html:hidden property="recipienter.id" styleId="recipienter_id"/>
		<html:hidden property="author.id" styleId="author_id"/><html:hidden property="author.name" styleId="author_name"/>
		<html:hidden property="createdDateTime" styleId="createdDateTime"/>
	</html:form>
</body>
<oz:organizeJs></oz:organizeJs>
<oz:js/>
<script type="text/javascript">
var _result = null;

function ozDlgOkFn(){
	if(null == _result){
		if(!OZ.Form.validate()) {
			return false;
		}

		// 组合提醒方式
		var remindActions = "";
		$(".oz-sendaction").each(function(){
			if($(this).attr("checked")){
				if(remindActions.length > 0)
					remindActions += ",";
				remindActions += $(this).attr("value");
			}
		});
		$("#remindType").val(remindActions);
		
		var saveUrl = contextPath + "/module/reminderAction.do?action=saveByAjax";
		OZ.Form.save({url:saveUrl, showMsg:false});
		return false;
	}else{
		return _result;
	}
}

function onBtnSave_Success(json){
	_result = json;
	OZ.Dlg.fireButtonEvent(0, "dlgReminder");
}

function afterSelectRecipienter(userInfo){
	$("#recipienter_id").val(userInfo.id);
	$("#recipienter_name").val(userInfo.name);
}

$(function(){
	var remindType = $("#remindType").val();
	if(null != remindType && remindType.length > 0){
		var remindActions = remindType.split(",");
		$(".oz-sendaction").each(function(){
			for(var i = 0; i < remindActions.length; i++){
				if($(this).attr("value") == remindActions[i]){
					$(this).attr("checked", true);
				}
			}
		});
	}
});
</script>
</html>