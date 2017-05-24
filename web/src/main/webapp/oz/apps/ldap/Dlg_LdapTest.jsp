<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="dialog"/>
<head>
	<title></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css />
</head>
<body style="background-color: #FFF;height:100%;width:100%;overflow:hidden;border:none;margin: 0px;padding: 0px;">
	<form id="thisForm">
		<table width="100%" style="background-color:#FFFFFF">
			<tr>
				<td style="padding:4px">
					<b><oz:messageSource code="oz.cmpn.ldap.config.fields.username"/>:</b>
				</td>
			</tr>
			<tr>
				<td style="padding:4px">
					<input type="text" id="loginName" name="loginName" style="width:100%" class="oz-form-btField">
				</td>
			</tr>
			<tr>
				<td style="padding:4px">
					<b><oz:messageSource code="oz.cmpn.ldap.config.fields.userpwd"/>:</b>
				</td>
			</tr>
			<tr>
				<td style="padding:4px">
					<input type="text" id="loginPwd" name="loginPwd" style="width:100%" class="oz-form-btField">
				</td>
			</tr>
		</table>
    </form>
</body>
<oz:js />
<script type="text/javascript">
	function ozDlgOkFn(){
		var loginName = $("#loginName").val();
		if(null == loginName || loginName.length == 0){
			OZ.Msg.info('<oz:messageSource code="oz.cmpn.ldap.msg.loginname.isempty"/>');
			return false;
		}

		var loginPwd = $("#loginPwd").val();
		if(null == loginPwd || loginPwd.length == 0){
			OZ.Msg.info('<oz:messageSource code="oz.cmpn.ldap.msg.loginpwd.isempty"/>');
			return false;
		}
		
		return {loginName:loginName, loginPwd:loginPwd};
	}
</script>
</html>