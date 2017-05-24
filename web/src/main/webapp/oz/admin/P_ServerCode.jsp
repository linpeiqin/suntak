<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" ex="bootstrap"/>
<head>
	<title>服务器机器码</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>	
</head>
<body class="oz-body" data-name="系统管理员工具">
<div id="page" class="oz-page">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="admin/getServerCodeAction">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<span>当前服务器的机器码为: <b>${serverCode}</b></span>
	</div>
</div>
</body>
<oz:js/>
</html>