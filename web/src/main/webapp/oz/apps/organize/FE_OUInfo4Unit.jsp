<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true" tabs="true" richinput="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.organize.ouinfo"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.organize.ouinfo"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="organize/ouInfoAction" defaultTB="editForm">
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="organize/ouInfoAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.mdu.organize.ouinfo.unit"/></div>
			<div class="oz-form-fields">
				<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:800px;table-layout:fixed;border-top-width:0px">
					<tr class="oz-form-locate-tr">
						<td width="11%" style="border-left:1px solid white;border-right:0px solid white"></td>
						<td width="20%" style="border-right:0px solid white"></td>
						<td width="11%" style="border-right:0px solid white"></td>
						<td width="20%" style="border-right:0px solid white"></td>
						<td width="11%" style="border-right:0px solid white"></td>						
						<td width="27%" style="border-right:1px solid white;"></td>
					</tr>
					<tr class="oz-form-tr"> 
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.ouinfo.fields.parent"/>：</td>
						<td class="oz-property" colspan="5">
							<html:text property="parent.fullName" styleId="parentFullName" styleClass="oz-form-zdField" readonly="true" style="width:590px"/>
							<oz:linkButton onclick="OZ.Organize.selectUnit(onAfterSelectUnit)" text="oz.btn.select"></oz:linkButton>
							<oz:linkButton onclick="onBtnClearParent_Clicked()" text="oz.clear"></oz:linkButton>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.ouinfo.fields.name"/>：</td>
						<td class="oz-property" colspan="3">
							<html:text property="name" styleClass="oz-form-btField"/>
						</td>
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.ouinfo.fields.abbrname"/>：</td>
						<td class="oz-property">
							<html:text property="abbrName" styleClass="oz-form-field"/>
						</td> 
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.ouinfo.fields.code"/>：</td>
						<td class="oz-property">
							<html:text property="code" styleClass="oz-form-field"/>
						</td> 
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.ouinfo.fields.orderno"/>：</td>
						<td class="oz-property">
							<html:text property="orderNo" styleClass="oz-form-field"/>
						</td>
						<td class="oz-form-label-r">
							<div class="ou-type">
								<oz:messageSource code="oz.mdu.organize.ouinfo.fields.unittype"/>：
							</span>
						</td>
						<td class="oz-property">
							<div class="ou-type">
								<html:select property="type" styleId="type" styleClass="oz-form-field">
									<html:optionsCollection name="typeOptions" label="name" value="value" />
								</html:select>
							</div>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.cfg.status"/>：</td>
						<td>
							<html:radio property="status" value="0"/><oz:messageSource code="oz.enable"/>
							<html:radio property="status" value="1"/><oz:messageSource code="oz.disable"/>
						</td> 
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.ouinfo.fields.istemporary.unit"/>：</td>
						<td>
							<html:radio property="tmpOUInfo" value="Y"/><oz:messageSource code="oz.yes"/>
							<html:radio property="tmpOUInfo" value="N"/><oz:messageSource code="oz.no"/>
						</td>
						<td class="oz-form-label-r">
							<div class="ou-validitydate">
								<oz:messageSource code="oz.validitydate"/>：
							</div>	
						</td>
						<td>
							<div class="ou-validitydate">
								<html:text property="validityStartDateTime" styleId="validityStartDateTime" styleClass="oz-form-field oz-dateField" style="width:95px"/>
								-
								<html:text property="validityEndDateTime" styleId="validityEndDateTime" styleClass="oz-form-field oz-dateField" style="width:95px"/>
							</div>	
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.ouinfo.fields.defaultrole"/>：</td>
						<td class="oz-property" colspan="3">
							<html:select property="defaultRoleId" styleId="defaultRoleId" styleClass="oz-form-field">
								<html:option value=""></html:option>
								<html:optionsCollection name="roleOptions" label="name" value="value" />
							</html:select>
						</td> 
						<td class="oz-form-label-r"></td>
						<td>
						</td>
					</tr>
					<tr class="oz-form-tr"> 
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.ouinfo.fields.unit.address"/>：</td>
						<td class="oz-property" colspan="3">
							<html:text property="address" styleClass="oz-form-field"/>
						</td>
						<td class="oz-form-label-r"><oz:messageSource code="oz.zipcode"/>：</td>
						<td class="oz-property">
							<html:text property="zipCode" styleClass="oz-form-field"/>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.email"/>：</td>
						<td class="oz-property" colspan="3">
							<html:text property="email" styleClass="oz-form-field"/>
						</td> 
						<td class="oz-form-label-r"><oz:messageSource code="oz.telephone"/>：</td>
						<td class="oz-property">
							<html:text property="telephone" styleClass="oz-form-field"/>
						</td>
					</tr>
					<tr class="oz-form-tr"> 
						<td class="oz-form-topLabel-r"><oz:messageSource code="oz.memos"/>：</td>
						<td class="oz-property" colspan="5">
							<html:textarea property="memos" styleClass="oz-form-field" rows="3"/>
						</td>
					</tr>
				</table>			
			</div>
			<div class="oz-form-tabs">
				<div id="tabCt" class="border" data-tabs='{"height":290}' style="border-width:0px;background-color: transparent;">
					<div data-tab-panel='{"id":"tab_01","title":"<oz:messageSource code="oz.mdu.organize.ouinfo.tabs.oumanagers"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<iframe id="IFRAME_01" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" src="<oz:contextPath/>/organize/ouManagerAction.do?action=display&editFlag=y&ouId=<%= request.getAttribute("ouId") %>">
						</iframe>
					</div>
					<div data-tab-panel='{"id":"tab_04","title":"<oz:messageSource code="oz.mdu.organize.ouinfo.tabs.departments"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<iframe id="IFRAME_04" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" src="<oz:contextPath/>/organize/ouInfoAction.do?action=display&viewType=ByOU&editFlag=y&ouId=<%= request.getAttribute("ouId") %>">
						</iframe>
					</div>
					<div data-tab-panel='{"id":"tab_02","title":"<oz:messageSource code="oz.mdu.organize.ouinfo.tabs.groups"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<iframe id="IFRAME_02" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" src="<oz:contextPath/>/organize/groupAction.do?action=display&viewType=ByOU&editFlag=y&ouId=<%= request.getAttribute("ouId") %>">
						</iframe>
					</div>
					<div data-tab-panel='{"id":"tab_03","title":"<oz:messageSource code="oz.mdu.organize.ouinfo.tabs.userinfos"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<iframe id="IFRAME_03" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" src="<oz:contextPath/>/organize/userInfoAction.do?action=display&viewType=ByOU&editFlag=y&ouId=<%= request.getAttribute("ouId") %>">
						</iframe>
					</div>
				</div>	
			</div>
			<html:hidden property="id" styleId="id"/><html:hidden property="parentUnit.id" styleId="parentUnitId"/>
			<html:hidden property="parent.id" styleId="parentId"/><html:hidden property="parent.fullName" styleId="parentFullName"/>
			<html:hidden property="ouType" styleId="ouType"/><html:hidden property="parent.name" styleId="parentName"/>
			<html:hidden property="namePinYin" styleId="namePinYin"/><html:hidden property="rank" styleId="rank"/>
			<html:hidden property="code" styleId="code"/>
		</html:form>
	</div>
