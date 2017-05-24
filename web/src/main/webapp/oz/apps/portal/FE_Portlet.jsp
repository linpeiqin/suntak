<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.portalmgm.constants.portletmgm"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.portalmgm.constants.portletmgm"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="module/portletAction" defaultTB="editForm">
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="module/portletAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.portalmgm.constants.portletmgm"/></div>
			<div class="oz-form-fields">
				<table cellpadding="0">
					<tr class="oz-form-emptyTR"> 
						<td width="120"></td>
						<td width="480"></td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.portalmgm.portlet.fields.name"/>：</td>
						<td class="oz-property">
							<html:text property="name" styleClass="oz-form-btField"/>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.portalmgm.portlet.fields.code"/>：</td>
						<td class="oz-property">
							<html:text property="code" styleClass="oz-form-btField"/>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.portalmgm.portlet.fields.status"/>：</td>
						<td>
							<html:radio property="status" styleId="status" value="0"/><oz:messageSource code="oz.enable"/>&nbsp;&nbsp;
							<html:radio property="status" styleId="status" value="1"/><oz:messageSource code="oz.disable"/>&nbsp;&nbsp;
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.portalmgm.portlet.fields.icon"/>：</td>
						<td class="oz-property">
							<html:text property="icon" styleClass="oz-form-btField"/>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.portalmgm.portlet.fields.urlpath"/>：</td>
						<td class="oz-property">
							<html:text property="urlPath" styleClass="oz-form-btField"/>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.portalmgm.portlet.fields.hrefmore"/>：</td>
						<td class="oz-property">
							<html:text property="hrefMore" styleClass="oz-form-field"/>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.portalmgm.portlet.fields.permissioncodes"/>：</td>
						<td class="oz-property">
							<html:text property="permissionCodes" styleClass="oz-form-field"/>
						</td>
						<td><oz:messageSource code="oz.portalmgm.portlet.fields.permissioncodes.memos"/></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.portalmgm.portlet.fields.showtitle"/>：</td>
						<td>
							<html:radio property="minWindow" styleId="minWindow" value="Y"/><oz:messageSource code="oz.yes"/>&nbsp;&nbsp;
							<html:radio property="minWindow" styleId="minWindow" value="N"/><oz:messageSource code="oz.no"/>&nbsp;&nbsp;
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-topLabel"><oz:messageSource code="oz.portalmgm.portlet.fields.memos"/>：</td>
						<td class="oz-property">
							<html:text property="memos" styleClass="oz-form-field"/>
						</td>
						<td></td>
					</tr>
				</table>			
			</div>
			<html:hidden property="id" styleId="id"/>
			<html:hidden property="maxWindow" styleId="maxWindow"/>
			<html:hidden property="minWindow" styleId="minWindow"/>
		</html:form>
	</div>
</body>
<oz:js/>
</html>