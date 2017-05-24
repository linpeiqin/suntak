<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true" tabs="true" richinput="true" select="true" tree="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.organize.group"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.organize.group"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="organize/groupAction" defaultTB="editForm">
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="organize/groupAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.mdu.organize.group"/></div>
			<div class="oz-form-fields" style="margin:0px;">
				<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:800px;table-layout:fixed;border-top-width:0px">
					<tr class="oz-form-locate-tr">
						<td width="12%" style="border-left:1px solid white;border-right:0px solid white"></td>
						<td width="38%" style="border-right:0px solid white"></td>
						<td width="12%" style="border-right:0px solid white"></td>						
						<td width="38%" style="border-right:1px solid white;"></td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.group.fields.ouinfo"/>：</td>
						<td class="oz-property" colspan="3">
							<html:text property="ouInfo.fullName" styleId="ouInfoFullName" styleClass="oz-form-zdField" readonly="true" style="width:630px"/>
							<oz:linkButton onclick="OZ.Organize.selectOUInfo(onSelectOUInfo)" text="oz.btn.select"></oz:linkButton>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.group.fields.name"/>：</td>
						<td class="oz-property">
							<html:text property="name" styleClass="oz-form-btField"/>
						</td>
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.group.fields.code"/>：</td>
						<td class="oz-property">
							<html:text property="code" styleClass="oz-form-field"/>
						</td>
					</tr>
					<tr class="oz-form-tr"> 
						<td class="oz-form-label-r"><oz:messageSource code="oz.status"/>：</td>
						<td>
							<html:radio property="status" value="0"/><span style="width:40px;display:inline-block;"><oz:messageSource code="oz.enable"/></span>
							<html:radio property="status" value="1"/><span style="width:40px;display:inline-block;"><oz:messageSource code="oz.disable"/></span>
						</td>
						<td class="oz-form-label-r">
							<c:if test="${!empty typeOptions}">
								<oz:messageSource code="oz.mdu.organize.group.fields.type"/>：
							</c:if>
						</td>
						<td class="oz-property">
							<c:if test="${!empty typeOptions}">
								<html:select property="type" styleId="type" styleClass="oz-form-field">
									<html:optionsCollection name="typeOptions" label="name" value="value" />
								</html:select>
							</c:if>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.group.fields.orderno"/>：</td>
						<td class="oz-property">
							<html:text property="orderNo" styleClass="oz-form-field"/>
						</td>
						<c:if test="${not isSystemAdmin}">
							<td class="oz-form-label-r"></td>
							<td></td>
						</c:if>
						<c:if test="${isSystemAdmin}">
							<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.group.inner.group"/>：</td>
							<td>
								<html:radio property="innerFlag" value="Y"/><span style="width:40px;display:inline-block;"><oz:messageSource code="oz.yes"/></span>
								<html:radio property="innerFlag" value="N"/><span style="width:40px;display:inline-block;"><oz:messageSource code="oz.no"/></span>
							</td>
						</c:if>
					</tr>
					<tr class="oz-form-tr"> 
						<td class="oz-form-topLabel-r"><oz:messageSource code="oz.memos"/>：</td>
						<td class="oz-property" colspan="3">
							<html:textarea property="memos" styleClass="oz-form-field" rows="3"/>
						</td>
					</tr>
				</table>			
			</div>
			<!-- 页签 -->
			<div class="oz-form-tabs">
				<div id="tabCt" class="border" data-tabs='{"height":320}' style="border-width:0px;background-color: transparent;border-bottom:#76abd3 0px solid">
					<div data-tab-panel='{"id":"tab_01","title":"<oz:messageSource code="oz.mdu.organize.group.tabs.roles"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<table cellpadding="3" cellspacing="3" style="width:99%;margin:2px 2px 2px 2px;">
							<tr>
								<td width="355px">
									<div class="oz-form-separator">
										<h2 class="oz-form-separator-title">
											<oz:messageSource code="oz.mdu.organize.group.tabs.roles.available"/>
										</h2>
									</div>
								</td>
								<td width="80px"></td>
								<td width="355px">
									<div class="oz-form-separator">								
										<h2 class="oz-form-separator-title">
											<oz:messageSource code="oz.mdu.organize.group.tabs.roles.members"/>
										</h2>
									</div>
								</td>
							</tr>
							<tr> 
								<td style="vertical-align:top">
									<oz:select value="curValue" property="canSelectRoles" options="canSelectRoleOptions" multiple="true" style="width:100%;height:260px;"></oz:select>
								</td>
								<td style="text-align:center; vertical-align:middle;">
									<oz:linkButton id="btnAddRole" onclick="OZ.SELECT.appendSelected('canSelectRoles', 'selectedRoles', true)" text="oz.btn.add" style="width:52px"></oz:linkButton><br /><br /><br />
									<oz:linkButton id="btnDelRole" onclick="OZ.SELECT.appendSelected('selectedRoles', 'canSelectRoles', true)" text="oz.btn.clear" style="width:52px"></oz:linkButton><br /><br /><br />
									<oz:linkButton id="btnClearRoles" onclick="OZ.SELECT.appendAll('selectedRoles', 'canSelectRoles', true)" text="oz.btn.clear.all" style="width:52px"></oz:linkButton>
								</td>
								<td class="oz-property">
									<html:select property="selectedRoles" styleId="selectedRoles" style="width:100%;height:260px;" multiple="true" ondblclick="openRole()">
	                					<html:optionsCollection name="selectedRoleOptions" label="name" value="value" /> 
	                				</html:select>
								</td>
							</tr>
					  	</table>
					</div>
					<div data-tab-panel='{"id":"tab_02","title":"<oz:messageSource code="oz.mdu.organize.group.tabs.members"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<table cellpadding="3" cellspacing="3" style="width:99%;margin:2px 2px 2px 2px;">
							<tr>
								<td colspan="2">
									<div class="oz-form-separator">								
										<h2 class="oz-form-separator-title">
											<oz:messageSource code="oz.mdu.organize.group.tabs.members.available"/>
										</h2>
									</div>
								</td>
								<td></td>
								<td>
									<div class="oz-form-separator">								
										<h2 class="oz-form-separator-title">
											<oz:messageSource code="oz.mdu.organize.group.tabs.members.selected"/>
										</h2>
									</div>
								</td>
							</tr>
							<tr>
								<td width="240px" valign="top">
									<div style="width:238px;height:260px;overflow:auto;border:1px solid #7F9DB9">
										<ul id="ouTree"></ul>
									</div>
								</td>
								<td width="235px" valign="top">
									<div style="width:234px;height:260px;border:1px solid #8DB2E3;border-left:0px;overflow:hidden;position: relative;">
										<select id="members" name="members" size="14" style="width:237px;margin:-2px;height:263px;z-index:1" multiple="multiple"></select>
									</div>
								</td>
								<td width="80px" style="text-align: center;vertical-align: middle;">
									<oz:linkButton id="btnAdd" onclick="onBtnAddMember_Clicked()" text="oz.btn.add" style="width:52px"></oz:linkButton><br/><br/><br/>
									<oz:linkButton id="btnDelete" onclick="onBtnDelMember_Clicked()" text="oz.btn.clear" style="width:52px"></oz:linkButton><br/><br/><br/>
									<oz:linkButton id="btnDelete" onclick="onBtnClearMember_Clicked()" text="oz.btn.clear.all" style="width:52px"></oz:linkButton>
								</td>
								<td width="235px" valign="top">          
									<html:select property="selectedMembers" styleId="selectedMembers" style="width:100%;height:260px;" multiple="true" ondblclick="openUserInfo('selectedMembers')">
	                					<html:optionsCollection name="selectedMemberOptions" label="name" value="value" /> 
	                				</html:select>
								</td>
							</tr>
						</table>
					</div>
					<div data-tab-panel='{"id":"tab_03","title":"<oz:messageSource code="oz.mdu.organize.group.tabs.managers"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<table cellpadding="3" cellspacing="3" style="width:99%;margin:2px 2px 2px 2px;">
							<tr>
								<td width="355px">
									<div class="oz-form-separator">								
										<h2 class="oz-form-separator-title">
											<oz:messageSource code="oz.mdu.organize.group.tabs.managers.available"/>
										</h2>
									</div>
								</td>
								<td width="80px"></td>
								<td width="355px">
									<div class="oz-form-separator">								
										<h2 class="oz-form-separator-title">
											<oz:messageSource code="oz.mdu.organize.group.tabs.managers.selected"/>
										</h2>
									</div>
								</td>
							</tr>
							<tr> 
								<td style="vertical-align:top">
									<oz:select value="curValue" property="canSelectGroupManagers" options="canSelectManagerOptions" multiple="true" style="width:100%;height:260px;"></oz:select>
								</td>
								<td style="text-align:center; vertical-align:middle;">
									<oz:linkButton id="btnAddManager" onclick="OZ.SELECT.appendSelected('canSelectGroupManagers', 'selectedGroupManagers', true)" text="oz.btn.add" style="width:52px"></oz:linkButton><br/><br/><br/>
									<oz:linkButton id="btnDelManager" onclick="OZ.SELECT.appendSelected('selectedGroupManagers', 'canSelectGroupManagers', true)" text="oz.btn.clear" style="width:52px"></oz:linkButton><br/><br/><br/>
									<oz:linkButton id="btnClearManagers" onclick="OZ.SELECT.appendAll('selectedGroupManagers', 'canSelectGroupManagers', true)" text="oz.btn.clear.all" style="width:52px"></oz:linkButton>
								</td>
								<td>
									<html:select property="selectedGroupManagers" styleId="selectedGroupManagers" style="width:100%;height:260px;" multiple="true" ondblclick="openUserInfo('selectedGroupManagers')">
	                					<html:optionsCollection name="selectedManagerOptions" label="name" value="value" /> 
	                				</html:select>
								</td>
							</tr>
					  	</table>
					</div>
					<div data-tab-panel='{"id":"tab_04","title":"<oz:messageSource code="oz.mdu.organize.group.tabs.permissions"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<table cellpadding="3" cellspacing="3" style="width:360px;margin:2px 2px 2px 2px;">
							<tr>
								<td width="100%" valign="top">
									<div style="width:360px;height:280px;overflow:auto;border:1px solid #76ABD3">
										<ul id="permissionTree"></ul>
									</div>
								</td>
							</tr>
						</table>
					</div>
				</div>	
			</div>
			<html:hidden property="id" styleId="id"/>
			<html:hidden property="ouInfo.id" styleId="ouInfoId"/><html:hidden property="ouInfo.name" styleId="ouInfoName"/>
			<html:hidden property="namePinYin" styleId="namePinYin"/>
		</html:form>
	</div>
