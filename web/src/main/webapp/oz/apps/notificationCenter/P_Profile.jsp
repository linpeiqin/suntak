<!DOCTYPE html>
<%@page import="cn.oz.NameValuePair"%>
<%@page import="cn.oz.module.notificationcenter.domain.NotificationCfgItem"%>
<%@page import="cn.oz.apps.Notification"%>
<%@page import="org.apache.jasper.tagplugins.jstl.ForEach"%>
<%@page import="java.util.List"%>
<%@page import="cn.oz.module.notificationcenter.domain.NotificationProfile"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="form" tabs="true"/>
<html>
<head>
	<title><oz:messageSource code="oz.mdu.notificationcenter.profile"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css />
</head>
<body data-name="<oz:messageSource code="oz.mdu.notificationcenter.profile"/>">
	<html:form action="module/notificationProfileAction.do" styleId="ozForm" styleClass="oz-form">
		<div id="page" class="oz-page">
			<div id="page-top" class="oz-page-top">
				<oz:toolbar action="module/notificationProfileAction">
					<oz:tbSeperator></oz:tbSeperator>
					<oz:tbButton id="btnBack"></oz:tbButton>
					<oz:tbSeperator></oz:tbSeperator>
					<oz:tbButton id="btnSave"></oz:tbButton>
				</oz:toolbar>
			</div>
			<div id="page-center" class="oz-page-form">
				<div class="oz-form-title"><oz:messageSource code="oz.mdu.notificationcenter.profile"/></div>
				<div class="oz-form-tabs">
					<div id="tabCt" class="border" data-tabs='{"height":480}' style="border-width:0px;background-color: transparent;">
						<div data-tab-panel='{"id":"tab_01","title":"<oz:messageSource code="oz.mdu.notificationcenter.profile.tabs.worktime"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
							<div class="oz-form-fields">
								<table cellpadding="2" cellspacing="2" style="border: 0px solid black">
									<tr height="18px"> 
										<td width="40%" style="text-align: right;padding-right: 4px;">
											<b><oz:messageSource code="oz.mdu.notificationcenter.profile.constants.status"/>：</b>
										</td>
										<td width="14%">
											<input type="radio" id="rdWorkTimeStatus" name="rdWorkTimeStatus" value="true" checked="checked" onclick="onWorkTimeStatus_Clicked()"><oz:messageSource code="oz.mdu.notificationcenter.profile.constants.status.enabled"/>&nbsp;&nbsp;&nbsp;&nbsp;
											<input type="radio" id="rdWorkTimeStatus" name="rdWorkTimeStatus" value="false" onclick="onWorkTimeStatus_Clicked()"><oz:messageSource code="oz.mdu.notificationcenter.profile.constants.status.disabled"/>
										</td>
										<td width="10%" style="text-align: right;padding-right: 4px;">
											<b><oz:messageSource code="oz.mdu.notificationcenter.profile.constants.alertaction"/>：</b>
										</td>
										<td width="27%">
											<oz:select value="workTimeAlertAction" property="workTimeAlertAction" options="alertActions" style="width:148px" onchange="onWorkTimeAlertAction_Changed()"></oz:select>
										</td>
										<td width="10%"></td>
									</tr>
									<tr height="4px;"> 
										<td colspan="5">
											<hr style="width:92%;float:right;margin-right:12px;">
										</td>
									</tr>
									<%
										NotificationProfile profile = (NotificationProfile)request.getAttribute("profile");
										List notifications = (List)request.getAttribute("notifications");
										List actionOptions = (List)request.getAttribute("alertActions");
										if(null != notifications && notifications.size() > 0){
											Notification notification = null;
											boolean enabled = true;
											String alertAction = "";
											for(int i = 0; i < notifications.size(); i++){
												notification = (Notification)notifications.get(i);
												if(null == notification)
													continue;
												
												NotificationCfgItem cfgItem = profile.getCfgItem(notification.getId(), NotificationProfile.TST_WORK);
												if(null != cfgItem){
													enabled = cfgItem.isEnable();
													alertAction = cfgItem.getActions();
												}else{
													enabled = notification.isEnable();
													alertAction = notification.getDefaultAction();
												}
									%>
									<tr> 
										<td style="text-align: right;padding-right: 4px;">
											<b><%= notification.getName() %>：</b>
										</td>
										<td>
									<%
												if(enabled){
									%>
											<input id="status_wt_<%= notification.getId() %>" name="wt_<%= notification.getId() %>" notificationId="<%= notification.getId() %>" type="radio" class="wtNotificationStatus" value="true" checked="checked"><oz:messageSource code="oz.mdu.notificationcenter.profile.constants.status.enabled"/>&nbsp;&nbsp;&nbsp;&nbsp;
											<input id="status_wt_<%= notification.getId() %>" name="wt_<%= notification.getId() %>" notificationId="<%= notification.getId() %>" type="radio" class="wtNotificationStatus" value="false"><oz:messageSource code="oz.mdu.notificationcenter.profile.constants.status.disabled"/>
									<%				
												}else{
									%>
											<input id="status_wt_<%= notification.getId() %>" name="wt_<%= notification.getId() %>" notificationId="<%= notification.getId() %>" type="radio" class="wtNotificationStatus" value="true"><oz:messageSource code="oz.mdu.notificationcenter.profile.constants.status.enabled"/>&nbsp;&nbsp;&nbsp;&nbsp;
											<input id="status_wt_<%= notification.getId() %>" name="wt_<%= notification.getId() %>" notificationId="<%= notification.getId() %>" type="radio" class="wtNotificationStatus" value="false" checked="checked"><oz:messageSource code="oz.mdu.notificationcenter.profile.constants.status.disabled"/>
									<%				
												}
									%>	
										</td>
										<td></td>
										<td>
											<select id="action_wt_<%= notification.getId() %>" notificationId="<%= notification.getId() %>" class="wtNotificationAction" style="width:148px">
									<%
												NameValuePair actionOption = null;
												for(int ai = 0; ai < actionOptions.size(); ai++){
													actionOption = (NameValuePair)actionOptions.get(ai);
													if(alertAction.equalsIgnoreCase(actionOption.getValue())){
									%>
												<option value="<%= actionOption.getValue() %>" selected="selected"><%= actionOption.getName() %></option>
									<%						
													}else{
									%>
												<option value="<%= actionOption.getValue() %>"><%= actionOption.getName() %></option>
									<%						
													}
												}
									%>
										</td>
										<td></td>
									</tr>
									<% 			
											}
										}
									%>
								</table>	
							</div>
						</div>
						<div data-tab-panel='{"id":"tab_02","title":"<oz:messageSource code="oz.mdu.notificationcenter.profile.tabs.sparetime"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
							<div class="oz-form-fields">
								<table cellpadding="2" cellspacing="2" style="border: 0px solid black">
									<tr> 
										<td style="text-align: right;padding-right: 4px;">
											<b><oz:messageSource code="oz.mdu.notificationcenter.profile.constants.sparetimetype"/>：</b>
										</td>
										<td colspan="4">
											<input type="radio" id="rdSpareTimeType" name="rdSpareTimeType" value="1" checked="checked" onclick="onSpareTimeType_Clicked()"><oz:messageSource code="oz.mdu.notificationcenter.profile.constants.sparttimetype.normal"/>&nbsp;&nbsp;&nbsp;&nbsp;
											<input type="radio" id="rdSpareTimeType" name="rdSpareTimeType" value="2" onclick="onSpareTimeType_Clicked()"><oz:messageSource code="oz.mdu.notificationcenter.profile.constants.sparttimetype.delay"/>&nbsp;&nbsp;&nbsp;&nbsp;
											<input type="radio" id="rdSpareTimeType" name="rdSpareTimeType" value="3" onclick="onSpareTimeType_Clicked()"><oz:messageSource code="oz.mdu.notificationcenter.profile.constants.sparttimetype.ignore"/>&nbsp;&nbsp;&nbsp;&nbsp;
											<input type="radio" id="rdSpareTimeType" name="rdSpareTimeType" value="9" onclick="onSpareTimeType_Clicked()"><oz:messageSource code="oz.mdu.notificationcenter.profile.constants.sparttimetype.ud"/>
										</td>
									</tr>
									<tr class="spareTimeTr">
										<td width="40%" style="text-align: right;padding-right: 4px;">
											<b><oz:messageSource code="oz.mdu.notificationcenter.profile.constants.status"/>：</b>
										</td>
										<td width="14%">
											<input type="radio" id="rdSpareTimeStatus" name="rdSpareTimeStatus" value="true" checked="checked" onclick="onSpareTimeStatus_Clicked()"><oz:messageSource code="oz.mdu.notificationcenter.profile.constants.status.enabled"/>&nbsp;&nbsp;&nbsp;&nbsp;
											<input type="radio" id="rdSpareTimeStatus" name="rdSpareTimeStatus" value="false" onclick="onSpareTimeStatus_Clicked()"><oz:messageSource code="oz.mdu.notificationcenter.profile.constants.status.disabled"/>
										</td>
										<td width="10%" style="text-align: right;padding-right: 4px;">
											<b><oz:messageSource code="oz.mdu.notificationcenter.profile.constants.alertaction"/>：</b>
										</td>
										<td width="27%">
											<oz:select value="spareTimeAlertAction" property="spareTimeAlertAction" options="alertActions" style="width:148px" onchange="onSpareTimeAlertAction_Changed()"></oz:select>
										</td>
										<td width="10%"></td>
									</tr>
									<tr height="4px;" class="spareTimeTr"> 
										<td colspan="5">
											<hr style="width:92%;float:right;margin-right:12px;">
										</td>
									</tr>
									<%
										if(null != notifications && notifications.size() > 0){
											Notification notification = null;
											boolean enabled = true;
											String alertAction = "";
											for(int i = 0; i < notifications.size(); i++){
												notification = (Notification)notifications.get(i);
												if(null == notification)
													continue;
												
												NotificationCfgItem cfgItem = profile.getCfgItem(notification.getId(), NotificationProfile.TST_SPARE);
												if(null != cfgItem){
													enabled = cfgItem.isEnable();
													alertAction = cfgItem.getActions();
												}else{
													enabled = notification.isEnable();
													alertAction = notification.getDefaultAction();
												}
									%>
									<tr class="spareTimeTr"> 
										<td style="text-align: right;padding-right: 4px;">
											<b><%= notification.getName() %>：</b>
										</td>
										<td>
									<%
												if(enabled){
									%>
											<input id="status_st_<%= notification.getId() %>" name="st_<%= notification.getId() %>" notificationId="<%= notification.getId() %>" type="radio" class="stNotificationStatus" value="true" checked="checked"><oz:messageSource code="oz.mdu.notificationcenter.profile.constants.status.enabled"/>&nbsp;&nbsp;&nbsp;&nbsp;
											<input id="status_st_<%= notification.getId() %>" name="st_<%= notification.getId() %>" notificationId="<%= notification.getId() %>" type="radio" class="stNotificationStatus" value="false"><oz:messageSource code="oz.mdu.notificationcenter.profile.constants.status.disabled"/>
									<%				
												}else{
									%>
											<input id="status_st_<%= notification.getId() %>" name="st_<%= notification.getId() %>" notificationId="<%= notification.getId() %>" type="radio" class="stNotificationStatus" value="true"><oz:messageSource code="oz.mdu.notificationcenter.profile.constants.status.enabled"/>&nbsp;&nbsp;&nbsp;&nbsp;
											<input id="status_st_<%= notification.getId() %>" name="st_<%= notification.getId() %>" notificationId="<%= notification.getId() %>" type="radio" class="stNotificationStatus" value="false" checked="checked"><oz:messageSource code="oz.mdu.notificationcenter.profile.constants.status.disabled"/>
									<%				
												}
									%>	
										</td>
										<td></td>
										<td>
											<select id="action_st_<%= notification.getId() %>" notificationId="<%= notification.getId() %>" class="stNotificationAction" style="width:148px">
									<%
												NameValuePair actionOption = null;
												for(int ai = 0; ai < actionOptions.size(); ai++){
													actionOption = (NameValuePair)actionOptions.get(ai);
													if(alertAction.equalsIgnoreCase(actionOption.getValue())){
									%>
												<option value="<%= actionOption.getValue() %>" selected="selected"><%= actionOption.getName() %></option>
									<%						
													}else{
									%>
												<option value="<%= actionOption.getValue() %>"><%= actionOption.getName() %></option>
									<%						
													}
												}
									%>
										</td>
										<td></td>
									</tr>
									<% 			
											}
										}
									%>
									<tr class="spareTimeTrBlank">
										<td width="40%">
											&nbsp;
										</td>
										<td width="14%">
											&nbsp;
										</td>
										<td width="10%" style="text-align: right;padding-right: 4px;">
											&nbsp;
										</td>
										<td width="27%">
											&nbsp;
										</td>
										<td width="10%">
											&nbsp;
										</td>
									</tr>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 表单域  -->
			<html:hidden property="id" styleId="id"/><html:hidden property="userId" styleId="userId"/>
			<html:hidden property="spareTimeNotificationType" styleId="spareTimeNotificationType"/>		
		</div>
	</html:form>
