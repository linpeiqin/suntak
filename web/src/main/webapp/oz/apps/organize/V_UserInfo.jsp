<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view" tree="true"/>
<html>
<head>
	<title><oz:messageSource code="oz.mdu.organize.userinfo"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.organize.userinfo"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="organize/userInfoAction" searchButton="normal">
			<oz:tbSeperator/>
			<oz:tbButton id="btnBack"/>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnNew"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnEnable" text="oz.enable" icon="oz-icon-0901" onclick="onBtnEnable_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnDisable" text="oz.disable" icon="oz-icon-0903" onclick="onBtnDisable_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnChangePassword" text="oz.mdu.organize.userinfo.button.changpassword" icon="oz-icon-0211" onclick="onBtnChangePassword_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnUnlock" text="解锁" icon="oz-icon-0533" onclick="onBtnUnlock_Clicked()"></oz:tbButton>	
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnPersonal" text="oz.mdu.organize.userinfo.button.editpersonal" icon="oz-icon-0238" onclick="onBtnPersonal_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnDelete"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>	
	<div id="page-center" class="oz-page-center">
		<div id="page-center-tree" class="oz-page-center-tree">
			<ul id="ouInfoTree"></ul>
		</div>
		<div id="page-center-seperator" class="oz-page-center-seperator"></div>
		<div id="page-center-grid" class="oz-page-center-grid">
			<oz:grid action="organize/userInfoAction" sortName="orderNo" sortOrder="asc" fit="true" pagination="false" excel="true">
				<oz:column field="id" checkbox="true"/>
				<oz:column field="status" title="oz.status" width="60" sortable="false" formatter="userInfoStatusFormatter"/>
				<oz:column field="loginName" title="oz.mdu.organize.userinfo.fields.loginname" width="100" sortable="false" formatter="oz_DefaultFormatter"/>
				<oz:column field="name" title="oz.mdu.organize.userinfo.fields.name" width="100" sortable="false" formatter="userInfoNameFormatter"/>
				<oz:column field="jobTitle_name" title="oz.mdu.organize.userinfo.fields.jobtitle" width="120" sortable="false"/>
				<oz:column field="email" title="oz.email" width="180" sortable="false"/>
				<oz:column field="mobile" title="oz.mobile" width="100" sortable="false"/>
				<oz:column field="telephone" title="oz.telephone" width="110" sortable="false"/>
			</oz:grid>
		</div>
	</div>
</body>
<oz:js />
<script type="text/javascript">
var _ouId = -1;
function userInfoStatusFormatter(value, json){
	if(value == 0)
		return '<oz:messageSource code="oz.enable"/>';
	return '<oz:messageSource code="oz.disable"/>';
}

function userInfoNameFormatter(value, rowData, rowIndex){
	return "<a href='javascript:oz_OpenGridRow(\"" + rowIndex+"\",null)' title='" + rowData.title + "'>" + value + "</a>";
}

function onBtnNew_Clicked(){
	var strUrl = contextPath + "/organize/userInfoAction.do?action=create&ouId=" + _ouId;
	OZ.openWindow({
		id: oz_grid_config.id + "_create" + (new Date().getTime()),
		title: '<oz:messageSource code="oz.mdu.organize.userinfo.button.new.userinfo"/>',
		url: strUrl, 
		refresh: true,
		beforeCloseFnName: "oz_Win_BeforeClose"
	});	
}

function onBtnDisable_Clicked(){	
	var rows = OZ.View.getGridSelection();
	if (null == rows || rows.length == 0) {
		OZ.Msg.info('<oz:messageSource code="oz.mdu.organize.userinfo.msg.disable.noneselected"/>');
		return;
	}
	
	var ids=[];
	for(var i=0;i<rows.length;i++){
		ids.push(rows[i].id);
	}	
	
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.mdu.organize.userinfo.msg.disable.confirm"/>',
		function(){
			$.getJSON(
				contextPath + "/organize/userInfoAction.do?action=disable&timeStamp=" + new Date().getTime(),
				{ids:ids.join(";")},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.mdu.organize.userinfo.msg.disable.success"/>');
						OZ.View.reload();
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			);
		}
	);
}

