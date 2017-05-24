<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.web.const"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.web.const"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="app/appConstAction" svFlag="true" searchButton="none">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="app/appConstAction" sortName="code" sortOrder="asc" fit="true" pagination="false" rownumbers="true">
			<oz:column field="id" checkbox="false" align="center"/>
			<oz:column field="name" title="key" width="400" sortable="false" formatter="constFormatter"/>
			<oz:column field="value" title="value" width="362" sortable="false" formatter="constFormatter"/>
		</oz:grid>
	</div>
</body>
<script type="text/javascript">
oz_grid_config.url = "<oz:contextPath/>/app/appConstAction.do?action=page&appId=${appId}";
</script>
<oz:js/>
<script type="text/javascript">
var _appId = '${appId}';
var _editFlag = ${editFlag};
function constFormatter(value, json){
	if(_editFlag){
		return '<a href="javascript:editConst(\'' + json.id + '\')">' + value + '</a>';
	}else{
		return value;
	}
}

function onRow_DBLClicked(rowIndex, json){
	if(_editFlag){
		editConst(json.id);
	}else{
		// do nothing...
	}
}

function editConst(id){
	var strUrl = contextPath + "/app/appConstAction.do?action=open&key=" + id + "&timeStamp=" + new Date().getTime();
	new OZ.Dlg.create({
		id:"Dlg_AppConst", 
		width:480, height:320,
		title:'<oz:messageSource code="oz.edit"/><oz:messageSource code="oz.web.const"/>',
		url: strUrl,
		onOk:function(result){
			window.location.reload();
		},
		onCancel:function(result){
			
		}
	}); 
}
</script>
</html>