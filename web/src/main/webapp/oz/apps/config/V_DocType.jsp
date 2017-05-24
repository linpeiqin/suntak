<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.config.doctype"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.config.doctype"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="config/doctypeAction" searchButton="normal">
			<oz:tbSeperator/>
			<oz:tbButton id="btnBack"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnRefresh"/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="config/doctypeAction" sortName="name" sortOrder="asc" fit="true">
			<oz:column field="id" checkbox="true" title=""/>
			<oz:column field="name" title="oz.config.doctype.fields.name" sortable="true" width="160" formatter="oz_DefaultFormatter"/>
			<oz:column field="code" title="oz.config.doctype.fields.code" sortable="false" width="160" formatter="oz_DefaultFormatter"/>
			<oz:column field="baseUrl" title="oz.config.doctype.fields.baseurl" sortable="false" width="300" formatter="oz_DefaultFormatter"/>
		</oz:grid>
	</div>
</body>
<oz:js/>
</html>