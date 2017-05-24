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
		<oz:toolbar action="security/permissionAction" defaultTB="editForm">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnAllocate" text="oz.mdu.security.permission.button.allocate4role" icon="oz-icon-0209" onclick="onBtnAllocate_Clicked()"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="security/permissionAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.mdu.security.permission"/></div>
			<div class="oz-form-fields">
				<table cellpadding="0">
					<tr class="oz-form-emptyTR"> 
						<td width="180"></td>
						<td width="360"></td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.security.permission.fields.parent"/>：</td>
						<td class="oz-property">
							<html:text property="parentPermissioName" styleId="parentPermissioName" styleClass="oz-form-field"/>							
						</td>
						<td>
							<input id="btnSelect" type="button" class="oz-form-button" value='<oz:messageSource code="oz.select"/>' onclick="onBtnSelect_Clicked()" style="width:62px;height:21px"/>
							&nbsp;
							<input id="btnClear" type="button" class="oz-form-button" value='<oz:messageSource code="oz.clear"/>' onclick="onBtnClear_Clicked()" style="width:62px;height:21px"/>
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.security.permission.fields.type"/>：</td>
						<td>
							<html:radio property="type" value="0" onclick="onType_Changed()"/><oz:messageSource code="oz.mdu.security.permission.type.module"/> 
							<html:radio property="type" value="1" onclick="onType_Changed()"/><oz:messageSource code="oz.mdu.security.permission.type.function"/>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.security.permission.fields.name"/>：</td>
						<td class="oz-property">
							<html:text property="name" styleClass="oz-form-btField"/>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.security.permission.fields.code"/>：</td>
						<td class="oz-property">
							<html:text property="code" styleClass="oz-form-btField"/>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.security.permission.fields.orderno"/>：</td>
						<td class="oz-property">
							<html:text property="orderNo" styleClass="oz-form-field"/>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.security.permission.fields.status"/>：</td>
						<td>
							<html:radio property="status" value="0"/><oz:messageSource code="oz.enable"/> 
							<html:radio property="status" value="1"/><oz:messageSource code="oz.disable"/>
						</td>
						<td></td>
					</tr>
					<tr id="TR_CSS"> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.security.permission.fields.cssclazz"/>：</td>
						<td class="oz-property">
							<html:text property="cssClass" styleClass="oz-form-field"/> 
						</td>
						<td></td>
					</tr>
					<tr id="TR_URL"> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.security.permission.fields.urlpath"/>：</td>
						<td class="oz-property">
							<html:text property="urlPath" styleClass="oz-form-field"/> 
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-topLabel"><oz:messageSource code="oz.mdu.security.permission.fields.description"/>：</td>
						<td class="oz-property">
							<html:textarea property="description" styleClass="oz-form-field" rows="2"/>
						</td>
						<td></td>
					</tr>
				</table>			
			</div>
			<html:hidden property="id" styleId="id"/><html:hidden property="unitId" styleId="unitId"/>
			<html:hidden property="innerFlag" styleId="innerFlag"/>
			<html:hidden property="parent.id" styleId="parentId"/>
		</html:form>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function onType_Changed(){
	var type = $("input[name='type']:checked").val();
	if(type == "0"){
		$("#TR_CSS").show();
		$("#TR_URL").show();
	}else{
		$("#TR_CSS").hide();
		$("#TR_URL").hide();
	}
}

function onBtnSelect_Clicked(){
	new OZ.Dlg.create({
		id:"dlg_selectPermission", 
		width:300, height:330,
		title:'<oz:messageSource code="oz.mdu.security.permission.selectpermission"/>',
		url: contextPath + "/security/permissionAction.do?action=selectParent&timeStamp=" + new Date().getTime(),
		onOk:function(value){
			$("#parentPermissioName").val(value.fullName);
			$("#parentId").val(value.id);
		},onCancel:function(value){
			// do nothing.
		}
	});
}

function onBtnClear_Clicked(){
	$("#parentPermissioName").val("");
	$("#parentId").val("-1");
}

function onBtnAllocate_Clicked(){
	var id = $("#id").val();
	if(null == id || id.length == 0 || id == -1){
		OZ.Msg.info("请先保存权限。");
		return;
	}
	
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
	onType_Changed();
});
</script>
</html>