</body>
<oz:organizeJs></oz:organizeJs>
<oz:js/>
<script type="text/javascript">
function onAfterSelectUnit(result){
	if(result.id == $("#id").val()){
		OZ.Msg.info('<oz:messageSource code="oz.mdu.organize.ouinfo.msg.parent.canbe.self"/>');
		return false;
	}else{
		$("#parentId").val(result.id);
		$("#parentName").val(result.name);
		$("#parentFullName").val(result.fullName);
		return true;
	}
}

function onBtnClearParent_Clicked(){
	$("#parentId").val("");
	$("#parentName").val("");
	$("#parentFullName").val("");
}

function onBtnSave_Clicked(){
	var id = $("#id").val();
	if(id == -1){
		ozTB_DefaultBtnSave_Clicked(contextPath + "/organize/ouInfoAction.do");
	}else{
		ozTB_DefaultBtnSaveByAjax_Clicked(contextPath + "/organize/ouInfoAction.do");
	}
}

function refresh(data){
	var tabType = data.data;
	if(tabType == "group"){
		var iframeObj = $("#IFRAME_02").get(0);
		iframeObj.src = contextPath + "/organize/groupAction.do?action=display&viewType=ByOU&editFlag=y&ouId=" + $("#id").val();
	}else if(tabType == "userInfo"){
		var iframeObj = $("#IFRAME_03").get(0);
		iframeObj.src = contextPath + "/organize/userInfoAction.do?action=display&viewType=ByOU&editFlag=y&ouId=" + $("#id").val();
	}else if(tabType == "ouInfo"){
		var iframeObj = $("#IFRAME_04").get(0);
		iframeObj.src = contextPath + "/organize/ouInfoAction.do?action=display&viewType=ByOU&editFlag=y&ouId=" + $("#id").val();
	}
}

$(function(){
	$("#tabCt").tabs();
	$("#tabCt").tabs("activeTab","tab_01");

	// 控制类型是否显示
	var isCanUsedType = "<%= request.getAttribute("isCanUsedType") %>";
	if(isCanUsedType == "n" || isCanUsedType == "N"){
		$(".ou-type").hide();
	} 
});
</script>
</html>