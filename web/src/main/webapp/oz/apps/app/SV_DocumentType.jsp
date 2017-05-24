<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.web.documenttype"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="app/documentTypeAction" svFlag="true" searchButton="none">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="app/documentTypeAction" sortName="name" sortOrder="asc" fit="true" pagination="false" rownumbers="true">
			<oz:column field="id" checkbox="false" align="center"/>
			<oz:column field="code" title="oz.web.documenttype.fields.code" width="120" sortable="false"/>		
			<oz:column field="name" title="oz.web.documenttype.fields.name" width="120" sortable="false"/>
			<oz:column field="openUrl" title="oz.web.documenttype.fields.openurl" width="320" sortable="false"/>
			<oz:column field="handlerClazz" title="oz.web.documenttype.fields.handlerclazz" width="180" sortable="false"/>
		</oz:grid>
	</div>
</body>
<script type="text/javascript">
oz_grid_config.url = "<oz:contextPath/>/app/documentTypeAction.do?action=page&appId=<%= request.getAttribute("appId") %>";
</script>
<oz:js/>
<script type="text/javascript">
function onRow_DBLClicked(rowIndex, json){
	// do nothing
}

$(function(){
	
});
</script>
</html>