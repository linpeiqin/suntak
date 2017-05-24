<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.config.policy"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.config.policy"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="config/policyAction" searchButton="normal">
			<oz:tbSeperator/>
			<oz:tbButton id="btnBack"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnRefresh"/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="config/policyAction" sortName="subject" sortOrder="asc" fit="true">
			<oz:column field="id" checkbox="true" title=""/>
			<oz:column field="code" title="oz.config.policy.fields.code" sortable="true" width="120" formatter="oz_DefaultFormatter"/>
			<oz:column field="subject" title="oz.config.policy.fields.subject" sortable="true" width="280" formatter="oz_DefaultFormatter"/>
			<oz:column field="policyValue" title="oz.config.policy.fields.policyvalue" width="300"/>
		</oz:grid>
	</div>
</body>
<oz:js/>
</html>