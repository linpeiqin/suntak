<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.mdu.document.documentprocesscfg"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.document.documentprocesscfg"/>">
	<html:form action="document/documentProcessCfgAction.do" styleId="ozForm">
		<div class="oz-form-title" style="width:100%;padding:0px;text-align:center;height:32px;"><oz:messageSource code="oz.mdu.document.documentprocesscfg"/></div>
		<div class="oz-form-fields" style="margin:4px;">
			<c:if test="${editable}">
				<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:100%;margin:0;">
					<tr class="oz-form-tr">
						<td width="80px" class="oz-form-label-r"><oz:messageSource code="oz.mdu.document.dp.field.processname"/>：</td>
						<td class="oz-property">
							<html:text property="processName" styleClass="oz-form-btField"/>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.document.dp.field.processkey"/>：</td>
						<td class="oz-property">							
							<html:text property="processKey" styleClass="oz-form-btField"/>
						</td>
					</tr>
					<tr class="oz-form-tr">
	                	<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.document.dp.field.supportername"/>：</td>
	                    <td class="oz-property">
	                    	<html:select property="documentProcessSupporterName" styleId="documentProcessSupporterName" styleClass="oz-form-btField">
								<html:optionsCollection name="supporterOptions" label="name" value="value" />
							</html:select>
						</td>
					</tr>
				</table>
			</c:if>
			<c:if test="${!editable}">
				<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:100%;margin:0;">
					<tr class="oz-form-tr">
						<td width="80px" class="oz-form-label-r"><oz:messageSource code="oz.mdu.document.dp.field.processname"/>：</td>
						<td class="oz-property">
							${OZ_DOMAIN.processName}
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.document.dp.field.processkey"/>：</td>
						<td class="oz-property">
							${OZ_DOMAIN.processKey}
						</td>
					</tr>
					<tr class="oz-form-tr">
	                	<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.document.dp.field.supportername"/>：</td>
	                    <td class="oz-property">
	                    	<html:select property="documentProcessSupporterName" styleId="documentProcessSupporterName" styleClass="oz-form-readField" disabled="true">
								<html:optionsCollection name="supporterOptions" label="name" value="value" />
							</html:select>
						</td>
					</tr>
				</table>
			</c:if>
		</div>
		<html:hidden property="id" styleId="id"/><html:hidden property="unitId" styleId="unitId"/>
		<html:hidden property="status" styleId="status"/>
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
		var saveUrl = contextPath + "/document/documentProcessCfgAction.do?action=saveByAjax";
		OZ.Form.save({url:saveUrl, showMsg:false});
		return false;
	}else{
		return _result;
	}
}

function onBtnSave_Success(json){
	if(json.result){
		_result = json;
		OZ.Dlg.fireButtonEvent(0, "Dlg_ProcessCfg");
	}else{
		OZ.Msg.info(json.msg);
	}
}
</script>
</html>