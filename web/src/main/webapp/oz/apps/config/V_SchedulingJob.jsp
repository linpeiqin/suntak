<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.config.schedulingjob"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.config.schedulingjob"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="config/schedulingJobAction" searchButton="none">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnEnable" text="oz.enable" icon="oz-icon-0901" onclick="onBtnEnable_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnDisable" text="oz.disable" icon="oz-icon-0903" onclick="onBtnDisable_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="config/schedulingJobAction" sortName="name" sortOrder="asc" fit="true">
			<oz:column field="id" checkbox="true"/>
			<oz:column field="jobStatus" title="oz.config.schedulingjob.fields.status" width="120" formatter="statusFormatter"/>
			<oz:column field="name" title="oz.config.schedulingjob.fields.name" width="240" sortable="true" formatter="oz_DefaultFormatter"/>
			<oz:column field="jobId" title="oz.config.schedulingjob.fields.jobid" width="160" sortable="true" formatter="oz_DefaultFormatter"/>
			<oz:column field="cronExpression" title="oz.config.schedulingjob.fields.cronexpression" width="240"/>
		</oz:grid>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function statusFormatter(value, json){
	if(value == 0)
		return '<oz:messageSource code="oz.enable"/>';
	return '<oz:messageSource code="oz.disable"/>';
}

function onBtnDisable_Clicked(){	
	var rows = OZ.View.getGridSelection();
	if (null == rows || rows.length == 0) {
		OZ.Msg.info('<oz:messageSource code="oz.config.schedulingjob.disable.msg.noneselected"/>');
		return;
	}
	
	var ids=[];
	for(var i=0;i<rows.length;i++){
		ids.push(rows[i].id);
	}	
	
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.config.schedulingjob.disable.msg.confirm"/>',
		function(){
			$.getJSON(
				contextPath + "/config/schedulingJobAction.do?action=disable&timeStamp=" + new Date().getTime(),
				{ids:ids.join(";")},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.config.schedulingjob.disable.msg.sucess"/>');
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
		OZ.Msg.info('<oz:messageSource code="oz.config.schedulingjob.enable.msg.noneselected"/>');
		return;
	}
	
	var ids=[];
	for(var i=0;i<rows.length;i++){
		ids.push(rows[i].id);
	}	
	
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.config.schedulingjob.enable.msg.confirm"/>',
		function(){
			$.getJSON(
				contextPath + "/config/schedulingJobAction.do?action=enable&timeStamp=" + new Date().getTime(),
				{ids:ids.join(";")},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.config.schedulingjob.enable.msg.sucess"/>');
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