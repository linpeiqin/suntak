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
		<oz:toolbar action="organize/userInfoAction" defaultTB="editForm">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnChangePassword" text="oz.mdu.organize.userinfo.button.changpassword" icon="oz-icon-0211" onclick="onBtnChangePassword_Clicked()"></oz:tbButton>	
			<oz:tbButton id="btnChangeLoginName" text="修改登录名" icon="oz-icon-0207" onclick="onBtnChangeLoginName_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnUnlock" text="解锁" icon="oz-icon-0533" onclick="onBtnUnlock_Clicked()"></oz:tbButton>	
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="organize/userInfoAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.mdu.organize.userinfo"/></div>			
			<div class="oz-form-fields">
				<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:800px;table-layout:fixed;border-top-width:0px">
					<tr class="oz-form-locate-tr">
						<td width="11%" style="padding:0px;"></td>
						<td width="39%" style="padding:0px;"></td>
						<td width="12%" style="padding:0px;"></td>
						<td width="38%" style="padding:0px;"></td>
					</tr>
					<tr class="oz-form-tr"> 
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.ouinfo"/>：</td>
						<td class="oz-property" colspan="3">
							<html:text property="ouInfo.fullName" styleId="ouInfoFullName" styleClass="oz-form-zdField" readonly="true" style="width:645px"/>
							<oz:linkButton onclick="OZ.Organize.selectOUInfo(onSelectOUInfo)" text="oz.btn.select"></oz:linkButton>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.name"/>：</td>
						<td class="oz-property" valign="bottom">
							<html:text property="name" styleId="name" styleClass="oz-form-btField"/>
						</td>
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.orderno"/>：</td>
						<td class="oz-property">
							<html:text property="orderNo" styleId="orderNo" styleClass="oz-form-field"/>
						</td>
					</tr>
					<tr id="LOGINNAME_TR_E" style="display:none" class="oz-form-tr">  
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.loginname"/>：</td>
						<td class="oz-property">
							<html:text property="loginName" styleId="loginName" styleClass="oz-form-btField" style="width:205px;float:left"/>
							<oz:userSelector onAfterSelect="onSelectUser"></oz:userSelector>
						</td>
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.password"/>：</td>
						<td class="oz-property">
							<html:password property="loginPassword" styleId="loginPassword" styleClass="oz-form-btField"/>
						</td>
					</tr>
					<tr id="LOGINNAME_TR_R" style="display:none" class="oz-form-tr"> 
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
							<html:radio property="status" styleId="status" value="0"/><oz:messageSource code="oz.enable"/>
							<html:radio property="status" styleId="status" value="1"/><oz:messageSource code="oz.disable"/>
						</td>
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.logintype"/>：</td>
						<td>
							<input type="checkbox" id="chkLoginType" name="chkLoginType" value="PASSWORD"><oz:messageSource code="oz.mdu.organize.userinfo.logintype.password"/>
							<input type="checkbox" id="chkLoginType" name="chkLoginType" value="KEY"><oz:messageSource code="oz.mdu.organize.userinfo.logintype.ukey"/>
							<input type="checkbox" id="chkLoginType" name="chkLoginType" value="CERT"><oz:messageSource code="oz.mdu.organize.userinfo.logintype.cert"/>
						</td>						
					</tr>
					<tr style="display:none" class="oz-form-tr"> 
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.managertype"/>：</td>
						<td colspan="3">
							<c:forEach var="managerType" items="${managetTypes}">
								<input type="checkbox" id="chkManagerType" name="chkManagerType" value="<c:out value="${managerType.value}"/>">${managerType.name}
							</c:forEach>
						</td>
					</tr>	
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.jobtitle"/>：</td>
						<td class="oz-property">
							<html:select property="userJobTitle.id" styleId="jobTitleId" styleClass="oz-form-btField">
								<html:optionsCollection name="jobTitleOptions" label="name" value="value" />
							</html:select>
						</td>
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.joblevel"/>：</td>
						<td class="oz-property">
							<html:select property="userJobLevel.id" styleId="jobLevelId" styleClass="oz-form-btField">
								<html:optionsCollection name="jobLevelOptions" label="name" value="value" />
							</html:select>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.istemporary"/>：</td>
						<td>
							<html:radio property="userTmpUser" styleId="userTmpUser" value="Y" onclick="onTmpUser_Changed()"/><oz:messageSource code="oz.yes"/>
							<html:radio property="userTmpUser" styleId="userTmpUser" value="N" onclick="onTmpUser_Changed()"/><oz:messageSource code="oz.no"/>
						</td>
						<td class="oz-form-label-r">
							<span class="userInfo-tmpuser"><oz:messageSource code="oz.validitydate"/>：</span>
						</td>
						<td class="oz-property">
							<span class="userInfo-tmpuser">
								<html:text property="userValidityStartDateTime" styleId="userValidityStartDateTime" styleClass="oz-form-field oz-dateField" style="width:120px"/>
								-
								<html:text property="userValidityEndDateTime" styleId="userValidityEndDateTime" styleClass="oz-form-field oz-dateField" style="width:120px"/>
							</span>	
						</td>
					</tr>
					<tr id="TR_USERTYPE" class="oz-form-tr"> 
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.usertype"/>：</td>
						<td class="oz-property">
							<html:select property="userType" styleId="userType" styleClass="oz-form-field">
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
						<iframe id="IFRAME_Group" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" src="<oz:contextPath/>/organize/groupAction.do?action=display&viewType=ByUserInfo&editFlag=y&userInfoId=<%= request.getAttribute("userInfoId") %>">
						</iframe>
					</div>
					<div data-tab-panel='{"id":"tab_02","title":"<oz:messageSource code="oz.mdu.organize.userinfo.tabs.charge"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<div style="width:100%;margin:4px;">
							<div class="oz-form-separator">								
								<h2 class="oz-form-separator-title">
									<input type="checkbox" name="chkAllSubordinates" onclick="onSubordinates_Clicked()">
									<oz:messageSource code="oz.mdu.organize.userinfo.tabs.subordinates"/>
								</h2>
							</div>
							<div id="subordinates-area" class="oz-form-separator-area" style="width:760px;padding-left:10px;padding-top:10px;">
								<c:if test="${not empty canSelectUserInfoOptions}">
									<c:forEach var="option" items="${canSelectUserInfoOptions}" varStatus="status">
										<div style="display:block;width:125px;overflow:hidden;text-overflow:ellipsis;white-space: nowrap;float:left;height:20px;">
											<input type="checkbox" id="chkSubordinates_${status.index}" name="chkSubordinates" value="<c:out value="${option.value}"/>">
											<label for="chkSubordinates_${status.index}" style="cursor:pointer;">${option.name}</label>
										</div>
									</c:forEach>
									<div style="clear:both;"></div>
								</c:if>
								<c:if test="${empty canSelectUserInfoOptions}">
									<span style="color:gray;">(无人员可选)</span>
								</c:if>
							</div>
							<br/>
							<div class="oz-form-separator">
								<h2 class="oz-form-separator-title">
									<input type="checkbox" name="chkAllChargeDepartments" onclick="onChargeDepartments_Clicked()">
									<oz:messageSource code="oz.mdu.organize.userinfo.tabs.charge.departments"/>
								</h2>
							</div>
							<div id="chargeDepartments-area" class="oz-form-separator-area" style="width:760px;padding-left:10px;padding-top:10px;">
								<c:forEach var="option" items="${canChargeDepartments}" varStatus="status">
									<span style="display:block;width:125px;overflow:hidden;text-overflow:ellipsis;white-space: nowrap;float:left;height:20px;">
										<input type="checkbox" id="chkChargeDepartments_${status.index}" name="chkChargeDepartments" value="<c:out value="${option.value}"/>">
										<label for="chkChargeDepartments_${status.index}" style="cursor:pointer;">${option.name}</label>
									</span>	
								</c:forEach>
								<div style="clear:both;"></div>
							</div>
						</div>						
					</div>	
					<div data-tab-panel='{"id":"tab_07","title":"<oz:messageSource code="oz.mdu.organize.userinfo.tabs.relations"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<iframe id="IFRAME_07" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" src="">
						</iframe>
					</div>								
					<div data-tab-panel='{"id":"tab_03","title":"<oz:messageSource code="oz.mdu.organize.userinfo.tabs.contactinfo"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:100%">
							<tr class="oz-form-tr"> 
								<td class="oz-form-label-r" width="12%"><oz:messageSource code="oz.telephone"/>：</td>
								<td class="oz-property" width="38%">
									<html:text property="telephone" styleId="telephone" styleClass="oz-form-field"/>
								</td>
								<td class="oz-form-label-r" width="12%"><oz:messageSource code="oz.mobile"/>：</td>
								<td class="oz-property" width="38%">
									<html:text property="mobile" styleId="mobile" styleClass="oz-form-field"/>
								</td>
							</tr>
							<tr class="oz-form-tr"> 
								<td class="oz-form-label-r"><oz:messageSource code="oz.email"/>：</td>
								<td class="oz-property">
									<html:text property="email" styleId="email" styleClass="oz-form-field"/>
								</td>
								<td class="oz-form-label-r"><oz:messageSource code="oz.faxno"/>：</td>
								<td class="oz-property">
									<html:text property="faxNo" styleId="faxNo" styleClass="oz-form-field"/>
								</td>
							</tr>
							<tr class="oz-form-tr"> 
								<td class="oz-form-label-r"><oz:messageSource code="oz.address"/>：</td>
								<td class="oz-property">
									<html:text property="address" styleId="address" styleClass="oz-form-field"/>
								</td>
								<td class="oz-form-label-r"><oz:messageSource code="oz.zipcode"/>：</td>
								<td class="oz-property">
									<html:text property="zipCode" styleId="zipCode" styleClass="oz-form-field"/>
								</td>
							</tr>
							<tr class="oz-form-tr"> 
								<td class="oz-form-label-r"><oz:messageSource code="oz.office"/>：</td>
								<td class="oz-property">
									<html:text property="office" styleId="office" styleClass="oz-form-field"/>
								</td>
								<td class="oz-form-label-r"><oz:messageSource code="oz.homeno"/>：</td>
								<td class="oz-property">
									<html:text property="homeNo" styleId="homeNo" styleClass="oz-form-field"/>
								</td>
							</tr>							
						</table>
					</div>
					<div data-tab-panel='{"id":"tab_04","title":"<oz:messageSource code="oz.mdu.organize.userinfo.tabs.otherinfo"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:100%">
							<tr class="oz-form-tr"> 
								<td class="oz-form-label-r" width="12%"><oz:messageSource code="oz.mdu.organize.userinfo.fields.title"/>：</td>
								<td class="oz-property" width="38%">
									<html:text property="title" styleId="title" styleClass="oz-form-field"/>
								</td>
								<td class="oz-form-label-r" width="12%"><oz:messageSource code="oz.mdu.organize.userinfo.fields.defaultflag"/>：</td>
								<td width="38%">
									<html:radio property="defaultFlag" styleId="defaultFlag" value="y"/><oz:messageSource code="oz.yes"/>
									<html:radio property="defaultFlag" styleId="defaultFlag" value="n"/><oz:messageSource code="oz.no"/>
								</td>
							</tr>
							<tr class="oz-form-tr"> 
								<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.employerid"/>：</td>
								<td class="oz-property">
									<html:text property="employerId" styleId="employerId" styleClass="oz-form-field"/>
								</td>
								<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.employeddate"/>：</td>
								<td class="oz-property">
									<html:text property="employedDateTime" styleId="employedDateTime" styleClass="oz-form-field oz-dateField" style="width:240px"/>
								</td>
							</tr>
							<tr class="oz-form-tr"> 
								<td class="oz-form-label-r"><oz:messageSource code="oz.gender"/>：</td>
								<td>
									<html:radio property="gender" styleId="gender" value="0"/><oz:messageSource code="oz.gender.unknown"/>
									<html:radio property="gender" styleId="gender" value="1"/><oz:messageSource code="oz.gender.male"/>
									<html:radio property="gender" styleId="gender" value="2"/><oz:messageSource code="oz.gender.female"/>
								</td>
								<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.birthday"/>：</td>
								<td class="oz-property">
									<html:text property="birthdayTime" styleId="birthdayTime" styleClass="oz-form-field oz-dateField" style="width:240px"/>
								</td>
							</tr>
							<tr class="oz-form-tr"> 
								<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.cardid"/>：</td>
								<td class="oz-property">
									<html:text property="cardId" styleId="cardId" styleClass="oz-form-field"/>
								</td>
								<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.workdate"/>：</td>
								<td class="oz-property">
									<html:text property="workDateTime" styleId="workDateTime" styleClass="oz-form-field oz-dateField" style="width:240px"/>
								</td>
							</tr>
							<tr class="oz-form-tr">  
								<td class="oz-form-topLabel-r"><oz:messageSource code="oz.memos"/>：</td>
								<td colspan="3" class="oz-property">
									<html:textarea property="memos" styleClass="oz-form-field" rows="3" style="width:650px"/>
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
<oz:organizeJs></oz:organizeJs>
<oz:js/>
<script type="text/javascript">
function onBtnSave_Clicked(){
	// 登录方式
	$("#userLoginType").val(getCheckBoxValus("chkLoginType"));
	
	// 负责人类型
	$("#managerTypes").val(getCheckBoxValus("chkManagerType"));
	
	// 分管人员
	$("#subordinateIds").val(getCheckBoxValus("chkSubordinates"));
	
	// 分管部门
	$("#chargeDepartmentIds").val(getCheckBoxValus("chkChargeDepartments"));
		
	// 调用保存方法
	var id = $("#id").val();
	if(id == -1){
		ozTB_DefaultBtnSave_Clicked(contextPath + "/organize/userInfoAction.do");

		// 重新加载用户映射信息
		_userMappingLoadFlag = false;
		$("#tabCt").tabs("activeTab","tab_01");
	}else{
		ozTB_DefaultBtnSaveByAjax_Clicked(contextPath + "/organize/userInfoAction.do");
	}
}

