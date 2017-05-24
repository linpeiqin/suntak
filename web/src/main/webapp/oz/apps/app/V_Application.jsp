<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view" tree="true"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.web.application"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssId="oz-app-icon"/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.web.application"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="app/applicationAction" searchButton="none">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="app/applicationAction" sortName="name" sortOrder="asc" fit="true" pagination="false" rownumbers="true">
			<oz:column field="id" checkbox="false" align="center"/>
			<oz:column field="icon" title="" width="28" sortable="false" formatter="iconFormatter"/>
			<oz:column field="name" title="oz.web.application.fields.name" width="320" sortable="false" formatter="oz_DefaultFormatter"/>
			<oz:column field="version" title="oz.web.application.fields.version" width="120" sortable="false"/>
		</oz:grid>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function iconFormatter(value, json){
	return '<span class="app-icon ' + value + '">&nbsp;</span>';
}

$(function(){
	
});
</script>
</html>