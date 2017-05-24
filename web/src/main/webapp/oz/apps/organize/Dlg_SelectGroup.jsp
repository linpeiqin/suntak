<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="dialog" tree="true" messager="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.organize.group"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.organize.group"/>" style="background-color: #F4FEFF;height:100%;width:100%;overflow:hidden;border:none;margin: 0px;padding: 0px;">
	<table width="390" style="background-color:#FFFFFF" >
		<tr>
			<td width="250px" valign="top">
				<div style="width:248;height:262px;overflow:auto;border:1px solid #7F9DB9">
					<ul id="ouTree"></ul>
				</div>
			</td>
			<td width="140" class="oz-property">
				<select id="group" name="group" style="width:100%;height:263px;" multiple="multiple" ondblclick="onSelectGroup_DblClicked()">
				</select>
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
			groups = json.groups;
			if(groups.length > 0){
				for(var i = 0; i < groups.length; i++){
					selOptionObj.options[selOptionObj.length] = new Option(groups[i].name, groups[i].id);
				}
			}
		}
	);
}

function onSelectGroup_DblClicked(){
	OZ.Dlg.fireButtonEvent(0, "dlg_selectGroup");
}

function ozDlgOkFn(){
	var selOptionObj = document.getElementById("group");
	var option = null;
	var len = selOptionObj.length;
	for(var i = 0; i < len; i++){
		if(selOptionObj.options[i].selected){
			option = selOptionObj.options[i];
			break;
		}
	}
	if(null == option){
		OZ.Msg.alert('<oz:messageSource code="oz.mdu.organize.group.msg.selectgroup.none"/>');
        return false;
    }
		
    return { 
        id:option.value, 
        name:option.text 
	};
}
</script>
</html>