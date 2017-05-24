<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="dialog" tree="true" messager="true"/>
<head>
	<title><oz:messageSource code="oz.component.acl.datascopepermission"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body oz-form" style="background-color: #F4FEFF;height:100%;width:100%;overflow:hidden;border:none;margin: 0px;padding: 0px;">
	<table width="100%" style="background-color:#FFFFFF" >
		<tr>
			<td width="80%" style="padding-left:4px">
				<ul>
					<li style="padding-top:4px;"><b><oz:messageSource code="oz.component.acl.datascopepermission.fields.resource"/>：</b><%= request.getAttribute("resourceName") %>(<%= request.getAttribute("resourceId") %>)
					<li style="padding-top:4px;"><b><oz:messageSource code="oz.component.acl.datascopepermission.fields.allocatetype"/>：</b><%= request.getAttribute("dataScopeTypeDesc") %>
				</ul>
			</td>
			<td width="20%" style="padding-right:4px;vertical-align:bottom;">
				<button type="button" class="oz-form-button" style="width:62px;height:21px;float:right;cursor:pointer;" onclick="onBtnSave_Clicked()" ><oz:messageSource code="oz.save"/></button>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="line-height:2px;">
				<hr>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="padding:4px;">
				<table width="100%">
					<tr>
						<td width="50%">
							<b><oz:messageSource code="oz.component.acl.datascopepermission.fields.allocateuser"/>：</b>
						</td>
						<td width="50%" style="padding-left:4px">
							<b><oz:messageSource code="oz.component.acl.datascopepermission.fields.datascope"/>：</b>
							<input type="radio" id="radioDST" name="radioDST" value="-1" onclick="onDataScopeType_Changed()" title="选择此项相应的用户可以查看系统中全部的数据">
							<span title="选择此项相应的用户可以查看系统中全部的数据"><oz:messageSource code="oz.component.acl.datascopepermission.allocatetype.all"/>&nbsp;</span>
							<input type="radio" id="radioDST" name="radioDST" value="1" onclick="onDataScopeType_Changed()" title="选择此项相应的用户可以查看系统中本单位数据及其下属单位的数据">
							<span title="选择此项相应的用户可以查看系统中本单位数据及其下属单位的数据"><oz:messageSource code="oz.component.acl.datascopepermission.allocatetype.localandchilds"/>&nbsp;</span>
							<input type="radio" id="radioDST" name="radioDST" value="0" CHECKED onclick="onDataScopeType_Changed()" title="选择此项相应的用户仅可查看系统中本单位数据">
							<span title="选择此项相应的用户仅可查看系统中本单位数据"><oz:messageSource code="oz.component.acl.datascopepermission.allocatetype.unit"/>&nbsp;</span>
							<input type="radio" id="radioDST" name="radioDST" value="9" onclick="onDataScopeType_Changed()" title="选择此项可精确定义用户查看数据的范围">
							<span title="选择此项可精确定义用户查看数据的范围"><oz:messageSource code="oz.component.acl.datascopepermission.allocatetype.userdefined"/></span>
						</td>
					</tr>
					<tr>
						<td valign="top">
							<div style="width:100%;height:358px;overflow:auto;border:1px solid #7F9DB9">
								<ul id="ouTree"></ul>
							</div>		
						</td>
						<td valign="top" style="padding-left:4px">
							<div style="width:100%;height:358px;overflow:auto;border:1px solid #7F9DB9">
								<ul id="permissionTree"></ul>
							</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>
<oz:js/>
<script type="text/javascript">
var _ouId = "<%= request.getAttribute("ouId") %>";
var _resourceId = "<%= request.getAttribute("resourceId") %>";
var _dataScopeType = <%= request.getAttribute("dataScopeType") %>;
var _treeInit = false;
var _curSelectedNode = null;

