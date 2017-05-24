<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.config.configitem"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.config.configitem"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="config/configItemAction">
			<oz:tbSeperator/>
			<oz:tbButton id="btnBack"/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="config/configItemAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.config.configitem"/></div>
			<div class="oz-form-fields">
				<table cellpadding="0">
					<tr class="oz-form-emptyTR"> 
						<td width="120"></td>
						<td width="480"></td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.config.configitem.fields.key"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="configItemFrom" property="key"/></span>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.config.configitem.fields.value"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="configItemFrom" property="value"/></span>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-topLabel"><oz:messageSource code="oz.config.configitem.fields.description"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="configItemFrom" property="description"/></span>
						</td>
						<td></td>
					</tr>
				</table>			
			</div>
			<html:hidden property="id" styleId="id"/><html:hidden property="unitId" styleId="unitId"/>
			<html:hidden property="key" styleId="key"/><html:hidden property="value" styleId="value"/>
			<html:hidden property="description" styleId="description"/>
			<html:hidden property="lastModifier.name" styleId="lastModifier.name"/>
			<html:hidden property="lastModifier.id" styleId="lastModifier.id"/>
			<html:hidden property="lastModifiedDate" styleId="lastModifiedDate"/>
		</html:form>
	</div>
</body>
<oz:js/>
</html>