function onBtnChangePassword_Clicked(){
	OZ.Msg.prompt(
		'<oz:messageSource code="oz.mdu.organize.userinfo.dlg.changpassword.inputnewpassword"/>', 
		function(value){
			if(null == value || value.length == 0){
				OZ.Msg.info('<oz:messageSource code="oz.mdu.organize.userinfo.dlg.changpassword.msg.newpassword.isnull"/>', null, onBtnChangePassword_Clicked);
			}else{
				$.getJSON(
					contextPath + "/security/userAction.do?action=changePassword&timeStamp=" + new Date().getTime(),
					{loginName:$("#loginName").val(), password:value},
					function(json){
						if(json.result == true){   		// Ajax请求处理成功
							OZ.Msg.info('<oz:messageSource code="oz.mdu.organize.userinfo.dlg.changpassword.success"/>');
						}else{                          // Ajax请求处理失败
							OZ.Msg.info(json.msg);
						}
					}
				);
			}
		}, 
		null, '', false, '<oz:messageSource code="oz.mdu.organize.userinfo.dlg.changpassword.title"/>', true
	);
}

function onBtnChangeLoginName_Clicked(){
	OZ.Msg.prompt(
			'<oz:messageSource code="oz.mdu.organize.userinfo.dlg.changeloginname.inputnewloginname"/>', 
			function(value){
				if(null == value || value.length == 0){
					OZ.Msg.info('<oz:messageSource code="oz.mdu.organize.userinfo.dlg.changeloginname.msg.newloginname.isnull"/>', null, onBtnChangePassword_Clicked);
				}else{
					if($("#loginName").val() == value){
						return;
					}
					$.getJSON(
						contextPath + "/security/userAction.do?action=changeLoginName&timeStamp=" + new Date().getTime(),
						{loginName:$("#loginName").val(), newLoginName:value},
						function(json){
							if(json.result == true){   		// Ajax请求处理成功
								OZ.Msg.info('<oz:messageSource code="oz.mdu.organize.userinfo.dlg.changeloginname.success"/>');
								window.location.reload();
							}else{                          // Ajax请求处理失败
								OZ.Msg.info(json.msg);
							}
						}
					);
				}
			}, 
			null, '', false, '<oz:messageSource code="oz.mdu.organize.userinfo.dlg.changeloginname.title"/>', false
		);
}

