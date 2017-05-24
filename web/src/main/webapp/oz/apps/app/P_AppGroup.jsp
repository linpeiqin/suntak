<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" easyui="true" select="true"/>
<head>
	<title><oz:messageSource code="oz.web.appgroup"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.web.appgroup"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="app/appGroupAction" defaultTB="editForm">
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<div class="oz-form-fields">
			<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:98%;border-top-width:0px">
				<tr class="oz-form-locate-tr">
					<td width="40%" style="border-left:1px solid white;"></td>
					<td width="60%" style="border-right:1px solid white;"></td>
				</tr>
				<tr class="oz-form-tr"> 
					<td class="oz-property">
						<div class="oz-form-separator" style="width:100%;height:24px;;float:left">
							<h2 class="oz-form-separator-title">
								可选应用
							</h2>								
						</div>
					</td>
					<td class="oz-property">
						<div class="oz-form-separator" style="width:100%;height:24px;float:left">
							<h2 class="oz-form-separator-title">
								应用分组
							</h2>
						</div>
					</td>
				</tr>
				<tr class="oz-form-tr" height="480px;"> 
					<td class="oz-property" style="vertical-align:middle;">
						<oz:select value="optionalApp" property="optionalApps" options="optionalApps" size="24" multiple="true" style="height:100%;"></oz:select>
					</td>
					<td class="oz-property" style="vertical-align:top;">
						<c:if test="${not empty appGroups}">
							<c:forEach var="appGroup" items="${appGroups}">
								<div id="Ag${appGroup.id}" class="appGroupDiv">
									<div style="width:100%;height:120px;position:relative;">
										<div style="display:block;position:absolute;left:0;top:0;bottom:0;width:80px;text-align:center;vertical-align:middle;padding-top:42px;">
											<oz:linkButton onclick="onBtnAddApp_Clicked('${appGroup.id}')" text="添加>>"></oz:linkButton>
											<br/><br/>
											<oz:linkButton onclick="onBtnDelApp_Clicked('${appGroup.id}')" text="<<删除"></oz:linkButton>
										</div>
										<div style="display:inline;position:absolute;left:80px;right:0px;top:0;bottom:0;">
											<div style="padding:4px;padding-right:0">
												分组名称：<input id="groupNameAg${appGroup.id}" type="text" class="oz-appgroup oz-form-btField" style="width:80px" value="${appGroup.groupName}">&nbsp;&nbsp;&nbsp;&nbsp;
												排序号：<input id="orderNoAg${appGroup.id}" type="text" class="oz-appgroup oz-form-btField" style="width:80px" value="${appGroup.orderNo}">
												<div style="float:right;">
													<oz:linkButton onclick="onBtnDelAppGroup_Clicked('${appGroup.id}')" text="删除本分组"></oz:linkButton>
												</div>
											</div>
											<div>
												<select id="selectedAg${appGroup.id}" style="width::100%;height:81px" multiple="multiple">
													<c:if test="${not empty appGroup.appOptions}">												
														<c:forEach var="option" items="${appGroup.appOptions}">
															<option value="${option.value}">${option.name}
														</c:forEach>
													</c:if>
												</select>
											</div>
										</div>
									</div>
									<hr>
								</div>	
							</c:forEach>
						</c:if>
						<div id="appGroupBtnDiv" style="float:right;">
							<oz:linkButton onclick="onBtnAddAppGroup_Clicked()" text="添加分组"></oz:linkButton>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
<oz:js/>
<oz:js jsId="jquery-tmpl"/>
<script id="appGroupTpl" type="text/html">
<div id="Ag{{= groupId}}" class="appGroupDiv" >	
	<div style="width:100%;height:120px;position:relative;">
		<div style="display:block;position:absolute;left:0;top:0;bottom:0;width:80px;text-align:center;vertical-align:middle;padding-top:42px;">
			<div class="oz-planbutton"><a id="btnAddApp" href="javascript:onBtnAddApp_Clicked(\'{{= groupId}}\')">添加>></a></div>
			<br/><br/>
			<div class="oz-planbutton"><a id="btnDelAppL" href="javascript:onBtnDelApp_Clicked(\'{{= groupId}}\')"><<删除</a></div>
		</div>
		<div style="display:block;position:absolute;left:80px;right:0px;top:0;bottom:0;">
			<div style="padding:4px;padding-right:0">
				分组名称：<input id="groupNameAg{{= groupId }}" type="text" class="oz-appgroup oz-form-btField" style="width:80px">&nbsp;&nbsp;&nbsp;&nbsp;
				排序号：<input id="orderNoAg{{= groupId }}" type="text" class="oz-appgroup oz-form-btField" style="width:80px">
				<div style="float:right;">
					<div class="oz-planbutton"><a id="btnDelAppGroup" href="javascript:onBtnDelAppGroup_Clicked(\'{{= groupId}}\')">删除本分组 </a></div>
				</div>
			</div>
			<div>
				<select id="selectedAg{{= groupId }}" style="width::100%;height:81px" multiple="multiple">
						
				</select>
			</div>
		</div>			
	</div>
	<hr>
</div>	
</script>
<script type="text/javascript">
function onBtnAddAppGroup_Clicked(){
	$("#appGroupBtnDiv").before($("#appGroupTpl").render([{groupId:new Date().getTime()}]));
}

function onBtnAddApp_Clicked(groupId){
	OZ.SELECT.appendSelected("optionalApps", "selectedAg" + groupId, true);
}

function onBtnDelApp_Clicked(groupId){
	OZ.SELECT.appendSelected("selectedAg" + groupId, "optionalApps", true);
}

function onBtnDelAppGroup_Clicked(groupId){
	$("#Ag" + groupId).hide(500, function(){
		$(this).remove();
	});
}

function onBtnSave_Clicked(){
	var datas = "";
	$(".appGroupDiv").each(function(){
		var groupId = $(this).attr("id");
		var appIds = "";
		$("#selected" + groupId + " option").each(function(){
			if(appIds.length > 0)
				appIds += "|";
			appIds += $(this).attr("value");	
		});
		
		var name = $("#groupName" + groupId).val();
		var orderNo = $("#orderNo" + groupId).val();
		
		if(null == name || name.length == 0 || null == orderNo || orderNo.length == 0 || null == appIds || appIds.length == 0){
			OZ.Msg.info("请填写完成的应用分组信息。");
			return false;
		}
		if(datas.length > 0)
			datas += ";";
		datas += name + "," + orderNo + "," + appIds;
	});
	
	$.post(
		contextPath + "/app/appGroupAction.do?action=save&timeStamp=" + new Date().getTime(), 
		{groups:datas},
		function(json){
			if(json.result == true){
				OZ.Msg.slide(json.msg || "信息保存成功！");
			}else{
				OZ.Msg.info(json.msg);
			}
		}, 
		"json"
	);	
}

$(function(){
	
});
</script>
</html>