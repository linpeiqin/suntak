<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="cn.oz.util.StringUtils"%>
<%@ page import="cn.oz.util.DateTimeUtils"%>
<%@ page import="cn.oz.module.worklog.domain.WorkLog"%>
<%@ page import="cn.oz.component.attachment.domain.Attachment"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.mdu.worklog"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
	<oz:css cssHref="/oz/apps/modules/WorkLog.css"/> 
</head>
<body class="oz-body">
<div id="page" class="oz-page">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar svFlag="true" action="workLogAction">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnAdd" text="oz.add" icon="oz-icon-0102" onclick="onBtnAdd_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh" text=""></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center" style="overflow-y: auto;">
		<table class="oz-worklog" border="0" cellspacing="0" cellpadding="0">
		<tr style="height:1px;line-height: 1px;">
			<td></td>
			<td width="250px"></td>
			<td width="150px"></td>
		</tr>
		<%  
			List workLogs = (List)request.getAttribute("workLogs");
			if(null != workLogs && workLogs.size() > 0){
				WorkLog workLog = null;
				for(int i = 0; i < workLogs.size(); i++){
					workLog = (WorkLog)workLogs.get(i);
		%>
		<tr class="oz-worklog-simple">
			<td class="subject"><oz:messageSource code="oz.mdu.worklog.fields.subject"/>：<span><%= workLog.getSubject() %></span></td>
			<td class="doer"><oz:messageSource code="oz.mdu.worklog.fields.author"/>：<span style="color:#009900;"><%= workLog.getAuthor().getName() %>(<%= workLog.getAuthor().getOuName() %>)</span></td>
			<td class="time"><oz:messageSource code="oz.mdu.worklog.fields.createddate"/>：<span><%= DateTimeUtils.formatDateTime2Minute(workLog.getCreatedDate()) %></span></td>
		</tr>
		<tr class="oz-worklog-detail" valign="top">
			<td colspan="3">
				<div class="content oz-font-medium">
					<%= workLog.getLogContent() != null ? workLog.getLogContent().replaceAll("\r\n|\r|\n","<br/>") : "" %>
				</div>
				<div class="attachments">
				<%	
					List attachments = workLog.getAttachments();
				  	if(null != attachments && !attachments.isEmpty()){
				  		Attachment attachment = null;
				  		for(int j = 0; j < attachments.size(); j++){
							attachment = (Attachment)attachments.get(j);
				%>  <ul><li><div class="attachment-icon"></div></li><li><%= attachment.getSubject() %></li><li><a href="<oz:contextPath/>/attachmentAction.do?action=downloadFile&id=<%= attachment.getId() %>"><oz:messageSource code="oz.download"/></a></li></ul>                                     
				<%}}%>
				</div>
			</td>
		</tr>
		<%}}else{%>
		<tr class="oz-worklog-empty">
			<td class="oz-font-medium" colspan="3">
				<b><oz:messageSource code="oz.mdu.worklog.fields.nologs"/></b>
			</td>
		</tr>
		<%}%>
		</table>
		<input type="hidden" id="parentIds" value="<%= request.getAttribute("parentIds") %>">
		<input type="hidden" id="parentId" value="<%= request.getAttribute("parentId") %>">
		<input type="hidden" id="type" value="<%= request.getAttribute("type") %>">
		<input type="hidden" id="editFlag" value="<%= request.getAttribute("editFlag") %>">
	</div>
</div>
</body>
<oz:js/> 
<script type="text/javascript">
function onBtnRefresh_Clicked(){
	document.location.reload(false);
}

function onBtnAdd_Clicked(){
	var strUrl = contextPath + "/module/workLogAction.do?action=add";
	strUrl += "&parentId=" + $("#parentId").val();
	strUrl += "&type=" + $("#type").val();
	OZ.Dlg.create({
		id:"DlgAddWorkLog", 
		width: 500, height: 400,
		url:strUrl,
	    title: '<oz:messageSource code="oz.mdu.worklog.dlg.title.add"/>',
	 	onOk:function(result){
			onBtnRefresh_Clicked();
	 	}
	});
}
</script>
</html>