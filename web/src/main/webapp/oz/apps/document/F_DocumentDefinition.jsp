<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true" tabs="true" select="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.document.documentdefinition"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.document.documentdefinition"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="document/documentDefAction">
			<oz:tbSeperator/>
			<oz:tbButton id="btnBack"/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="document/documentDefAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.mdu.document.documentdefinition"/></div>
			<div class="oz-form-fields">
				<table cellpadding="0">
					<tr class="oz-form-emptyTR"> 
						<td width="120"></td>
						<td width="380"></td>
						<td width="120"></td>
						<td width="180"></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.dd.fields.classified"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="documentDefinitionForm" property="classified"/></span>
						</td>
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.dd.fields.filetype"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="documentDefinitionForm" property="fileType"/></span>
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.dd.fields.name"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="documentDefinitionForm" property="name"/></span>
						</td>
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.dd.fields.code"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="documentDefinitionForm" property="code"/></span>
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.dd.fields.orderno"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="documentDefinitionForm" property="orderNo"/></span>
						</td>
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.dd.fields.status"/>：</td>
						<td>
							<html:radio property="enable" styleId="enable" value="true" disabled="true"/><oz:messageSource code="oz.enable"/>
							<html:radio property="enable" styleId="enable" value="false" disabled="true"/><oz:messageSource code="oz.disable"/>
						</td>
					</tr>
					<tr>
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.dd.fields.process"/>：</td>
						<td colspan="3">
							<html:text property="processName" styleClass="oz-form-zdField" readonly="true" style="width:612px;float:left"/>
							<button id="btnViewProcess" type="button" class="oz-form-button" style="width:62px;height:21px;float:right;" onclick="onBtnViewProcess_Clicked()" ><oz:messageSource code="oz.mdu.document.dd.buttons.viewprocess"/></button>
						</td>
					</tr>					
					<tr>
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.dd.fields.form"/>：</td>
						<td colspan="3">
							<html:text property="formName" styleClass="oz-form-zdField" readonly="true" style="width:612px;float:left"/>
							<button id="btnViewForm" type="button" class="oz-form-button" style="width:62px;height:21px;float:right;" onclick="onBtnViewForm_Clicked()" ><oz:messageSource code="oz.mdu.document.dd.buttons.viewform"/></button>
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.dd.fields.used.acl"/>：</td>
						<td class="oz-property" colspan="3">
							<oz:acl id="aclUsed" entityClazz="cn.oz.module.document.def.domain.DocumentDefinition" permissionMask="2" style="width:612px;float:left;" readOnly="true"></oz:acl>
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.dd.fields.view.acl"/>：</td>
						<td class="oz-property" colspan="3">
							<oz:acl id="aclView" entityClazz="cn.oz.module.document.def.domain.DocumentDefinition" permissionMask="4" style="width:612px;float:left;" readOnly="true"></oz:acl>
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.dd.fields.admin.acl"/>：</td>
						<td class="oz-property" colspan="3">
							<oz:acl id="aclAdmin" entityClazz="cn.oz.module.document.def.domain.DocumentDefinition" permissionMask="1" style="width:612px;float:left;" readOnly="true"></oz:acl>
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.dd.fields.description"/>：</td>
						<td class="oz-property" colspan="3">
							<span class="oz-form-fields-span"><bean:write name="documentDefinitionForm" property="description"/></span>
						</td>
					</tr>
				</table>			
			</div>
			<div class="oz-form-tabs">
				<div id="tabCt" class="border" data-tabs='{"height":360}' style="border-width:0px;background-color: transparent;">
					<div data-tab-panel='{"id":"tab_02","title":"<oz:messageSource code="oz.mdu.document.dd.tabs.relateds"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<iframe id="IFRAME_02" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" src="<oz:contextPath/>/document/documentDefAction.do?action=display&viewType=related&editFlag=n&&ddId=<%= request.getAttribute("OZ_DOMAIN_ID") %>">
						</iframe>
					</div>
					<div data-tab-panel='{"id":"tab_03","title":"<oz:messageSource code="oz.mdu.document.dd.tabs.mapping"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<iframe id="IFRAME_03" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" src="<oz:contextPath/>/organize/userInfoAction.do?action=display&viewType=ByOU&editFlag=y&ouId=<%= request.getAttribute("ouId") %>">
						</iframe>
					</div>
				</div>	
			</div>
			<html:hidden property="id" styleId="id"/><html:hidden property="uuid" styleId="uuid"/>
			<html:hidden property="author.id" styleId="author.id"/><html:hidden property="author.name" styleId="author.name"/>
			<html:hidden property="createdDateTime" styleId="createdDateTime"/><html:hidden property="IS_ENABLE" styleId="IS_ENABLE"/>
			<html:hidden property="processCfg.id" styleId="processCfg_id"/><html:hidden property="formCfg.id" styleId="formCfg_id"/>
			<html:hidden property="adminAclFlag" styleId="adminAclFlag"/><html:hidden property="usedAclFlag" styleId="usedAclFlag"/>
			<html:hidden property="viewAclFlag" styleId="viewAclFlag"/><html:hidden property="unitId" styleId="unitId"/>
			<html:hidden property="hideRights" styleId="hideRights"/>
		</html:form>
	</div>
</body>
<oz:js/>
<script type="text/javascript">

function getOzEntityId(){
	var entityId = $("#id").val();
	if(null == entityId || entityId.length == 0 || entityId == "-1"){
		entityId = $("#uuid").val(); 
	}
	return entityId;
}

function checkVersion(){
	if($("#formKey").val()=="" || $("#processKey").val()==""){
		return;
	}
	var dlgUrl = contextPath + "/documentDefinitionAction.do?action=getVersion&loadRight=true&timeStamp=" + new Date().getTime();
	$.getJSON(dlgUrl,{id:$("#id").val(),form:$("#formKey").val(),process:$("#processKey").val()},function(json){
		if(json.result){
			$("#v_id").val(json.id);		
		}else{
			$("#v_id").val("-1");	
		}
	})
}

$(function(){
	$("#tabCt").tabs();
	$("#tabCt").tabs("activeTab","tab_02");

	// bingding事件
	$("#dstatus").change(function(){
		if(this.selectedIndex==-1)return;
		assignRight(this.value);
	});
});
</script>
</html>