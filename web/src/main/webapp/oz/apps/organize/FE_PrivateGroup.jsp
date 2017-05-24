<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" select="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.organize.privategroup"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.organize.privategroup"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="organize/privateGroupAction" defaultTB="editForm">
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="organize/privateGroupAction.do" styleId="ozForm" styleClass="oz-form">
		<logic:equal value="public" name="privateGroupForm" property="type">
			<div class="oz-form-title"><oz:messageSource code="oz.mdu.organize.shortcutgroup"/></div>
		</logic:equal>
		<logic:notEqual value="public" name="privateGroupForm" property="type">
			<div class="oz-form-title"><oz:messageSource code="oz.mdu.organize.privategroup"/></div>
		</logic:notEqual>
			<div class="oz-form-fields">
				<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:800px;table-layout:fixed;border-top-width:0px">
					<tr class="oz-form-locate-tr">
						<td width="100px" style="border-left:1px solid white;"></td>
						<td></td>
						<td width="65px" style="border-right:1px solid white;"></td>
					</tr>
					<tr class="oz-form-tr">  
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.privategroup.fields.name"/>：</td>
						<td class="oz-property" colspan="2">
							<html:text property="name" styleClass="oz-form-btField"/>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-topLabel-r"><oz:messageSource code="oz.mdu.organize.privategroup.fields.members"/>：</td>
						<td class="oz-property">
							<html:select property="members" styleId="members" style="width:100%;height:230px;" multiple="true">
	                			<html:optionsCollection name="memberOptions" label="name" value="value" /> 
	                		</html:select>
						</td>
						<td valign="bottom" style="text-align:right;">
							<input id="btnAdd" type="button" class="oz-form-button" value="<oz:messageSource code="oz.add"/>" onclick="onBtnAddMember_Clicked()" /><br/><br/>
							<input id="btnDelete" type="button" class="oz-form-button" value="<oz:messageSource code="oz.delete"/>" onclick="onBtnDelMember_Clicked()" /><br/><br/>
							<input id="btnDelete" type="button" class="oz-form-button" value="<oz:messageSource code="oz.clearall"/>" onclick="onBtnClearMember_Clicked()" />
						</td>
					</tr>
					<c:if test="${OZ_DOMAIN.type=='public'}">
						<tr class="oz-form-tr">  
							<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.privategroup.fields.used.acl"/>：</td>
							<td class="oz-property" colspan="2">
								<oz:acl id="aclUsed" entityClazz="cn.oz.module.organize.domain.PrivateGroup" permissionMask="1" style="width:610px;float:left;"></oz:acl>
							</td>
						</tr>
					</c:if>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.privategroup.fields.memos"/>：</td>
						<td class="oz-property" colspan="2">
							<html:text property="memos" styleClass="oz-form-field"/>
						</td>
					</tr>
				</table>			
			</div>
			<html:hidden property="id" styleId="id"/><html:hidden property="uuid" styleId="uuid"/>
			<html:hidden property="author.id" styleId="author_id"/><html:hidden property="author.unitId" styleId="author_unit_id"/>
			<html:hidden property="code" styleId="code"/><html:hidden property="type" styleId="type"/>
			<html:hidden property="usedAclFlag" styleId="usedAclFlag"/>
		</html:form>
	</div>
</body>
<oz:organizeJs></oz:organizeJs>
<oz:js/>
<script type="text/javascript">
function getOzEntityId(){
	var entityId = $("#id").val();
	if(null == entityId || entityId.length == 0 || entityId == "-1"){
		entityId = $("#uuid").val(); 
	}
	return entityId;
}

function onBtnSave_Clicked(){
	OZ.SELECT.selectAll(["members"]);
	ozTB_DefaultBtnSaveByAjax_Clicked(contextPath + "/organize/privateGroupAction.do");
}

function onBtnAddMember_Clicked(){
	var param = {
		privateGroup : false,
		shortcutGroup : false
	};
	
	OZ.Organize.addressBook(function(result) {
		var $factor = null;
		$.each(result, function(index, d) {
			OZ.SELECT.addOption("members", d.name, d.id);
		});
	}, -1, true, param);
}

function onBtnDelMember_Clicked() {
	OZ.SELECT.removeSelected('members');
}

function onBtnClearMember_Clicked() {
	OZ.SELECT.removeAll("members");
}
</script>
</html>