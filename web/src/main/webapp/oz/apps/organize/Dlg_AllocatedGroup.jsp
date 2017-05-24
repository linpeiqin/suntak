<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" tree="true" select="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.security.role.allocated.group"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" style="height:100%;width:100%;overflow:hidden;border:none;margin: 0px;padding: 0px;">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="security/permissionAction" searchButton="none">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="security/permissionAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title">
				<%= request.getAttribute("name") %>(<%= request.getAttribute("code") %>)
			</div>
			<div style="width:100%;height480px;overflow:auto;">
				<table cellpadding="3" cellspacing="3" style="width:600px;margin:2px 2px 2px 2px;">
					<tr>
						<td width="300px" valign="top">
							<div style="width:310px;height:440px;overflow:auto;border:1px solid #76ABD3">
								<ul id="groupOUTree"></ul>
							</div>
						</td>
						<td width="300px" valign="top">
							<select id="groups" style="width:310px;size:12;height:440px" multiple="multiple" ondblclick="onGroup_Clicked()"></select>
						</td>
					</tr>
				</table>
			</div>
		</html:form>
	</div>		
</body>
<oz:js/>
<script type="text/javascript">
var _roleId = '<%= request.getAttribute("roleId") %>';

function reloadGroups(ouId){
	OZ.SELECT.removeAll("groups");
	var selOptionObj = document.getElementById("groups");
    selOptionObj.length = 0;
    var strUrl = contextPath + "/organize/groupAction.do?action=findGroupByOUInfo&timeStamp=" + new Date().getTime();
    $.getJSON(
		strUrl, 
		{ouId:ouId, roleId:_roleId},
		function(json){
			var groups = json.groups;
			if(groups.length > 0){
				for(var i = 0; i < groups.length; i++){
					selOptionObj.options[selOptionObj.length] = new Option(groups[i].name, groups[i].id);
				}
			}
		}
	);
}

function onGroup_Clicked(){
	var groupId = $("#groups").val();
	var strUrl = contextPath + "/organize/groupAction.do?action=open&timeStamp=" + new Date().getTime();
	strUrl += "&id=" + groupId;
	OZ.openWindow({
		id: "Group" + groupId,
		title: "岗位配置",
		url: strUrl, 
		refresh: false,
		beforeCloseFnName: "oz_Win_BeforeClose"
	});
}

$(function(){
	$('#groupOUTree').tree({
		url: contextPath + '/organize/ouTreeAction.do?action=getTree&timeStamp=' + new Date().getTime(),
		click:function(e, data){
			reloadGroups(data.id);
		}
	});
});
</script>
</html>