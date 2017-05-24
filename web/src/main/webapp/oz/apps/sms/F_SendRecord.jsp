<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.cmpn.sms.sendrecord"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.cmpn.sms.sendrecord"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="sms/smsConfigAction">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="sms/smsSendRecordAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.cmpn.sms.sendrecord"/></div>
			<div class="oz-form-fields">
				<table cellpadding="0" style="table-layout:   fixed  ;">
					<tr class="oz-form-emptyTR"> 
						<td width="120"></td>
						<td width="480"></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.sms.sendrecord.fields.authorname"/>：</td>
						<td class="oz-property">
							<bean:write name="smsSendRecordForm" property="author.name"/>
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.sms.sendrecord.fields.createddate"/>：</td>
						<td class="oz-property">
							<bean:write name="smsSendRecordForm" property="createdDate" format="yyyy-MM-dd"/>
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.sms.sendrecord.fields.mobiles"/>：</td>
						<td style="word-wrap:   break-word">
							<logic:iterate id="mobileNo" name="smsSendRecordForm" property="mobileNos">
							<span>	<bean:write name="mobileNo"/> </span>
							</logic:iterate>
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.sms.sendrecord.fields.content"/>：</td>
						<td class="oz-property">
							<bean:write name="smsSendRecordForm" property="content"/>
						</td>
					</tr>
				</table>			
			</div>
			<html:hidden property="id" styleId="id"/>
		</html:form>
	</div>
</body>
<oz:js/>
<script type="text/javascript">

</script>
</html>