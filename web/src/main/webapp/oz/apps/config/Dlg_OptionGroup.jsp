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
						<html:text property="name" styleId="name" styleClass="oz-form-btField"/>
					</td>
				</tr>
				<tr class="oz-form-tr">
					<td class="oz-form-label-r"><oz:messageSource code="oz.config.optiongroup.fields.code"/>：</td>
					<td class="oz-property">							
						<html:text property="code" styleId="code" styleClass="oz-form-btField"/>
					</td>
				</tr>
				<tr class="oz-form-tr">
					<td class="oz-form-label-r"><oz:messageSource code="oz.config.optiongroup.fields.editable"/>：</td>
					<td>							
						<html:radio property="editableFlag" styleId="editableFlag" value="Y"/><oz:messageSource code="oz.yes"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<html:radio property="editableFlag" styleId="editableFlag" value="N"/><oz:messageSource code="oz.no"/>
					</td>
				</tr>
				<tr class="oz-form-tr">
					<td class="oz-form-label-r"><oz:messageSource code="oz.cfg.management.type"/>：</td>
					<td>							
						<html:radio property="managementType" styleId="managementType" value="CM"/><oz:messageSource code="oz.cfg.management.type.cm"/>&nbsp;&nbsp;
						<html:radio property="managementType" styleId="managementType" value="DM"/><oz:messageSource code="oz.cfg.management.type.dm"/>
					</td>
				</tr>
				<tr class="oz-form-tr">
					<td class="oz-form-label-r"><oz:messageSource code="oz.memos"/>：</td>
					<td class="oz-property">							
						<html:text property="memos" styleId="memos" styleClass="oz-form-field"/>
					</td>
				</tr>
			</table>			
		</div>
		<html:hidden property="id" styleId="id"/>
		<html:hidden property="innerFlag" styleId="innerFlag"/>
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
		var saveUrl = contextPath + "/config/optionGroupAction.do?action=saveByAjax";
		OZ.Form.save({url:saveUrl, showMsg:false});
		return false;
	}else{
		return _result;
	}
}

function onBtnSave_Success(json){
	if(json.result){
		_result = json;
		OZ.Dlg.fireButtonEvent(0, "Dlg_OptionGroup");
	}else{
		OZ.Msg.info(json.msg);
	}
}
</script>
</html>