</body>
<oz:organizeJs></oz:organizeJs>
<oz:js/>
<script type="text/javascript">
var _unitId = '<%= request.getAttribute("unitId") %>';
function onBtnSave_Clicked(){
	// 选中列表框的所有值
	OZ.SELECT.selectAll(["selectedRoles", "selectedMembers", "selectedGroupManagers"]);
	
	// 调用默认的保存方法
	ozTB_DefaultBtnSaveByAjax_Clicked(contextPath + "/organize/groupAction.do");
}

function onSelectOUInfo(result){
	var oldOUId = $("#ouInfoId").val();
	if(oldOUId == result.id)
		return false;

	// 更新相应的信息
	$("#ouInfoFullName").val(result.fullName);
	$("#ouInfoName").val(result.name);
	$("#ouInfoId").val(result.id);
		
	// 重新加载
	var strUrl = contextPath + '/organize/ouTreeAction.do?action=getTree&timeStamp=' + new Date().getTime()
	strUrl += "&ouId=" + result.unitId;
	$('#ouTree').tree("option", "url", strUrl);
	$('#ouTree').tree("reload");
	OZ.SELECT.removeAll("members");
	OZ.SELECT.removeAll("selectedMembers");

	OZ.SELECT.removeAll("canSelectGroupManagers");
	OZ.SELECT.removeAll("selectedGroupManagers");
	
	if(_unitId != result.unitId){
		OZ.SELECT.removeAll("canSelectRoles");
		OZ.SELECT.removeAll("selectedRoles");
		reloadRoles(result.unitId);
	}
	_unitId = result.unitId;
	return true;
}

