<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.portalmgm.constants.layout"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.portalmgm.constants.layout"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="module/layoutAction" defaultTB="editForm">
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="module/layoutAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.portalmgm.constants.layoutmgm"/></div>
			<div class="oz-form-fields">
				<table cellpadding="0">
					<tr class="oz-form-emptyTR"> 
						<td width="120"></td>
						<td width="480"></td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.portalmgm.layout.fields.name"/>：</td>
						<td class="oz-property">
							<html:text property="name" styleClass="oz-form-btField"/>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.portalmgm.layout.fields.iconclazz"/>：</td>
						<td class="oz-property">
							<html:text property="iconClazz" styleClass="oz-form-btField"/>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.portalmgm.layout.fields.status"/>：</td>
						<td>
							<html:radio property="status" styleId="status" value="0"/><oz:messageSource code="oz.enable"/>&nbsp;&nbsp;
							<html:radio property="status" styleId="status" value="1"/><oz:messageSource code="oz.disable"/>&nbsp;&nbsp;
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-topLabel"><oz:messageSource code="oz.portalmgm.layout.fields.htmldom"/>：</td>
						<td class="oz-property">
							<html:textarea property="htmlDom" styleClass="oz-form-field" rows="12" style="width:100%;height:350px;" cols="80"></html:textarea>
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