<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" tree="true" messager="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.organize.ouinfo"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body oz-form" style="background-color: #F4FEFF;height:100%;width:100%;overflow:hidden;border:none;margin: 0px;padding: 0px;">
	<table width="100%" style="background-color:#FFFFFF" >
		<tr>
			<td style="padding-left:8px">
				<b><oz:messageSource code="oz.mdu.organize.oumanager.fields.managertype"/>:</b>
			</td>
		</tr>
		<tr>
			<td class="oz-property" style="padding-left:8px">
				<oz:select value="managerType" property="managerType" options="managerTypeOptions" style="width:230px" onchange="onManagerType_Changed()"></oz:select>
			</td>
		</tr>
		<tr>
			<td style="padding-left:8px">
				<b><oz:messageSource code="oz.mdu.organize.oumanager.fields.userinfo"/>:</b>
			</td>
		</tr>
		<tr id="TR_SELECT_LOCAL">
			<td class="oz-property" style="padding-left:8px">
				<oz:select value="userInfo" property="userInfo" options="userInfoOptions" style="width:230px"></oz:select>
			</td>
		</tr>
		<tr id="TR_SELECT_ALL">
			<td class="oz-property" style="padding-left:8px">
				<input type="text" id="userInfoEx" name="userInfoEx" style="width:161px;float:left" readonly="readonly" class="oz-form-zdField"><input id="btnSelect" type="button" class="oz-form-button" value='<oz:messageSource code="oz.select"/>' onClick="OZ.Organize.selectUserInfo(onSelectUserInfo)" style="width:62px;height:21px;float:right"/>
			</td>
		</tr>
	</table>
	<input type="hidden" id="userInfoExId" name="userInfoExId">
</body>
<oz:js/>
<script type="text/javascript" src="<oz:contextPath/>/oz/apps/organize/js/oz.organize.js"></script>
<script type="text/javascript">
$(function(){
	onManagerType_Changed();
});

function onManagerType_Changed(){
	var managerType = $("#managerType").val();
	if(managerType.indexOf("DW_") >= 0){
		$("#TR_SELECT_ALL").show();
		$("#TR_SELECT_LOCAL").hide();
	}else{
		$("#TR_SELECT_ALL").hide();
		$("#TR_SELECT_LOCAL").show();
	}
}

function onSelectUserInfo(result){
	$("#userInfoEx").val(result.name);
	$("#userInfoExId").val(result.id);
}

function ozDlgOkFn(){
	var managerType = $("#managerType").val();
	var userInfoId = "";
	var userInfoName = "";
	if(managerType.indexOf("DW_") >= 0){
		userInfoId = $("#userInfoExId").val();
		userInfoName = $("#userInfoEx").val();
	}else{
		var userInfoObj = document.getElementById("userInfo");
		for(var i = 0; i < userInfoObj.length; i++){
			if(userInfoObj.options[i].selected){
				userInfoId = userInfoObj.options[i].value;
				userInfoName = userInfoObj.options[i].text;
				break;
			}
		}
	}
	if(userInfoName.length == 0 || userInfoId.length == 0){
		OZ.Msg.alert("<oz:messageSource code="oz.mdu.organize.oumanager.msg.userinfo.isnull"/>");
        return false;	
	}
	
    return { 
    	managerType:managerType,
    	userInfoId:userInfoId,
    	userInfoName:userInfoName
    };
}
</script>
</html>