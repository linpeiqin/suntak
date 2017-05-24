<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="dialog" tree="true" messager="true" select="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.organize.userinfo"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" style="background-color: #F4FEFF;height:100%;width:100%;overflow:hidden;border:none;margin: 0px;padding: 0px;">
	<table width="100%" style="background-color:#FFFFFF" >
		<tr>
			<td width="65%" valign="top">
				<div style="height:267px;width:100%;overflow:auto;border-bottom:1px solid #8DB2E3;background-color:white;">
					<ul id="ouTree"></ul>
				</div>
			</td>
			<td width="35%" class="oz-property">
				<div style="width:100%; height:267px;border-left:1px solid #8DB2E3;border-bottom:1px solid #8DB2E3;overflow:hidden;position: relative;">
					<input type="text" id="searchCondition" onkeyup="findUserInfos()" style="width:98%;position:absolute; top:1px;border-width:0px; border-bottom : 1px solid #8DB2E3;background-color: white;z-index: 1000"> 
					<select id="userInfo" name="userInfo" size="16" style="width:100%;position:absolute;top:20px;left:-2px;height:248px;z-index:1; outline:none;" ondblclick="onSelectUserInfo_DblClicked()"></select>
				</div>
			</td>
		</tr>
	</table>
</body>
<oz:js/>
<script type="text/javascript">
var userType = "<%= request.getAttribute("userType") %>";

$(function(){
	var strUrl = contextPath + '/organize/ouTreeAction.do?action=getTree&timeStamp=' + new Date().getTime()
	strUrl += "&ouId=<%= request.getAttribute("ouId") %>";
	$('#ouTree').tree({
		url: strUrl,
		click:function(e, data){
			onTree_Clicked(data.id);
		}
	});
});

function onTree_Clicked(ouId){
	var node = $('#ouTree').tree('getSelected');
	if(null == node)
        return;
	if(node.type != "DW" && node.type != "dw" && node.type != "BM" && node.type != "bm")
		return;
	
	var selOptionObj = document.getElementById("userInfo");
    selOptionObj.length = 0;
    var strUrl = contextPath + "/organize/userInfoAction.do?action=findUserInfoByOUInfo&timeStamp=" + new Date().getTime();
    $.getJSON(
		strUrl, 
		{ouId:ouId, userType:userType},
		function(json){
			var userInfos = json.userInfos;
			if(userInfos.length > 0){
				for(var i = 0; i < userInfos.length; i++){
					selOptionObj.options[selOptionObj.length] = new Option(userInfos[i].name, userInfos[i].id);
				}
			}
		}
	);
}

function findUserInfos(){
	var searchCondition = $("#searchCondition").val();
	if(null == searchCondition || searchCondition.length < 1)
		return;
	
	var selOptionObj = document.getElementById("userInfo");
    selOptionObj.length = 0;
    var strUrl = contextPath + "/organize/userInfoAction.do?action=findUserInfoBySearch&timeStamp=" + new Date().getTime();
    $.getJSON(
		strUrl, 
		{searchCondition:searchCondition, userType:userType},
		function(json){
			var userInfos = json.userInfos;
			if(userInfos.length > 0){
				// 清空原来的
				OZ.SELECT.removeAll("userInfo");
				for(var i = 0; i < userInfos.length; i++){
					// 首先判断是否已经存在
					if(!OZ.SELECT.isExist("userInfo", userInfos[i].id)){
						selOptionObj.options[selOptionObj.length] = new Option(userInfos[i].name, userInfos[i].id);
					}
				}
			}
		}
	);
}

function onSelectUserInfo_DblClicked(){
	OZ.Dlg.fireButtonEvent(0, "dlg_selectUserInfo");
}

function ozDlgOkFn(){
	var selOptionObj = document.getElementById("userInfo");
	var option = null;
	var len = selOptionObj.length;
	for(var i = 0; i < len; i++){
		if(selOptionObj.options[i].selected){
			option = selOptionObj.options[i];
			break;
		}
	}
	if(null == option){
		OZ.Msg.alert('<oz:messageSource code="oz.mdu.organize.userinfo.msg.selectuserinfo.none"/>');
        return false;
    }
		
    return { 
        id:option.value,
        name:option.text
    };
}
</script>
</html>