<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.config.configitem"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.config.configitem"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="config/configItemAction" searchButton="normal">
			<oz:tbSeperator/>
			<oz:tbButton id="btnRefresh"/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="config/configItemAction" sortName="key" sortOrder="asc" fit="true">
			<oz:column field="id" checkbox="true" title=""/>
			<oz:column field="key" title="oz.config.configitem.fields.key" sortable="true" width="240" formatter="render4ConfigItem"/>
			<oz:column field="value" title="oz.config.configitem.fields.value" sortable="false" width="240" formatter="render4ConfigItem"/>
			<oz:column field="description" title="oz.config.configitem.fields.description" sortable="false" width="282" formatter="render4ConfigItem"/>
		</oz:grid>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
var _editFlag = ${editFlag};
function oz_GetTabTitle(json){
	return json.key;
}

function render4ConfigItem(value, json){
	return '<a href="javascript:openConfigItem(' + json.id + ')">' + value + '</a>';
}

function onRow_DBLClicked(rowIndex, json){
	openConfigItem(json.id);
}

function openConfigItem(id){
	var strUrl = contextPath + "/config/configItemAction.do?action=open&id=" + id;
	if(!_editFlag){
		openConfigItemViewDlg(strUrl, '<oz:messageSource code="oz.view"/><oz:messageSource code="oz.config.configitem"/>');
	}else{
		openConfigItemDlg(strUrl, '<oz:messageSource code="oz.edit"/><oz:messageSource code="oz.config.configitem"/>');
	}
}

function openConfigItemDlg(strUrl, title){
	strUrl += "&timeStamp=" + new Date().getTime();	
	new OZ.Dlg.create({ 
		id:"Dlg_ConfigItem", 
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
}

function openConfigItemViewDlg(strUrl, title){
	strUrl += "&timeStamp=" + new Date().getTime();	
	new OZ.Dlg.create({ 
		id:"Dlg_ConfigItem", 
		width:480, height:320,
		title:title,
		url: strUrl,
		buttons:[{text:'<oz:messageSource code="oz.close"/>', handler:$.noop}]
	});
}
</script>
</html>