function onBtnEnable_Clicked(){
	var rows = OZ.View.getGridSelection();
	if (null == rows || rows.length == 0) {
		OZ.Msg.info('<oz:messageSource code="oz.mdu.organize.userinfo.msg.enable.noneselected"/>');
		return;
	}
	
	var ids=[];
	for(var i=0;i<rows.length;i++){
		ids.push(rows[i].id);
	}	
	
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.mdu.organize.userinfo.msg.enable.confirm"/>',
		function(){
			$.getJSON(
				contextPath + "/organize/userInfoAction.do?action=enable&timeStamp=" + new Date().getTime(),
				{ids:ids.join(";")},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.mdu.organize.userinfo.msg.enable.success"/>');
						OZ.View.reload();
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			);
		}
	);
}

function onBtnChangePassword_Clicked(){
	var rows = OZ.View.getGridSelection();
	if (null == rows || rows.length == 0) {
		OZ.Msg.info('<oz:messageSource code="oz.mdu.organize.userinfo.msg.changpassword.noneselected"/>');
		return;
	}
	
	var loginNames = [];
	for(var i = 0; i < rows.length; i++){
		loginNames.push(rows[i].loginName);
	}	

	OZ.Msg.prompt(
		'<oz:messageSource code="oz.mdu.organize.userinfo.dlg.changpassword.inputnewpassword"/>', 
		function(value){
			if(null == value || value.length == 0){
				OZ.Msg.info('<oz:messageSource code="oz.mdu.organize.userinfo.dlg.changpassword.msg.newpassword.isnull"/>', null, onBtnChangePassword_Clicked);
			}else{
				$.getJSON(
					contextPath + "/security/userAction.do?action=changePassword&timeStamp=" + new Date().getTime(),
					{loginName:loginNames.join(","), password:value},
					function(json){
						if(json.result == true){
							OZ.Msg.info('<oz:messageSource code="oz.mdu.organize.userinfo.dlg.changpassword.success"/>');
						}else{
							OZ.Msg.info(json.msg);
						}
					}
				);
			}
		}, 
		null, '', false, '<oz:messageSource code="oz.mdu.organize.userinfo.dlg.changpassword.title"/>', true);
}

function onBtnUnlock_Clicked(){
	var rows = OZ.View.getGridSelection();
	if (null == rows || rows.length == 0) {
		OZ.Msg.info('请先选择所要解锁的人员');
		return;
	}
	
	var loginNames = [];
	for(var i = 0; i < rows.length; i++){
		loginNames.push(rows[i].loginName);
	}	
	$.getJSON(
		contextPath + "/security/userAction.do?action=unlock&timeStamp=" + new Date().getTime(),
		{loginName:loginNames.join(",")},
		function(json){
			if(json.result == true){
				OZ.Msg.info('用户解锁成功');
			}else{
				OZ.Msg.info(json.msg);
			}
		}
	);
}

function onBtnPersonal_Clicked(){
	var strUrl = contextPath + "/organize/userInfoAction.do?action=editPersonal&timeStamp=" + new Date().getTime();
	OZ.openWindow({
		id: oz_grid_config.id + "_create" + (new Date().getTime()),
		title: '<oz:messageSource code="oz.mdu.organize.userinfo.dlg.editpersonal.title"/>',
		url: strUrl, 
		refresh: true,
		beforeCloseFnName: "oz_Win_BeforeClose"
	});	
}

function executeSync(){
	$.post(
		"/sync/syncAction.do", 
		{action:"doSync"}, 
		function (data){
			var jsonResult = eval("(" + data + ")");;

			if (jsonResult.Result){
				OZ.Msg.info("同步已完成，请重新打开本页面！");
			}
			else {
				OZ.Msg.info(jsonResult.Msg);
			}
		}
	);
}

function executeSync(){
	$.post(
		"/sync/syncAction.do", 
		{action:"doSync"}, 
		function (data){
			var jsonResult = eval("(" + data + ")");;

			if (jsonResult.Result){
				OZ.Msg.info("同步已完成，请重新打开本页面！");
			}
			else {
				OZ.Msg.info(jsonResult.Msg);
			}
		}
	);
}

$(function(){
	$('#ouInfoTree').tree({
		url: contextPath + '/organize/ouTreeAction.do?action=getTree&timeStamp=' + new Date().getTime(),
		click:function(e, data){
			$("#ozQuery").val("");
			_ouId = data.id;
			OZ.View.reloadGrid({ouId:_ouId, dbftsParams:""});
		}
	});
});
</script>
</html>