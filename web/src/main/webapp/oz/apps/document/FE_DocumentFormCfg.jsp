<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.mdu.document.documentformcfg"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.document.documentformcfg"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="document/documentFormCfgAction" defaultTB="editForm">
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="document/documentFormCfgAction" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.mdu.document.documentformcfg"/></div>
			<div class="oz-form-fields">
				<table cellpadding="0" cellspacing="4">
					<tr class="oz-form-emptyTR"> 
						<td width="180"></td>
						<td width="360"></td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.df.field.formname"/>：</td>
						<td class="oz-property">
							<html:text property="formName" styleClass="oz-form-btField"/>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.df.field.formkey"/>：</td>
						<td class="oz-property">
							<html:text property="formKey" styleClass="oz-form-btField"/>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.df.field.supportername"/>：</td>
						<td class="oz-property">
							<html:select property="documentFormSupporterName" styleId="documentFormSupporterName" styleClass="oz-form-btField">
								<html:optionsCollection name="supporterOptions" label="name" value="value" />
							</html:select>
						</td>
						<td></td>
					</tr>
				</table>			
			</div>
			<html:hidden property="id" styleId="id"/><html:hidden property="unitId" styleId="unitId"/>
		</html:form>
	</div>
</body>
<oz:js/>
</html>