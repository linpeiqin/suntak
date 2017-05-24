<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.web.strategy"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssId="oz-app-icon"/> 
</head>
<body data-name="<oz:messageSource code="oz.web.strategy"/>">
	<html:form action="app/strategyAction.do" styleId="ozForm" styleClass="oz-form">
		<div class="oz-form-title" style="width:100%;padding:0px;text-align:center;height:32px;"><oz:messageSource code="oz.web.strategy"/></div>
		<div class="oz-form-fields" style="margin:4px;">
			<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:100%;margin:0;">
				<tr class="oz-form-tr">
					<td width="20%" class="oz-form-label-r"><oz:messageSource code="oz.web.strategy.fields.code"/>：</td>
					<td width="80%" class="oz-property">
						${strategy.code}
					</td>
				</tr>
				<tr class="oz-form-tr">
					<td class="oz-form-label-r"><oz:messageSource code="oz.web.strategy.fields.name"/>：</td>
					<td class="oz-property">
						${strategy.name}
					</td>
				</tr>
				<tr class="oz-form-tr">
					<td class="oz-form-label-r"><oz:messageSource code="oz.web.strategy.fields.value"/>：</td>
					<td class="oz-property">
						${strategy.valueTitle}
					</td>
				</tr>
				<tr class="oz-form-tr">
					<td class="oz-form-label-r"><oz:messageSource code="oz.web.uicomponent.fields.description"/>：</td>
					<td class="oz-property">
						${strategy.description}
					</td>
				</tr>
			</table>
		</div>	
		<html:hidden property="code" styleId="code"/>
		<html:hidden property="type" styleId="type"/>
	</html:form>
</body>
<oz:js/>
<script type="text/javascript">

</script>
</html>