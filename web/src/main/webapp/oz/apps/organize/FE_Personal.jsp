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
			<oz:tbButton id="btnBack"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnSave"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnChangePassword" text="oz.mdu.organize.userinfo.button.changpassword" icon="oz-icon-0211" onclick="onBtnChangePassword_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnConfigMyPage" text="oz.mdu.organize.userinfo.button.configmypage" icon="oz-icon-0119" onclick="onBtnConfigMyPage_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnShowMyPermission" text="oz.mdu.organize.userinfo.button.mypermission" icon="oz-icon-0238" onclick="onBtnShowMyPermission_Clicked()"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="organize/userInfoAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.mdu.organize.personal"/></div>
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
							<span class="oz-form-fields-span"><bean:write name="userInfoForm" property="ouInfo.fullName"/></span>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.loginname"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="userInfoForm" property="loginName"/></span>
						</td>
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.name"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="userInfoForm" property="name"/></span>
						</td>
					</tr>
					<tr id="TR_DEFAULTUSERINFO" style="display:none" class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.defaultuserinfo"/>：</td>
						<td class="oz-property" colspan="3">
							<oz:select value="defaultUserInfoId" property="defaultUserInfoId" options="userInfoOptions"></oz:select>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.title"/>：</td>
						<td class="oz-property">
							<html:text property="title" styleId="title" styleClass="oz-form-field"/>
						</td>
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.homepage"/>：</td>
						<td class="oz-property">
							<oz:select value="defaultHomePage" property="defaultHomePage" options="homePageOptions"></oz:select>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.jobtitle"/>：</td>
						<td class="oz-property">
							<html:select property="userJobTitle.id" styleId="jobTitleId" styleClass="oz-form-field">
								<html:optionsCollection name="jobTitleOptions" label="name" value="value" />
							</html:select>
						</td>
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.joblevel"/>：</td>
						<td class="oz-property">
							<html:select property="userJobLevel.id" styleId="jobLevelId" styleClass="oz-form-field">
								<html:optionsCollection name="jobLevelOptions" label="name" value="value" />
							</html:select>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.telephone"/>：</td>
						<td class="oz-property">
							<html:text property="telephone" styleId="telephone" styleClass="oz-form-field"/>
						</td>
						<td class="oz-form-label-r"><oz:messageSource code="oz.mobile"/>：</td>
						<td class="oz-property">
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
							<html:textarea property="memos" styleClass="oz-form-field" rows="3"/>
						</td>
					</tr>
					<tr style="display:none;">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.userinfo.fields.remindtype"/>：</td>
						<td>
							<INPUT type="radio" id="rad_remindType" name="rad_remindType" value="sysmsg"/><oz:messageSource code="oz.mdu.organize.userinfo.remindtype.sysmsg"/>
							<INPUT type="radio" id="rad_remindType" name="rad_remindType" value="sms"/><oz:messageSource code="oz.mdu.organize.userinfo.remindtype.sms"/>
							<INPUT type="radio" id="rad_remindType" name="rad_remindType" value="email"/><oz:messageSource code="oz.mdu.organize.userinfo.remindtype.email"/>
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
					<div data-tab-panel='{"id":"tab_01","title":"<oz:messageSource code="oz.mdu.organize.userinfo.tabs.usermapping"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<iframe id="IFRAME_01" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" src="">
						</iframe>
					</div>
					<div data-tab-panel='{"id":"tab_02","title":"<oz:messageSource code="oz.mdu.organize.userinfo.tabs.relations"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<iframe id="IFRAME_02" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" src="">
						</iframe>
					</div>	
				</div>
			</div>
			<html:hidden property="id" styleId="id"/><html:hidden property="ouInfo.id" styleId="ouInfoId"/>
			<input type="hidden" id="remindType" name="remindType" value="<%= request.getAttribute("remindType") %>"/>
		</html:form>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function onBtnSave_Clicked(){
	$("input[type='radio'][name='rad_remindType']").each(function(){
		if(this.checked == true)
			$("#remindType").val(this.value);
	});
	
	ozTB_DefaultBtnSaveByAjax_ClickedEx(contextPath + "/organize/userInfoAction.do?action=savePersonal");
}

