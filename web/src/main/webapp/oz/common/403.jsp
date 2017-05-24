<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<head>
	<title>403 - 缺少权限</title>
    <oz:css cssId="oz-common"/>
</head>

<body style="padding: 10px;">
<div class="system-msg-titleWrap"><span class="system-msgBg titleIcon"></span>系统提示</div>
<div class="msgTitle-wrap">
	<div class="system-msgBg msgTitle-icon icon-excalmatory"></div>
    <div class="msgTitle-text">你没有访问该页面的权限.</div>
</div>
<div class="msgDetail-wrap">
    <div class="msgDetail-textBold">HTTP 403 错误信息</div>
    <div class="msgDetail-text" >
    您正在打开的页面已经禁止访问。
    </div>
</div>
<div class="msgButton-wrap">
    <div class="msgButton-text" ><input onClick="location.href='/'" class="msgButton1" type="button" value="返回首页"><input onClick="location.href=''" class="msgButton1" type="button" value="退出登录">
    </div> 
</div> 

<!--<div>
	<div><h1>你没有访问该页面的权限.</h1></div>
	<div><a href="<c:url value="/"/>">返回首页</a> <a href="<c:url value="/logout"/>">退出登录</a></div>
</div> -->
</body>
</html>