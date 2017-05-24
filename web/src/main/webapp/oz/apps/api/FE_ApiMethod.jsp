<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true" attachment="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.bulletin"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="module/bulletinAction">
			<oz:tbButton id="btnBack"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnSave"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRelease" text="oz.mdu.bulletin.buttons.release" icon="oz-icon-0124" onclick="onBtnRelease_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>			
			<oz:tbButton id="btnDelete"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="module/bulletinAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.mdu.bulletin"/></div>
			<div class="oz-form-fields2">
				<table cellpadding="2" cellspacing="0" class="oz-form-bordertable">
					<tr class="oz-form-tr">
						<td width="15%" class="oz-form-label-r"><oz:messageSource code="oz.subject"/>：</td>
						<td width="85%" class="oz-property">
							<html:text property="subject" styleClass="oz-form-btField"/>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.bulletin.fields.expireddate"/>：</td>
						<td>
							<html:radio property="expiredTimeDef" styleId="expiredTimeDef" value="1w" onclick="onExpiredTimeDef_Changed()"/><oz:messageSource code="oz.mdu.bulletin.etdt.1w"/>
							<html:radio property="expiredTimeDef" styleId="expiredTimeDef" value="2w" onclick="onExpiredTimeDef_Changed()"/><oz:messageSource code="oz.mdu.bulletin.etdt.2w"/>
							<html:radio property="expiredTimeDef" styleId="expiredTimeDef" value="1m" onclick="onExpiredTimeDef_Changed()"/><oz:messageSource code="oz.mdu.bulletin.etdt.1m"/>
							<html:radio property="expiredTimeDef" styleId="expiredTimeDef" value="2m" onclick="onExpiredTimeDef_Changed()"/><oz:messageSource code="oz.mdu.bulletin.etdt.2m"/>
							<html:radio property="expiredTimeDef" styleId="expiredTimeDef" value="ud" onclick="onExpiredTimeDef_Changed()"/><oz:messageSource code="oz.mdu.bulletin.etdt.ud"/>
							<span id="SPAN_ETD_UD">
								<html:text property="expiredDateTime" styleClass="oz-form-field oz-dateField" style="width:100px;"/>
							</span>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.bulletin.fields.reader"/>：</td>
						<td class="oz-property">
							<oz:acl entityClazz="cn.oz.module.bulletin.domain.Bulletin" style="width:592px;float:left;"></oz:acl>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-topLabel-r"><oz:messageSource code="oz.mdu.bulletin.fields.content"/>：</td>
						<td class="oz-property">
							<html:textarea property="content" styleClass="xheditor" rows="12" style="width:100%;height:350px;" cols="80"></html:textarea>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-topLabel-r"><oz:messageSource code="oz.attachments"/>：</td>
						<td class="oz-property">
							<div style="width:100%;padding:0px;height:100%;">
								<oz:attachment id="ATTACHMENT" style="border:1px solid #ccc;margin:0;height:160px;width:100%;"/>
							</div>
						</td>
					</tr>
				</table>			
			</div>
			<html:hidden property="id" styleId="id"/><html:hidden property="fileUuid" styleId="fileUuid"/>
			<html:hidden property="status" styleId="status"/><html:hidden property="fileUnitId" styleId="fileUnitId"/>
			<html:hidden property="author.id" styleId="authorId"/><html:hidden property="author.name" styleId="authorName"/>
			<html:hidden property="author.ouId" styleId="authorOuId"/><html:hidden property="author.ouName" styleId="authorOuName"/>
			<html:hidden property="author.unitId" styleId="authorUnitId"/><html:hidden property="createdDateTime" styleId="createdDateTime"/>
			<html:hidden property="publisher.id" styleId="publisherId"/><html:hidden property="publisher.name" styleId="publisherName"/>
			<html:hidden property="publisher.ouId" styleId="publisherOuId"/><html:hidden property="publisher.ouName" styleId="publisherOuName"/>
			<html:hidden property="releaseDateTime" styleId="releaseDateTime"/>
		</html:form>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function getOzEntityId(){
	var entityId = $("#id").val();
	if(null == entityId || entityId.length == 0 || entityId == "-1"){
		entityId = $("#fileUuid").val(); 
	}
	return entityId;
}

function onExpiredTimeDef_Changed(){
	var value = $("input[name='expiredTimeDef']:checked").val();
	if("ud" == value){
		$("#SPAN_ETD_UD").show();
	}else{
		$("#SPAN_ETD_UD").hide();
	}
}

function onBtnRelease_Clicked(){
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.mdu.bulletin.msg.release.confirm.single"/>',
		function(){
			if(!OZ.Form.validate()){
				return;
			}
			
			// 提交表单
			document.forms[0].action = contextPath + "/module/bulletinAction.do?action=releaseFromForm";
			document.forms[0].target = "_self";
			document.forms[0].submit();
		}
	);
}

function onBtnDelete_Clicked(){
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.mdu.bulletin.msg.delete.confirm.single"/>',
		function(){
			$.getJSON(
				contextPath + "/module/bulletinAction.do?action=delete&timeStamp=" + new Date().getTime(),
				{id:$("#id").val()},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.core.msg.delete.success"/>', null, function(){
							ozTB_BtnBack_Clicked();
						});
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			);
		}
	);
}

$(function(){
	onExpiredTimeDef_Changed();
});
</script>
</html>