function onBtnAddMember_Clicked(){
	OZ.SELECT.appendSelected('members', 'selectedMembers', false);
	OZ.SELECT.appendSelected('members', 'canSelectGroupManagers', true);
}

function onBtnDelMember_Clicked(){
	OZ.SELECT.appendSelected('selectedMembers', 'members', true);

	// 同步岗位负责可选列表
	var destObj = document.getElementById("canSelectGroupManagers");
	var len = destObj.length;
	for(var i = len-1; i >= 0; i--){
		if(!OZ.SELECT.isExist("selectedMembers", destObj.options[i].value))
			destObj.options[i] = null;
	}

	destObj = document.getElementById("selectedGroupManagers");
	len = destObj.length;
	for(var i = len-1; i >= 0; i--){
		if(!OZ.SELECT.isExist("selectedMembers", destObj.options[i].value))
			destObj.options[i] = null;
	}
}

function onBtnClearMember_Clicked(){
	OZ.SELECT.appendAll('selectedMembers', 'members', true);
	OZ.SELECT.removeAll("canSelectGroupManagers");
	OZ.SELECT.removeAll("selectedGroupManagers");
}

function reloadRoles(ouId){
	var selOptionObj = document.getElementById("canSelectRoles");
    var strUrl = contextPath + "/organize/groupAction.do?action=findRoleByOUInfo&timeStamp=" + new Date().getTime();
    $.getJSON(
		strUrl, 
		{ouId:ouId},
		function(json){
			var roles = json.roles;
			if(roles.length > 0){
				for(var i = 0; i < roles.length; i++){
					selOptionObj.options[selOptionObj.length] = new Option(roles[i].name, roles[i].id);
				}
			}
		}
	);
}