function onBtnUnlock_Clicked(){
	$.getJSON(
		contextPath + "/security/userAction.do?action=unlock&timeStamp=" + new Date().getTime(),
		{loginName:$("#loginName").val()},
		function(json){
			if(json.result == true){   		// Ajax请求处理成功
				OZ.Msg.info('用户解锁成功');
			}else{                          // Ajax请求处理失败
				OZ.Msg.info(json.msg);
			}
		}
	);
}

function onSelectOUInfo(result){
	$("#ouInfoFullName").val(result.fullName);
	$("#ouInfoName").val(result.name);
	$("#ouInfoId").val(result.id);
	
	// 重新加载	
	var strUrl = contextPath + '/organize/ouTreeAction.do?action=getTree&timeStamp=' + new Date().getTime()
	strUrl += "&ouId=" + result.unitId;
	$('#ouTree').tree("option", "url", strUrl);
	$('#ouTree').tree("reload");
  
	OZ.SELECT.removeAll("group");
	OZ.SELECT.removeAll("selectedGroups");

	// 更新分管人员及分管部门的信息
	$("#subordinateIds").val(getCheckBoxValus("chkSubordinates"));
	$("#chargeDepartmentIds").val(getCheckBoxValus("chkChargeDepartments"));
	
	reloadUserInfos(result.id);
	reloadChargeDepatments(result.id);
	return true;
}

