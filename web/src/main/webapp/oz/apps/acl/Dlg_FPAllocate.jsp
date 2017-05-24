<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="dialog" tree="true" messager="true"/>
<head>
	<title><oz:messageSource code="oz.component.acl.functionpermission"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body oz-form" style="background-color: #F4FEFF;height:100%;width:100%;overflow:hidden;border:none;margin: 0px;padding: 0px;">
	<table width="100%" style="background-color:#FFFFFF;margin:4px">
		<tr height="24px">
			<td>
				<b><oz:messageSource code="oz.component.acl.functionpermission.fields.functionid"/>:</b>
			</td>
		</tr>
		<tr>
			<td>
				<input type="text" id="txtFunctionId" name="txtFunctionId" value="<%= request.getAttribute("functionId") %>" style="width:395px">
			</td>
		</tr>
		<tr height="24px">
			<td style="padding-top:4px;">
				<b><oz:messageSource code="oz.component.acl.functionpermission.fields.sids"/>:</b>
			</td>
		</tr>
		<tr>
			<td valign="top">
				<div style="width:395px;height:351px;overflow:auto;border:1px solid #7F9DB9">
					<ul id="ouTree"></ul>
				</div>
			</td>
		</tr>
	</table>
</body>
<oz:js/>
<script type="text/javascript">
var _ouId = "<%= request.getAttribute("ouId") %>";
var _aclId = <%= request.getAttribute("id") %>;
		
$(function(){
	var strUrl = contextPath + '/acl/functionPermissionAction.do?action=getPermissionTree&timeStamp=' + new Date().getTime()
	strUrl += "&ouId=" + _ouId + "&groupFlag=y&userInfoFlag=y";
	strUrl += "&aclId=" + _aclId;
	$('#ouTree').tree({url:strUrl, checkbox: true});
});

var result = null;
function ozDlgOkFn(){
	if(null == result){
		var functionId = $("#txtFunctionId").val();
		if(null == functionId || functionId.length == 0){
			OZ.Msg.info('<oz:messageSource code="oz.component.acl.functionpermission.msg.functionid.is.null"/>');
			return false;
		}
		
		// 获取选择的权限
		var nodes = $('#ouTree').tree('getChecked', false);
		var sids = '';
		for(var i = 0; i < nodes.length; i++){
			if(sids != '') 
				sids += ',';
			sids += nodes[i].id + ";";
			sids += nodes[i].type + ";";
			sids += nodes[i].text;
		}
			
		if(sids.length == 0){
			OZ.Msg.confirm(
				'<oz:messageSource code="oz.component.acl.functionpermission.msg.sids.null.confirm"/>',
				function(){
					result = {id:_aclId, functionId:functionId, sids:sids};
					OZ.Dlg.fireButtonEvent(0, "dlg_FPermission");
				},function(){return false;});
		}else{
			return {id:_aclId, functionId:functionId, sids:sids};
		}
		return false;
	}else{
		return result;
	}
}
</script>
</html>