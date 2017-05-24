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
		<oz:toolbar action="config/schedulingJobAction" defaultTB="editForm">
			<oz:tbSeperator/>
			<oz:tbButton id="btnExecute" text="立即运行" icon="oz-icon-0139" onclick="onBtnExecute_Clicked()"></oz:tbButton>
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
							<html:text property="cronExpression" styleId="cronExpression" styleClass="oz-form-btField"/>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.config.schedulingjob.fields.status"/>：</td>
						<td>
							<html:radio property="jobStatus" value="0"/><oz:messageSource code="oz.enable"/>&nbsp;&nbsp;&nbsp;&nbsp;
							<html:radio property="jobStatus" value="1"/><oz:messageSource code="oz.disable"/>
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
			<html:hidden property="lastModifier.name" styleId="lastModifier.name"/>
			<html:hidden property="lastModifier.id" styleId="lastModifier.id"/>
			<html:hidden property="lastModifiedDate" styleId="lastModifiedDate"/>
		</html:form>
	</div>
</body>
<oz:js/>
<script type="text/javascript" language="javascript">
function onBtnSave_Clicked(){
	var cronExpression = $("#cronExpression").val();
	if(null == cronExpression || cronExpression.length == 0){
		OZ.Msg.info('<oz:messageSource code="oz.config.schedulingjob.msg.cronexpress.is.null"/>');
		return;
	}
	
	var strUrl = contextPath + "/config/schedulingJobAction.do?action=updateScheduling&timeStamp=" + new Date().getTime();
	var data = 
	$.ajax({
		type: "POST", dataType: "json", url: strUrl,
		data: {id:$("#id").val(), cronExpression:cronExpression, status:$("input[name='jobStatus']:checked").val()},
		success: function(json, _status){
			OZ.Msg.slide(json.msg);
		},
		error: function(xhr, errorMsg, errorThrown){
			OZ.Msg.info('<oz:messageSource code="oz.core.exception.save.unknown"/>');
		}
	});
}

function onBtnExecute_Clicked(){
	OZ.Msg.confirm(
		'您确认要立即执行该任务吗？',
		function(){
			$.post(
				contextPath + "/config/schedulingJobAction.do?action=executeJob&timeStamp=" + new Date().getTime(), 
				{id:$("#id").val()},
				function(json){
					if(json.result === true){				
						OZ.Msg.info('执行成功');
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			, "json");	
		}
	);
}
</script>
</html>