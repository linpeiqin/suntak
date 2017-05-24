<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" tree="true" select="true" ex="oz-linkselect,oz-otabs"/>
<head>
	<title><oz:messageSource code="oz.mdu.security.permission.button.allocate.brief"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body data-name="<oz:messageSource code="oz.mdu.security.permission.button.allocate.brief"/>">	
	<div id="page" class="ui-tab">
		<div class="oz-form-title">
			权限名称：${name}(${code})
		</div>
		<div id="page-top" class="oz-page-top">
			<div id="triggers" class="ui-tab-trigger" style="border-top: 1px solid #94BDEE;height:28px;">
				<div class="ui-tab-trigger-inner">
					<ul>						
						<li class="ui-tab-trigger-item"><a hidefocus="hideFocus" href="javascript:void(0)"><span id="myAppTitle"><oz:messageSource code="oz.mdu.security.permission.tabs.roles"/></span></a></li>
						<li class="ui-tab-trigger-item"><a hidefocus="hideFocus" href="javascript:void(0)"><span id="myAppTitle"><oz:messageSource code="oz.mdu.security.permission.tabs.groups"/></span></a></li>
						<li class="ui-tab-trigger-item"><a hidefocus="hideFocus" href="javascript:void(0)"><span id="myAppTitle"><oz:messageSource code="oz.mdu.security.permission.tabs.userinfos"/></span></a></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="ui-tab-container" id="views" style="overflow: auto;">
			<div class="ui-tab-container-item" style="padding:6px;text-align:center;">
				<table cellpadding="3" cellspacing="3" style="width:640px;margin:auto;">
					<tr>
						<td style="font-weight:bold;text-align:left;">
							已分配给的角色：
						</td>
					</tr>
					<tr>
						<td style="vertical-align:top">
							<select id="roles" style="width:100%;size:12;height:440px" multiple="multiple" ondblclick="onRole_Clicked()"></select>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-tab-container-item" style="padding:6px;text-align:center;">
				<table cellpadding="3" cellspacing="3" style="width:640px;margin:auto;">
					<tr>
						<td width="50%" style="font-weight:bold;text-align:left;">
							请选择一个组织架构：
						</td>
						<td width="50%" style="font-weight:bold;text-align:left;">
							&nbsp;已分配给的岗位：
						</td>
					</tr>
					<tr>
						<td valign="top">
							<div style="width:310px;height:440px;overflow:auto;border:1px solid #76ABD3;text-align:left;">
								<ul id="groupOUTree"></ul>
							</div>
						</td>
						<td valign="top">
							<select id="groups" style="width:310px;size:12;height:440px" multiple="multiple" ondblclick="onGroup_Clicked()"></select>
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-tab-container-item" style="padding:6px;text-align:center;">
				<table cellpadding="3" cellspacing="3" style="width:640px;margin:auto;">
					<tr>
						<td width="50%" style="font-weight:bold;text-align:left;">
							请选择一个组织架构：
						</td>
						<td width="50%" style="font-weight:bold;text-align:left;">
							&nbsp;已分配给的人员：
						</td>
					</tr>
					<tr>
						<td valign="top">
							<div style="width:310px;height:440px;overflow:auto;border:1px solid #76ABD3;text-align:left;">
								<ul id="userInfoOUTree"></ul>
							</div>
						</td>
						<td valign="top">
							<select id="userInfos" style="width:310px;size:12;height:440px" multiple="multiple" ondblclick="onUserInfo_Clicked()"></select>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
var _permissionCode = '${code}';
var _permissionName = '${name}';

var _rolesLoadFlag = false;
var _groupLoadFlag = false;
var _userInfoLoadFlag = false;
function onPageActive(tabIndex){
	if(tabIndex == 0){
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
	}else if(tabIndex == 1){
		if(_groupLoadFlag)
			return;
		
		$('#groupOUTree').tree({
			url: contextPath + '/organize/ouTreeAction.do?action=getTree&timeStamp=' + new Date().getTime(),
			click:function(e, data){
				reloadGroups(data.id);
			}
		});
		_groupLoadFlag = true;
	}else if(tabIndex == 2){
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
	$(".ui-tab").oTabs().bind("select", function(e,index){
		onPageActive(index);
	});
});
</script>
</html>