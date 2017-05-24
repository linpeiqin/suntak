<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.mdu.security.role"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.security.role"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="security/roleAction" searchButton="normal">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnNew"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnEnable" text="oz.enable" icon="oz-icon-0901" onclick="onBtnEnable_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnDisable" text="oz.disable" icon="oz-icon-0903" onclick="onBtnDisable_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnAllocatedGroup" text="oz.mdu.security.role.allocated.group" icon="oz-icon-0507" onclick="onBtnAllocatedGroup_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnDelete"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="security/roleAction" sortName="name" sortOrder="asc" fit="true">
			<oz:column field="id" checkbox="true"/>
			<oz:column field="status" title="oz.mdu.security.role.fields.status" width="48" sortable="false" formatter="roleStatusFormatter"/>
			<oz:column field="name" title="oz.mdu.security.role.fields.name" width="240" sortable="true" formatter="oz_DefaultFormatter"/>
			<oz:column field="code" title="oz.mdu.security.role.fields.code" width="240" sortable="true" formatter="oz_DefaultFormatter"/>
		</oz:grid>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function roleStatusFormatter(value, json){
	if(value == 0)
		return '<oz:messageSource code="oz.enable"/>';
	return '<oz:messageSource code="oz.disable"/>';
}

function onBtnDisable_Clicked(){	
	var rows = OZ.View.getGridSelection();
	if (null == rows || rows.length == 0) {
		OZ.Msg.info('<oz:messageSource code="oz.mdu.security.role.msg.disable.noneselected"/>');
		return;
	}
	
	var ids=[];
	for(var i=0;i<rows.length;i++){
		ids.push(rows[i].id);
	}	
	
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.mdu.security.role.msg.disable.confirm"/>',
		function(){
			$.getJSON(
				contextPath + "/security/roleAction.do?action=disable&timeStamp=" + new Date().getTime(),
				{ids:ids.join(";")},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.mdu.security.role.msg.disable.success"/>');
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
		OZ.Msg.info('<oz:messageSource code="oz.mdu.security.role.msg.enable.noneselected"/>');
		return;
	}
	
	var ids=[];
	for(var i=0;i<rows.length;i++){
		ids.push(rows[i].id);
	}	
	
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.mdu.security.role.msg.enable.confirm"/>',
		function(){
			$.getJSON(
				contextPath + "/security/roleAction.do?action=enable&timeStamp=" + new Date().getTime(),
				{ids:ids.join(";")},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.mdu.security.role.msg.enable.success"/>');
						OZ.View.reload();
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			);
		}
	);
}

function onBtnAllocatedGroup_Clicked(){
	var rows = OZ.View.getGridSelection();
	if (null == rows || rows.length != 1) {
		OZ.Msg.info('请选择一个所要查看的角色。');
		return;
	}

	var id = rows[0].id;
	var strUrl = contextPath + "/organize/groupAction.do?action=dlgAllocatedGroup&roleId=" + id;
	strUrl += "&timeStamp=" + new Date().getTime();
	OZ.openWindow({
		id: "AllocatedGroup" + id,
		title: "包含岗位",
		url: strUrl, 
		refresh: false,
		beforeCloseFnName: "oz_Win_BeforeClose"
	});
}
</script>
</html>