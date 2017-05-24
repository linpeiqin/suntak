<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.businesshours.holiday"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.businesshours.holiday"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="module/holidayAction">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack" text="返回"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="module/holidayAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.mdu.businesshours.holiday"/></div>
			<div class="oz-form-fields">
				<table cellpadding="0" cellspacing="4">
					<tr class="oz-form-emptyTR"> 
						<td width="120"></td>
						<td width="480"></td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.businesshours.holiday.fields.name"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="holidayForm" property="name"/></span>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.businesshours.holiday.fields.isworkday"/>：</td>
						<td>
							<html:radio property="workDay" styleId="workDay" value="N" disabled="true"/><oz:messageSource code="oz.mdu.businesshours.holiday.holiday"/>
							<html:radio property="workDay" styleId="workDay" value="Y" disabled="true"/><oz:messageSource code="oz.mdu.businesshours.holiday.workday"/>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.businesshours.holiday.fields.holidaydate"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="holidayForm" property="holidayDateTime"/></span>
						</td>
						<td></td>
					</tr>
				</table>			
			</div>
			<html:hidden property="id" styleId="id"/>
		</html:form>
	</div>
</body>
<oz:js/>
</html>