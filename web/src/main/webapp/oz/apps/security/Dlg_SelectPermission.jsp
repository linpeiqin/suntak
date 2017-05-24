<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" tree="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.security.permission"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.security.permission"/>" style="background-color: #F4FEFF;height:100%;width:100%;overflow:hidden;border:none;margin: 0px;padding: 0px;">
	<div style="width:280;height:260px;overflow:auto;">
		<ul id="permissionTree"></ul>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
$(function(){
	$('#permissionTree').tree({ 
		url: contextPath + '/security/permissionAction.do?action=getPermissionTree&timeStamp=' + new Date().getTime()
	});
});

function ozDlgOkFn(){
	var node = $('#permissionTree').tree('getSelected');
	if(node){
		return {
			name:node.text,
			fullName:node.fullName,
			id:node.id
		};
	}else{
		OZ.Msg.alert("对不起，请选择。");
		return false;
	}
}
</script>
</html>