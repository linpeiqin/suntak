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
		<oz:toolbar action="organize/ouInfoAction">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack" text="返回"></oz:tbButton>
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
							<span class="oz-form-fields-span"><bean:write name="ouInfoForm" property="parent.fullName"/></span>
						</td>
					</tr>
					<tr class="oz-form-tr"> 
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.ouinfo.fields.name"/>：</td>
						<td class="oz-property" colspan="3">
							<span class="oz-form-fields-span"><bean:write name="ouInfoForm" property="name"/></span>
						</td>
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.ouinfo.fields.abbrname"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="ouInfoForm" property="abbrName"/></span>
						</td>
					</tr>
					<tr class="oz-form-tr"> 
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.ouinfo.fields.code"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="ouInfoForm" property="code"/></span>
						</td> 
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.ouinfo.fields.orderno"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="ouInfoForm" property="orderNo"/></span>
						</td>
						<td class="oz-form-label-r">
							<div class="ou-type">
								<oz:messageSource code="oz.mdu.organize.ouinfo.fields.unittype"/>：
							</span>
						</td>
						<td class="oz-property">
							<div class="ou-type">
								<html:select property="type" styleId="type" styleClass="oz-form-zdField" disabled="true">
									<html:optionsCollection name="typeOptions" label="name" value="value" />
								</html:select>
							</div>
						</td>
					</tr>
					<tr class="oz-form-tr"> 
						<td class="oz-form-label-r"><oz:messageSource code="oz.cfg.status"/>：</td>
						<td>
							<c:if test="${OZ_DOMAIN.status == '0'}">
								<span class="oz-form-fields-span"><oz:messageSource code="oz.enable"/></span>
							</c:if>
							<c:if test="${OZ_DOMAIN.status == '1'}">
								<span class="oz-form-fields-span"><oz:messageSource code="oz.disable"/></span>
							</c:if>
						</td> 
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.ouinfo.fields.istemporary.unit"/>：</td>
						<td>
							<c:if test="${OZ_DOMAIN.tmpOUInfo == 'Y'}">
								<span class="oz-form-fields-span"><oz:messageSource code="oz.yes"/></span>
							</c:if>
							<c:if test="${OZ_DOMAIN.tmpOUInfo == 'N'}">
								<span class="oz-form-fields-span"><oz:messageSource code="oz.no"/></span>
							</c:if>
						</td>
						<td class="oz-form-label-r">
							<div class="ou-validitydate">
								<oz:messageSource code="oz.validitydate"/>：
							</div>	
						</td>
						<td>
							<div class="ou-validitydate">
								<bean:write name="ouInfoForm" property="validityStartDateTime"/>
								-
								<bean:write name="ouInfoForm" property="validityEndDateTime"/>
							</div>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.ouinfo.fields.defaultrole"/>：</td>
						<td class="oz-property" colspan="3">
							<html:select property="defaultRoleId" styleId="defaultRoleId" styleClass="oz-form-field" disabled="true">
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
							<span class="oz-form-fields-span"><bean:write name="ouInfoForm" property="address"/></span>
						</td>
						<td class="oz-form-label-r"><oz:messageSource code="oz.zipcode"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="ouInfoForm" property="zipCode"/></span>
						</td>
					</tr>
					<tr class="oz-form-tr"> 
						<td class="oz-form-label-r"><oz:messageSource code="oz.email"/>：</td>
						<td class="oz-property" colspan="3">
							<span class="oz-form-fields-span"><bean:write name="ouInfoForm" property="email"/></span>
						</td> 
						<td class="oz-form-label-r"><oz:messageSource code="oz.telephone"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="ouInfoForm" property="telephone"/></span>
						</td>
					</tr>
					<tr class="oz-form-tr"> 
						<td class="oz-form-topLabel-r"><oz:messageSource code="oz.memos"/>：</td>
						<td class="oz-property" colspan="5">
							<span class="oz-form-fields-span"><bean:write name="ouInfoForm" property="memos"/></span>
						</td>
					</tr>
				</table>			
			</div>
			<div class="oz-form-tabs">
				<div id="tabCt" class="border" data-tabs='{"height":290}' style="border-width:0px;background-color: transparent;">
					<div data-tab-panel='{"id":"tab_01","title":"<oz:messageSource code="oz.mdu.organize.ouinfo.tabs.oumanagers"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<iframe id="IFRAME_01" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" src="<oz:contextPath/>/organize/ouManagerAction.do?action=display&editFlag=n&ouId=<%= request.getAttribute("ouId") %>">
						</iframe>
					</div>
					<div data-tab-panel='{"id":"tab_04","title":"<oz:messageSource code="oz.mdu.organize.ouinfo.tabs.departments"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<iframe id="IFRAME_04" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" src="<oz:contextPath/>/organize/ouInfoAction.do?action=display&viewType=ByOU&editFlag=n&ouId=<%= request.getAttribute("ouId") %>">
						</iframe>
					</div>
					<div data-tab-panel='{"id":"tab_02","title":"<oz:messageSource code="oz.mdu.organize.ouinfo.tabs.groups"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<iframe id="IFRAME_02" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" src="<oz:contextPath/>/organize/groupAction.do?action=display&viewType=ByOU&editFlag=n&ouId=<%= request.getAttribute("ouId") %>">
						</iframe>
					</div>
					<div data-tab-panel='{"id":"tab_03","title":"<oz:messageSource code="oz.mdu.organize.ouinfo.tabs.userinfos"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<iframe id="IFRAME_03" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" src="<oz:contextPath/>/organize/userInfoAction.do?action=display&viewType=ByOU&editFlag=n&ouId=<%= request.getAttribute("ouId") %>">
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
<oz:js/>
<script type="text/javascript">
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
	if(isCanUsedType == "n" || isCanUsedGroupType == "N"){
		$(".ou-type").hide();
	} 
});
</script>
</html>