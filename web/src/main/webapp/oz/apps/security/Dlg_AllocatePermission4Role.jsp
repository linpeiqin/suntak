<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" tree="true" messager="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.security.permission.button.allocate4role"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" style="background-color: #F4FEFF;height:100%;width:100%;overflow:hidden;border:none;margin: 0px;padding: 0px;">
	<div style="width:288;height:320px;overflow:auto;">
		<ul id="roleTree"></ul>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
var _permissionId = '<%= request.getAttribute("permissionId") %>';

$(function(){
	var strUrl = contextPath + "/security/roleAction.do?action=getRoleTree&timeStamp=" + new Date().getTime();
	strUrl += "&permissionId=" + _permissionId;
	$('#roleTree').tree({checkbox: true, checkable: true, url: strUrl});
});

function ozDlgOkFn(){
	var nodes = $('#roleTree').tree('getChecked', true);
	var roleIds = '';
	for(var i = 0; i < nodes.length; i++){
		if(roleIds != '') 
			roleIds += ',';
		roleIds += nodes[i].id;
	}
	return roleIds;
}
</script>
</html>