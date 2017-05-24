<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.mdu.integrated.thirdsystem"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.integrated.thirdsystem"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="module/thirdSystemAction" searchButton="normal">
			<oz:tbSeperator/>
			<oz:tbButton id="btnBack"/>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnNew"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnDelete"></oz:tbButton>
			<oz:tbSeperator/>
			<oz:tbButton id="btnRefresh"/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="module/thirdSystemAction" sortName="name" sortOrder="desc" fit="true">
			<oz:column field="id" checkbox="true" title=""/>
			<oz:column field="name" title="oz.mdu.integrated.thirdsystem.fields.name" width="300" sortable="true" formatter="oz_DefaultFormatter"/>
			<oz:column field="key" title="oz.mdu.integrated.thirdsystem.fields.key" width="150" sortable="true" formatter="oz_DefaultFormatter"/>
		</oz:grid>
	</div>
</body>
<oz:js/>
</html>