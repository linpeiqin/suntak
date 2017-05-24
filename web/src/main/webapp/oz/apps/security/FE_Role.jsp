<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" tree="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.security.role"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.security.role"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="security/roleAction" defaultTB="editForm">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnAllocatedGroup" text="oz.mdu.security.role.allocated.group" icon="oz-icon-0507" onclick="onBtnAllocatedGroup_Clicked()"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="security/roleAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.mdu.security.role"/></div>
			<div style="text-align:left; margin-top:10px;color:red;font-weight:bold"><div id="DIV_INNERFLAG"></div></div>
			<div class="oz-form-fields">
				<table width="790px" cellpadding="0">
					<tr class="oz-form-emptyTR">
						<td width="50%"></td>
						<td width="50%"></td>
					</tr>
					<tr>
						<td valign="top">
							<table cellpadding="0" style="width:390px;border:0px">
								<tr class="oz-form-emptyTR"> 
									<td width="25%"></td>
									<td width="75%"></td>
								</tr>
								<tr>
									<td class="oz-form-label"><oz:messageSource code="oz.mdu.security.role.fields.name"/>：</td>
									<td class="oz-property">
										<html:text property="name" styleClass="oz-form-btField"/>
									</td>
								</tr>
								<tr>
									<td class="oz-form-label"><oz:messageSource code="oz.mdu.security.role.fields.code"/>：</td>
									<td class="oz-property">
										<html:text property="code" styleClass="oz-form-btField"/>
									</td>
								</tr>
								<tr>
									<td class="oz-form-label"><oz:messageSource code="oz.mdu.security.role.fields.status"/>：</td>
									<td >
										<html:radio property="status" value="0"/><oz:messageSource code="oz.enable"/> 
										<html:radio property="status" value="1"/><oz:messageSource code="oz.disable"/>
									</td>
								</tr>
								<tr> 
									<td class="oz-form-topLabel"><oz:messageSource code="oz.mdu.security.role.fields.description"/>：</td>
									<td class="oz-property">
							 			<html:textarea property="description" styleClass="oz-form-field" rows="2"/>
									</td>
								</tr>
								<tr id="TR_PEMISSION" style="display:none"> 
									<td class="oz-form-topLabel">权限描述：</td>
									<td class="oz-property">
							 			<span id="permissionDescription" style="color:gray;">
							 				&nbsp;
							 			</span>
									</td>
								</tr>
							</table>
						</td>
						<td valign="top">
							<table width="390px" cellpadding="0" style="width:390px;border:0px">
								<tr class="oz-form-emptyTR"> 
									<td width="90"></td>
									<td width="300"></td>
								</tr>
								<tr>
									<td class="oz-form-topLabel"><oz:messageSource code="oz.mdu.security.role.fields.permission"/>：</td>
									<td valign="top">
										<div style="width:315px;height:430px;overflow:auto;border:1px solid #76ABD3">
											<ul id="permissionTree"></ul>
										</div>
									</td>
								</tr>
							</table>
						</td>								
					</tr>
				</table>
			</div>
			<html:hidden property="id" styleId="id"/><html:hidden property="unitId" styleId="unitId"/>
			<html:hidden property="innerFlag" styleId="innerFlag"/>
			<html:hidden property="permissionIds" styleId="permissionIds"/>
		</html:form>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function onBtnSave_Clicked(action){
	var nodes = $('#permissionTree').tree('getChecked', true);
	var permissionIds = '';
	for(var i = 0; i < nodes.length; i++){
		if(permissionIds != '') 
			permissionIds += ',';
		permissionIds += nodes[i].id;
	}
	$("#permissionIds").val(permissionIds);
	ozTB_DefaultBtnSaveByAjax_Clicked(action);
}

function onBtnAllocatedGroup_Clicked(){
	var id = $("#id").val();
	if(null == id || id.length == 0 || id == -1){
		OZ.Msg.info("请先保存角色。");
		return;
	}
	
	var strUrl = contextPath + "/organize/groupAction.do?action=dlgAllocatedGroup&roleId=" + $("#id").val();
	strUrl += "&timeStamp=" + new Date().getTime();
	OZ.openWindow({
		id: "AllocatedGroup" + id,
		title: "包含岗位",
		url: strUrl, 
		refresh: false,
		beforeCloseFnName: "oz_Win_BeforeClose"
	});
}

$(function(){
	if($("#innerFlag").val() == "Y"){
		$("#DIV_INNERFLAG").html('&nbsp;&nbsp;(<oz:messageSource code="oz.mdu.security.role.innerrole"/>)');
	}
	
	// 加载功能导航树
	var treeDataUrl = contextPath + "/security/roleAction.do?action=getPermissionTree";
	treeDataUrl += "&id=" + $("#id").val() + "&timeStamp=" + new Date().getTime();
	$('#permissionTree').tree({
		checkbox: true, 
		url: treeDataUrl, 
		cascade: true,
		click:function(e, data){
			var description = data.description;
			if(null == description)
				description = "";
			$("#permissionDescription").html(description);
			if(description == "")
				$("#TR_PEMISSION").hide();
			else
				$("#TR_PEMISSION").show();
		}
	});
});
</script>
</html>