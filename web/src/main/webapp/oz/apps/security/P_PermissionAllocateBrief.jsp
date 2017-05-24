<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" tabs="true" tree="true" select="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.security.permission.button.allocate.brief"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.security.permission.button.allocate.brief"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="security/permissionAction" searchButton="none">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="security/permissionAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title">
				<%= request.getAttribute("name") %>(<%= request.getAttribute("code") %>)
			</div>
			<div class="oz-form-tabs">
				<div id="tabCt" class="border" data-tabs='{"height":480,"width":640}' style="border-width:0px;background-color: transparent;border-bottom:#76abd3 0px solid">
					<div data-tab-panel='{"id":"tab_01","title":"<oz:messageSource code="oz.mdu.security.permission.tabs.roles"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<table cellpadding="3" cellspacing="3" style="width:99%;margin:2px 2px 2px 2px;">
							<tr> 
								<td style="vertical-align:top">
									<select id="roles" style="width:100%;size:12;height:440px" multiple="multiple" ondblclick="onRole_Clicked()"></select>
								</td>
							</tr>
					  	</table>
					</div>
					<div data-tab-panel='{"id":"tab_02","title":"<oz:messageSource code="oz.mdu.security.permission.tabs.groups"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<table cellpadding="3" cellspacing="3" style="width:100%;margin:2px 2px 2px 2px;">
							<tr>
								<td width="50%" valign="top">
									<div style="width:310px;height:440px;overflow:auto;border:1px solid #76ABD3">
										<ul id="groupOUTree"></ul>
									</div>
								</td>
								<td width="50%" valign="top">
									<select id="groups" style="width:310px;size:12;height:440px" multiple="multiple" ondblclick="onGroup_Clicked()"></select>
								</td>
							</tr>
						</table>
					</div>
					<div data-tab-panel='{"id":"tab_03","title":"<oz:messageSource code="oz.mdu.security.permission.tabs.userinfos"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<table cellpadding="3" cellspacing="3" style="width:100%;margin:2px 2px 2px 2px;">
							<tr>
								<td width="50%" valign="top">
									<div style="width:310px;height:440px;overflow:auto;border:1px solid #76ABD3">
										<ul id="userInfoOUTree"></ul>
									</div>
								</td>
								<td width="50%" valign="top">
									<select id="userInfos" style="width:310px;size:12;height:440px" multiple="multiple" ondblclick="onUserInfo_Clicked()"></select>
								</td>
							</tr>
						</table>
					</div>
				</div>	
			</div>
		</html:form>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
var _permissionCode = '<%= request.getAttribute("code") %>';
var _permissionName = '<%= request.getAttribute("name") %>';

var _rolesLoadFlag = false;
var _groupLoadFlag = false;
var _userInfoLoadFlag = false;
function onPageActive(data, editFlag){
	var pageId = data.tab.tabPanel("option", "id");
	if(pageId == "tab_01"){
		// 加载角色列表
		if(_rolesLoadFlag)
			return;
		
		var strUrl = contextPath + "/security/roleAction.do?action=findRoleByPermission&timeStamp=" + new Date().getTime();
	    $.getJSON(
			strUrl, 
			{permissionCode:_permissionCode},
			function(json){
				var roles = json.roles;
				if(roles.length > 0){
					OZ.SELECT.removeAll("roles");
					var selOptionObj = document.getElementById("roles");
					for(var i = 0; i < roles.length; i++){
						selOptionObj.options[selOptionObj.length] = new Option(roles[i].name, roles[i].id);
					}
					_rolesLoadFlag = true;
				}
			}
		);
	}else if(pageId == "tab_02"){
		if(_groupLoadFlag)
			return;
		
		$('#groupOUTree').tree({
			url: contextPath + '/organize/ouTreeAction.do?action=getTree&timeStamp=' + new Date().getTime(),
			click:function(e, data){
				reloadGroups(data.id);
			}
		});
		_groupLoadFlag = true;
	}else if(pageId == "tab_03"){
		if(_userInfoLoadFlag)
			return;
		
		$('#userInfoOUTree').tree({
			url: contextPath + '/organize/ouTreeAction.do?action=getTree&timeStamp=' + new Date().getTime(),
			click:function(e, data){
				reloadUserInfos(data.id);
			}
		});
		_userInfoLoadFlag = true;
	}
}

function onRole_Clicked(){
	var roleId = $("#roles").val();
	var strUrl = contextPath + "/security/roleAction.do?action=open&timeStamp=" + new Date().getTime();
	strUrl += "&id=" + roleId;
	OZ.openWindow({
		id: "Role_" + roleId,
		title: "角色配置",
		url: strUrl, 
		refresh: false,
		beforeCloseFnName: "oz_Win_BeforeClose"
	});
}

function reloadGroups(ouId){
	OZ.SELECT.removeAll("groups");
	var selOptionObj = document.getElementById("groups");
    selOptionObj.length = 0;
    var strUrl = contextPath + "/organize/groupAction.do?action=findGroupByOUInfo&timeStamp=" + new Date().getTime();
    $.getJSON(
		strUrl, 
		{ouId:ouId, permissionCode:_permissionCode},
		function(json){
			var groups = json.groups;
			if(groups.length > 0){
				for(var i = 0; i < groups.length; i++){
					selOptionObj.options[selOptionObj.length] = new Option(groups[i].name, groups[i].id);
				}
			}
		}
	);
}

function onGroup_Clicked(){
	var groupId = $("#groups").val();
	var strUrl = contextPath + "/organize/groupAction.do?action=open&timeStamp=" + new Date().getTime();
	strUrl += "&id=" + groupId;
	OZ.openWindow({
		id: "Group" + groupId,
		title: "岗位配置",
		url: strUrl, 
		refresh: false,
		beforeCloseFnName: "oz_Win_BeforeClose"
	});
}

function reloadUserInfos(ouId){
	OZ.SELECT.removeAll("userInfos");
	var selOptionObj = document.getElementById("userInfos");
    selOptionObj.length = 0;
    var strUrl = contextPath + "/organize/userInfoAction.do?action=findUserInfoByOUInfo&timeStamp=" + new Date().getTime();
    $.getJSON(
		strUrl, 
		{ouId:ouId, permissionCode:_permissionCode},
		function(json){
			var userInfos = json.userInfos;
			if(userInfos.length > 0){
				for(var i = 0; i < userInfos.length; i++){
					selOptionObj.options[selOptionObj.length] = new Option(userInfos[i].name, userInfos[i].id);
				}
			}
		}
	);
}

function onUserInfo_Clicked(){
	var userInfoId = $("#userInfoId").val();
	var strUrl = contextPath + "/organize/userInfoAction.do?action=open&timeStamp=" + new Date().getTime();
	strUrl += "&id=" + userInfoId;
	OZ.openWindow({
		id: "UserInfo" + userInfoId,
		title: "人员配置",
		url: strUrl, 
		refresh: false,
		beforeCloseFnName: "oz_Win_BeforeClose"
	});
}

$(function(){
	$("#tabCt").tabs({
		active:function(e,data){onPageActive(data, true);}
	});
	$("#tabCt").tabs("activeTab","tab_01");
});
</script>
</html>