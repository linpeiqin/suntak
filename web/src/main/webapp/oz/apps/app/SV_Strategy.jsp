<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.web.strategy"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.web.strategy"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="app/strategyAction" svFlag="true" searchButton="none">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="app/strategyAction" sortName="code" sortOrder="asc" fit="true" pagination="false" rownumbers="true">
			<oz:column field="id" checkbox="false" align="center"/>
			<oz:column field="code" title="oz.web.strategy.fields.code" width="200" sortable="false" formatter="strategyFormatter"/>
			<oz:column field="name" title="oz.web.strategy.fields.name" width="400" sortable="false" formatter="strategyFormatter"/>
			<oz:column field="value" title="oz.web.strategy.fields.value" width="160" sortable="false"/>
		</oz:grid>
	</div>
</body>
<script type="text/javascript">
oz_grid_config.url = "<oz:contextPath/>/app/strategyAction.do?action=page&appId=<%= request.getAttribute("appId") %>";
</script>
<oz:js/>
<script type="text/javascript">
var _editFlag = ${editFlag};
function strategyFormatter(value, json){
	return '<a href="javascript:openStrategy(\'' + json.id + '\')">' + value + '</a>';
}

function onRow_DBLClicked(rowIndex, json){
	openStrategy(json.id);
}

function openStrategy(id){
	if(_editFlag)
		editStrategy(id);
	else
		viewStrategy(id);
}

function editStrategy(id){
	var strUrl = contextPath + "/app/strategyAction.do?action=open&id=" + id + "&timeStamp=" + new Date().getTime();
	new OZ.Dlg.create({
		id:"Dlg_Strategy", 
		width:480, height:320,
		title:'<oz:messageSource code="oz.edit"/><oz:messageSource code="oz.web.strategy"/>',
		url: strUrl,
		onOk:function(result){
			window.location.reload();
		},
		onCancel:function(result){
			
		}
	}); 
}

function viewStrategy(id){
	var strUrl = contextPath + "/app/strategyAction.do?action=open&id=" + id + "&timeStamp=" + new Date().getTime();
	new OZ.Dlg.create({
		id:"Dlg_Strategy", 
		width:480, height:320,
		title:'<oz:messageSource code="oz.view"/><oz:messageSource code="oz.web.strategy"/>',
		url: strUrl,
		buttons:[{text:'<oz:messageSource code="oz.close"/>', handler:$.noop}]
	}); 
}
</script>
</html>