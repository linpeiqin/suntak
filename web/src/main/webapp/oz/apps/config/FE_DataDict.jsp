<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" formValidator="true"/>
<head>
	<title><oz:messageSource code="oz.config.datadict"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.config.datadict"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="config/dataDictAction" defaultTB="editForm">
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="config/dataDictAction" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.config.datadict"/></div>
			<div class="oz-form-fields">
				<table cellpadding="0">
					<tr class="oz-form-emptyTR"> 
						<td width="120"></td>
						<td width="480"></td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.config.datadict.fields.parent"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="dataDictFrom" property="parentName"/></span>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.config.datadict.fields.defaultflag"/>：</td>
						<td>
							<html:radio property="defaultFlag" styleId="radio11" value="Y"/><label for="radio11" style="width:30px;"><oz:messageSource code="oz.yes"/></label>
							<html:radio property="defaultFlag" styleId="radio12" value="N"/><label for="radio12" style="width:30px;"><oz:messageSource code="oz.no"/></label>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.config.datadict.fields.name"/>：</td>
						<td class="oz-property">
							<html:text property="name" styleId="name" styleClass="oz-form-btField validate[required]"/>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.config.datadict.fields.value"/>：</td>
						<td class="oz-property">
							<html:text property="value" styleId="value" styleClass="oz-form-btField validate[required]"/>
						</td>
						<td></td>
					</tr>
                    <tr> 
                        <td class="oz-form-label"><oz:messageSource code="oz.config.datadict.fields.orderno"/>：</td>
                        <td class="oz-property">
                            <html:text property="orderNo" styleId="orderNo" styleClass="oz-form-btField validate[required]"/>
                        </td>
                        <td></td>
                    </tr>
				</table>			
			</div>
			<html:hidden property="id" styleId="id"/>
			<html:hidden property="parent.id" styleId="parent.id"/>
		</html:form>
	</div>
</body>
<oz:js/>
</html>