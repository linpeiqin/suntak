<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.mdu.organize.oulevel"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.organize.oulevel"/>">
	<html:form action="organize/ouLevelAction.do" styleId="ozForm">
		<div class="oz-form-title" style="width:100%;padding:0px;text-align:center;height:32px;"><oz:messageSource code="oz.mdu.organize.oulevel"/></div>
		<div class="oz-form-fields" style="margin:4px;">
			<c:if test="${editable}">
				<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:100%;margin:0;">
					<tr class="oz-form-tr">
						<td width="70px" class="oz-form-label-r" onclick="onBtnClearParent_Clicked()" style="cursor:pointer;" title="点击清空"><oz:messageSource code="oz.mdu.organize.oulevel.fields.parent"/>：</td>
						<td class="oz-property">							
							<html:text property="parent.name" styleId="parentName" styleClass="oz-form-field oz-form-zdField" style="width:155px"/>
							<oz:linkButton onclick="selectOULevel()" text="oz.btn.select"></oz:linkButton>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.name"/>：</td>
						<td class="oz-property">							
							<html:text property="name" styleId="name" styleClass="oz-form-btField"/>
						</td>
					</tr>
					<tr class="oz-form-tr">
	                	<td class="oz-form-label-r"><oz:messageSource code="oz.description"/>：</td>
	                    <td class="oz-property">
	                    	<html:text property="description" styleClass="oz-form-field"/>
						</td>
					</tr>
				</table>
			</c:if>
			<c:if test="${!editable}">
				<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:100%;margin:0;">
					<tr class="oz-form-tr">
						<td width="70px" class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.oulevel.fields.parent"/>：</td>
						<td class="oz-property">
							${OZ_DOMAIN.parentName}
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.name"/>：</td>
						<td class="oz-property">
							${OZ_DOMAIN.name}
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.oulevel.fields.level"/>：</td>
						<td class="oz-property">
							${OZ_DOMAIN.level}
						</td>
					</tr>
					<tr class="oz-form-tr">
	                	<td class="oz-form-label-r"><oz:messageSource code="oz.description"/>：</td>
	                    <td class="oz-property">
	                    	${OZ_DOMAIN.description}
						</td>
					</tr>
				</table>
			</c:if>
		</div>
		<html:hidden property="id" styleId="id"/><html:hidden property="parent.id" styleId="parentId"/>
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
		var saveUrl = contextPath + "/organize/ouLevelAction.do?action=saveByAjax";
		OZ.Form.save({url:saveUrl, showMsg:false});
		return false;
	}else{
		return _result;
	}
}

function onBtnSave_Success(json){
	if(json.result){
		_result = json;
		OZ.Dlg.fireButtonEvent(0, "Dlg_OULevel");
	}else{
		OZ.Msg.info(json.msg);
	}
}

function onBtnClearParent_Clicked(){
	$("#parentId").val(-1);
	$("#parentName").val("");
}

function selectOULevel(){
	var strUrl = contextPath + "/organize/ouLevelAction.do?action=ouLevelSelectDlg&excludeId=" + $("#id").val() + "&timeStamp=" + new Date().getTime();
	new OZ.Dlg.create({ 
		id:"dlg_SelectOULevel", 
		width:330, height:330,
		title:'<oz:messageSource code="oz.select"/><oz:messageSource code="oz.mdu.organize.oulevel"/>',
		url: strUrl,
		onOk:function(result){
			$("#parentId").val(result.id);
			$("#parentName").val(result.name);
		},
		onCancel:function(result){
			// do nothing...
		}
	});
}
</script>
</html>