<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.config.policy"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.config.policy"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="config/policyAction" defaultTB="editForm">
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="config/policyAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.config.policy"/></div>
			<div class="oz-form-fields">
				<table cellpadding="0" cellspacing="4">
					<tr class="oz-form-emptyTR"> 
						<td width="120"></td>
						<td width="480"></td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.config.policy.fields.code"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="policyForm" property="code"/></span>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.config.policy.fields.subject"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="policyForm" property="subject"/></span>
						</td>
						<td></td>
					</tr>
					<tr id="TR_VALUE_INPUT"> 
						<td class="oz-form-label"><oz:messageSource code="oz.config.policy.fields.policyvalue"/>：</td>
						<td class="oz-property">
							<html:text property="policyValue" styleId="policyValue" styleClass="oz-form-btField"/>
						</td>
						<td></td>
					</tr>
					<tr id="TR_VALUE_SELECT"> 
						<td class="oz-form-label"><oz:messageSource code="oz.config.policy.fields.policyvalue"/>：</td>
						<td class="oz-property">
							<oz:select value="curValue" property="selectPolicyValue" options="values" onchange="onPolicyValue_changed()"></oz:select>
						</td>
						<td></td>
					</tr>
				</table>			
			</div>
			<html:hidden property="id" styleId="id"/><html:hidden property="unitId" styleId="unitId"/>
			<html:hidden property="code" styleId="code"/><html:hidden property="subject" styleId="subject"/>
			<html:hidden property="type" styleId="type"/>
			<html:hidden property="optionNames" styleId="optionNames"/>
			<html:hidden property="optionValus" styleId="optionValus"/>
			<html:hidden property="lastModifier.name" styleId="lastModifier.name"/>
			<html:hidden property="lastModifier.id" styleId="lastModifier.id"/>
			<html:hidden property="lastModifiedDate" styleId="lastModifiedDate"/>
		</html:form>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function onPolicyValue_changed(){
	$("#policyValue").val($("#selectPolicyValue").val());
}

//初始化
jQuery(function($){
	if($("#type").val() == "select"){
		$("#TR_VALUE_SELECT").show();
		$("#TR_VALUE_INPUT").hide();
	}else{
		$("#TR_VALUE_SELECT").hide();
		$("#TR_VALUE_INPUT").show();
	}
});
</script>
</html>