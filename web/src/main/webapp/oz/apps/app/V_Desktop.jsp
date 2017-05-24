<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view" tree="true"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.web.desktop"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.web.desktop"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="app/desktopAction" searchButton="normal">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnNew"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnEnable" text="oz.enable" icon="oz-icon-0901" onclick="onBtnEnable_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnDisable" text="oz.disable" icon="oz-icon-0903" onclick="onBtnDisable_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnDelete"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="app/desktopAction" sortName="priority" sortOrder="asc" fit="true" pagination="false">
			<oz:column field="id" checkbox="true" title=""/>
			<oz:column field="enable" title="oz.web.desktop.fields.enable" width="60" sortable="false" formatter="enableFormatter"/>
			<oz:column field="priority" title="oz.web.desktop.fields.priority" width="60" sortable="false"/>
			<oz:column field="name" title="oz.web.desktop.fields.name" width="240" sortable="false" formatter="oz_DefaultFormatter"/>
		</oz:grid>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function enableFormatter(value, json){
	if(value == true)
		return '<oz:messageSource code="oz.enable"/>';
	return '<oz:messageSource code="oz.disable"/>';
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
$(function(){
	
});
</script>
</html>