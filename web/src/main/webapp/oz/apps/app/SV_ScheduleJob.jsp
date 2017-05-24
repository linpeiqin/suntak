<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.web.schedulejob"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.web.schedulejob"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="app/scheduleJobAction" svFlag="true" searchButton="none">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnEnable" text="oz.enable" icon="oz-icon-0901" onclick="onBtnEnable_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnDisable" text="oz.disable" icon="oz-icon-0903" onclick="onBtnDisable_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="app/scheduleJobAction" sortName="code" sortOrder="asc" fit="true" pagination="false">
			<oz:column field="id" checkbox="true"/>
			<oz:column field="enable" title="oz.web.schedulejob.fields.enable" width="70" sortable="false" formatter="enableFormatter"/>
			<oz:column field="code" title="oz.web.schedulejob.fields.code" width="160" sortable="false" formatter="scheduleJobFormatter"/>
			<oz:column field="name" title="oz.web.schedulejob.fields.name" width="160" sortable="false" formatter="scheduleJobFormatter"/>
			<oz:column field="beanName" title="oz.web.schedulejob.fields.beanname" width="240" sortable="false" formatter="scheduleJobFormatter"/>
			<oz:column field="cronExpression" title="oz.web.schedulejob.fields.fields.cronexpression" width="120" formatter="scheduleJobFormatter"/>
		</oz:grid>
	</div>
</body>
<script type="text/javascript">
oz_grid_config.url = "<oz:contextPath/>/app/scheduleJobAction.do?action=page&appId=${appId}";
</script>
<oz:js/>
<script type="text/javascript">
var _editFlag = ${editFlag};
function enableFormatter(value, json){
	if(value == true)
		return '<oz:messageSource code="oz.enable"/>';
	return '<oz:messageSource code="oz.disable"/>';
}

function scheduleJobFormatter(value, json){
	return '<a href="javascript:openScheduleJob(\'' + json.id + '\')">' + value + '</a>';
}

function onRow_DBLClicked(rowIndex, json){
	openScheduleJob(json.id);
}

function openScheduleJob(id){
	var strUrl = contextPath + "/app/scheduleJobAction.do?action=open&id=" + id;
	if(!_editFlag){
		openScheduleJobViewDlg(strUrl, '<oz:messageSource code="oz.view"/><oz:messageSource code="oz.web.schedulejob"/>');
	}else{
		openScheduleJobDlg(strUrl, '<oz:messageSource code="oz.edit"/><oz:messageSource code="oz.web.schedulejob"/>');
	}
}

function openScheduleJobDlg(strUrl, title){
	strUrl += "&timeStamp=" + new Date().getTime();	
	new OZ.Dlg.create({ 
		id:"Dlg_ScheduleJob", 
		width:640, height:480,
		title:title,
		url: strUrl,
		onOk:function(result){
			OZ.View.reloadGrid();
		},
		onCancel:function(result){
			// do nothing...
		}
	});
}

function openScheduleJobViewDlg(strUrl, title){
	strUrl += "&timeStamp=" + new Date().getTime();	
	new OZ.Dlg.create({ 
		id:"Dlg_ScheduleJob", 
		width:640, height:480,
		title:title,
		url: strUrl,
		buttons:[{text:'<oz:messageSource code="oz.close"/>', handler:$.noop}]
	});
}

function onBtnDisable_Clicked(){
	var ids = oz_GetGridSelectionIds();
	if(null == ids || ids.length == 0){
		OZ.Msg.info('<oz:messageSource code="oz.web.schedulejob.msg.disable.noneselected"/>');
		return;
	}
	
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.web.schedulejob.msg.disable.confirm"/>',
		function(){
			$.getJSON(
				contextPath + "/app/scheduleJobAction.do?action=disable&timeStamp=" + new Date().getTime(),
				{ids:ids},
				function(json){
					if(json.result == true){
						OZ.Msg.slide('<oz:messageSource code="oz.web.schedulejob.msg.disable.success"/>');
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
		OZ.Msg.info('<oz:messageSource code="oz.web.schedulejob.msg.enable.noneselected"/>');
		return;
	}
	
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.web.schedulejob.msg.enable.confirm"/>',
		function(){
			$.getJSON(
				contextPath + "/app/scheduleJobAction.do?action=enable&timeStamp=" + new Date().getTime(),
				{ids:ids},
				function(json){
					if(json.result == true){
						OZ.Msg.slide('<oz:messageSource code="oz.web.schedulejob.msg.enable.success"/>');
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