</body>
<oz:js/>
<oz:js jsId="jquery-json"/>
<script type="text/javascript">
function onWorkTimeAlertAction_Changed(){
	var action = $("#workTimeAlertAction").val();
	$(".wtNotificationAction").each(function(){
		$(this).val(action);
	});
}

function onWorkTimeStatus_Clicked(){
	var status = val("rdWorkTimeStatus");
	$(".wtNotificationStatus").each(function(){
		if($(this).attr("value") == status){
			$(this).attr("checked", "checked");
		}
	});
}

function onSpareTimeAlertAction_Changed(){
	var action = $("#spareTimeAlertAction").val();
	$(".stNotificationAction").each(function(){
		$(this).val(action);
	});
}

function onSpareTimeStatus_Clicked(){
	var status = val("rdSpareTimeStatus");
	$(".stNotificationStatus").each(function(){
		if($(this).attr("value") == status){
			$(this).attr("checked", "checked");
		}
	});
}

function onSpareTimeType_Clicked(){
	var type = val("rdSpareTimeType");
	$("#spareTimeNotificationType").val(type);
	$(".spareTimeTr").each(function(){
		if(type == "9"){
			$(this).show();
		}else{
			$(this).hide();
		}
	});
}

function onBtnSave_Clicked(){
	// 组合返回的数据
	var datas = {};
	var workTimeAlertActions = {};
	$(".wtNotificationAction").each(function(){
		var id = $(this).attr("notificationId");
		workTimeAlertActions[id] = $(this).val();
	});
	datas.workTimeAlertActions = workTimeAlertActions;
	
	var workTimeStatus = {};
	$(".wtNotificationStatus").each(function(){
		if($(this).attr("checked") == "checked"){
			var id = $(this).attr("notificationId");
			workTimeStatus[id] = $(this).attr("value");
		}
	});
	datas.workTimeStatus = workTimeStatus;
	
	// 判断业务时间的提醒类型
	var spareTimeNotificationType = $("#spareTimeNotificationType").val();
	if(spareTimeNotificationType == "9"){
		var spareTimeAlertActions = {};
		$(".stNotificationAction").each(function(){
			var id = $(this).attr("notificationId");
			spareTimeAlertActions[id] = $(this).val();
		});
		datas.spareTimeAlertActions = spareTimeAlertActions;
		
		var spareTimeStatus = {};
		$(".stNotificationStatus").each(function(){
			if($(this).attr("checked") == "checked"){
				var id = $(this).attr("notificationId");
				spareTimeStatus[id] = $(this).attr("value");
			}
		});
		datas.spareTimeStatus = spareTimeStatus;	
	}
	datas.spareTimeNotificationType = spareTimeNotificationType;
	
	var saveUrl = contextPath + "/module/notificationProfileAction.do?action=save&timeStamp=" + new Date().getTime();		
	$.post(
		saveUrl,
		{datas:$.toJSON(datas)},
		function(json){
			if(json.result === true){
				OZ.Msg.slide(json.msg || "信息保存成功！");	
			}else{
				OZ.Msg.slide(json.msg || "信息保存失败！");
			}
		},
		"json"
	);	
}

$(function() {
	$("#tabCt").tabs();
	$("#tabCt").tabs("activeTab","tab_01");	
	val("rdSpareTimeType", $("#spareTimeNotificationType").val());
	onSpareTimeType_Clicked();
});
</script>
</html>