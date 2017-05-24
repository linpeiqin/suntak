<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.mdu.organize.jobtitle"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.organize.jobtitle"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="organize/jobTitleAction" searchButton="none">
			<oz:tbSeperator/>
			<oz:tbButton id="btnBack"/>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnNew"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnViewParentData" text="oz.mdu.organize.button.view.partentdata" icon="oz-icon-1416" onclick="onBtnViewParentData_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnDelete"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<c:if test="${editable}">
			<oz:grid action="organize/jobTitleAction" sortName="name" sortOrder="asc" fit="true">
				<oz:column field="id" checkbox="true" title=""/>
				<oz:column field="name" title="oz.mdu.organize.jobtitle.fields.name" width="160" sortable="true" formatter="render4JobTitle"/>
				<oz:column field="code" title="oz.mdu.organize.jobtitle.fields.code" width="160" sortable="true" formatter="render4JobTitle"/>
			</oz:grid>
		</c:if>
		<c:if test="${!editable}">
			<oz:grid action="organize/jobTitleAction" sortName="name" sortOrder="asc" fit="true" rownumbers="true">
				<oz:column field="id" checkbox="false" title="" align="center"/>
				<oz:column field="name" title="oz.mdu.organize.jobtitle.fields.name" width="160" sortable="true" formatter="render4JobTitle"/>
				<oz:column field="code" title="oz.mdu.organize.jobtitle.fields.code" width="160" sortable="true" formatter="render4JobTitle"/>
			</oz:grid>
		</c:if>
		
		
	</div>
</body>
<oz:js/>
<script type="text/javascript">
var _baseUrl = contextPath + "/organize/jobTitleAction.do?action=";
var _editable = ${editable};
function render4JobTitle(value, json){
	return '<a href="javascript:openJobTitle(' + json.id + ')">' + value + '</a>';
}

function onRow_DBLClicked(rowIndex, json){
	openJobTitle(json.id);
}

function onBtnNew_Clicked(){
	openJobTitleDlg(_baseUrl + "create", '<oz:messageSource code="oz.new"/>', true);
}

function openJobTitle(id){
	var strUrl = _baseUrl + "open&id=" + id;
	if(_editable)
		openJobTitleDlg(strUrl, '<oz:messageSource code="oz.edit"/>', true);
	else
		openJobTitleDlg(strUrl, '<oz:messageSource code="oz.view"/>', false);
}

function openJobTitleDlg(strUrl, title, canEdit){
	strUrl += "&timeStamp=" + new Date().getTime();
	title += '<oz:messageSource code="oz.mdu.organize.jobtitle"/>';
	if(canEdit){
		new OZ.Dlg.create({ 
			id:"Dlg_JobTitle", 
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
			id:"Dlg_JobTitle", 
			width:480, height:320,
			title:title,
			url: strUrl,
			buttons:[{text:'<oz:messageSource code="oz.close"/>', handler:$.noop}]
		});
	}	
}

function onBtnViewParentData_Clicked(){
	new OZ.Dlg.create({ 
		id:"Dlg_ViewParentJobTitles", 
		width:640, height:480,
		title:'<oz:messageSource code="oz.mdu.organize.dlg.title.view.partentdata"/>',
		url: _baseUrl + "viewParentData&timeStamp=" + new Date().getTime(),
		buttons:[{text:'<oz:messageSource code="oz.close"/>', handler:function(result){
			OZ.View.reloadGrid();
		}}]
	});
}
</script>
</html>