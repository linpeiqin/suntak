<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.config.optiongroup"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.config.optiongroup"/>">
	<html:form action="config/optionGroupAction.do" styleId="ozForm">
		<div class="oz-form-title" style="width:100%;padding:0px;text-align:center;height:32px;"><oz:messageSource code="oz.config.optiongroup"/></div>
		<div class="oz-form-fields" style="margin:4px;">
			<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:100%;margin:0;">
				<tr class="oz-form-tr">
					<td width="90px" class="oz-form-label-r"><oz:messageSource code="oz.config.optiongroup.fields.name"/>：</td>
					<td class="oz-property">
						${OZ_DOMAIN.name}
					</td>
				</tr>
				<tr class="oz-form-tr">
					<td class="oz-form-label-r"><oz:messageSource code="oz.config.optiongroup.fields.code"/>：</td>
					<td class="oz-property">
						${OZ_DOMAIN.code}
					</td>
				</tr>
				<tr class="oz-form-tr">
					<td class="oz-form-label-r"><oz:messageSource code="oz.config.optiongroup.fields.editable"/>：</td>
					<td>
						${OZ_DOMAIN.editableFlagTitle}
					</td>
				</tr>
				<tr class="oz-form-tr">
					<td class="oz-form-label-r"><oz:messageSource code="oz.cfg.management.type"/>：</td>
					<td>
						${OZ_DOMAIN.managementTypeTitle}
					</td>
				</tr>
				<tr class="oz-form-tr">
					<td class="oz-form-label-r"><oz:messageSource code="oz.inner.cfg.flag"/>：</td>
					<td>
						${OZ_DOMAIN.innerFlagTitle}
					</td>
				</tr>
				<tr class="oz-form-tr">
					<td class="oz-form-label-r"><oz:messageSource code="oz.memos"/>：</td>
					<td class="oz-property">
						${OZ_DOMAIN.memos}
					</td>
				</tr>
			</table>			
		</div>
		<html:hidden property="id" styleId="id"/>
		<html:hidden property="innerFlag" styleId="innerFlag"/>
	</html:form>
</body>
<oz:js/>
</html>