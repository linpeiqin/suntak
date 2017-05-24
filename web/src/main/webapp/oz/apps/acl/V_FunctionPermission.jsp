<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title><oz:messageSource code="oz.component.acl.functionpermission"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.component.acl.functionpermission"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="acl/functionPermissionAction" searchButton="none">
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
		<oz:grid action="acl/functionPermissionAction" sortName="functionId" sortOrder="asc" fit="true">
			<oz:column field="id" checkbox="true" title=""/>
			<oz:column field="functionId" title="oz.component.acl.functionpermission.fields.functionid" sortable="true" width="420" formatter="functionPermissionFormatter"/>
		</oz:grid>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function functionPermissionFormatter(value, json){
	var html = "<a href='javascript:functionPermissionAllocate_Clicked(" + json.id + ")'>";
	html += value + "</a>";
	return html;
}

function onBtnNew_Clicked(){
	functionPermissionAllocate_Clicked(-1);
}

function functionPermissionAllocate_Clicked(aclId){
	var strUrl = contextPath + "/acl/functionPermissionAction.do?action=dlgPermissionAllocate&id=" + aclId;
	strUrl += "&timeStamp=" + new Date().getTime();

	new OZ.Dlg.create({
		id:"dlg_FPermission", width:420, height:500,
		title:'<oz:messageSource code="oz.component.acl.functionpermission"/>',
		url: strUrl,
		onOk:function(result){
			strUrl = contextPath + "/acl/functionPermissionAction.do?action=updatePermission";
			strUrl += "&timeStamp=" + new Date().getTime();
			$.getJSON(
				strUrl,
				{id:result.id, functionId:result.functionId, sids:result.sids},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.component.acl.functionpermission.dlg.allocate.success"/>');
						OZ.View.reload();
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			);
		},onCancel:function(result){

		}
	});
}
</script>
</html>