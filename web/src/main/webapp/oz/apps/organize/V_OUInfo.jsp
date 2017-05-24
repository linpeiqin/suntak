<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view" tree="true"/>
<html>
<head>
	<title><oz:messageSource code="oz.mdu.organize.ouinfo"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.organize.ouinfo"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="organize/ouInfoAction" searchButton="normal">
			<oz:tbSeperator/>
			<oz:tbButton id="btnBack"/>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnNewUnit" text="oz.mdu.organize.ouinfo.button.new.unit" icon="oz-icon-0214" onclick="onBtnNewUnit_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnNewDepartment" text="oz.mdu.organize.ouinfo.button.new.department" icon="oz-icon-0216" onclick="onBtnNewDepartment_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnEnable" text="oz.enable" icon="oz-icon-0901" onclick="onBtnEnable_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnDisable" text="oz.disable" icon="oz-icon-0903" onclick="onBtnDisable_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnOULevelMgm" text="oz.mdu.organize.ouinfo.button.oulevel.mgm" icon="oz-icon-0721" onclick="onBtnOULevelMgm_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnOUTypeMgm" text="oz.mdu.organize.ouinfo.button.outype.mgm" icon="oz-icon-1425" onclick="onBtnOUTypeMgm_Clicked()"></oz:tbButton>
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
			<oz:grid action="organize/ouInfoAction" sortName="orderNo" sortOrder="asc" fit="true" pagination="true" excel="true">
				<oz:column field="id" checkbox="true"/>
				<oz:column field="status" title="oz.status" width="60" sortable="false" formatter="ouInfoStatusFormatter"/>
				<oz:column field="ouType" title="oz.type" width="160" sortable="false" formatter="ouInfoTypeFormatter"/>
				<oz:column field="name" title="oz.mdu.organize.ouinfo.fields.name" width="240" sortable="false" formatter="oz_DefaultFormatter"/>
			</oz:grid>
		</div>		
	</div>
</body>
<oz:js />
<script type="text/javascript">
var _ouId = -1;
function ouInfoStatusFormatter(value, json){
	if(value == 0)
		return '<oz:messageSource code="oz.enable"/>';
	return '<oz:messageSource code="oz.disable"/>';
}

function ouInfoTypeFormatter(value, json){
	var html = "";
	if(json.tmpOUInfo == "Y" || json.tmpOUInfo == "y")
		html += '<oz:messageSource code="oz.mdu.organize.ouinfo.temporary"/>';
	if(value == "DW")
		return html + '<oz:messageSource code="oz.mdu.organize.ouinfo.type.unit"/>';
	return html + '<oz:messageSource code="oz.mdu.organize.ouinfo.type.department"/>';
}

function ozRefresh(){
	onBtnRefresh_Clicked();
}

function onBtnRefresh_Clicked(){
	oz_ReloadGrid();
	$('#ouInfoTree').tree("reload");
}

function onBtnNewUnit_Clicked(){
	var strUrl = contextPath + "/organize/ouInfoAction.do?action=create&type=DW&parentId=" + _ouId;
	OZ.openWindow({
		id: oz_grid_config.id + "_create" + (new Date().getTime()),
		title: '<oz:messageSource code="oz.mdu.organize.ouinfo.button.new.unit"/>',
		url: strUrl, 
		refresh: true,
		beforeCloseFnName: "oz_Win_BeforeClose"
	});	
}

function onBtnNewDepartment_Clicked(){
	var strUrl = contextPath + "/organize/ouInfoAction.do?action=create&type=BM&parentId=" + _ouId;
	OZ.openWindow({
		id: oz_grid_config.id + "_create" + (new Date().getTime()),
		title: '<oz:messageSource code="oz.mdu.organize.ouinfo.button.new.department"/>',
		url: strUrl, 
		refresh: true,
		beforeCloseFnName: "oz_Win_BeforeClose"
	});	
}

function executeSync(){
	$.post(
		"/sync/syncAction.do", 
		{action:"doSync"}, 
		function (data){
			var jsonResult = eval("(" + data + ")");
			if (jsonResult.Result){
				OZ.Msg.info("同步已完成，请重新打开本页面！");
			}
			else {
				OZ.Msg.info(jsonResult.Msg);
			}
		}
	);
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


function onBtnOULevelMgm_Clicked(){
	var strUrl = contextPath + "/organize/ouLevelAction.do?action=display&timeStamp=" + new Date().getTime();
	new OZ.Dlg.create({ 
		id:"Dlg_OULevelMgm", 
		width:480, height:360,
		title:'<oz:messageSource code="oz.mdu.organize.oulevel"/>',
		url: strUrl,
		buttons:[{text:'<oz:messageSource code="oz.close"/>', handler:$.noop}]
	});		
}

function onBtnOUTypeMgm_Clicked(){
	var strUrl = contextPath + "/organize/ouInfoAction.do?action=openTypeMgmDlg&timeStamp=" + new Date().getTime();
	new OZ.Dlg.create({ 
		id:"Dlg_OUTypeMgm", 
		width:640, height:463,
		title:'<oz:messageSource code="oz.mdu.organize.outype"/>',
		url: strUrl,
		buttons:[{text:'<oz:messageSource code="oz.close"/>', handler:$.noop}]
	});	
}

$(function(){
	$('#ouInfoTree').tree({
		url: contextPath + '/organize/ouTreeAction.do?action=getTree&timeStamp=' + new Date().getTime(),
		click:function(e, data){
			$("#ozQuery").val("");
			_ouId = data.id;
			OZ.View.reloadGrid({parentId:_ouId, dbftsParams:""});
		}
	});
});
</script>
</html>