// 重新加载分管人员信息
function reloadUserInfos(ouId){
	$("#subordinates-area").empty();	
    var strUrl = contextPath + "/organize/userInfoAction.do?action=findUserInfoByOUInfo&timeStamp=" + new Date().getTime();
    $.getJSON(
		strUrl, 
		{ouId:ouId},
		function(json){
			var html = "";
			var userInfos = json.userInfos;
			var curUserInfoId = $("#id").val();
			if(userInfos.length > 0){
				for(var i = 0; i < userInfos.length; i++){
					if(curUserInfoId == userInfos[i].id)
						continue;
					html += '<input type="checkbox" id="chkSubordinates" name="chkSubordinates" value="' + userInfos[i].id + '"/>' + userInfos[i].name;
				}
			}
			$("#subordinates-area").html(html);
		    setCheckBoxStatus("chkSubordinates", $("#subordinateIds").val().split(","));
		}
	);
}

// 重新加载分管部门信息
function reloadChargeDepatments(ouId){
	$("#chargeDepartments-area").empty();	
 	var strUrl = contextPath + "/organize/ouInfoAction.do?action=findDepartments&timeStamp=" + new Date().getTime();
 	$.getJSON(
		strUrl, 
		{ouId:ouId},
		function(json){
			var html = "";
			var departments = json.departments;
			if(departments.length > 0){
				for(var i = 0; i < departments.length; i++){
					html += '<input type="checkbox" id="chkChargeDepartments" name="chkChargeDepartments" value="' + departments[i].id + '"/>' + departments[i].name;
				}
			}
			$("#chargeDepartments-area").html(html);
		    setCheckBoxStatus("chkChargeDepartments", $("#chargeDepartmentIds").val().split(","));
		}
	);
}

