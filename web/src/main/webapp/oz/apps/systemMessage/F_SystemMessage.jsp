<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.mdu.systemmessage"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.systemmessage"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="module/systemMessageAction">
			<oz:tbSeperator/>
			<oz:tbButton id="btnBack"/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="module/systemMessageAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.mdu.systemmessage"/></div>
			<div class="oz-form-fields">
				<table cellpadding="0">
					<tr class="oz-form-emptyTR"> 
						<td width="180"></td>
						<td width="420"></td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.systemmessage.fields.sender"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="systemMessageForm" property="author.name"/> 发送于 <bean:write name="systemMessageForm" property="createdDateTime"/></span>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.systemmessage.fields.subject"/>：</td>
						<td class="oz-property">
							<%
								if("true".equalsIgnoreCase((String)request.getAttribute("href"))){
							%>
							<a href="javascript:onSubject_Cliked()" title="<oz:messageSource code="oz.mdu.systemmessage.fields.view.source.document"/>">
								<span class="oz-form-fields-span"><bean:write name="systemMessageForm" property="subject"/></span>
							</a>
							<%
								}else{
							%>
								<span class="oz-form-fields-span"><bean:write name="systemMessageForm" property="subject"/></span>
							<%
								}
							%>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.systemmessage.fields.message"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="systemMessageForm" property="message"/></span>
						</td>
						<td></td>
					</tr>
				</table>			
			</div>
			<html:hidden property="id" styleId="id"/>
		</html:form>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function onSubject_Cliked(){	
	var strUrl = contextPath + "/module/systemMessageAction.do?action=openSrc";
	strUrl += "&id=" + $("#id").val();
	window.open(strUrl, "_self");
}
</script>
</html>