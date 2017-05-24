<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view" tree="true"/>
<html>
<head>
	<title><oz:messageSource code="oz.mdu.organize.group"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.organize.group"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="organize/groupAction" searchButton="normal">
			<oz:tbSeperator/>
			<oz:tbButton id="btnBack"/>
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
		<div id="page-center-tree" class="oz-page-center-tree">
			<ul id="ouInfoTree"></ul>
		</div>
		<div id="page-center-seperator" class="oz-page-center-seperator"></div>
		<div id="page-center-grid" class="oz-page-center-grid">
			<oz:grid action="organize/groupAction" sortName="orderNo" sortOrder="asc" fit="true" pagination="false">
				<oz:column field="id" checkbox="true"/>
				<oz:column field="status" title="oz.status" width="60" sortable="false" formatter="groupStatusFormatter"/>
				<oz:column field="name" title="oz.mdu.organize.group.fields.name" width="240" sortable="true" formatter="oz_DefaultFormatter"/>
				<oz:column field="code" title="oz.mdu.organize.group.fields.code" width="100" sortable="true" formatter="oz_DefaultFormatter"/>
				<oz:column field="orderNo" title="oz.mdu.organize.group.fields.orderno" width="100" sortable="true" formatter="oz_DefaultFormatter"/>
			</oz:grid>
		</div>
	</div>
</body>
<oz:js />
<script type="text/javascript">
var _ouId = -1;
function groupStatusFormatter(value, json){
	if(value == 0)
		return '<oz:messageSource code="oz.enable"/>';
	return '<oz:messageSource code="oz.disable"/>';
}

function onBtnNew_Clicked(){
	var strUrl = contextPath + "/organize/groupAction.do?action=create&ouId=" + _ouId;
	OZ.openWindow({
		id: oz_grid_config.id + "_create" + (new Date().getTime()),
		title: '<oz:messageSource code="oz.mdu.organize.group.button.new.group"/>',
		url: strUrl, 
		refresh: true,
		beforeCloseFnName: "oz_Win_BeforeClose"
	});	
}

function onBtnDisable_Clicked(){	
	var rows = OZ.View.getGridSelection();
	if (null == rows || rows.length == 0) {
		OZ.Msg.info('<oz:messageSource code="oz.mdu.organize.group.msg.disable.noneselected"/>');
		return;
	}
	
	var ids=[];
	for(var i=0;i<rows.length;i++){
		ids.push(rows[i].id);
	}	
	
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.mdu.organize.group.msg.disable.confirm"/>',
		function(){
			$.getJSON(
				contextPath + "/organize/groupAction.do?action=disable&timeStamp=" + new Date().getTime(),
				{ids:ids.join(";")},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.mdu.organize.group.msg.disable.success"/>');
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
		OZ.Msg.info('<oz:messageSource code="oz.mdu.organize.group.msg.enable.noneselected"/>');
		return;
	}
	
	var ids=[];
	for(var i=0;i<rows.length;i++){
		ids.push(rows[i].id);
	}	
	
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.mdu.organize.group.msg.enable.confirm"/>',
		function(){
			$.getJSON(
				contextPath + "/organize/groupAction.do?action=enable&timeStamp=" + new Date().getTime(),
				{ids:ids.join(";")},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.mdu.organize.group.msg.enable.success"/>');
						OZ.View.reload();
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			);
		}
	);
}
function executeSync(){
	$.post(
		"/sync/syncAction.do", 
		{action:"doSync"}, 
		function (data){
			var jsonResult = eval("(" + data + ")");;

			if (jsonResult.Result){
				OZ.Msg.info("同步已完成，请重新打开本页面！");
			}
			else {
				OZ.Msg.info(jsonResult.Msg);
			}
		}
	);
}


$(function(){
	$('#ouInfoTree').tree({
		url: contextPath + '/organize/ouTreeAction.do?action=getTree&timeStamp=' + new Date().getTime(),
		click:function(e, data){
			_ouId = data.id;
			OZ.View.reloadGrid({ouId:_ouId, dbftsParams:""});
		}
	});
});
</script>
</html>