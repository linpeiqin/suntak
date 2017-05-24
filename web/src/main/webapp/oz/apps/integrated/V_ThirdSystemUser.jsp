<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view" tree="true"/>
<html>
<head>
	<title><oz:messageSource code="oz.mdu.security.usermapping"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.security.usermapping"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="module/thirdSystemUserAction" searchButton="none">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnEditSystem" text="编辑系统" icon="oz-icon-edit" onclick="onBtnEdit_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnAddUser" text="添加用户" icon="oz-icon-new" onclick="onBtnAdd_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnDeleteUser" text="删除用户" icon="oz-icon-delete"  onclick="ozTB_BtnDelete_Clicked(this)"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<div id="page-center-tree" class="oz-page-center-tree">
			<ul id="thirdSystemTree"></ul>
		</div>
		<div id="page-center-seperator" class="oz-page-center-seperator"></div>
		<div id="page-center-grid" class="oz-page-center-grid">
			<oz:grid action="module/thirdSystemUserAction" sortName="mappingSystemId" sortOrder="asc" fit="true" pagination="false">
				<oz:column field="id" checkbox="true" title=""/>
				<oz:column field="loginName" title="系统用户" width="120" sortable="true" formatter="render4UserMapping"/>
				<oz:column field="mappingLoginName" title="oz.mdu.security.usermapping.fields.loginname" width="120" sortable="true" formatter="render4UserMapping"/>
				<oz:column field="mappingPassword" title="oz.mdu.security.usermapping.fields.password" width="120" sortable="true" formatter="render4UserMapping"/>
				<oz:column field="memos" title="oz.mdu.security.usermapping.fields.memos" width="120" sortable="true" formatter="render4Memo"/>
			</oz:grid>
		</div>
	</div>
</body>
<script type="text/javascript">
var _loginName = '<%= request.getAttribute("loginName") %>';
var _editFlag = '<%= request.getAttribute("editFlag") %>';
//oz_grid_config.url = "<oz:contextPath/>/module/thirdSystemUserAction.do?action=page;
</script>
<oz:js/>
<script type="text/javascript">
function render4UserMapping(value, rowData, rowIndex){
	var title = rowData.loginName + "-Mapping";
	var _href = "<a href='";
	_href += "javascript:OZ.openWindow({";
	_href += "url:\"" + OZ.addParamToUrl(oz_grid_config.path, "action=" + ozOpenActionName + "&id=" + rowData.id + "&editFlag=" + _editFlag) + "\",";
	_href += "title:\"" + title + "\",";
	_href += "id:\"" + oz_grid_config.id + rowData.id + "\",";
	_href += "tabTip:\"" + title + "\",";
	_href += "refresh:true,";
	_href += "data:\"UserMapping\",";
	_href += "beforeCloseFnName:\"oz_Win_BeforeClose\"";
	_href += "})";
	_href += "'>" + value + "</a>";
    return _href;
}
function render4Memo(value, rowData, rowIndex){
    return value.replace(/\n/ig,"");
}
function onBtnEdit_Clicked(){
	if(_systemKey==""){
		OZ.Msg.info("请先选择系统，再进行添加操作");
		return;
	}
	var strUrl = contextPath + "/module/thirdSystemAction.do?action=edit&editUrl&id=" + _systemId;
	strUrl += "&timeStamp=" + new Date().getTime();
	OZ.openWindow({
		id: oz_grid_config.id + "_create" + (new Date().getTime()),
		title: '<oz:messageSource code="oz.mdu.integrated.thirdsystem"/>',
		url: strUrl,
		refresh: true,
		beforeCloseFnName: "oz_Win_BeforeClose",
		data:"UserMapping"
	});	
}

function onBtnAdd_Clicked(){
	if(_systemKey==""){
		OZ.Msg.info("请先选择系统，再进行添加操作");
		return;
	}
	var strUrl = contextPath + "/module/thirdSystemUserAction.do?action=create&systemId=" + _systemKey;
	strUrl += "&timeStamp=" + new Date().getTime();
	OZ.openWindow({
		id: oz_grid_config.id + "_create" + (new Date().getTime()),
		title: '<oz:messageSource code="oz.mdu.security.usermapping"/>',
		url: strUrl,
		refresh: true,
		beforeCloseFnName: "oz_Win_BeforeClose",
		data:"UserMapping"
	});	
}

var _systemKey = "";
var _systemId = -1;
$(function(){
	$('#thirdSystemTree').tree({
		url: contextPath + '/module/thirdSystemAction.do?action=getTree&timeStamp=' + new Date().getTime(),
		click:function(e, data){
			_systemKey = data.key;
			_systemId = data.id;
			OZ.View.reloadGrid({systemId:_systemKey, dbftsParams:""});
		}
	});
});
</script>
</html>