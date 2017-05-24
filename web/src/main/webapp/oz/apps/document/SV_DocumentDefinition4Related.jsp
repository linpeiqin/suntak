<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view" tree="true"/>
<html>
<head>
	<title><oz:messageSource code="oz.mdu.document.documentdefinition"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.document.documentdefinition"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar svFlag="true" action="document/documentDefAction" searchButton="none">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRelated" text="oz.mdu.document.dd.buttons.related" icon="oz-icon-0529" onclick="onBtnRelated_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnUnrelated" text="oz.mdu.document.dd.buttons.unrelated" icon="oz-icon-0530" onclick="onBtnUnrelated_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>	
	<div id="page-center" class="oz-page-center">
		<oz:grid action="document/documentDefAction" sortName="orderNo" sortOrder="asc" fit="true" pagination="false">
			<oz:column field="id" checkbox="true"/>
			<oz:column field="enable" title="oz.isenable" width="60" sortable="false" formatter="isEnableFormatter"/>
			<oz:column field="code" title="oz.mdu.document.dd.fields.code" width="100" sortable="false" formatter="oz_DefaultFormatter"/>
			<oz:column field="name" title="oz.mdu.document.dd.fields.name" width="160" sortable="false" formatter="oz_DefaultFormatter"/>
			<oz:column field="processCfg_processName" title="oz.mdu.document.dd.fields.process" width="220" sortable="false" formatter="processFormatter"/>
			<oz:column field="formCfg_formName" title="oz.mdu.document.dd.fields.form" width="220" sortable="false" formatter="formFormatter"/>
		</oz:grid>
	</div>
</body>
<script type="text/javascript">
var _ddId = '<%= request.getAttribute("ddId") %>';
var _viewType = '<%= request.getAttribute("viewType") %>';
oz_grid_config.url = "<oz:contextPath/>/document/documentDefAction.do?action=page&viewType=" + _viewType + "&ddId=" + _ddId;
</script>
<oz:js />
<script type="text/javascript">
var _categoryId = -1;
function isEnableFormatter(value, json){
	if(value == "N")
		return '<oz:messageSource code="oz.disable"/>';	
	return '<oz:messageSource code="oz.enable"/>';
}

function processFormatter(value, json){
	if(value == "")
		return "";
	return value + "(" + json.processCfg_processKey + ")";
}

function formFormatter(value, json){
	if(value == "")
		return "";
	return value + "(" + json.formCfg_formKey + ")";
}

function onBtnRelated_Clicked(){
	var strUrl = contextPath + "/document/documentDefAction.do?action=dlgRelated&ddId=" + _ddId;
	strUrl += "&timeStamp=" + new Date().getTime();

	new OZ.Dlg.create({ 
		id:"dlg_Related", 
		width:300, height:272,
		title:'<oz:messageSource code="oz.mdu.document.dd.related.dlg.title"/>',
		url: strUrl,
		onOk:function(result){
			strUrl = contextPath + "/document/documentDefAction.do?action=addRelated&timeStamp=" + new Date().getTime();
			$.getJSON(
				strUrl, 
				{ddId:_ddId, ids:result},
				function(json){
					if(json.result == true){
						OZ.View.reload();
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			);
		},
		onCancel:function(result){
			// do nothing...
		}
	});
}

function onBtnUnrelated_Clicked(){
	var rows = OZ.View.getGridSelection();
	if (null == rows || rows.length == 0) {
		OZ.Msg.info('<oz:messageSource code="oz.mdu.document.dd.msg.unrelated.noneselected"/>');
		return;
	}
	
	var ids=[];
	for(var i=0;i<rows.length;i++){
		ids.push(rows[i].id);
	}	
	
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.mdu.document.dd.msg.unrelated.confirm"/>',
		function(){
			$.getJSON(
				contextPath + "/document/documentDefAction.do?action=delRelated&timeStamp=" + new Date().getTime(),
				{ddId:_ddId, ids:ids.join(";")},
				function(json){
					if(json.result == true){
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