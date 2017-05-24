<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.mdu.document.documentformcfg"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.document.documentformcfg"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="document/documentFormCfgAction" searchButton="normal" defaultTB="view">
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="document/documentFormCfgAction" sortName="formName" sortOrder="asc" fit="true">
			<oz:column field="id" checkbox="true" title=""/>
			<oz:column field="formName" title="oz.mdu.document.df.field.formname" width="280" sortable="true" formatter="render4FormCfg"/>
			<oz:column field="formKey" title="oz.mdu.document.df.field.formkey" width="320" sortable="true" formatter="render4FormCfg"/>
			<oz:column field="documentFormSupporterName" title="oz.mdu.document.df.field.supportername" width="160" sortable="true" formatter="render4FormCfg"/>
		</oz:grid>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
var _baseUrl = contextPath + "/document/documentFormCfgAction.do?action=";
function render4FormCfg(value, json){
	return '<a href="javascript:openFormCfg(' + json.id + ', \'' + json.documentFormSupporterCode + '\')">' + value + '</a>';
}

function onRow_DBLClicked(rowIndex, json){
	openFormCfg(json.id, json.documentFormSupporterCode);
}

function onBtnNew_Clicked(){
	openFormCfgDlg(_baseUrl + "create", '<oz:messageSource code="oz.new"/>', true);
}

function openFormCfg(id, formSupporter){
	var strUrl = _baseUrl + "open&id=" + id;
	if(formSupporter == "documentFormSupporter4UserDefined")
		openFormCfgDlg(strUrl, '<oz:messageSource code="oz.edit"/>', true);
	else
		openFormCfgDlg(strUrl, '<oz:messageSource code="oz.view"/>', false);
}

function openFormCfgDlg(strUrl, title, canEdit){
	strUrl += "&timeStamp=" + new Date().getTime();
	title += '<oz:messageSource code="oz.mdu.document.documentformcfg"/>';
	if(canEdit){
		new OZ.Dlg.create({ 
			id:"Dlg_FormCfg", 
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
			id:"Dlg_FormCfg", 
			width:480, height:320,
			title:title,
			url: strUrl,
			buttons:[{text:'<oz:messageSource code="oz.close"/>', handler:$.noop}]
		});
	}	
}
</script>
</html>