<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.mdu.organize.oulevel"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.organize.oulevel"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="organize/ouLevelAction" searchButton="none">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnNew"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnDelete"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<c:if test="${editable}">
			<oz:grid action="organize/ouLevelAction" sortName="level" sortOrder="asc" fit="true" pagination="false">
				<oz:column field="id" checkbox="true" title=""/>
				<oz:column field="name" title="oz.name" width="205" sortable="false" formatter="render4OULevel"/>
				<oz:column field="level" title="oz.mdu.organize.oulevel.fields.level" width="205" sortable="false" formatter="render4OULevel"/>
			</oz:grid>
		</c:if>
		<c:if test="${!editable}">
			<oz:grid action="organize/ouLevelAction" sortName="level" sortOrder="asc" fit="true" pagination="false" rownumbers="true">
				<oz:column field="id" checkbox="false" title="" align="center"/>
				<oz:column field="name" title="oz.name" width="205" sortable="false" formatter="render4OULevel"/>
				<oz:column field="level" title="oz.mdu.organize.oulevel.fields.level" width="205" sortable="false" formatter="render4OULevel"/>
			</oz:grid>
		</c:if>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
var _baseUrl = contextPath + "/organize/ouLevelAction.do?action=";
var _editable = ${editable};
function render4OULevel(value, json){
	return '<a href="javascript:openOULevel(' + json.id + ')">' + value + '</a>';
}

function onRow_DBLClicked(rowIndex, json){
	openOULevel(json.id);
}

function onBtnNew_Clicked(){
	openOULevelDlg(_baseUrl + "create", '<oz:messageSource code="oz.new"/>', true);
}

function openOULevel(id){
	var strUrl = _baseUrl + "open&id=" + id;
	if(_editable)
		openOULevelDlg(strUrl, '<oz:messageSource code="oz.edit"/>', true);
	else
		openOULevelDlg(strUrl, '<oz:messageSource code="oz.view"/>', false);
}

function openOULevelDlg(strUrl, title, canEdit){
	strUrl += "&timeStamp=" + new Date().getTime();
	title += '<oz:messageSource code="oz.mdu.organize.oulevel"/>';
	if(canEdit){
		new OZ.Dlg.create({ 
			id:"Dlg_OULevel", 
			width:320, height:240,
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
			id:"Dlg_OULevel", 
			width:320, height:240,
			title:title,
			url: strUrl,
			buttons:[{text:'<oz:messageSource code="oz.close"/>', handler:$.noop}]
		});
	}	
}
</script>
</html>