function reloadUserInfos(ouId){
	var selOptionObj = document.getElementById("members");
    selOptionObj.length = 0;
    var strUrl = contextPath + "/organize/userInfoAction.do?action=findUserInfoByOUInfo&timeStamp=" + new Date().getTime();
    $.getJSON(
		strUrl, 
		{ouId:ouId},
		function(json){
			var userInfos = json.userInfos;
			if(userInfos.length > 0){
				for(var i = 0; i < userInfos.length; i++){
					if(!OZ.SELECT.isExist("selectedMembers", userInfos[i].id))
						selOptionObj.options[selOptionObj.length] = new Option(userInfos[i].fullName, userInfos[i].id);
				}
			}
		}
	);
}

var _permissionTreeLoadFlag = false;
function onPageActive(data, editFlag){
	var pageId = data.tab.tabPanel("option", "id");
	if(pageId == "tab_04"){
		// 获取已选角色的Id
		var roleIds = "";
		var roleObj = document.getElementById("selectedRoles");
		for (var i = 0; i < roleObj.length; i++){
			if(roleIds.length > 0)
				roleIds += ",";
			roleIds += roleObj.options[i].value;
		}
		var treeDataUrl = contextPath + "/security/roleAction.do?action=getPermissionTree";
		treeDataUrl += "&ids=" + roleIds + "&timeStamp=" + new Date().getTime();

		if(!_permissionTreeLoadFlag){
			$('#permissionTree').tree({checkbox: true, checkable: false, url: treeDataUrl});
			_permissionTreeLoadFlag = true;
		}else{
			$('#permissionTree').tree("option", "url", treeDataUrl);
			$('#permissionTree').tree("reload");
		}
	}
}

function openRole(){
	var roleName = $("#selectedRoles").find("option:selected").text();
	var roleId = $("#selectedRoles").val();
	var strUrl = contextPath + "/security/roleAction.do?action=open&timeStamp=" + new Date().getTime();
	strUrl += "&id=" + roleId;
	OZ.openWindow({
		id: "Role_" + roleId,
		title: roleName,
		url: strUrl, 
		refresh: false,
		beforeCloseFnName: "oz_Win_BeforeClose"
	});
}

function openUserInfo(selectId){
	var userInfoName = $("#" + selectId).find("option:selected").text();
	var userInfoId = $("#" + selectId).val();
	var strUrl = contextPath + "/organize/userInfoAction.do?action=open&timeStamp=" + new Date().getTime();
	strUrl += "&id=" + userInfoId;
	OZ.openWindow({
		id: "UserInfo" + userInfoId,
		title: userInfoName,
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
	
	// 加载人员选择树	
	var strUrl = contextPath + '/organize/ouTreeAction.do?action=getTree&timeStamp=' + new Date().getTime()
	strUrl += "&ouId=<%= request.getAttribute("unitId") %>";
	$('#ouTree').tree({
		url: strUrl,
		click:function(e, data){
			reloadUserInfos(data.id);
		}
	});
});
</script>
</html>