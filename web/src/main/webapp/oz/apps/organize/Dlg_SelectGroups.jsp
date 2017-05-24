<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="dialog" tree="true" messager="true" select="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.organize.group"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" style="background-color: #F4FEFF;height:100%;width:100%;overflow:hidden;border:none;margin: 0px;padding: 0px;">
	<table width="600" style="background-color:#FFFFFF" >
		<tr>
			<td width="250px">
				<div style="width:248;height:262px;overflow:auto;border:1px solid #7F9DB9">
					<ul id="ouTree"></ul>
				</div>
			</td>
			<td width="140">
				<select id="group" name="group" style="width:100%;height:263px;" multiple="multiple" ondblclick="onSelectGroup_DblClicked()">
				</select>
			</td>
			<td width="70px" style="text-align:center; vertical-align:middle;">
				<input id="btnAdd" type="button" class="oz-form-button" value=" <oz:messageSource code="oz.add"/> > " onclick="OZ.SELECT.appendSelected('group', 'groups', false)"/><br /><br /><br />
				<input id="btnDelete" type="button" class="oz-form-button" value=" < <oz:messageSource code="oz.delete"/> " onclick="OZ.SELECT.appendSelected('groups', 'group', false)"/><br /><br /><br />
				<input id="btnClear" type="button" class="oz-form-button" value=" << <oz:messageSource code="oz.clearall"/> " onclick="OZ.SELECT.removeAll('groups')"/>
			</td>
			<td width="140px">
				<oz:select value="groups" property="groups" options="groupOptions" multiple="true" style="width:100%;height:263px;"></oz:select>
			</td>
		</tr>
	</table>
		
</body>
<oz:js/>
<script type="text/javascript">
var groupType = "<%= request.getAttribute("groupType") %>";

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
	
	var selOptionObj = document.getElementById("group");
    selOptionObj.length = 0;
    var strUrl = contextPath + "/organize/groupAction.do?action=findGroupByOUInfo&timeStamp=" + new Date().getTime();
    $.getJSON(
		strUrl, 
		{ouId:ouId, groupType:groupType},
		function(json){
			allGroups = json.groups;
			if(allGroups.length > 0){
				for(var i = 0; i < allGroups.length; i++){
					selOptionObj.options[selOptionObj.length] = new Option(allGroups[i].name, allGroups[i].id);
				}
			}
		}
	);
}

function onSelectGroup_DblClicked(){
	OZ.SELECT.appendSelected('group', 'groups', false);
}

function ozDlgOkFn(){
	var selOptionObj = document.getElementById("groups");
	var option = null;
	var len = selOptionObj.length;
	if(len == 0){
		OZ.Msg.alert('<oz:messageSource code="oz.mdu.organize.group.msg.selectgroup.none"/>');
        return false;
    }

	var groups = new Array();
	for(var i = 0; i < len; i++){
		groups[i] = {id : selOptionObj.options[i].value, name : selOptionObj.options[i].text };
	}
	return groups;
}
</script>
</html>