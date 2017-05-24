<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true" tabs="true" richinput="true" select="true" tree="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.organize.userinfo"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.organize.userinfo"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="organize/userInfoAction">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack"/>	
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="organize/userInfoAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.mdu.organize.userinfo"/></div>
			<div class="oz-form-fields">
				<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:800px;table-layout:fixed;border-top-width:0px">
					<tr class="oz-form-locate-tr">
						<td width="12%" style="border-left:1px solid white;border-right:0px solid white"></td>
						<td width="38%" style="border-right:0px solid white"></td>
						<td width="12%" style="border-right:0px solid white"></td>						
						<td width="38%" style="border-right:1px solid white;"></td>
					</tr>
					<tr class="oz-form-tr"> 
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.ouinfo"/>：</td>
						<td class="oz-property" colspan="3">
							<span class="oz-form-fields-span"><bean:write name="userInfoForm" property="ouInfo.fullName"/></span>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.name"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="userInfoForm" property="name"/></span>
						</td>
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.orderno"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="userInfoForm" property="orderNo"/></span>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.loginname"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="userInfoForm" property="loginName"/></span>
						</td>
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.password"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span">******</span>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.status"/>：</td>
						<td>
							<html:radio property="status" styleId="status" value="0" disabled="true"/><oz:messageSource code="oz.enable"/>
							<html:radio property="status" styleId="status" value="1" disabled="true"/><oz:messageSource code="oz.disable"/>
						</td>
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.logintype"/>：</td>
						<td>
							<input type="checkbox" id="chkLoginType" name="chkLoginType" value="PASSWORD" disabled="disabled"><oz:messageSource code="oz.mdu.organize.userinfo.logintype.password"/>
							<input type="checkbox" id="chkLoginType" name="chkLoginType" value="KEY" disabled="disabled"><oz:messageSource code="oz.mdu.organize.userinfo.logintype.ukey"/>
							<input type="checkbox" id="chkLoginType" name="chkLoginType" value="CERT" disabled="disabled"><oz:messageSource code="oz.mdu.organize.userinfo.logintype.cert"/>
						</td>
					</tr>
					<tr style="display:none" class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.managertype"/>：</td>
						<td colspan="3">
							<c:forEach var="managerType" items="${managetTypes}">
								<input type="checkbox" id="chkManagerType" name="chkManagerType" value="<c:out value="${managerType.value}"/>" disabled="disabled">${managerType.name}
							</c:forEach>
						</td>
					</tr>	
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.jobtitle"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="userInfoForm" property="userJobTitle.name"/></span>
						</td>
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.joblevel"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span">
								<bean:write name="userInfoForm" property="userJobLevel.name"/>(<bean:write name="userInfoForm" property="userJobLevel.level" format="#"/>)
							</span>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.istemporary"/>：</td>
						<td>
							<html:radio property="userTmpUser" styleId="userTmpUser" value="Y" disabled="true"/><oz:messageSource code="oz.yes"/>
							<html:radio property="userTmpUser" styleId="userTmpUser" value="N" disabled="true"/><oz:messageSource code="oz.no"/>
						</td>
						<td class="oz-form-label-r">
							<div class="userInfo-tmpuser">
								<oz:messageSource code="oz.validitydate"/>：
							</div>
						</td>
						<td class="oz-property">
							<div class="userInfo-tmpuser">
								<span class="oz-form-fields-span">
									<bean:write name="userInfoForm" property="userValidityStartDateTime"/>
									-
									<bean:write name="userInfoForm" property="userValidityEndDateTime"/>
								</span>
							</div>	
						</td>
					</tr>
					<tr id="TR_USERTYPE" class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.usertype"/>：</td>
						<td class="oz-property">
							<html:select property="userType" styleId="userType" styleClass="oz-form-zdField" disabled="true">
								<html:optionsCollection name="userTypeOptions" label="name" value="value" />
							</html:select>
						</td>
						<td class="oz-form-label-r"></td>
						<td class="oz-property">
						</td>
					</tr>
				</table>			
			</div>
			<!-- 页签 -->
			<div class="oz-form-tabs">
				<div id="tabCt" class="border" data-tabs='{"height":336}' style="border-width:0px;background-color: transparent;">
					<div data-tab-panel='{"id":"tab_01","title":"<oz:messageSource code="oz.mdu.organize.userinfo.tabs.groups"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<iframe id="IFRAME_Group" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" src="<oz:contextPath/>/organize/groupAction.do?action=display&viewType=ByUserInfo&editFlag=n&userInfoId=<%= request.getAttribute("userInfoId") %>">
						</iframe>
					</div>
					<div data-tab-panel='{"id":"tab_02","title":"<oz:messageSource code="oz.mdu.organize.userinfo.tabs.charge"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<div style="width:100%;margin:4px;">
							<div class="oz-form-separator">								
								<h2 class="oz-form-separator-title">
									<oz:messageSource code="oz.mdu.organize.userinfo.tabs.subordinates"/>
								</h2>
							</div>
							<div id="subordinates-area" class="oz-form-separator-area" style="width:760px;padding-left:10px;padding-top:10px;">
								<c:forEach var="option" items="${canSelectUserInfoOptions}">
									<span style="display:block;width:125px;overflow:hidden;text-overflow:ellipsis;white-space: nowrap;float:left;height:20px;">
										<input type="checkbox" id="chkSubordinates" name="chkSubordinates" value="<c:out value="${option.value}"/>" disabled="disabled">&nbsp;${option.name}
									</span>	
								</c:forEach>
								<div style="clear:both;"></div>
							</div>
							<br/>
							<div class="oz-form-separator">
								<h2 class="oz-form-separator-title">
									<oz:messageSource code="oz.mdu.organize.userinfo.tabs.charge.departments"/>
								</h2>
							</div>
							<div id="chargeDepartments-area" class="oz-form-separator-area" style="width:760px;padding-left:10px;padding-top:10px;">
								<c:forEach var="option" items="${canChargeDepartments}" varStatus="status">
									<span style="display:block;width:125px;overflow:hidden;text-overflow:ellipsis;white-space: nowrap;float:left;height:20px;">
										<input type="checkbox" id="chkChargeDepartments" name="chkChargeDepartments" value="<c:out value="${option.value}"/>" disabled="disabled">&nbsp;${option.name}
									</span>	
								</c:forEach>
								<div style="clear:both;"></div>
							</div>
						</div>		
					</div>										
					<div data-tab-panel='{"id":"tab_03","title":"<oz:messageSource code="oz.mdu.organize.userinfo.tabs.contactinfo"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:100%">
							<tr class="oz-form-tr">
								<td class="oz-form-label-r" width="12%"><oz:messageSource code="oz.telephone"/>：</td>
								<td class="oz-property" width="38%">
									<span class="oz-form-fields-span"><bean:write name="userInfoForm" property="telephone"/></span>
								</td>
								<td class="oz-form-label-r" width="12%"><oz:messageSource code="oz.mobile"/>：</td>
								<td class="oz-property" width="38%">
									<span class="oz-form-fields-span"><bean:write name="userInfoForm" property="mobile"/></span>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-r"><oz:messageSource code="oz.email"/>：</td>
								<td class="oz-property">
									<span class="oz-form-fields-span"><bean:write name="userInfoForm" property="email"/></span>
								</td>
								<td class="oz-form-label-r"><oz:messageSource code="oz.faxno"/>：</td>
								<td class="oz-property">
									<span class="oz-form-fields-span"><bean:write name="userInfoForm" property="faxNo"/></span>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-r"><oz:messageSource code="oz.address"/>：</td>
								<td class="oz-property">
									<span class="oz-form-fields-span"><bean:write name="userInfoForm" property="address"/></span>
								</td>
								<td class="oz-form-label-r"><oz:messageSource code="oz.zipcode"/>：</td>
								<td class="oz-property">
									<span class="oz-form-fields-span"><bean:write name="userInfoForm" property="zipCode"/></span>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-r"><oz:messageSource code="oz.office"/>：</td>
								<td class="oz-property">
									<span class="oz-form-fields-span"><bean:write name="userInfoForm" property="office"/></span>
								</td>
								<td class="oz-form-label-r"><oz:messageSource code="oz.homeno"/>：</td>
								<td class="oz-property">
									<span class="oz-form-fields-span"><bean:write name="userInfoForm" property="homeNo"/></span>
								</td>
							</tr>							
						</table>
					</div>
					<div data-tab-panel='{"id":"tab_04","title":"<oz:messageSource code="oz.mdu.organize.userinfo.tabs.otherinfo"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:100%">
							<tr class="oz-form-tr">
								<td class="oz-form-label-r" width="12%"><oz:messageSource code="oz.mdu.organize.userinfo.fields.title"/>：</td>
								<td class="oz-property" width="38%">
									<span class="oz-form-fields-span"><bean:write name="userInfoForm" property="title"/></span>
								</td>
								<td class="oz-form-label-r" width="12%"><oz:messageSource code="oz.mdu.organize.userinfo.fields.defaultflag"/>：</td>
								<td width="38%">
									<html:radio property="defaultFlag" styleId="defaultFlag" value="y" disabled="true"/><oz:messageSource code="oz.yes"/>
									<html:radio property="defaultFlag" styleId="defaultFlag" value="n" disabled="true"/><oz:messageSource code="oz.no"/>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.employerid"/>：</td>
								<td class="oz-property">
									<span class="oz-form-fields-span"><bean:write name="userInfoForm" property="employerId"/></span>
								</td>
								<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.employeddate"/>：</td>
								<td class="oz-property">
									<span class="oz-form-fields-span"><bean:write name="userInfoForm" property="employedDateTime"/></span>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-r"><oz:messageSource code="oz.gender"/>：</td>
								<td>
									<html:radio property="gender" styleId="gender" value="0" disabled="true"/><oz:messageSource code="oz.gender.unknown"/>
									<html:radio property="gender" styleId="gender" value="1" disabled="true"/><oz:messageSource code="oz.gender.male"/>
									<html:radio property="gender" styleId="gender" value="2" disabled="true"/><oz:messageSource code="oz.gender.female"/>
								</td>
								<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.birthday"/>：</td>
								<td class="oz-property">
									<span class="oz-form-fields-span"><bean:write name="userInfoForm" property="birthdayTime"/></span>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.cardid"/>：</td>
								<td class="oz-property">
									<span class="oz-form-fields-span"><bean:write name="userInfoForm" property="cardId"/></span>
								</td>
								<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.workdate"/>：</td>
								<td class="oz-property">
									<span class="oz-form-fields-span"><bean:write name="userInfoForm" property="workDateTime"/></span>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-topLabel-r"><oz:messageSource code="oz.memos"/>：</td>
								<td colspan="3" class="oz-property">
									<span class="oz-form-fields-span"><bean:write name="userInfoForm" property="memos"/></span>
								</td>
							</tr>
						</table>
					</div>		
					<div data-tab-panel='{"id":"tab_05","title":"<oz:messageSource code="oz.mdu.organize.userinfo.tabs.usermapping"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<iframe id="IFRAME_05" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" src="">
						</iframe>
					</div>	
					<div data-tab-panel='{"id":"tab_06","title":"<oz:messageSource code="oz.mdu.organize.userinfo.tabs.permissions"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
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
			<html:hidden property="id" styleId="id"/><html:hidden property="ouInfo.fullName" styleId="ouInfoFullName"/>
			<html:hidden property="ouInfo.id" styleId="ouInfoId"/><html:hidden property="ouInfo.name" styleId="ouInfoName"/>
			<html:hidden property="namePinYin" styleId="namePinYin"/><html:hidden property="userLoginType" styleId="userLoginType"/>
			<html:hidden property="subordinateIds" styleId="subordinateIds"/><html:hidden property="chargeDepartmentIds" styleId="chargeDepartmentIds"/>
			<html:hidden property="managerTypes" styleId="managerTypes"/>
		</html:form>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function onTmpUser_Changed(){
	var userTmpUser = $("input[name='userTmpUser']:checked").val();
	if("Y" == userTmpUser){
		$(".userInfo-tmpuser").show();
	}else{
		$(".userInfo-tmpuser").hide();
	}
}

