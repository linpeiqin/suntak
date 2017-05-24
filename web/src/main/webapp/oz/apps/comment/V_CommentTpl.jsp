<!DOCTYPE HTML>
<%@page import="cn.oz.web.util.RequestUtils"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title>常用批示语管理</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="常用批示语管理">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="module/commentTplAction" defaultTB="view" searchButton="none">
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="module/commentTplAction" sortName="comment" sortOrder="asc" fit="true">
			<oz:column field="id" checkbox="true" title=""/>
			<oz:column field="comment" title="批示语" width="760" sortable="true" formatter="render4CommentTpl"/>
		</oz:grid>
	</div>
</body>
<script type="text/javascript">
var type ='${type}';
oz_grid_config.url = "<oz:contextPath/>/module/commentTplAction.do?action=page&type=" + type;
</script>
<oz:js/>
<script type="text/javascript">
var _baseUrl = contextPath + "/module/commentTplAction.do?action=";
function render4CommentTpl(value, json){
	return '<a href="javascript:openCommentTpl(' + json.id + ')">' + value + '</a>';
}

function onRow_DBLClicked(rowIndex, json){
	openCommentTpl(json.id);
}

function onBtnNew_Clicked(){
	openCommentTplDlg(_baseUrl + "create&type=" + type, '<oz:messageSource code="oz.new"/>', true);
}

function openCommentTpl(id){
	var strUrl = _baseUrl + "open&id=" + id;
	openCommentTplDlg(strUrl, '<oz:messageSource code="oz.edit"/>', true);
}

function openCommentTplDlg(strUrl, title, canEdit){
	strUrl += "&timeStamp=" + new Date().getTime();
	title += '常用批示语';
	if(canEdit){
		new OZ.Dlg.create({ 
			id:"Dlg_CommentTpl", 
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
			id:"Dlg_CommentTpl", 
			width:480, height:320,
			title:title,
			url: strUrl,
			buttons:[{text:'<oz:messageSource code="oz.close"/>', handler:$.noop}]
		});
	}	
}
</script>
</html>