<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.mdu.security.permission"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.security.permission"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="security/permissionAction">
			<oz:tbSeperator/>
			<oz:tbButton id="btnBack"/>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnEnable" text="oz.enable" icon="oz-icon-0901" onclick="onBtnEnable_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnDisable" text="oz.disable" icon="oz-icon-0903" onclick="onBtnDisable_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnAllocate" text="oz.mdu.security.permission.button.allocate4role" icon="oz-icon-0209" onclick="onBtnAllocate_Clicked()"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="security/permissionAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.mdu.security.permission"/></div>
			<div style="text-align:left; margin-top:10px;color:red;font-weight:bold">
				<div id="DIV_INNERFLAG"></div>
			</div>
			<div class="oz-form-fields">
				<table cellpadding="0">
					<tr class="oz-form-emptyTR"> 
						<td width="180"></td>
						<td width="420"></td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.security.permission.fields.parent"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="permissionForm" property="parentPermissioName"/></span>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.security.permission.fields.type"/>：</td>
						<td>
							<html:radio property="type" value="0" disabled="true"/><oz:messageSource code="oz.mdu.security.permission.type.module"/> 
							<html:radio property="type" value="1" disabled="true"/><oz:messageSource code="oz.mdu.security.permission.type.function"/>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.security.permission.fields.name"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span">
								<bean:write name="permissionForm" property="name"/>
								(<bean:write name="permissionForm" property="permissioName"/>)
							</span>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.security.permission.fields.code"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="permissionForm" property="code"/></span>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.security.permission.fields.orderno"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="permissionForm" property="orderNo"/></span>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.security.permission.fields.status"/>：</td>
						<td>
							<html:radio property="status" value="0" disabled="true"/><oz:messageSource code="oz.enable"/> 
							<html:radio property="status" value="1" disabled="true"/><oz:messageSource code="oz.disable"/>
						</td>
						<td></td>
					</tr>
					<tr id="TR_CSS">
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.security.permission.fields.cssclazz"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="permissionForm" property="cssClass"/></span>
						</td>
						<td></td>
					</tr>
					<tr id="TR_URL">  
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.security.permission.fields.urlpath"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="permissionForm" property="urlPath"/></span>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.security.permission.fields.description"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="permissionForm" property="description"/></span>
						</td>
						<td></td>
					</tr>
				</table>			
			</div>
			<html:hidden property="id" styleId="id"/><html:hidden property="unitId" styleId="unitId"/>
			<html:hidden property="innerFlag" styleId="innerFlag"/>
		</html:form>
	</div>
</body>
<oz:js/>
<script type="text/javascript" src="<oz:contextPath/>/oz-platform/apps/security/js/oz.security.js"></script>
<script type="text/javascript">
function onBtnDisable_Clicked(){
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.mdu.security.permission.msg.disable.single"/>',
		function(){
			$.getJSON(
				contextPath + "/security/permissionAction.do?action=disable&timeStamp=" + new Date().getTime(),
				{id:$("#id").val()},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.mdu.security.permission.msg.disable.success"/>');
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
		'<oz:messageSource code="oz.mdu.security.permission.msg.enable.single"/>',
		function(){
			$.getJSON(
				contextPath + "/security/permissionAction.do?action=enable&timeStamp=" + new Date().getTime(),
				{id:$("#id").val()},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.mdu.security.permission.msg.enable.success"/>');
						window.location.reload();
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			);
		}
	);
}

function onBtnAllocate_Clicked(){
	var strUrl = contextPath + "/security/roleAction.do?action=dlgAllocatePermission&permissionId=" + $("#id").val();
	strUrl += "&timeStamp=" + new Date().getTime();
	
	new OZ.Dlg.create({
		id:"dlg_AllocatePermission", width:305, height:400,
		title:'<oz:messageSource code="oz.mdu.security.permission.button.allocate4role"/>',
		url: strUrl,
		onOk:function(result){
			$.post(
				contextPath + "/security/roleAction.do?action=updateByPermission&timeStamp=" + new Date().getTime(),
				{permissionId:$("#id").val(), roleIds:result},
				function(json){
					OZ.Msg.info(json.msg);
				},
				"json"
			);
		},
		onCancel:function(result){
			// do nothing...
		}
	});
}

$(function(){
	if($("#innerFlag").val() == "Y"){
		$("#DIV_INNERFLAG").html('&nbsp;&nbsp;(<oz:messageSource code="oz.mdu.security.permission.innerpermission"/>)');
	}
	
	var type = $("input[name='type']:checked").val();
	if(type == "0"){
		$("#TR_CSS").show();
		$("#TR_URL").show();
	}else{
		$("#TR_CSS").hide();
		$("#TR_URL").hide();
	}
});
</script>
</html>