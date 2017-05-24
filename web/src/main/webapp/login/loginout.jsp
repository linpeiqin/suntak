<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
	<oz:ui/>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>
        	<oz:systemConfiguration key="system.title"></oz:systemConfiguration>-<oz:systemConfiguration key="system.version.no"></oz:systemConfiguration>
        </title>
        <oz:css/>
	</head>
<body>
</body>
<oz:js/>
<script type="text/javascript">
$(function(){
	var logoutPage = contextPath + '/?ts=' + new Date().getTime();
	window.open(logoutPage, "_self");
});
</script>
</html>