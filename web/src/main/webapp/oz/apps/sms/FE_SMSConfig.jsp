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
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnSave"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnTest" text="oz.cmpn.sms.config.buttons.test" icon="oz-icon-0740" onclick="onBtnTest_Clicked()"></oz:tbButton>
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
							<html:select property="configName" styleId="configName" styleClass="egd-form-btField" onchange="onConfigName_Changed()">
								<html:optionsCollection name="configNames" label="name" value="value" />
							</html:select>
						</td>
						<td></td>
					</tr>
					<tr id="TR_IP" style="display:none"> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.sms.config.fields.ipaddress"/>：</td>
						<td class="oz-property">
							<html:text property="imIpAddress" styleClass="oz-form-field"/>
						</td>
						<td></td>
					</tr>
					<tr id="TR_LOGINNAME" style="display:none">
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.sms.config.fields.loginname"/>：</td>
						<td class="oz-property">
							<html:text property="loginName" styleClass="oz-form-field"/>
						</td>
						<td></td>
					</tr>
					<tr id="TR_LOGINPWD" style="display:none"> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.sms.config.fields.loginpwd"/>：</td>
						<td class="oz-property">
							<html:text property="loginPwd" styleClass="oz-form-field"/>
						</td>
						<td></td>
					</tr>
					<tr id="TR_CONFIGCODE" style="display:none"> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.sms.config.fields.configcode"/>：</td>
						<td class="oz-property">
							<html:text property="configCode" styleClass="oz-form-field"/>
						</td>
						<td></td>
					</tr>
					<tr id="TR_DBNAME" style="display:none">
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.sms.config.fields.dbname"/>：</td>
						<td class="oz-property">
							<html:text property="dbName" styleClass="oz-form-field"/>
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
function onBtnTest_Clicked(){
	var strUrl = contextPath + "/sms/smsSendRecordAction.do?action=dlgSendSMS&timeStamp=" + new Date().getTime();
	new OZ.Dlg.create({
		id:"Dlg_SendSMS", 
		width:320, height:240,
		title:'<oz:messageSource code="oz.cmpn.sms.dlg.title.test"/>',
		url: strUrl,
		onOk:function(result){
			strUrl = contextPath + "/sms/smsSendRecordAction.do?action=sendSMS&timeStamp=" + new Date().getTime();
			$.getJSON(
				strUrl, 
				{mobiles:result.mobiles, content:result.content},
				function(json){
					if(json.result == true){
						OZ.Msg.info(json.msg);
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			);
		},
		onCancel:function(result){}
	});
}

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