$(function(){
	var strUrl = contextPath + '/organize/ouTreeAction.do?action=getTree&timeStamp=' + new Date().getTime()
	strUrl += "&ouId=" + _ouId + "&userFlag=y&groupFlag=y";
	$('#ouTree').tree({
		url: strUrl,
		click:function(e, data){
			// 只有类型为人员或者岗位的时候才触发动作
			if(data.type == "USER" || data.type == "GROUP"){
				onTreeNode_Clicked(e, data);
				_curSelectedNode = data;
			}else{
				_curSelectedNode = null;
				$("input[type='radio'][name='radioDST']").each(function(){
					if(this.value == "0")
						this.checked = true;
				});
				$("#permissionTree").hide();
			}
		}
	});
});

function onTreeNode_Clicked(e, data){
	var strUrl = contextPath + "/acl/dataScopePermissionAction.do?action=getDSPermissionInfo";
	strUrl += "&timeStamp=" + new Date().getTime();
	$.getJSON(
		strUrl,
		{sid:data.type + "_" + data.id, resourceId:_resourceId, sidType:1},
		function(json){
			if(json.result == true){
				$("input[type='radio'][name='radioDST']").each(function(){
					if(this.value == json.scopeType)
						this.checked = true;
				});
				reloadPermissionTree(e, data);
				if(json.scopeType == "9"){
					$("#permissionTree").show();
				}else{
					$("#permissionTree").hide();
				}
			}else{
				OZ.Msg.info(json.msg);
			}
		}
	);
}

function reloadPermissionTree(e, data){
	var strUrl = contextPath + '/acl/dataScopePermissionAction.do?action=getPermissionTree&resourceId=' + _resourceId;
	strUrl += "&sid=" + data.type + "_" + data.id;
	strUrl += "&dsType=" + _dataScopeType + "&timeStamp=" + new Date().getTime();
	if(_treeInit){
		$('#permissionTree').tree("option", "url", strUrl);
		$('#permissionTree').tree("reload");
	}else{
		$('#permissionTree').tree({
			checkbox: true, url: strUrl,
			click:function(e, data){
				$("input[type='radio'][name='radioDST']").each(function(){
					if(this.value == 1)
						this.checked = true;
				});
			}
		});
		_treeInit = true;
	}
}

function onDataScopeType_Changed(){
	if(null == _curSelectedNode)
		return;
	
	var dataScopeType = val("radioDST");
	if(dataScopeType == "9"){
		$("#permissionTree").show();
	}else{
		$("#permissionTree").hide();
	}
}

function onBtnSave_Clicked(){
	if(null == _curSelectedNode){
		OZ.Msg.alert('<oz:messageSource code="oz.component.acl.datascopepermission.msg.unselected.userinfo"/>');
		return false;
	}else{
		var sidId = _curSelectedNode.type + "_" + _curSelectedNode.id;
		var sidName = _curSelectedNode.text;

		// 获取用户的选择
		var scopeType = val("radioDST");
		if(scopeType == "9"){
			// 获取选择的权限
			var nodes = $('#permissionTree').tree('getChecked', false);
			var permissionIds = '';
			for(var i = 0; i < nodes.length; i++){
				if(permissionIds != '') 
					permissionIds += ',';
				permissionIds += nodes[i].type + "_" + nodes[i].id;
			}	
			
			if(permissionIds.length == 0){
				OZ.Msg.confirm(
					'<oz:messageSource code="oz.component.acl.datascopepermission.msg.permissions.isnull.confirm"/>',
					function(){
						savePermissions(_resourceId, sidId, sidName, scopeType, permissionIds);
					}
				);
			}else{
				savePermissions(_resourceId, sidId, sidName, scopeType, permissionIds);
			}
		}else{
			savePermissions(_resourceId, sidId, sidName, scopeType, '');
		}
	}
}

function savePermissions(resourceId, sid, sidName, scopeType, permissionIds){
	var strUrl = contextPath + "/acl/dataScopePermissionAction.do?action=updatePermission";
	$.getJSON(
		strUrl + "&timeStamp=" + new Date().getTime(),
		{resourceId:resourceId, sidName:sidName, sid:sid, scopeType:scopeType, datascopes:permissionIds},
		function(json){
			if(json.result == true){
				OZ.Msg.info('<oz:messageSource code="oz.component.acl.datascopepermission.dlg.allocate.success"/>');
			}else{
				OZ.Msg.info(json.msg);
			}
		}
	);
}	
</script>
</html>