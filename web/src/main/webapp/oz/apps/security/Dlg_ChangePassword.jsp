<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" tree="true" messager="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.security.user"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body oz-form" style="background-color: #FFFFFF;height:100%;width:100%;overflow:hidden;border:none;margin: 0px;padding: 0px;">
	<div style="padding:4px 4px 0 4px;"><b><oz:messageSource code="oz.mdu.security.user.fields.oldpassword"/>:</b></div>
	<div style="padding:0 4px;">
		<input type="password" id="oldPassword" name="oldPassword" style="width:234px">
	</div>
	<div style="padding:4px 4px 0 4px;"><b><oz:messageSource code="oz.mdu.security.user.fields.newpassword"/>:</b></div>
	<div style="padding:0 4px;">
		<input type="password" id="newPassword" name="newPassword" style="width:234px">
	</div>
	<div style="padding:4px 4px 0 4px;"><b><oz:messageSource code="oz.mdu.security.user.fields.newpassword.again"/>:</b></div>
	<div style="padding:0 4px;">
		<input type="password" id="newPasswordEx" name="newPasswordEx" style="width:234px">
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function ozDlgOkFn(){
	var oldPassword = $("#oldPassword").val();
	if(null == oldPassword || oldPassword.length == 0){
		OZ.Msg.alert('<oz:messageSource code="oz.mdu.security.user.msg.oldpassword.is.null"/>');
        return false;	
	}

	var newPassword = $("#newPassword").val();
	var newPasswordEx = $("#newPasswordEx").val();
	if(null == newPassword || newPassword == 0){
		OZ.Msg.alert('<oz:messageSource code="oz.mdu.security.user.msg.newpassword.is.null"/>');
        return false;	
	}
	if(null == newPasswordEx || newPasswordEx == 0){
		OZ.Msg.alert('<oz:messageSource code="oz.mdu.security.user.msg.newpassword.is.null"/>');
        return false;	
	}
	if(newPassword != newPasswordEx){
		OZ.Msg.alert('<oz:messageSource code="oz.mdu.security.user.msg.newpassword.isnot.match"/>');
        return false;
	}

    return {         
        oldPassword:oldPassword, 
        newPassword:newPassword 
	};
}
</script>
</html>