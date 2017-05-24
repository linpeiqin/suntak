<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="form"/>
<html>
	<head>
		<title><oz:messageSource code="oz.error.page.title"/></title>
		<oz:css/>
	</head>
	<body>
		<div class="system-msg-titleWrap">
			<span class="system-msgBg titleIcon"></span>
			<oz:messageSource code="oz.prompted"/>
		</div>
		<div class="msgTitle-wrap">
			<div class="system-msgBg msgTitle-icon icon-excalmatory"></div>
    		<div class="msgTitle-text" id="content">
    			<oz:messageSource code="oz.exception.access.deniedde"/>
    		</div>
		</div>
	</body>
</html>