var _userMappingLoadFlag = false;
var _permissionTreeLoadFlag = false;
function onPageActive(data, editFlag){
	var pageId = data.tab.tabPanel("option", "id");

	// InfoDefinition
	if(pageId == "tab_05"){
		strUrl = contextPath + "/security/userMappingAction.do?action=display&editFlag=false&loginName=" + $("#loginName").val();
		_userMappingLoadFlag = loadSubPanel("IFRAME_05", _userMappingLoadFlag, strUrl);
		return;
	}else if(pageId == "tab_04"){
		var treeDataUrl = contextPath + "/organize/groupAction.do?action=getPermissionTree";
		treeDataUrl += "&userInfoId=" + $("#id").val() + "&timeStamp=" + new Date().getTime();
		if(!_permissionTreeLoadFlag){
			$('#permissionTree').tree({checkbox: true, checkable: false, url: treeDataUrl});
			_permissionTreeLoadFlag = true;
		}else{
			$('#permissionTree').tree("option", "url", treeDataUrl);
			$('#permissionTree').tree("reload");
		}
	}
}

function loadSubPanel(iframeId, loadFlag, strUrl){
	if(loadFlag == false)
		($("#" + iframeId).get(0)).src = strUrl + "&timeStamp=" + new Date().getTime();
	return true;
}

$(function(){
	$("#tabCt").tabs({
		active:function(e,data){onPageActive(data, true);}
	});
	$("#tabCt").tabs("activeTab","tab_01");

	// 设置登录方式
	setCheckBoxStatus("chkLoginType", $("#userLoginType").val().split(","));
		
	// 设置负责人类型
	setCheckBoxStatus("chkManagerType", $("#managerTypes").val().split(","));
	
	// 设置分管人员
	setCheckBoxStatus("chkSubordinates", $("#subordinateIds").val().split(","));

	// 设置分管部门
	setCheckBoxStatus("chkChargeDepartments", $("#chargeDepartmentIds").val().split(","));
	
	// 临时用户
	onTmpUser_Changed();
	
	// 控制类型是否显示
	var isCanUsedUserType = "<%= request.getAttribute("isCanUsedUserType") %>";
	if(isCanUsedUserType == "n" || isCanUsedUserType == "N"){
		$("#TR_USERTYPE").hide();
	}
});
</script>
</html>