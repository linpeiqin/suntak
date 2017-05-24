<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.cmpn.sms.config"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.cmpn.sms.config"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="sms/smsConfigAction">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="sms/smsConfigAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.cmpn.sms.config"/></div>
			<div class="oz-form-fields">
				<table cellpadding="0">
					<tr class="oz-form-emptyTR"> 
						<td width="120"></td>
						<td width="480"></td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.sms.config.fields.configname"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="smsConfigForm" property="configName"/></span>
						</td>
						<td></td>
					</tr>
					<tr id="TR_IP" style="display:none"> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.sms.config.fields.ipaddress"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="smsConfigForm" property="imIpAddress"/></span>
						</td>
						<td></td>
					</tr>
					<tr id="TR_LOGINNAME" style="display:none">
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.sms.config.fields.loginname"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="smsConfigForm" property="loginName"/></span>
						</td>
						<td></td>
					</tr>
					<tr id="TR_LOGINPWD" style="display:none"> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.sms.config.fields.loginpwd"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="smsConfigForm" property="loginPwd"/></span>
						</td>
						<td></td>
					</tr>
					<tr id="TR_CONFIGCODE" style="display:none"> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.sms.config.fields.configcode"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="smsConfigForm" property="configCode"/></span>
						</td>
						<td></td>
					</tr>
					<tr id="TR_DBNAME" style="display:none">
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.sms.config.fields.dbname"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="smsConfigForm" property="dbName"/></span>
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
function onConfigName_Changed(){
	var configName = $("#configName").val();
	if(configName == "MAS" || configName == "MAS_ROYA"){
		$("#TR_IP").show();
		$("#TR_LOGINNAME").show();
		$("#TR_LOGINPWD").show();
		$("#TR_CONFIGCODE").show();
		$("#TR_DBNAME").show();
	}else{
		$("#TR_IP").hide();
		$("#TR_LOGINNAME").hide();
		$("#TR_LOGINPWD").hide();
		$("#TR_CONFIGCODE").hide();
		$("#TR_DBNAME").hide();
	}
}

$(function(){
	onConfigName_Changed();
});
</script>
</html>