function onBtnChangePassword_Clicked(){
	var strUrl = contextPath + "/security/userAction.do?action=dlgChangePassword";
	strUrl += "&timeStamp=" + new Date().getTime();
	
	new OZ.Dlg.create({ 
		id: "dlg_ChangePassword", 
		width:260, height:200,
		title:'<oz:messageSource code="oz.mdu.organize.userinfo.dlg.changpassword.title"/>',
		url: strUrl,
		onOk:function(result){
			$.getJSON(
				contextPath + "/security/userAction.do?action=changePersonalPassword&timeStamp=" + new Date().getTime(),
				{newPassword:result.newPassword, oldPassword:result.oldPassword},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.mdu.organize.userinfo.dlg.changpassword.success"/>');
					}else{
						OZ.Msg.info(json.msg, null, onBtnChangePassword_Clicked);
					}
				}
			);
		},
		onCancel:function(result){
			// do nothing...
		}
	});
}

function onBtnConfigMyPage_Clicked(){
	var strUrl = contextPath + "/module/portalAction.do?action=customize&timeStamp=" + new Date().getTime();
	OZ.openWindow({
		id:"HomePageCustomize",
		title:'<oz:messageSource code="oz.portalmgm.constants.homepage.customize"/>',
		url:strUrl,
		refresh:false
	});
}

function onBtnShowMyPermission_Clicked(){
	var strUrl = contextPath + "/security/userAction.do?action=showMyPermission";
	strUrl += "&timeStamp=" + new Date().getTime();
	
	new OZ.Dlg.create({ 
		id:"dlg_ShowMyPermission", 
		width:300, height:330,
		title:'<oz:messageSource code="oz.mdu.organize.userinfo.dlg.mypermission.title"/>',
		url: strUrl,
		buttons:[{text:'<oz:messageSource code="oz.close"/>', handler:$.noop}]
	});
}

var _userMappingLoadFlag = false;
var _userInfoRelationLoadFlag = false;
function onPageActive(data, editFlag){
	var pageId = data.tab.tabPanel("option", "id");
	if(pageId == "tab_01"){
		strUrl = contextPath + "/security/userMappingAction.do?action=display&editFlag=true&loginName=" + $("#loginName").val();
		_userMappingLoadFlag = loadSubPanel("IFRAME_01", _userMappingLoadFlag, strUrl);
		return;
	}else if(pageId == "tab_02"){
		strUrl = contextPath + "/organize/userInfoRelationAction.do?action=display&editFlag=true&userInfoId=" + $("#id").val();
		_userInfoRelationLoadFlag = loadSubPanel("IFRAME_02", _userInfoRelationLoadFlag, strUrl);
		return;
	}
}

function loadSubPanel(iframeId, loadFlag, strUrl){
	if(loadFlag == false)
		($("#" + iframeId).get(0)).src = strUrl + "&timeStamp=" + new Date().getTime();
	return true;
}

$(function(){
	//初始化页签
	$("#tabCt").tabs({
		active:function(e,data){onPageActive(data, true);}
	});
	$("#tabCt").tabs("activeTab","tab_01");

	var showDefaultUserInfo = '<%= request.getAttribute("showDefaultUserInfo") %>';
	if("y" == showDefaultUserInfo || "Y" == showDefaultUserInfo){
		$("#TR_DEFAULTUSERINFO").show();
	}

	var remindType = $("#remindType").val();
	$("input[type='radio'][name='rad_remindType']").each(function(){
		if(this.value == remindType){
			this.checked = true;
		}
	});
	
	var showChangePwd = ${changePwd};
	if(showChangePwd)
		onBtnChangePassword_Clicked();
});
</script>
</html>