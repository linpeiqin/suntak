<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.web.schedulejob"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssId="oz-app-icon"/> 
</head>
<body data-name="<oz:messageSource code="oz.web.schedulejob"/>">
	<html:form action="app/scheduleJobAction.do" styleId="ozForm" styleClass="oz-form">
		<div class="oz-form-title" style="width:100%;padding:0px;text-align:center;height:32px;"><oz:messageSource code="oz.web.schedulejob"/></div>
		<div class="oz-form-fields" style="margin:4px;">
			<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:100%;margin:0;">			
				<tr class="oz-form-tr">
					<td width="100px" class="oz-form-label-r"><oz:messageSource code="oz.web.schedulejob.fields.name"/>：</td>
					<td class="oz-property">
						${scheduleJob.name}
					</td>
				</tr>
				<tr class="oz-form-tr">
					<td class="oz-form-label-r"><oz:messageSource code="oz.web.schedulejob.fields.code"/>：</td>
					<td class="oz-property">
						${scheduleJob.code}
					</td>
				</tr>
				<tr class="oz-form-tr">
					<td class="oz-form-label-r"><oz:messageSource code="oz.web.schedulejob.fields.beanname"/>：</td>
					<td class="oz-property">
						${scheduleJob.beanName}
					</td>
				</tr>
				<tr class="oz-form-tr">
					<td class="oz-form-label-r"><oz:messageSource code="oz.web.schedulejob.fields.fields.cronexpression"/>：</td>
					<td class="oz-property">
						${scheduleJob.cronExpression}
					</td>
				</tr>
				<tr class="oz-form-tr">
					<td class="oz-form-label-r"><oz:messageSource code="oz.web.schedulejob.fields.enable"/>：</td>
					<td>
						<c:if test="${scheduleJob.enable}">
							<oz:messageSource code="oz.enable"/>
						</c:if>
						<c:if test="${!scheduleJob.enable}">
							<oz:messageSource code="oz.disable"/>
						</c:if>
					</td>
				</tr>
				<tr class="oz-form-tr">
					<td class="oz-form-topLabel-r"><oz:messageSource code="oz.web.schedulejob.fields.description"/>：</td>
					<td class="oz-property">
						${scheduleJob.description}
					</td>
				</tr>
			</table>
			<%@ include file="SF_SchedulingJob.jsp" %>
		</div>	
		<html:hidden property="code" styleId="code"/>
	</html:form>
</body>
<oz:js/>
<script type="text/javascript">

</script>
</html>