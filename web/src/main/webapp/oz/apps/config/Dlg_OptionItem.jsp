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
						<html:text property="name" styleId="name" styleClass="oz-form-btField"/>
					</td>
				</tr>
				<tr class="oz-form-tr">
					<td class="oz-form-label-r"><oz:messageSource code="oz.config.optionitem.fields.value"/>：</td>
					<td class="oz-property">							
						<html:text property="value" styleId="value" styleClass="oz-form-btField"/>
					</td>
				</tr>
				<tr class="oz-form-tr">
                	<td class="oz-form-label-r"><oz:messageSource code="oz.config.optionitem.fields.orderno"/>：</td>
                    <td class="oz-property">
                    	<html:text property="orderNo" styleId="orderNo" styleClass="oz-form-btField"/>
					</td>
				</tr>
				<tr class="oz-form-tr">
					<td class="oz-form-label-r"><oz:messageSource code="oz.config.optionitem.fields.defaultflag"/>：</td>
					<td>							
						<html:radio property="defaultFlag" styleId="radio11" value="Y"/><label for="radio11"><oz:messageSource code="oz.yes"/>&nbsp;&nbsp;&nbsp;&nbsp;</label>
						<html:radio property="defaultFlag" styleId="radio12" value="N"/><label for="radio12"><oz:messageSource code="oz.no"/>&nbsp;&nbsp;&nbsp;&nbsp;</label>
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
<script type="text/javascript">
var _result = null;
function ozDlgOkFn(){
	if(null == _result){
		if(!OZ.Form.validate()) {
			return false;
		}
		var saveUrl = contextPath + "/config/optionItemAction.do?action=saveByAjax";
		OZ.Form.save({url:saveUrl, showMsg:false});
		return false;
	}else{
		return _result;
	}
}

function onBtnSave_Success(json){
	if(json.result){
		_result = json;
		OZ.Dlg.fireButtonEvent(0, "Dlg_OptionItem");
	}else{
		OZ.Msg.info(json.msg);
	}
}
</script>
</html>