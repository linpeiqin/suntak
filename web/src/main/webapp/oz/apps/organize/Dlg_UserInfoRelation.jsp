<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" tree="true" messager="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.organize.userinfo.relation"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body oz-form" style="background-color: #FFFFFF;height:100%;width:100%;overflow:hidden;border:none;margin: 0px;padding: 0px;">
	<table width="100%" class="oz-form-bordertable" style="border-top:0px solid #99BBE8;">
		<tr height="28px"> 
			<td class="oz-form-label" width="24%">
				<oz:messageSource code="oz.mdu.organize.userinfo.relation.fields.relationtype"/>：
			</td>
			<td class="oz-property" width="76%">
				<oz:select value="relationType" property="relationType" options="relationTypeOptions"></oz:select>
			</td>	
		</tr>
		<tr height="28px">
			<td class="oz-form-label">
				<oz:messageSource code="oz.mdu.organize.userinfo.relation.fields.userinfoname"/>：
			</td>
			<td class="oz-property">
				<input type="text" id="userInfoName" name="userInfoName" style="width:162px;float:left" readonly="readonly" class="oz-form-zdField" value="${userInfoName}">
				<input id="btnSelect" type="button" class="oz-form-button" value='<oz:messageSource code="oz.select"/>' onClick="OZ.Organize.selectUserInfo(onSelectUserInfo)" style="width:62px;height:21px;float:right"/>
			</td>
		</tr>
		<tr height="28px">
			<td class="oz-form-label">
				<oz:messageSource code="oz.mdu.organize.userinfo.relation.fields.authorization"/>：
			</td>
			<td>
				<c:if test="${!empty authzCodes}" >
					<c:forEach var="authzCode" items="${authzCodes}">
						<input type="checkbox" name="authzCode" class="authzCode" id="authzCode_${authzCode.value}" value="${authzCode.value}">
						<label for="authzCode_${authzCode.value}" style="cursor:pointer">${authzCode.name}</label>
					</c:forEach>
				</c:if>
			</td>	
		</tr>
	</table>
	<input type="hidden" id="userInfoId" name="userInfoId" value="${userInfoId}">
	<input type="hidden" id="authorizations" name="authorizations" value="${authorizations}">
</body>
<oz:js/>
<script type="text/javascript" src="<oz:contextPath/>/oz/apps/organize/js/oz.organize.js"></script>
<script type="text/javascript">
$(function(){
	var authorizations = $("#authorizations").val();
	if(null != authorizations && authorizations.length > 0){
		var authzCodes = authorizations.split(",");
		if(null != authzCodes && authzCodes.length > 0){
			$(".authzCode").each(function(){
				var curValue = $(this).attr("value");
				for(var i = 0; i < authzCodes.length; i++){
					if(curValue == authzCodes[i]){
						$(this).attr("checked", "checked");
						break;
					}
				}
			});
		}
	}
});

function onSelectUserInfo(result){
	$("#userInfoName").val(result.name);
	$("#userInfoId").val(result.id);
}

function ozDlgOkFn(){
	var relationType = $("#relationType").val();
	var userInfoId = $("#userInfoId").val();
	var userInfoName = $("#userInfoName").val();
	if(userInfoName.length == 0 || userInfoId.length == 0){
		OZ.Msg.alert("请先选择人员");
        return false;	
	}
	
	// 组合授权信息
	var authzCodes = "";
	$(".authzCode").each(function(){
		if($(this).attr("checked")){
			if(authzCodes.length > 0)
				authzCodes += ",";
			authzCodes += $(this).attr("value");
		}
	});
	
    return { 
    	relationType:relationType,
    	userInfoId:userInfoId,
    	userInfoName:userInfoName,
    	authzCodes:authzCodes
    };
}
</script>
</html>