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
					<html:text property="reminderDateTime" styleId="reminderDateTime" styleClass="oz-form-zdField" style="width:160px" readonly="true"/>
				</td>
			</tr>
			<tr>
				<td class="oz-form-label"><oz:messageSource code="oz.mdu.reminder.fields.recipienter"/>：</td>
				<td class="oz-property">
					<html:text property="recipienter.name" styleId="recipienter_name" styleClass="oz-form-zdField" style="width:160px" readonly="true"/>
				</td>
			</tr>
			<tr>
				<td class="oz-form-topLabel"><oz:messageSource code="oz.mdu.reminder.fields.content"/>：</td>
				<td class="oz-property">
					<html:textarea property="content" styleId="content" styleClass="oz-form-zdField" rows="4" readonly="true"/>
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
					<input id="chk_<%= sendAction.getValue() %>" class="oz-sendaction" type="checkbox" value="<%= sendAction.getValue() %>" disabled="disabled"><%= sendAction.getName() %>
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
function ozDlgOkFn(){
	return true;
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