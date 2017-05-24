<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="dialog" tree="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.security.user"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssId="oz-icon"/>
</head>
<body class="oz-body oz-form" style="background-color: #F4FEFF;height:100%;width:100%;overflow:hidden;border:none;margin: 0px;padding: 0px;">
	<div style="width:288;height:260px;overflow:auto;">
		<ul id="permissionTree"></ul>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
$(function(){
	var strUrl = contextPath + '/security/userAction.do?action=getMyPermissionTree&timeStamp=' + new Date().getTime()
	$('#permissionTree').tree({ url: strUrl});
});
</script>
</html>