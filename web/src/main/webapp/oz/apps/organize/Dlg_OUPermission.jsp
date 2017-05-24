<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="dialog" tree="true" messager="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.organize.ouinfo."/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body oz-form" style="background-color: #F4FEFF;height:100%;width:100%;overflow:hidden;border:none;margin: 0px;padding: 0px;">
	<table width="100%" style="background-color:#FFFFFF" >
		<tr>
			<td width="315px">
				<b><oz:messageSource code="oz.mdu.organize.ouinfo.dlg.oupermission.selectou"/>:</b>
			</td>
			<td width="315px" align="right">
				<button type="button" class="oz-form-button" style="width:62px;height:21px;float:right" onclick="onBtnSave_Clicked()" ><oz:messageSource code="oz.save"/></button>
			</td>
		</tr>
		<tr>
			<td>
				<div style="width:100%;height:375px;overflow:auto;border:1px solid #7F9DB9">
					<ul id="ouTree"></ul>
				</div>
			</td>
			<td>
				<div style="width:100%;height:375px;overflow:auto;border:1px solid #7F9DB9">
					<ul id="permissionTree"></ul>
				</div>
			</td>
		</tr>
	</table>
</body>
<oz:js/>
<script type="text/javascript">
var _ouId = "<%= request.getAttribute("ouId") %>";
var _treeInit = false;

$(function(){
	// 加载组织架构树
	var strUrl = contextPath + '/organize/ouTreeAction.do?action=getTree&timeStamp=' + new Date().getTime()
	strUrl += "&ouId=" + _ouId;
	$('#ouTree').tree({
		url: strUrl,
		click:function(e, data){
			var strUrl = contextPath + "/organize/ouPermissionAction.do?action=getPermissionTree&id=" + data.id + "&timeStamp=" + new Date().getTime();
			
			if(_treeInit){
				$('#permissionTree').tree("option", "url", strUrl);
				$('#permissionTree').tree("reload");
			}else{
				$('#permissionTree').tree({checkbox: true, url: strUrl});
				_treeInit = true;
			}
		}
	});
});

function onBtnSave_Clicked(){
	var node = $('#ouTree').tree('getSelected');
	if(null == node){
		OZ.Msg.alert('<oz:messageSource code="oz.mdu.organize.ouinfo.dlg.oupermission.msg.selectedou.isnull"/>');
		return false;
	}else{
		var type = node.type;
		var id = node.id;

		// 获取选择的权限
		var nodes = $('#permissionTree').tree('getChecked', true);
		var permissionIds = '';
		for(var i = 0; i < nodes.length; i++){
			if(permissionIds != '') 
				permissionIds += ',';
			permissionIds += nodes[i].id;
		}
		if(permissionIds.length == 0){
			OZ.Msg.confirm(
				'<oz:messageSource code="oz.mdu.organize.ouinfo.dlg.oupermission.msg.oupermission.isnull.confirm"/>',
				function(){
					savePermissions(id, type, permissionIds);
				}
			);
		}else{
			savePermissions(id, type, permissionIds);
		}
	}
}

function savePermissions(id, type, permissionIds){
	var strUrl = contextPath + "/organize/ouPermissionAction.do?action=updateOUPermission";
	$.getJSON(
		strUrl + "&timeStamp=" + new Date().getTime(),
		{id:id, permissionCodes:permissionIds},
		function(json){
			if(json.result == true){
				OZ.Msg.info('<oz:messageSource code="oz.mdu.organize.ouinfo.dlg.oupermission.msg.oupermission.update.success"/>');
			}else{
				OZ.Msg.info(json.msg);
			}
		}
	);
	
}	
</script>
</html>