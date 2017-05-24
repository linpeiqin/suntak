<!DOCTYPE HTML>
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
		<oz:toolbar action="document/documentDefAction" searchButton="normal">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnNew"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnEditRight" text="oz.mdu.document.dd.buttons.editdocumentright" icon="oz-icon-1131" onclick="onEditRgith()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnViewFormCfg" text="oz.mdu.document.dd.buttons.viewformcfg" icon="oz-icon-1229" onclick="onBtnViewFormCfg_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnViewProcessCfg" text="oz.mdu.document.dd.buttons.viewprocesscfg" icon="oz-icon-1220" onclick="onBtnViewProcessCfg_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnViewDocumentClassified" text="oz.mdu.document.dd.buttons.documentclassified" icon="oz-icon-1425" onclick="onBtnDocumentClassified_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnDelete"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>	
	<div id="page-center" class="oz-page-center">
		<div id="page-center-tree" class="oz-page-center-tree">
			<ul id="classifiedTree"></ul>
		</div>
		<div id="page-center-seperator" class="oz-page-center-seperator"></div>
		<div id="page-center-grid" class="oz-page-center-grid">
			<oz:grid action="document/documentDefAction" sortName="orderNo" sortOrder="asc" fit="true" pagination="false">
				<oz:column field="id" checkbox="true"/>
				<oz:column field="enable" title="oz.isenable" width="60" sortable="true" formatter="isEnableFormatter"/>
				<oz:column field="code" title="oz.mdu.document.dd.fields.code" width="120" sortable="true" formatter="oz_DefaultFormatter"/>
				<oz:column field="name" title="oz.mdu.document.dd.fields.name" width="200" sortable="true" formatter="oz_DefaultFormatter"/>
				<oz:column field="fileType" title="oz.mdu.document.dd.fields.filetype" width="120" sortable="true"/>
				<oz:column field="processCfg_processName" title="oz.mdu.document.dd.fields.process" width="160" sortable="false" formatter="processFormatter"/>
				<oz:column field="formCfg_formName" title="oz.mdu.document.dd.fields.form" width="160" sortable="false" formatter="formFormatter"/>
			</oz:grid>
		</div>		
	</div>
</body>
<oz:js />
<script type="text/javascript">
var _classified = "";
function isEnableFormatter(value, json){
	if(value == "N")
		return '<oz:messageSource code="oz.disable"/>';	
	return '<oz:messageSource code="oz.enable"/>';
}

function processFormatter(value, json){
	if(value == "")
		return "";
	return value; // + "(" + json.processCfg_processKey + ")";
}

function formFormatter(value, json){
	if(value == "")
		return "";
	return value; // + "(" + json.formCfg_formKey + ")";
}

function onBtnNew_Clicked(){
	var strUrl = contextPath + "/document/documentDefAction.do?action=create&classified=" + _classified;
	OZ.openWindow({
		id: oz_grid_config.id + "_create" + (new Date().getTime()),
		title: '<oz:messageSource code="oz.new"/>' + '<oz:messageSource code="oz.mdu.document.documentdefinition"/>',
		url: strUrl, 
		refresh: true,
		beforeCloseFnName: "oz_Win_BeforeClose"
	});	
}

function onBtnViewFormCfg_Clicked(){
	var strUrl = contextPath + "/document/documentFormCfgAction.do?action=display";
	OZ.openWindow({
		id: oz_grid_config.id + "_documentFormCfg",
		title: '<oz:messageSource code="oz.mdu.document.documentformcfg"/>',
		url: strUrl, 
		refresh: false,
		beforeCloseFnName: "oz_Win_BeforeClose"
	});	
}

function onBtnViewProcessCfg_Clicked(){
	var strUrl = contextPath + "/document/documentProcessCfgAction.do?action=display";
	OZ.openWindow({
		id: oz_grid_config.id + "_documentPorcessCfg",
		title: '<oz:messageSource code="oz.mdu.document.documentprocesscfg"/>',
		url: strUrl, 
		refresh: false,
		beforeCloseFnName: "oz_Win_BeforeClose"
	});	
}

function onBtnDocumentClassified_Clicked(){
	var strUrl = contextPath + "/config/optionGroupAction.do?action=viewOptionItems&groupCode=DocumentClassified&groupName=" + encodeURIComponent("文种分类") + "&autoCreate=true";
	strUrl += "&timeStamp=" + new Date().getTime();
	new OZ.Dlg.create({ 
		id:"Dlg_ViewOptionItemData", 
		width:640, height:463,
		title:'<oz:messageSource code="oz.config.optiongroup.button.viewdata"/>',
		url: strUrl,
		buttons:[{text:'关闭', iconCls:'oz-icon-cancel', handler:$.noop}]
	});	
}

$(function(){
	$('#classifiedTree').tree({
		url: contextPath + '/document/documentDefAction.do?action=getClassifiedTree&root=y&timeStamp=' + new Date().getTime(),
		click:function(e, data){
			_classified = data.fullName||"";
			OZ.View.reloadGrid({classified:_classified, dbftsParams:""});
		}
	});
});
</script>
<script type="text/javascript">
function onEditRgith(){
	var rows = OZ.View.getGridSelection();
	if (null == rows || rows.length != 1) {
		OZ.Msg.info('请选择一条记录进行配置。');
		return null;
	}
	var id =rows[0].id;
	OZ.openWindow({
		id:"editRight",
		title:"编辑权限",
		url:contextPath+"/document/def/rightAction.do?action=edit&id="+id
	})
}
</script>
</html>