<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.mdu.document.documentprocesscfg"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.document.documentprocesscfg"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="document/documentProcessCfgAction" searchButton="normal" defaultTB="view">
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="document/documentProcessCfgAction" sortName="processName" sortOrder="asc" fit="true">
			<oz:column field="id" checkbox="true" title=""/>
			<oz:column field="processName" title="oz.mdu.document.dp.field.processname" width="280" sortable="true" formatter="render4ProcessCfg"/>
			<oz:column field="processKey" title="oz.mdu.document.dp.field.processkey" width="320" sortable="true" formatter="render4ProcessCfg"/>
			<oz:column field="documentProcessSupporterName" title="oz.mdu.document.dp.field.supportername" width="160" sortable="true" formatter="render4ProcessCfg"/>
		</oz:grid>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
var _baseUrl = contextPath + "/document/documentProcessCfgAction.do?action=";
function render4ProcessCfg(value, json){
	return '<a href="javascript:openProcessCfg(' + json.id + ', \'' + json.documentProcessSupporterCode + '\')">' + value + '</a>';
}

function onRow_DBLClicked(rowIndex, json){
	openProcessCfg(json.id, json.documentProcessSupporterCode);
}

function onBtnNew_Clicked(){
	openProcessCfgDlg(_baseUrl + "create", '<oz:messageSource code="oz.new"/>', true);
}

function openProcessCfg(id, supporterCode){
	var strUrl = _baseUrl + "open&id=" + id;
	if(supporterCode == "documentProcessSupporter4UserDefined")
		openProcessCfgDlg(strUrl, '<oz:messageSource code="oz.edit"/>', true);
	else
		openProcessCfgDlg(strUrl, '<oz:messageSource code="oz.view"/>', false);
}

function openProcessCfgDlg(strUrl, title, canEdit){
	strUrl += "&timeStamp=" + new Date().getTime();
	title += '<oz:messageSource code="oz.mdu.document.documentprocesscfg"/>';
	if(canEdit){
		new OZ.Dlg.create({ 
			id:"Dlg_ProcessCfg", 
			width:480, height:320,
			title:title,
			url: strUrl,
			onOk:function(result){
				OZ.View.reloadGrid();	
			},
			onCancel:function(result){
				// do nothing...
			}
		});
	}else{
		new OZ.Dlg.create({ 
			id:"Dlg_ProcessCfg", 
			width:480, height:320,
			title:title,
			url: strUrl,
			buttons:[{text:'<oz:messageSource code="oz.close"/>', handler:$.noop}]
		});
	}	
}
</script>
</html>