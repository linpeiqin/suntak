<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.mdu.businesshours.holiday"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.businesshours.holiday"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="module/holidayAction" searchButton="none">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnNew"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnImport" text="oz.mdu.businesshours.button.import" icon="oz-icon-0627" onclick="onBtnImport_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnDelete"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="module/holidayAction" sortName="holidayDate" sortOrder="desc" fit="true">
			<oz:column field="id" checkbox="true" title=""/>
			<oz:column field="workDay" title="oz.mdu.businesshours.holiday.fields.isworkday" sortable="false" width="120" formatter="workDayFormatter"/>
			<oz:column field="name" title="oz.mdu.businesshours.holiday.fields.name" sortable="false" width="160" formatter="oz_DefaultFormatter"/>
			<oz:column field="holidayDate" title="oz.mdu.businesshours.holiday.fields.holidaydate" sortable="false" width="120" formatter="oz_DefaultFormatter"/>
			
		</oz:grid>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function workDayFormatter(value, json){
	if(value == "Y" || value == "y")
		return '<oz:messageSource code="oz.mdu.businesshours.holiday.workday"/>';
	return '<oz:messageSource code="oz.mdu.businesshours.holiday.holiday"/>';
}

function onBtnImport_Clicked(){
	var strUrl = contextPath + "/module/holidayAction.do?action=dlgBatchAdd";
	new OZ.Dlg.create({
		id:"dlg_BatchAdd", 
		width:360, height:240,
		title:'<oz:messageSource code="oz.mdu.businesshours.holiday.dlg.import.title"/>',
		url: strUrl,
		onOk:function(result){
			strUrl = contextPath + "/module/holidayAction.do?action=batchAdd&timeStamp=" + new Date().getTime();
			$.getJSON(
				strUrl, {holidays:result},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.mdu.businesshours.holiday.msg.import.success"/>');
						OZ.View.reload();
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			);
		},
		onCancel:function(result){
		}
	});
}
</script>
</html>