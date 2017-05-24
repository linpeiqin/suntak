<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.config.configitem"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.config.configitem"/>">
	<html:form action="config/configItemAction.do" styleId="ozForm">
		<div class="oz-form-title" style="width:100%;padding:0px;text-align:center;height:32px;"><oz:messageSource code="oz.config.configitem"/></div>
		<div class="oz-form-fields" style="margin:4px;">
			<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:100%;margin:0;">
				<tr class="oz-form-tr">
					<td width="80px" class="oz-form-label-r"><oz:messageSource code="oz.config.configitem.fields.key"/>：</td>
					<td class="oz-property">
						${OZ_DOMAIN.key}
					</td>
				</tr>
				<tr class="oz-form-tr">
					<td class="oz-form-label-r"><oz:messageSource code="oz.config.configitem.fields.value"/>：</td>
					<td class="oz-property">							
						<html:text property="value" styleId="value" styleClass="oz-form-btField"/>
					</td>
				</tr>
				<tr class="oz-form-tr">
                	<td class="oz-form-label-r"><oz:messageSource code="oz.config.configitem.fields.description"/>：</td>
                    <td class="oz-property">
                    	<html:text property="description" styleClass="oz-form-field"/>
					</td>
				</tr>
			</table>			
		</div>
		<html:hidden property="id" styleId="id"/><html:hidden property="unitId" styleId="unitId"/>
		<html:hidden property="key" styleId="key"/>
		<html:hidden property="lastModifier.name" styleId="lastModifier.name"/>
		<html:hidden property="lastModifier.id" styleId="lastModifier.id"/>
		<html:hidden property="lastModifiedDate" styleId="lastModifiedDate"/>
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
		var saveUrl = contextPath + "/config/configItemAction.do?action=saveByAjax";
		OZ.Form.save({url:saveUrl, showMsg:false});
		return false;
	}else{
		return _result;
	}
}

function onBtnSave_Success(json){
	if(json.result){
		_result = json;
		OZ.Dlg.fireButtonEvent(0, "Dlg_ConfigItem");
	}else{
		OZ.Msg.info(json.msg);
	}
}
</script>
</html>