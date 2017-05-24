<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" select="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.organize.grouptemplate"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.organize.grouptemplate"/>">
	<html:form action="organize/groupTemplateAction.do" styleId="ozForm">
		<div class="oz-form-title" style="width:100%;padding:0px;text-align:center;height:32px;"><oz:messageSource code="oz.mdu.organize.grouptemplate"/></div>
		<div class="oz-form-fields" style="margin:4px;">
			<c:if test="${editable}">
				<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:100%;margin:0;">
					<tr class="oz-form-tr">
						<td width="80px" class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.grouptemplate.fields.name"/>：</td>
						<td class="oz-property">
							<html:text property="name" styleId="name" styleClass="oz-form-btField"/>
						</td>
					</tr>
					<c:if test="${isSysAdmin}">
						<tr class="oz-form-tr">
		                	<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.grouptemplate.fields.usedscope"/>：</td>
		                    <td>
		                    	<html:radio property="unitId" value="-1"><oz:messageSource code="cn.oz.module.organize.usedscope.all"/></html:radio>
		                    	<html:radio property="unitId" value="${curUnitId}"><oz:messageSource code="cn.oz.module.organize.usedscope.localunit"/></html:radio>
							</td>
						</tr>
					</c:if>
					<tr class="oz-form-tr">
						<td class="oz-form-topLabel-r"><oz:messageSource code="oz.mdu.organize.grouptemplate.fields.groups"/>：</td>
						<td class="oz-property">
							<table style="width:100%;border:0px" class="oz-plain-table">
								<tr>
									<td width="300px">
										<html:select property="selectedGroups" styleId="selectedGroups" style="width:100%;height:120px;" multiple="true">
	                						<html:optionsCollection name="selectedGroupOptions" label="name" value="value" /> 
	                					</html:select>
									</td>
									<td valign="bottom">
										<oz:linkButton onclick="onBtnAddGroup_Clicked()" text="oz.add"></oz:linkButton><br/>
										<oz:linkButton onclick="OZ.SELECT.removeSelected('selectedGroups')" text="oz.delete"></oz:linkButton><br/>
										<oz:linkButton onclick="OZ.SELECT.removeAll('selectedGroups')" text="oz.clearall"></oz:linkButton>	
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr class="oz-form-tr">
	                	<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.grouptemplate.fields.memos"/>：</td>
	                    <td class="oz-property">
	                    	<html:text property="memos" styleClass="oz-form-field"/>
						</td>
					</tr>
				</table>
			</c:if>
			<c:if test="${!editable}">
				<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:100%;margin:0;">
					<tr class="oz-form-tr">
						<td width="80px" class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.grouptemplate.fields.name"/>：</td>
						<td class="oz-property">
							${OZ_DOMAIN.name}
						</td>
					</tr>
					<c:if test="${isSysAdmin}">
						<tr class="oz-form-tr">
		                	<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.grouptemplate.fields.usedscope"/>：</td>
		                    <td>
		                    	<html:radio property="unitId" value="-1" disabled="true"><oz:messageSource code="cn.oz.module.organize.usedscope.all"/></html:radio>
		                    	<html:radio property="unitId" value="${curUnitId}" disabled="true"><oz:messageSource code="cn.oz.module.organize.usedscope.localunit"/></html:radio>
							</td>
						</tr>
					</c:if>
					<tr class="oz-form-tr">
						<td class="oz-form-topLabel-r"><oz:messageSource code="oz.mdu.organize.grouptemplate.fields.groups"/>：</td>
						<td class="oz-property">
							<html:select property="selectedGroups" styleId="selectedGroups" style="width:100%;height:120px;" multiple="true" disabled="true">
	                			<html:optionsCollection name="selectedGroupOptions" label="name" value="value" /> 
	                		</html:select>
						</td>
					</tr>
					<tr class="oz-form-tr">
	                	<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.grouptemplate.fields.memos"/>：</td>
	                    <td class="oz-property">
	                    	${OZ_DOMAIN.memos}
						</td>
					</tr>
				</table>
			</c:if>
		</div>
		<html:hidden property="id" styleId="id"/>
		<c:if test="${not isSysAdmin}">
			<html:hidden property="unitId" styleId="unitId"/>
		</c:if>
	</html:form>
</body>
<oz:organizeJs></oz:organizeJs>
<oz:js/>
<script type="text/javascript">
function onBtnAddGroup_Clicked(){
	OZ.Organize.selectGroups(function(groups){
		if(null == groups || groups.length == 0)
			return;
		
		var selOptionObj = document.getElementById("selectedGroups");
		for(var i = 0; i < groups.length; i++){
			if(!OZ.SELECT.isExist("selectedGroups", groups[i].id))
				selOptionObj.options[selOptionObj.length] = new Option(groups[i].name, groups[i].id);
		}
	});
}

var _result = null;
function ozDlgOkFn(){
	if(null == _result){
		if(!OZ.Form.validate()) {
			return false;
		}
		OZ.SELECT.selectAll(["selectedGroups"]);
		var saveUrl = contextPath + "/organize/groupTemplateAction.do?action=saveByAjax";
		OZ.Form.save({url:saveUrl, showMsg:true});
		return false;
	}else{
		return _result;
	}
}

function onBtnSave_Success(json){
	if(json.result){
		_result = json;
		OZ.Dlg.fireButtonEvent(0, "Dlg_GroupTemplate");
	}else{
		OZ.Msg.info(json.msg);
	}
}
</script>
</html>