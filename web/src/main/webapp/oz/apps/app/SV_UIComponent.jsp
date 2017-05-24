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
<body class="oz-body" data-name="<oz:messageSource code="oz.web.uicomponent"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="app/uicomponentAction" svFlag="true" searchButton="none">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="app/uicomponentAction" sortName="name" sortOrder="asc" fit="true" pagination="false" excel="true">
			<oz:column field="id" checkbox="true"/>
			<oz:column field="type" title="oz.web.uicomponent.fields.type" width="65" sortable="false" formatter="typeFormatter"/>			
			<oz:column field="code" title="oz.web.uicomponent.fields.code" width="260" sortable="false" formatter="uiComponentFormatter"/>
			<oz:column field="name" title="oz.web.uicomponent.fields.name" width="100" sortable="false" formatter="uiComponentFormatter"/>
			<oz:column field="url" title="oz.web.uicomponent.fields.url" width="330" sortable="false" formatter="uiComponentFormatter"/>
		</oz:grid>
	</div>
</body>
<script type="text/javascript">
oz_grid_config.url = "<oz:contextPath/>/app/uicomponentAction.do?action=page&appId=<%= request.getAttribute("appId") %>";
</script>
<oz:js/>
<script type="text/javascript">
function typeFormatter(value, json){
	if("widget" == value)
		return '<oz:messageSource code="oz.web.uicomponent.widget"/>';
	if("shortcut" == value)
		return '<oz:messageSource code="oz.web.uicomponent.shortcut"/>';
	if("navigation" == value)
		return '<oz:messageSource code="oz.web.uicomponent.navigation"/>';
	return value;
}

function uiComponentFormatter(value, json){
	return '<a href="javascript:openUIComponent(\'' + json.id + '\', \'' + json.name + '\')">' + value + '</a>';
}

function onRow_DBLClicked(rowIndex, json){
	openUIComponent(json.id, json.name);
}

function openUIComponent(id, name){
	var strUrl = contextPath + "/app/uicomponentAction.do?action=open&id=" + id + "&timeStamp=" + new Date().getTime();
	new OZ.Dlg.create({
		id:"Dlg_UIComponent", 
		width:640, height:480,
		title:'<oz:messageSource code="oz.view"/><oz:messageSource code="oz.web.uicomponent"/>',
		url: strUrl,
		buttons:[{text:'<oz:messageSource code="oz.close"/>', handler:$.noop}]
	}); 
}

$(function(){
});
</script>
</html>