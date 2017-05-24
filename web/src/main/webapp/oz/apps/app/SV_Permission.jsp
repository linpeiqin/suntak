<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
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
		<oz:toolbar action="app/permissionAction" svFlag="true" searchButton="none">
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
		<c:if test="${editFlag}">
			<oz:grid action="app/permissionAction" sortName="name" sortOrder="asc" fit="true" pagination="false" excel="true">
				<oz:column field="id" checkbox="true"/>
				<oz:column field="enable" title="oz.mdu.security.permission.fields.status" width="48" sortable="false" formatter="permissionEnableFormatter"/>
				<oz:column field="code" title="oz.mdu.security.permission.fields.code" width="320" sortable="false" formatter="permissionFormatter"/>
				<oz:column field="name" title="oz.mdu.security.permission.fields.name" width="240" sortable="false" formatter="permissionFormatter"/>
			</oz:grid>
		</c:if>
		<c:if test="${!editFlag}">
			<oz:grid action="app/permissionAction" sortName="name" sortOrder="asc" fit="true" pagination="false" rownumbers="true">
				<oz:column field="id" checkbox="false" align="center"/>
				<oz:column field="enable" title="oz.mdu.security.permission.fields.status" width="48" sortable="false" formatter="permissionEnableFormatter"/>
				<oz:column field="code" title="oz.mdu.security.permission.fields.code" width="320" sortable="false" formatter="permissionFormatter"/>
				<oz:column field="name" title="oz.mdu.security.permission.fields.name" width="240" sortable="false" formatter="permissionFormatter"/>
			</oz:grid>
		</c:if>
	</div>
</body>
<script type="text/javascript">
oz_grid_config.url = "<oz:contextPath/>/app/permissionAction.do?action=page&appId=<%= request.getAttribute("appId") %>";
</script>
<oz:js/>
<script type="text/javascript">
function permissionEnableFormatter(value, json){
	if(value == true)
		return '<oz:messageSource code="oz.enable"/>';
	return '<oz:messageSource code="oz.disable"/>';
}

function permissionFormatter(value, json){
	return '<a href="javascript:openPermission(\'' + json.id + '\', \'' + json.name + '\')">' + value + '</a>';
}

function onRow_DBLClicked(rowIndex, json){
	openPermission(json.id, json.name);
}

function openPermission(id, name){
	var strUrl = contextPath + "/app/permissionAction.do?action=open&id=" + id + "&timeStamp=" + new Date().getTime();
	new OZ.Dlg.create({
		id:"Dlg_Permission", 
		width:480, height:320,
		title:'<oz:messageSource code="oz.view"/><oz:messageSource code="oz.mdu.security.permission"/>',
		url: strUrl,
		buttons:[{text:'<oz:messageSource code="oz.close"/>', handler:$.noop}]
	}); 
}

function onBtnDisable_Clicked(){
	var ids = oz_GetGridSelectionIds();
	if(null == ids || ids.length == 0){
		OZ.Msg.info('<oz:messageSource code="oz.mdu.security.permission.msg.disable.noneselected"/>');
		return;
	}
	
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.mdu.security.permission.msg.disable.confirm"/>',
		function(){
			$.getJSON(
				contextPath + "/app/permissionAction.do?action=disable&timeStamp=" + new Date().getTime(),
				{ids:ids},
				function(json){
					if(json.result == true){
						OZ.Msg.slide('<oz:messageSource code="oz.mdu.security.permission.msg.disable.success"/>');
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
	var ids = oz_GetGridSelectionIds();
	if(null == ids || ids.length == 0){
		OZ.Msg.info('<oz:messageSource code="oz.mdu.security.permission.msg.enable.noneselected"/>');
		return;
	}
	
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.mdu.security.permission.msg.enable.confirm"/>',
		function(){
			$.getJSON(
				contextPath + "/app/permissionAction.do?action=enable&timeStamp=" + new Date().getTime(),
				{ids:ids},
				function(json){
					if(json.result == true){
						OZ.Msg.slide('<oz:messageSource code="oz.mdu.security.permission.msg.enable.success"/>');
						OZ.View.reload();
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			);
		}
	);
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
					OZ.Msg.slide(json.msg);
				},
				"json"
			);
		},
		onCancel:function(result){
			// do nothing...
		}
	});
}

function onBtnAllocateBrief_Clicked(){
	var rows = OZ.View.getGridSelection();
	if (null == rows || rows.length != 1) {
		OZ.Msg.info('请选择一个所要查看的权限。');
		return;
	}

	var strUrl = contextPath + "/app/permissionAction.do?action=showAllocateBrief&timeStamp=" + new Date().getTime();
	strUrl += "&id=" + rows[0].id;
	OZ.openWindow({
		id: "PermissionAllocateBrief_" + rows[0].id,
		title: "权限分配情况",
		url: strUrl, 
		refresh: false,
		beforeCloseFnName: "oz_Win_BeforeClose"
	});
}
</script>
</html>