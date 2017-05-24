<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.mdu.organize.joblevel"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.organize.joblevel"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="organize/jobLevelAction" searchButton="none">
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
			<oz:grid action="organize/jobLevelAction" sortName="level" sortOrder="asc" fit="true">
				<oz:column field="id" checkbox="true" title=""/>
				<oz:column field="name" title="oz.mdu.organize.joblevel.fields.name" width="160" sortable="true" formatter="render4JobLevel"/>
				<oz:column field="level" title="oz.mdu.organize.joblevel.fields.level" width="160" sortable="true" formatter="render4JobLevel"/>			
			</oz:grid>
		</c:if>
		<c:if test="${!editable}">
			<oz:grid action="organize/jobLevelAction" sortName="level" sortOrder="asc" fit="true" rownumbers="true">
				<oz:column field="id" checkbox="false" title="" align="center"/>
				<oz:column field="name" title="oz.mdu.organize.joblevel.fields.name" width="160" sortable="true" formatter="render4JobLevel"/>
				<oz:column field="level" title="oz.mdu.organize.joblevel.fields.level" width="160" sortable="true" formatter="render4JobLevel"/>
			</oz:grid>
		</c:if>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
var _baseUrl = contextPath + "/organize/jobLevelAction.do?action=";
var _editable = ${editable};
function render4JobLevel(value, json){
	return '<a href="javascript:openJobLevel(' + json.id + ')">' + value + '</a>';
}

function onRow_DBLClicked(rowIndex, json){
	openJobLevel(json.id);
}

function onBtnNew_Clicked(){
	openJobLevelDlg(_baseUrl + "create", '<oz:messageSource code="oz.new"/>', true);
}

function openJobLevel(id){
	var strUrl = _baseUrl + "open&id=" + id;
	if(_editable)
		openJobLevelDlg(strUrl, '<oz:messageSource code="oz.edit"/>', true);
	else
		openJobLevelDlg(strUrl, '<oz:messageSource code="oz.view"/>', false);
}

function openJobLevelDlg(strUrl, title, canEdit){
	strUrl += "&timeStamp=" + new Date().getTime();
	title += '<oz:messageSource code="oz.mdu.organize.joblevel"/>';
	if(canEdit){
		new OZ.Dlg.create({ 
			id:"Dlg_JobLevel", 
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
			id:"Dlg_JobLevel", 
			width:480, height:320,
			title:title,
			url: strUrl,
			buttons:[{text:'<oz:messageSource code="oz.close"/>', handler:$.noop}]
		});
	}	
}

function onBtnViewParentData_Clicked(){
	new OZ.Dlg.create({ 
		id:"Dlg_ViewParentJobLevels", 
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