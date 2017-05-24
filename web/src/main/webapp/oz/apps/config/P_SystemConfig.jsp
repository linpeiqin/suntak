<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="page"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.config.configitem"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssHref="/oz/apps/config/css/configPage.css"/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.config.configitem"/>">
	<div style="margin:6px;margin-bottom:0px;font-weight:bold;vertical-align:bottom;">基础参数配置</div>
	<hr style="margin-left:4px;margin-right:4px"></hr>
	<div style="padding:4px;text-align: center;margin-bottom:4px">
		<ul class="oz-config-icons">
			<li>
				<div onclick="onConfigItem_Clicked()">
					<div>
						<img src="<oz:contextPath/>/oz/apps/config/images/configItem.png">
					</div>
					<div>
						<oz:messageSource code="oz.config.constants.configitem"/>
					</div>
				</div>
			</li>
			<li style="display:none">
				<div onclick="onEmailConfig_Clicked()">
					<div>
						<img src="<oz:contextPath/>/oz/apps/config/images/email.png">
					</div>
					<div>
						<oz:messageSource code="oz.config.constants.email.config"/>
					</div>
				</div>
			</li>
			<li>
				<div onclick="onSMSConfig_Clicked()">
					<div>
						<img src="<oz:contextPath/>/oz/apps/config/images/sms.png">
					</div>
					<div>
						<oz:messageSource code="oz.config.constants.sms.config"/>
					</div>
				</div>
			</li>
			<li>
				<div onclick="onWindowsADConfig_Clicked()">
					<div>
						<img src="<oz:contextPath/>/oz/apps/config/images/winad.png">
					</div>
					<div>
						<oz:messageSource code="oz.config.constants.winad.config"/>
					</div>
				</div>
			</li>
			<li>
				<div onclick="onLDAPConfig_Clicked()">
					<div>
						<img src="<oz:contextPath/>/oz/apps/config/images/ldap.png">
					</div>
					<div>
						<oz:messageSource code="oz.config.constants.ldap.config"/>
					</div>
				</div>
			</li>
			<li>
				<div onclick="onRtxConfig_Clicked()">
					<div>
						<img src="<oz:contextPath/>/oz/apps/config/images/rtx.png">
					</div>
					<div>
						<oz:messageSource code="oz.cmpn.rtx.config"/>
					</div>
				</div>
			</li>
		</ul>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function onConfigItem_Clicked(){
	var strUrl = contextPath + "/config/configItemAction.do?action=display";
	OZ.openWindow({
		id: "view_configitem" + (new Date().getTime()),
		title: '<oz:messageSource code="oz.config.constants.configitem"/>',
		url: strUrl, 
		refresh: false,
		beforeCloseFnName: "oz_Win_BeforeClose"
	});	
}

function onSMSConfig_Clicked(){
	var strUrl = contextPath + "/sms/smsConfigAction.do?action=open";
	OZ.openWindow({
		id: "view_smsconfig" + (new Date().getTime()),
		title: '<oz:messageSource code="oz.config.constants.sms.config"/>',
		url: strUrl, 
		refresh: false,
		beforeCloseFnName: "oz_Win_BeforeClose"
	});	
}

function onEmailConfig_Clicked(){
	alert("功能完善中...");
}

function onWindowsADConfig_Clicked(){
	var strUrl = contextPath + "/ad/winADConfigAction.do?action=open";
	OZ.openWindow({
		id: "view_winadconfig" + (new Date().getTime()),
		title: '<oz:messageSource code="oz.config.constants.winad.config"/>',
		url: strUrl, 
		refresh: false,
		beforeCloseFnName: "oz_Win_BeforeClose"
	});
}

function onLDAPConfig_Clicked(){
	var strUrl = contextPath + "/ldap/ldapConfigAction.do?action=open";
	OZ.openWindow({
		id: "view_ldapconfig" + (new Date().getTime()),
		title: '<oz:messageSource code="oz.cmpn.ldap.config"/>',
		url: strUrl, 
		refresh: false,
		beforeCloseFnName: "oz_Win_BeforeClose"
	});	
}

function onRtxConfig_Clicked(){
	var strUrl = contextPath + "/rtx/rtxConfigAction.do?action=open";
	OZ.openWindow({
		id: "view_rtxconfig" + (new Date().getTime()),
		title: '<oz:messageSource code="oz.cmpn.rtx.config"/>',
		url: strUrl, 
		refresh: false,
		beforeCloseFnName: "oz_Win_BeforeClose"
	});	
}
</script>
</html>