function onSelectUser(user){
	OZ.Organize.getUserDetail(user.id, onAfterGetUserInfo);
}

function onAfterGetUserInfo(user){
	$("#name").val(user.name);
	$("#loginName").val(user.loginName);
	$("#loginPassword").val(user.password);	
	$("#userType").val(user.type);
	
	$("#userValidityStartDateTime").val(user.validityStartDate);
	$("#userValidityEndDateTime").val(user.validityEndDate);

	// 设置临时标记
	$("input[type='radio'][name='userTmpUser']").each(function(){
		if(this.value == user.tmpUser){
			this.checked = true;
		}
	});

	// 设置登录方式
	$("#userLoginType").val(user.loginType);
	setCheckBoxStatus("chkLoginType", $("#userLoginType").val().split(","));
	
	// 设置密码、登录名称不可编辑
	$("#loginName").attr("readonly", "readonly");	
	$("#loginName").attr("class", "oz-form-zdField");
	$("#loginPassword").attr("readonly", "readonly");	
	$("#loginPassword").attr("class", "oz-form-zdField");

	// 重新加载映射信息
	_userMappingLoadFlag = false;
	$("#tabCt").tabs("activeTab","tab_01");
}

function onTmpUser_Changed(){
	var userTmpUser = $("input[name='userTmpUser']:checked").val();
	if("Y" == userTmpUser){
		$(".userInfo-tmpuser").show();
	}else{
		$(".userInfo-tmpuser").hide();
	}
}

