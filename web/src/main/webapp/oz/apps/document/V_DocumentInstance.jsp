<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.mdu.document.documentinstance"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.document.documentinstance"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="document/documentInstanceAction" searchButton="normal">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<!-- 
			<oz:tbButton id="btnBatchSendBack" text="oz.component.work.buttons.batchsendback" icon="oz-icon-wf-sendback" onclick="onBtnBatchSendBack_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnBatchRetrieve" text="oz.component.work.buttons.batchretrieve" icon="oz-icon-wf-retrieve" onclick="onBtnBatchRetrieve_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnBatchPause" text="oz.component.work.buttons.batchpause" icon="oz-icon-wf-pause" onclick="onBtnBatchPause_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnBatchResumt" text="oz.component.work.buttons.batchresumt" icon="oz-icon-wf-resumt" onclick="onBtnBatchResumt_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnViewProcesslog" text="oz.component.work.buttons.viewprocesslog" icon="oz-icon-wf-processlog" onclick="onBtnViewProcessLog_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			 -->
			<oz:tbButton id="btnDelete"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="document/documentInstanceAction" sortName="createdDate" sortOrder="desc" fit="true">
			<oz:column field="id" checkbox="true"/>
			<oz:column field="status" title="oz.status" width="60"  formatter="oz_StatusFormatter"/>
			<oz:column field="documentDefinition_classified" title="oz.mdu.document.dd.fields.classified" width="120"/>
			<oz:column field="documentDefinition_name" title="oz.mdu.document.dd.fields.name" width="120"/>
			<oz:column field="documentDefinition_fileType" title="oz.mdu.document.dd.fields.filetype" width="100"/>
			<oz:column field="subject" title="oz.mdu.document.di.fields.subject" width="280" formatter="oz_DefaultFormatter"/>
			<oz:column field="fileWord" title="oz.mdu.document.di.fields.fileword" width="120" formatter="oz_DefaultFormatter"/>
			<oz:column field="author_name" title="oz.author" width="180" formatter="authorFormatter"/>
			<oz:column field="createdDate" title="oz.createddate" width="120"/>
		</oz:grid>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function authorFormatter(value, json){
	return value + "(" + json.author_ouName + ")";
}
function oz_StatusFormatter(value, json){
	if(value == 0){
		return "新建";
	}
	if(value == 1){
		return "流转中";
	}
	if(value == 2){
		return "完成";
	}
	return value + "";
}
</script>
</html>