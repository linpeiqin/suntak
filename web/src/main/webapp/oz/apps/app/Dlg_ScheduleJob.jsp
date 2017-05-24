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
						<html:text property="cronExpression" styleId="cronExpression" styleClass="oz-form-btField"/>
					</td>
				</tr>
				<tr class="oz-form-tr">
					<td class="oz-form-label-r"><oz:messageSource code="oz.web.schedulejob.fields.enable"/>：</td>
					<td>
						<html:radio property="enable" styleId="enable" value="true"/><oz:messageSource code="oz.enable"/>&nbsp;&nbsp;&nbsp;&nbsp;
						<html:radio property="enable" styleId="enable" value="false"/><oz:messageSource code="oz.disable"/>
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
var _result = null;
function ozDlgOkFn(){
	if(null == _result){
		var cronExpression = $("#cronExpression").val();
		var enable = val("enable");
		if(enable == "true"){
			if(null == cronExpression || cronExpression.length == 0){
				OZ.Msg.info("对不起,定时表达式的值不能够为空");
				return false;
			}
		}
		var code = $("#code").val();
		$.post(
			contextPath + "/app/scheduleJobAction.do?action=saveCfgValue&timeStamp=" + new Date().getTime(), 
			{code:code, enable:enable, cronExpression:cronExpression},
			function(json){
				if(json.result == true){
					_result = json;
					OZ.Msg.slide('配置信息已成功保存');
					OZ.Dlg.fireButtonEvent(0, "Dlg_ScheduleJob");
				}else{
					OZ.Msg.info(json.msg);
				}
			},
			"json"
		);
		return false;
	}else{
		return _result;
	}
}
</script>
</html>