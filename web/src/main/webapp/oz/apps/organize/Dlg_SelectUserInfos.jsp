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
	<table width="600" style="background-color:#FFFFFF" >
		<tr>
			<td width="250px" valign="top">
				<div style="width:248;height:267px;overflow:auto;border:1px solid #7F9DB9">
					<ul id="ouTree"></ul>
				</div>
			</td>
			<td width="140" valign="top" class="oz-property">
				<input type="text" id="searchCondition" onkeyup="findUserInfos()">				
				<select id="userInfo" name="userInfo" style="width:100%;height:260px;" multiple="multiple" ondblclick="OZ.SELECT.appendSelected('userInfo', 'userInfos', false)">
				</select>
			</td>
			<td width="70px" style="text-align:center; vertical-align:middle;">
				<input id="btnAdd" type="button" class="oz-form-button" value=" <oz:messageSource code="oz.add"/> > " onclick="OZ.SELECT.appendSelected('userInfo', 'userInfos', false)"/><br /><br /><br />
				<input id="btnDelete" type="button" class="oz-form-button" value=" < <oz:messageSource code="oz.delete"/> " onclick="OZ.SELECT.appendSelected('userInfos', 'userInfo', true)"/><br /><br /><br />
				<input id="btnClear" type="button" class="oz-form-button" value=" << <oz:messageSource code="oz.clearall"/> " onclick="OZ.SELECT.removeAll('userInfos')"/>
			</td>
			<td width="140px" valign="top">
				<oz:select value="userInfos" property="userInfos" options="userInfoOptions" multiple="true" style="width:100%;height:263px;"></oz:select>
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
			allUserInfos = json.userInfos;
			if(allUserInfos.length > 0){
				for(var i = 0; i < allUserInfos.length; i++){
					selOptionObj.options[selOptionObj.length] = new Option(allUserInfos[i].name, allUserInfos[i].id);
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
			allUserInfos = json.userInfos;
			if(allUserInfos.length > 0){
				// 清空原来的
				OZ.SELECT.removeAll("userInfo");
				for(var i = 0; i < allUserInfos.length; i++){
					// 首先判断是否已经存在
					if(!OZ.SELECT.isExist("userInfo", allUserInfos[i].id)){
						selOptionObj.options[selOptionObj.length] = new Option(allUserInfos[i].name, allUserInfos[i].id);
					}
				}
			}
		}
	);
}

function ozDlgOkFn(){
	var selOptionObj = document.getElementById("userInfos");
	var option = null;
	var len = selOptionObj.length;
	if(len == 0){
		OZ.Msg.alert('<oz:messageSource code="oz.mdu.organize.userinfo.msg.selectuserinfo.none"/>');
        return false;
    }

	var users = new Array();
	for(var i = 0; i < len; i++){
		users[i] = {id : selOptionObj.options[i].value, name : selOptionObj.options[i].text };
	}
	return users;
}
</script>
</html>