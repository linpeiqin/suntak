<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.config.schedulingjob"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.config.schedulingjob"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="config/schedulingJobAction">
			<oz:tbSeperator/>
			<oz:tbButton id="btnBack"/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="config/schedulingJobAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.config.schedulingjob"/></div>
			<div class="oz-form-fields" style="margin:4px;">
				<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:100%;margin:0;">
					<tr class="oz-form-tr">
						<td width="120px" class="oz-form-label-r"><oz:messageSource code="oz.config.schedulingjob.fields.name"/>：</td>
						<td class="oz-property">
							${OZ_DOMAIN.name}
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.config.schedulingjob.fields.jobid"/>：</td>
						<td class="oz-property">
							${OZ_DOMAIN.jobId}
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.config.schedulingjob.fields.jobgroup"/>：</td>
						<td class="oz-property">
							${OZ_DOMAIN.jobGroup}
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.config.schedulingjob.fields.cronexpression"/>：</td>
						<td class="oz-property">
							${OZ_DOMAIN.cronExpression}
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.config.schedulingjob.fields.status"/>：</td>
						<td>
							<c:if test="${OZ_DOMAIN.jobStatus =='0'}">
								<oz:messageSource code="oz.enable"/>
							</c:if>
							<c:if test="${OZ_DOMAIN.jobStatus =='1'}">
								<oz:messageSource code="oz.disable"/>
							</c:if>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-topLabel-r"><oz:messageSource code="oz.config.schedulingjob.fields.description"/>：</td>
						<td class="oz-property">
							${OZ_DOMAIN.description}
						</td>
					</tr>
				</table>
				<%@ include file="SF_SchedulingJob.jsp" %>
			</div>
			<html:hidden property="id" styleId="id"/><html:hidden property="unitId" styleId="unitId"/>
			<html:hidden property="name" styleId="name"/><html:hidden property="jobId" styleId="jobId"/>
			<html:hidden property="jobGroup" styleId="jobGroup"/><html:hidden property="description" styleId="description"/>
			<html:hidden property="cronExpression" styleId="cronExpression"/>
			<html:hidden property="lastModifier.name" styleId="lastModifier.name"/>
			<html:hidden property="lastModifier.id" styleId="lastModifier.id"/>
			<html:hidden property="lastModifiedDate" styleId="lastModifiedDate"/>
		</html:form>
	</div>
</body>
<oz:js/>
</html>