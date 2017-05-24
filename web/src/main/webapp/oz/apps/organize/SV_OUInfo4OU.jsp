<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title><oz:messageSource code="oz.mdu.organize.ouinfo"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.organize.ouinfo"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar svFlag="true" action="organize/ouInfoAction" searchButton="none">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnNewDepartment" text="oz.mdu.organize.ouinfo.button.new.department" icon="oz-icon-1413" onclick="onBtnNewDepartment_Clicked()"></oz:tbButton>
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
		<oz:grid action="organize/ouInfoAction" sortName="orderNo" sortOrder="asc" fit="true" pagination="false">
				<oz:column field="id" checkbox="true"/>
				<oz:column field="status" title="oz.status" width="60" sortable="false" formatter="ouInfoStatusFormatter"/>
				<oz:column field="name" title="oz.mdu.organize.ouinfo.fields.name" width="240" sortable="false" formatter="ouInfoFormatter"/>
			</oz:grid>
	</div>
</body>
<script type="text/javascript">
var _ouId = <%= request.getAttribute("ouId") %>;
oz_grid_config.url = "<oz:contextPath/>/organize/ouInfoAction.do?action=page&ouType=BM&parentId=" + _ouId;
</script>
<oz:js />
<script type="text/javascript">
function ouInfoStatusFormatter(value, json){
	if(value == 0)
		return '<oz:messageSource code="oz.enable"/>';
	return '<oz:messageSource code="oz.disable"/>';
}

function onBtnNewDepartment_Clicked(){
	var strUrl = contextPath + "/organize/ouInfoAction.do?action=create&type=BM&parentId=" + _ouId;
	OZ.openWindow({
		id: oz_grid_config.id + "_create" + (new Date().getTime()),
		title: '<oz:messageSource code="oz.mdu.organize.ouinfo.button.new.department"/>',
		url: strUrl, 
		refresh: true,
		beforeCloseFnName: "oz_Win_BeforeClose",
		data: "ouInfo"
	});	
}

function onRow_DBLClicked(rowIndex,rowData){
	oz_Default_Row_DBLClicked(rowIndex,rowData,"ouInfo");
}

function ouInfoFormatter(value, rowData, rowIndex){
	return oz_DefaultFormatterEx(value, rowData, rowIndex, "ouInfo");
}

function onBtnDisable_Clicked(){	
	var rows = OZ.View.getGridSelection();
	if (null == rows || rows.length == 0) {
		OZ.Msg.info('<oz:messageSource code="oz.mdu.organize.ouinfo.msg.disable.noneselected"/>');
		return;
	}
	
	var ids=[];
	for(var i=0;i<rows.length;i++){
		ids.push(rows[i].id);
	}	
	
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.mdu.organize.ouinfo.msg.disable.confirm"/>',
		function(){
			$.getJSON(
				contextPath + "/organize/ouInfoAction.do?action=disable&timeStamp=" + new Date().getTime(),
				{ids:ids.join(";")},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.mdu.organize.ouinfo.msg.disable.success"/>');
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
		OZ.Msg.info('<oz:messageSource code="oz.mdu.organize.ouinfo.msg.enable.noneselected"/>');
		return;
	}
	
	var ids=[];
	for(var i=0;i<rows.length;i++){
		ids.push(rows[i].id);
	}	
	
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.mdu.organize.ouinfo.msg.enable.confirm"/>',
		function(){
			$.getJSON(
				contextPath + "/organize/ouInfoAction.do?action=enable&timeStamp=" + new Date().getTime(),
				{ids:ids.join(";")},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.mdu.organize.ouinfo.msg.enable.success"/>');
						OZ.View.reload();
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			);
		}
	);
}
</script>
</html>