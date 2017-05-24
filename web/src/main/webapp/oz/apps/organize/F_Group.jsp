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
		<oz:toolbar action="organize/groupAction">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack" text="返回"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="organize/groupAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.mdu.organize.group"/></div>
			<div style="text-align:left; margin-top:10px;color:red;font-weight:bold;display:none"><div id="DIV_INNERFLAG"></div></div>
			<div class="oz-form-fields">
				<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:800px;table-layout:fixed;border-top-width:0px">
					<tr class="oz-form-locate-tr">
						<td width="14%" style="border-left:1px solid white;"></td>
						<td width="36%"></td>
						<td width="14%"></td>						
						<td width="36%" style="border-right:1px solid white;"></td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.group.fields.ouinfo"/>：</td>
						<td class="oz-property" colspan="3">
							<bean:write name="groupForm" property="ouInfo.fullName"/>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.group.fields.name"/>：</td>
						<td class="oz-property">
							<bean:write name="groupForm" property="name"/>
						</td>
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.group.fields.code"/>：</td>
						<td class="oz-property">
							<bean:write name="groupForm" property="code"/>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.status"/>：</td>
						<td>
							<html:radio property="status" value="0" disabled="true"/><span style="width:40px;display:inline-block;"><oz:messageSource code="oz.enable"/></span>
							<html:radio property="status" value="1" disabled="true"/><span style="width:40px;display:inline-block;"><oz:messageSource code="oz.disable"/></span>
						</td>
						<td class="oz-form-label-r">
							<c:if test="${!empty typeOptions}">
								<oz:messageSource code="oz.mdu.organize.group.fields.type"/>：
							</c:if>
						</td>
						<td class="oz-property">
							<c:if test="${!empty typeOptions}">
								<html:select property="type" styleId="type" styleClass="oz-form-zdField" disabled="true">
									<html:optionsCollection name="typeOptions" label="name" value="value" />
								</html:select>
							</c:if>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.group.fields.orderno"/>：</td>
						<td class="oz-property">
							<bean:write name="groupForm" property="orderNo"/>
						</td>
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.group.inner.group"/>：</td>
						<td>
							<html:radio property="innerFlag" value="Y" disabled="true"/><span style="width:40px;display:inline-block;"><oz:messageSource code="oz.yes"/></span>
							<html:radio property="innerFlag" value="N" disabled="true"/><span style="width:40px;display:inline-block;"><oz:messageSource code="oz.no"/></span>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.group.tabs.roles"/>(${fn:length(selectedRoleOptions)})：</td>
						<td colspan="3">
							<c:if test="${!empty selectedRoleOptions}">
								<c:forEach var="role" items="${selectedRoleOptions}">
									<span style="width:80px;display:inline-block;">
										&bull;
										<a href="javascript:openRole(${role.value}, '${role.name}')">${role.name}</a>
									</span>
								</c:forEach>
							</c:if>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.group.tabs.managers"/>(${fn:length(selectedGroupManagers)})：</td>
						<td colspan="3">
							<c:if test="${!empty selectedGroupManagers}">
								<c:forEach var="manager" items="${selectedGroupManagers}">
									<span style="width:80px;display:inline-block;">
										&bull;
										<a href="javascript:openUserInfo(${manager.value}, '${manager.name}')">${manager.name}</a>
									</span>
								</c:forEach>
							</c:if>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.group.tabs.members"/>(${fn:length(selectedMemberOptions)})：</td>
						<td colspan="3">
							<c:if test="${!empty selectedMemberOptions}">
								<c:forEach var="member" items="${selectedMemberOptions}">
									<span style="width:80px;display:inline-block;">
										&bull;
										<a href="javascript:openUserInfo(${member.value}, '${member.name}')">${member.name}</a>
									</span>
								</c:forEach>
							</c:if>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-topLabel-r"><oz:messageSource code="oz.mdu.organize.group.tabs.permissions"/>：</td>
						<td colspan="3">
							<div style="width:360px;height:280px;overflow:auto;border:1px solid #76ABD3">
								<ul id="permissionTree"></ul>
							</div>
						</td>
					</tr>
					<tr class="oz-form-tr"> 
						<td class="oz-form-topLabel-r"><oz:messageSource code="oz.memos"/>：</td>
						<td class="oz-property" colspan="3">
							<bean:write name="groupForm" property="memos"/>
						</td>
					</tr>
				</table>			
			</div>
			<html:hidden property="id" styleId="id"/><html:hidden property="ouInfo.fullName" styleId="ouInfoFullName"/>
			<html:hidden property="ouInfo.id" styleId="ouInfoId"/><html:hidden property="ouInfo.name" styleId="ouInfoName"/>
			<html:hidden property="innerFlag" styleId="innerFlag"/><html:hidden property="namePinYin" styleId="namePinYin"/>
		</html:form>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
var _roleIds = "${OZ_DOMAIN.roleIds}";

function openRole(roleId, roleName){
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

function openUserInfo(userInfoId, userInfoName){
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
	var treeDataUrl = contextPath + "/security/roleAction.do?action=getPermissionTree";
	treeDataUrl += "&ids=" + _roleIds + "&timeStamp=" + new Date().getTime();
	$('#permissionTree').tree({checkbox: true, checkable: false, url: treeDataUrl});
});
</script>
</html>