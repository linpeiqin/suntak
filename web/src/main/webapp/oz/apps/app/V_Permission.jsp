<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view" tree="true"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.mdu.security.permission"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.security.permission"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="app/permissionAction" searchButton="normal">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnEnable" text="oz.enable" icon="oz-icon-0901" onclick="onBtnEnable_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnDisable" text="oz.disable" icon="oz-icon-0903" onclick="onBtnDisable_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnAllocate4Role" text="oz.mdu.security.permission.button.allocate4role" icon="oz-icon-0209" onclick="onBtnAllocate4Role_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnAllocateBrief" text="oz.mdu.security.permission.button.allocate.brief" icon="oz-icon-1417" onclick="onBtnAllocateBrief_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<div id="page-center-tree" class="oz-page-center-tree">
			<ul id="appTree"></ul>
		</div>
		<div id="page-center-seperator" class="oz-page-center-seperator"></div>
		<div id="page-center-grid" class="oz-page-center-grid">
			<oz:grid action="app/permissionAction" sortName="name" sortOrder="asc" fit="true" pagination="false" excel="true">
				<oz:column field="id" checkbox="true"/>
				<oz:column field="enable" title="oz.mdu.security.permission.fields.status" width="48" sortable="false" formatter="permissionEnableFormatter"/>
				<oz:column field="code" title="oz.mdu.security.permission.fields.code" width="360" sortable="false" formatter="permissionFormatter"/>
				<oz:column field="name" title="oz.mdu.security.permission.fields.name" width="240" sortable="false" formatter="permissionFormatter"/>
			</oz:grid>
		</div>		
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function permissionEnableFormatter(value, json){
	if(value == true)
		return '<oz:messageSource code="oz.enable"/>';
	return '<oz:messageSource code="oz.disable"/>';
}

function permissionFormatter(value, json, rowIndex){
	return "<a href='javascript:oz_OpenGridRow(" + rowIndex + ",\"\")' title='" + json.description + "'>" + value + "</a>";
}

function onBtnDisable_Clicked(){	
	var rows = OZ.View.getGridSelection();
	if (null == rows || rows.length == 0) {
		OZ.Msg.info('<oz:messageSource code="oz.mdu.security.permission.msg.disable.noneselected"/>');
		return;
	}
	
	var ids=[];
	for(var i=0;i<rows.length;i++){
		ids.push(rows[i].id);
	}	
	
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.mdu.security.permission.msg.disable.confirm"/>',
		function(){
			$.getJSON(
				contextPath + "/app/permissionAction.do?action=disable&timeStamp=" + new Date().getTime(),
				{codes:ids.join(",")},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.mdu.security.permission.msg.disable.success"/>');
						OZ.View.reload();
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			);
		}
	);
}

function onBtnEnable_Clicked(){
	var rows = OZ.View.getGridSelection();
	if (null == rows || rows.length == 0) {
		OZ.Msg.info('<oz:messageSource code="oz.mdu.security.permission.msg.enable.noneselected"/>');
		return;
	}
	
	var ids=[];
	for(var i=0;i<rows.length;i++){
		ids.push(rows[i].id);
	}	
	
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.mdu.security.permission.msg.enable.confirm"/>',
		function(){
			$.getJSON(
				contextPath + "/app/permissionAction.do?action=enable&timeStamp=" + new Date().getTime(),
				{codes:ids.join(",")},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.mdu.security.permission.msg.enable.success"/>');
						OZ.View.reload();
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			);
		}
	);
}

function onBtnAllocate_Clicked(){
	var strUrl = contextPath + "/organize/ouPermissionAction.do?action=dlgOUPermission";
	strUrl += "&timeStamp=" + new Date().getTime();
	
	new OZ.Dlg.create({
		id:"dlg_OUPermission", width:640, height:475,
		title:'<oz:messageSource code="oz.mdu.security.permission.button.allocate"/>',
		url: strUrl,
		buttons:[{text:'<oz:messageSource code="oz.close"/>',handler:$.noop}]
	});
}

function onBtnAllocateBrief_Clicked(){
	var rows = OZ.View.getGridSelection();
	if (null == rows || rows.length != 1) {
		OZ.Msg.info('请选择一个所要查看的权限。');
		return;
	}

	var strUrl = contextPath + "/security/permissionAction.do?action=showAllocateBrief&timeStamp=" + new Date().getTime();
	strUrl += "&id=" + rows[0].id;
	OZ.openWindow({
		id: "PermissionAllocateBrief_" + rows[0].id,
		title: "权限分配情况",
		url: strUrl, 
		refresh: false,
		beforeCloseFnName: "oz_Win_BeforeClose"
	});
}

function onBtnAllocate4Role_Clicked(){
	var rows = OZ.View.getGridSelection();
	if (null == rows || rows.length != 1) {
		OZ.Msg.info('请选择一个所要分配的权限。');
		return;
	}
	
	var strUrl = contextPath + "/security/roleAction.do?action=dlgAllocatePermission&permissionId=" + rows[0].id;
	strUrl += "&timeStamp=" + new Date().getTime();
	new OZ.Dlg.create({
		id:"dlg_AllocatePermission", width:305, height:400,
		title:'<oz:messageSource code="oz.mdu.security.permission.button.allocate4role"/>',
		url: strUrl,
		onOk:function(result){
			$.post(
				contextPath + "/security/roleAction.do?action=updateByPermission&timeStamp=" + new Date().getTime(),
				{permissionId:rows[0].id, roleIds:result},
				function(json){
					OZ.Msg.info(json.msg);
				},
				"json"
			);
		},
		onCancel:function(result){
			// do nothing...
		}
	});
}

$(function(){
	$('#appTree').tree({
		url: contextPath + '/app/applicationAction.do?action=appTree&timeStamp=' + new Date().getTime(),
		click:function(e, data){
			OZ.View.reloadGrid({appId:data.id, dbftsParams:""});
		}
	});
});
</script>
</html>