<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.mdu.organize.joblevel"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.organize.joblevel"/>">
	<html:form action="organize/jobLevelAction.do" styleId="ozForm">
		<div class="oz-form-title" style="width:100%;padding:0px;text-align:center;height:32px;"><oz:messageSource code="oz.mdu.organize.joblevel"/></div>
		<div class="oz-form-fields" style="margin:4px;">
			<c:if test="${editable}">
				<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:100%;margin:0;">
					<tr class="oz-form-tr">
						<td width="80px" class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.joblevel.fields.name"/>：</td>
						<td class="oz-property">							
							<html:text property="name" styleId="name" styleClass="oz-form-btField"/>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.joblevel.fields.level"/>：</td>
						<td class="oz-property">							
							<html:text property="level" styleId="level" styleClass="oz-form-field"/>
						</td>
					</tr>
					<tr class="oz-form-tr">
	                	<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.joblevel.fields.description"/>：</td>
	                    <td class="oz-property">
	                    	<html:text property="description" styleClass="oz-form-field"/>
						</td>
					</tr>
				</table>
			</c:if>
			<c:if test="${!editable}">
				<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:100%;margin:0;">
					<tr class="oz-form-tr">
						<td width="80px" class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.joblevel.fields.name"/>：</td>
						<td class="oz-property">
							${OZ_DOMAIN.name}
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.joblevel.fields.level"/>：</td>
						<td class="oz-property">
							${OZ_DOMAIN.level}
						</td>
					</tr>
					<tr class="oz-form-tr">
	                	<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.joblevel.fields.description"/>：</td>
	                    <td class="oz-property">
	                    	${OZ_DOMAIN.description}
						</td>
					</tr>
				</table>
			</c:if>
		</div>
		<html:hidden property="id" styleId="id"/><html:hidden property="unitId" styleId="unitId"/>
	</html:form>
</body>
<oz:js/>
<script type="text/javascript">
var _result = null;
function ozDlgOkFn(){
	if(null == _result){
		if(!OZ.Form.validate()) {
			return false;
		}
		var saveUrl = contextPath + "/organize/jobLevelAction.do?action=saveByAjax";
		OZ.Form.save({url:saveUrl, showMsg:false});
		return false;
	}else{
		return _result;
	}
}

function onBtnSave_Success(json){
	if(json.result){
		_result = json;
		OZ.Dlg.fireButtonEvent(0, "Dlg_JobLevel");
	}else{
		OZ.Msg.info(json.msg);
	}
}
</script>
</html>