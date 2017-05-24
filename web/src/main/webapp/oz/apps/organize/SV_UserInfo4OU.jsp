<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title><oz:messageSource code="oz.mdu.organize.userinfo"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.organize.userinfo"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar svFlag="true" action="organize/userInfoAction" searchButton="none">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnNew"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnEnable" text="oz.enable" icon="oz-icon-0901" onclick="onBtnEnable_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnDisable" text="oz.disable" icon="oz-icon-0903" onclick="onBtnDisable_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnChangePassword" text="oz.mdu.organize.userinfo.button.changpassword" icon="oz-icon-0211" onclick="onBtnChangePassword_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnDelete"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="organize/userInfoAction" sortName="orderNo" sortOrder="asc" fit="true" pagination="false">
			<oz:column field="id" checkbox="true"/>
			<oz:column field="status" title="oz.status" width="60" sortable="false" formatter="userInfoStatusFormatter"/>
			<oz:column field="loginName" title="oz.mdu.organize.userinfo.fields.loginname" width="80" sortable="false" formatter="userInfoFormatter"/>
			<oz:column field="name" title="oz.mdu.organize.userinfo.fields.name" width="120" sortable="false" formatter="userInfoFormatter"/>
			<oz:column field="jobTitle_name" title="oz.mdu.organize.userinfo.fields.jobtitle" width="80" sortable="false"/>
			<oz:column field="email" title="oz.email" width="160" sortable="false"/>
			<oz:column field="mobile" title="oz.mobile" width="80" sortable="false"/>
			<oz:column field="telephone" title="oz.telephone" width="80" sortable="false"/>
		</oz:grid>
	</div>
</body>
<script type="text/javascript">
var _ouId = <%= request.getAttribute("ouId") %>;
oz_grid_config.url = "<oz:contextPath/>/organize/userInfoAction.do?action=page&ouId=" + _ouId;
</script>
<oz:js />
<script type="text/javascript">
function userInfoStatusFormatter(value, json){
	if(value == 0)
		return '<oz:messageSource code="oz.enable"/>';
	return '<oz:messageSource code="oz.disable"/>';
}

function onBtnNew_Clicked(){
	var strUrl = contextPath + "/organize/userInfoAction.do?action=create&ouId=" + _ouId;
	OZ.openWindow({
		id: oz_grid_config.id + "_create" + (new Date().getTime()),
		title: '<oz:messageSource code="oz.mdu.organize.userinfo.button.new.userinfo"/>',
		url: strUrl, 
		refresh: true,
		beforeCloseFnName: "oz_Win_BeforeClose",
		data:"userInfo"
	});	
}

function onRow_DBLClicked(rowIndex,rowData){
	oz_Default_Row_DBLClicked(rowIndex,rowData,"userInfo");
}

function userInfoFormatter(value, rowData, rowIndex){
	return oz_DefaultFormatterEx(value, rowData, rowIndex, "userInfo");
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
</script>
</html>