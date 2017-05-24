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
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.organize.userinfo"/>" style="background-color: #F4FEFF;height:100%;width:100%;overflow:hidden;border:none;margin: 0px;padding: 0px;">
	<table width="390" style="background-color:#FFFFFF" >
		<tr>
			<td width="250px" valign="top">
				<div style="width:248;height:267px;overflow:auto;border:1px solid #7F9DB9">
					<ul id="ouTree"></ul>
				</div>
			</td>
			<td width="140" class="oz-property">
				<input type="text" id="searchCondition" onkeyup="findUsers()">
				<select id="user" name="user" style="width:100%;height:250px;" size="16"  ondblclick="onSelectUser_DblClicked()">
				</select>
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
    
	var selOptionObj = document.getElementById("user");
    selOptionObj.length = 0;
    var strUrl = contextPath + "/organize/userInfoAction.do?action=findUserByOUInfo&timeStamp=" + new Date().getTime();
    $.getJSON(
		strUrl, 
		{ouId:ouId, userType:userType},
		function(json){
			var users = json.users;
			if(users.length > 0){
				for(var i = 0; i < users.length; i++){
					selOptionObj.options[selOptionObj.length] = new Option(users[i].name, users[i].id);
				}
			}
		}
	);
}

function findUsers(){
	var searchCondition = $("#searchCondition").val();
	if(null == searchCondition || searchCondition.length < 1)
		return;
	
	var selOptionObj = document.getElementById("user");
    selOptionObj.length = 0;
    var strUrl = contextPath + "/organize/userInfoAction.do?action=findUserBySearch&timeStamp=" + new Date().getTime();
    $.getJSON(
		strUrl, 
		{searchCondition:searchCondition, userType:userType},
		function(json){
			var users = json.users;
			if(users.length > 0){
				// 清空原来的
				OZ.SELECT.removeAll("user");
				for(var i = 0; i < users.length; i++){
					// 首先判断是否已经存在
					if(!OZ.SELECT.isExist("user", users[i].id)){
						selOptionObj.options[selOptionObj.length] = new Option(users[i].name, users[i].id);
					}
				}
			}
		}
	);
}

function onSelectUser_DblClicked(){
	OZ.Dlg.fireButtonEvent(0, "dlg_selectUser");
}

function ozDlgOkFn(){
	var selOptionObj = document.getElementById("user");
	var option = null;
	var len = selOptionObj.length;
	for(var i = 0; i < len; i++){
		if(selOptionObj.options[i].selected){
			option = selOptionObj.options[i];
			break;
		}
	}
	if(null == option){
		OZ.Msg.alert('<oz:messageSource code="oz.mdu.organize.userinfo.msg.selectuser.none"/>');
        return false;
    }
		
    return { 
        id:option.value,
        name:option.text
    };
}
</script>
</html>