<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.mdu.organize.grouptemplate"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.organize.grouptemplate"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="organize/groupTemplateAction" searchButton="normal">
			<oz:tbSeperator/>
			<oz:tbButton id="btnBack"/>
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
			<oz:grid action="organize/groupTemplateAction" sortName="name" sortOrder="asc" fit="true">
				<oz:column field="id" checkbox="true" title=""/>
				<oz:column field="name" title="oz.mdu.organize.grouptemplate.fields.name" width="240" sortable="true" formatter="render4GroupTemplate"/>
				<oz:column field="unitId" title="oz.mdu.organize.grouptemplate.fields.usedscope" width="120" sortable="true" formatter="render4Unit"/>			
			</oz:grid>
		</c:if>
		<c:if test="${!editable}">
			<oz:grid action="organize/groupTemplateAction" sortName="name" sortOrder="asc" fit="true" rownumbers="true">
				<oz:column field="id" checkbox="false" title="" align="center"/>
				<oz:column field="name" title="oz.mdu.organize.grouptemplate.fields.name" width="240" sortable="true" formatter="render4GroupTemplate"/>
				<oz:column field="unitId" title="oz.mdu.organize.grouptemplate.fields.usedscope" width="120" sortable="true" formatter="render4Unit"/>
			</oz:grid>
		</c:if>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
var _baseUrl = contextPath + "/organize/groupTemplateAction.do?action=";
var _editable = ${editable};
function render4GroupTemplate(value, json){
	return '<a href="javascript:openGroupTemplate(' + json.id + ')">' + value + '</a>';
}

function render4Unit(value, json){
	if(null == value || value == "" || value.length == 0 || value == "-1"){
		return '<a href="javascript:openGroupTemplate(' + json.id + ')"><oz:messageSource code="cn.oz.module.organize.usedscope.all"/></a>'; 
	}else{
		return '<a href="javascript:openGroupTemplate(' + json.id + ')"><oz:messageSource code="cn.oz.module.organize.usedscope.localunit"/></a>';
	}
}

function onRow_DBLClicked(rowIndex, json){
	openGroupTemplate(json.id);
}

function onBtnNew_Clicked(){
	openGroupTemplateDlg(_baseUrl + "create", '<oz:messageSource code="oz.new"/>', true);
}

function openGroupTemplate(id){
	var strUrl = _baseUrl + "open&id=" + id;
	if(_editable)
		openGroupTemplateDlg(strUrl, '<oz:messageSource code="oz.edit"/>', true);
	else
		openGroupTemplateDlg(strUrl, '<oz:messageSource code="oz.view"/>', false);
}

function openGroupTemplateDlg(strUrl, title, canEdit){
	strUrl += "&timeStamp=" + new Date().getTime();
	title += '<oz:messageSource code="oz.mdu.organize.grouptemplate"/>';
	if(canEdit){
		new OZ.Dlg.create({ 
			id:"Dlg_GroupTemplate", 
			width:480, height:335,
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
			id:"Dlg_GroupTemplate", 
			width:480, height:335,
			title:title,
			url: strUrl,
			buttons:[{text:'<oz:messageSource code="oz.close"/>', handler:$.noop}]
		});
	}	
}
</script>
</html>