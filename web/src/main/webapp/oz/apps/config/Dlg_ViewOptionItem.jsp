<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.config.optionitem"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.config.optionitem"/>">
	<html:form action="config/optionItemAction.do" styleId="ozForm">
		<div class="oz-form-title" style="width:100%;padding:0px;text-align:center;height:32px;"><oz:messageSource code="oz.config.optionitem"/></div>
		<div class="oz-form-fields" style="margin:4px;">
			<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:100%;margin:0;">
				<tr class="oz-form-tr">
					<td width="80px" class="oz-form-label-r"><oz:messageSource code="oz.config.optionitem.fields.name"/>：</td>
					<td class="oz-property">							
						${OZ_DOMAIN.name}
					</td>
				</tr>
				<tr class="oz-form-tr">
					<td class="oz-form-label-r"><oz:messageSource code="oz.config.optionitem.fields.value"/>：</td>
					<td class="oz-property">
						${OZ_DOMAIN.value}
					</td>
				</tr>
				<tr class="oz-form-tr">
                	<td class="oz-form-label-r"><oz:messageSource code="oz.config.optionitem.fields.orderno"/>：</td>
                    <td class="oz-property">
                    	${OZ_DOMAIN.orderNo}
					</td>
				</tr>
				<tr class="oz-form-tr">
					<td class="oz-form-label-r"><oz:messageSource code="oz.config.optionitem.fields.defaultflag"/>：</td>
					<td>
						${OZ_DOMAIN.defaultFlagTitle}
					</td>
				</tr>
			</table>			
		</div>
		<html:hidden property="id" styleId="id"/><html:hidden property="unitId" styleId="unitId"/>
		<html:hidden property="groupCode" styleId="groupCode"/><html:hidden property="groupName" styleId="groupName"/>
		<html:hidden property="lastModifier.name" styleId="lastModifier.name"/>
		<html:hidden property="lastModifier.id" styleId="lastModifier.id"/>
		<html:hidden property="lastModifiedDate" styleId="lastModifiedDate"/>
	</html:form>
</body>
<oz:js/>
</html>