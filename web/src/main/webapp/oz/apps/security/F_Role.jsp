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
		<oz:toolbar action="security/roleAction">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack" text="返回"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnEnable" text="oz.enable" icon="oz-icon-0901" onclick="onBtnEnable_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnDisable" text="oz.disable" icon="oz-icon-0903" onclick="onBtnDisable_Clicked()"></oz:tbButton>
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
									<td width="120"></td>
									<td width="260"></td>
									<td></td>
								</tr>
								<tr>
									<td class="oz-form-label"><oz:messageSource code="oz.mdu.security.role.fields.name"/>：</td>
									<td class="oz-property">
										<span class="oz-form-fields-span"><bean:write name="roleForm" property="name"/></span>
									</td>
									<td></td>
								</tr>
								<tr>
									<td class="oz-form-label"><oz:messageSource code="oz.mdu.security.role.fields.code"/>：</td>
									<td class="oz-property">
										<span class="oz-form-fields-span"><bean:write name="roleForm" property="code"/></span>
									</td>
								</tr>
								<tr>
									<td class="oz-form-label"><oz:messageSource code="oz.mdu.security.role.fields.status"/>：</td>
									<td >
										<html:radio property="status" value="0" disabled="true"/><oz:messageSource code="oz.enable"/> 
										<html:radio property="status" value="1" disabled="true"/><oz:messageSource code="oz.disable"/>
									</td>
								</tr>
								<tr> 
									<td class="oz-form-label"><oz:messageSource code="oz.mdu.security.role.fields.description"/>：</td>
									<td class="oz-property">
										<span class="oz-form-fields-span"><bean:write name="roleForm" property="description"/></span>
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
function onBtnDisable_Clicked(){
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.mdu.security.role.msg.disable.single"/>',
		function(){
			$.getJSON(
				contextPath + "/security/roleAction.do?action=disable&timeStamp=" + new Date().getTime(),
				{id:$("#id").val()},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.mdu.security.role.msg.disable.success"/>');
						window.location.reload();
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			);
		}
	);
}

function onBtnEnable_Clicked(){
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.mdu.security.role.msg.enable.single"/>',
		function(){
			$.getJSON(
				contextPath + "/security/roleAction.do?action=enable&timeStamp=" + new Date().getTime(),
				{id:$("#id").val()},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.mdu.security.role.msg.enable.success"/>');
						window.location.reload();
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			);
		}
	);
}

function onBtnAllocatedGroup_Clicked(){
	var id = $("#id").val();
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
	$('#permissionTree').tree({checkbox: true, checkable: false, url: treeDataUrl});
});
</script>
</html>