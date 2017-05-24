<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title><oz:messageSource code="oz.component.acl.datascopepermission"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.component.acl.datascopepermission"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="acl/dataScopePermissionAction" searchButton="none">
			<oz:tbSeperator/>
			<oz:tbButton id="btnBack"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnRefresh"/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="acl/dataScopePermissionAction" sortName="resourceName" sortOrder="asc" fit="true">
			<oz:column field="id" checkbox="true" title=""/>
			<oz:column field="dataScopeType" title="oz.component.acl.datascopepermission.fields.type" width="120" sortable="true" formatter="dataScopeTypeFormatter"/>
			<oz:column field="resourceName" title="oz.component.acl.datascopepermission.fields.name" width="240" sortable="true" formatter="dataScopeResourceFormatter"/>
			<oz:column field="resourceId" title="oz.component.acl.datascopepermission.fields.resourceid" width="240" sortable="true" formatter="dataScopeResourceFormatter"/>
		</oz:grid>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function dataScopeTypeFormatter(value, json){
	if(value == 0)
		return '<oz:messageSource code="oz.component.acl.datascopepermission.type.byunit"/>';
	if(value == 1)
		return '<oz:messageSource code="oz.component.acl.datascopepermission.type.bydepartment"/>';
	if(value == 2)
		return '<oz:messageSource code="oz.component.acl.datascopepermission.type.byuser"/>';
	return '<oz:messageSource code="oz.component.acl.datascopepermission.type.userdefined"/>';
}

function dataScopeResourceFormatter(value, json){
	var html = "<a href='javascript:dataScopeAllocate_Clicked(" + json.id + ")'>";
	html += value + "</a>";
	return html;
}

function dataScopeAllocate_Clicked(resourceId){
	var strUrl = contextPath + "/acl/dataScopePermissionAction.do?action=dlgPermissionAllocate&resourceId=" + resourceId;
	strUrl += "&timeStamp=" + new Date().getTime();
	
	new OZ.Dlg.create({ 
		id:"dlg_DSPermission", width:640, height:510,
		title:'<oz:messageSource code="oz.component.acl.datascopepermission"/>',
		url: strUrl,
		buttons:[{text:'<oz:messageSource code="oz.close"/>',handler:$.noop}]
	});
}
</script>
</html>