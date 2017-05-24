<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" attachment="true" formValidator="true"/>
<head>
	<title><oz:messageSource code="oz.module.filemgm.fileinstance"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css />	
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.module.filemgm.fileinstance"/>">
<div id="page" class="oz-page">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="component/attachmentAction">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnSave"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnInsertFile" text="oz.module.filemgm.fileinstance.button.insertfile" icon="oz-icon-0414" onclick="onBtnInsertFile_Clicked()"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<div id="container" style="width:100%;height:100%;">
		</div>
	</div>
</div>
</body>
<oz:js/>
<oz:js jsId="oz-ocx"/>
<script type="text/javascript">
var _contentId = '<%=request.getParameter("id")%>';
var _officeOcx = null;

function onBtnSave_Clicked(json){
	saveOffice();
}

function onBtnRecommend_Clicked(){
	OZ.Msg.info("功能完善中...");
	return;
}

function createOfficeOcx(){
	 var attributes = {};
    var params = {
		Toolbars : true,
		FileSaveAs:	true
	};
	_officeOcx = oz.office.create("container",attributes,params);
	if(!_officeOcx){
		return null;
	}
    
	if (_officeOcx) {
		if(_contentId == "-1"){
			_officeOcx.CreateNew("Word.Document");
		}else{
			var strUrl = contextPath + '/component/attachmentAction.do?action=getFile&id=' + _contentId;
			strUrl += "&timeStamp=" + new Date().getTime();
			_officeOcx.OpenFromURL(strUrl, "true");
			if (0 != _officeOcx.StatusCode) {
				showEmptyMsg();
			}else{
				_officeOcx.ActiveDocument.ShowRevisions = false;
			}
		}
	} else {
		showEmptyMsg("当前浏览器不支持Office控件，请使用IE打开进行操作。");
	}
}

function onBtnInsertFile_Clicked(){
	if (_officeOcx) {
		_officeOcx.AddTemplateFromLocal("", true);
	}
}

function saveOffice(){
	if (_officeOcx) {
		if(_officeOcx.ActiveDocument.Saved)
			return;
		
		var strUrl = contextPath + "/component/attachmentAction.do?action=updateFile";
		strUrl += "&id=" + _contentId;
		strUrl += "&timeStamp=" + new Date().getTime();
		try {
			_officeOcx.SaveToURL(strUrl, "EDITFILE", "","");
			if (0 == _officeOcx.StatusCode) {
				// alert("文件保存成功。");
			}
		} catch (err) {
			alert("文件保存失败，错误原因：" + err.number + "，" + err.description);
		}
	}	
}

function showEmptyMsg(msg){
	msg = msg || "加载文件失败！";
	$("#container").html("<strong>" + msg + "</strong>");
}

jQuery(function($){
	createOfficeOcx();
});
</script>
</html>