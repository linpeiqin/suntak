<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="page"/>
<html>
	<head>
		<title><oz:messageSource code="oz.core.web.error"/></title>
		<oz:css/>
</head>
<body style="padding: 10px;">
	<div class="system-msg-titleWrap">
		<span class="system-msgBg titleIcon">
			<b><oz:messageSource code="oz.core.web.systemmsg"/>:</b>
		</span>
	</div>
	<div class="msgTitle-wrap">
		<div class="system-msgBg msgTitle-icon icon-excalmatory"></div>
    	<div class="msgTitle-text" id="content"><%=request.getAttribute("OZ_ErrMsg") %></div>
	</div>
</body>
</html>