// 重新加载岗位信息
function reloadGroups(ouId){
	var selOptionObj = document.getElementById("group");
    selOptionObj.length = 0;
    var strUrl = contextPath + "/organize/groupAction.do?action=findGroupByOUInfo&timeStamp=" + new Date().getTime();
    $.getJSON(
		strUrl, 
		{ouId:ouId},
		function(json){
			var groups = json.groups;
			if(groups.length > 0){
				for(var i = 0; i < groups.length; i++){
					if(!OZ.SELECT.isExist("selectedGroups", groups[i].id))
						selOptionObj.options[selOptionObj.length] = new Option(groups[i].name, groups[i].id);
				}
			}
		}
	);
}

var _userMappingLoadFlag = -1;
var _permissionTreeLoadFlag = false;
var _userInfoRelationLoadFlag = -1;
function onPageActive(data, editFlag){
	var pageId = data.tab.tabPanel("option", "id");
	if(pageId == "tab_05"){
		strUrl = contextPath + "/security/userMappingAction.do?action=display&editFlag=true&loginName=" + $("#loginName").val();
		_userMappingLoadFlag = loadSubPanel("IFRAME_05", _userMappingLoadFlag, strUrl);
		return;
	}else if(pageId == "tab_06"){
		var treeDataUrl = contextPath + "/organize/groupAction.do?action=getPermissionTree";
		treeDataUrl += "&userInfoId=" + $("#id").val() + "&timeStamp=" + new Date().getTime();
		if(!_permissionTreeLoadFlag){
			$('#permissionTree').tree({checkbox: true, checkable: false, url: treeDataUrl});
			_permissionTreeLoadFlag = true;
		}else{
			$('#permissionTree').tree("option", "url", treeDataUrl);
			$('#permissionTree').tree("reload");
		}
	}else if(pageId == "tab_07"){
		strUrl = contextPath + "/organize/userInfoRelationAction.do?action=display&editFlag=true&userInfoId=" + $("#id").val();
		_userInfoRelationLoadFlag = loadSubPanel("IFRAME_07", _userInfoRelationLoadFlag, strUrl);
		return;
	}
}

function loadSubPanel(iframeId, loadFlag, strUrl){
	if(loadFlag == 0)
		($("#" + iframeId).get(0)).src = strUrl + "&timeStamp=" + new Date().getTime();
	return loadFlag + 1;
}

function onSubordinates_Clicked(){
	$("input[type='checkbox'][name='chkAllSubordinates']").each(function(){
		var checked = this.checked;
		$("input[type='checkbox'][name='chkSubordinates']").each(function(){
			this.checked = checked;
		});
	});
}

function onChargeDepartments_Clicked(){
	$("input[type='checkbox'][name='chkAllChargeDepartments']").each(function(){
		var checked = this.checked;
		$("input[type='checkbox'][name='chkChargeDepartments']").each(function(){
			this.checked = checked;
		});
	});
}

function refresh(data){
	var tabType = data.data;
	if(tabType == "UserMapping"){
		_userMappingLoadFlag = false;
		$("#tabCt").tabs("activeTab","tab_05");
	}
}

$(function(){
	$("#tabCt").tabs({
		active:function(e,data){onPageActive(data, true);}
	});
	$("#tabCt").tabs("activeTab", "tab_01");

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
	
	// 加载岗位选择树
	var strUrl = contextPath + '/organize/ouTreeAction.do?action=getTree&timeStamp=' + new Date().getTime()
	strUrl += "&ouId=<%= request.getAttribute("unitId") %>";
	$('#ouTree').tree({
		url: strUrl,
		click:function(e, data){
			reloadGroups(data.id);
		}
	});

	if($("#id").val() == -1){
		$("#LOGINNAME_TR_E").show();
	}else{
		$("#LOGINNAME_TR_R").show();
	}
});
</script>
</html>