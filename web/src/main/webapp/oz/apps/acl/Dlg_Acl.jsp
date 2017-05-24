<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="dialog" tree="true" messager="true"/>
<head>
	<title><oz:messageSource code="oz.component.acl.acl"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body oz-form" style="background-color: #F4FEFF;height:100%;width:100%;overflow:hidden;border:none;margin: 0px;padding: 0px;">
	<div style="width:100%;height:390px;overflow:auto;">
		<ul id="ouTree"></ul>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
var contextPath = "<oz:contextPath/>";
var ouId = "<%= request.getAttribute("ouId") %>";
var entityClazz = "<%= request.getAttribute("entityClazz") %>";
var entityId = "<%= request.getAttribute("entityId") %>";
var mask = "<%= request.getAttribute("mask") %>";
var editFlag = "<%= request.getAttribute("editFlag") %>";
var checkable = false;
if(editFlag == "Y" || editFlag == "y")
	checkable = true;

var defaultSids = <%= request.getAttribute("sids") %>;

$(function(){
	// 加载组织架构树
	var strUrl = contextPath + '/acl/aclAction.do?action=getAclTree&timeStamp=' + new Date().getTime()
	strUrl += "&ouId=" + ouId + "&type=-1&userInfoFlag=y&groupFlag=y&entityClazz=" + entityClazz;
	strUrl += "&entityId=" + entityId + "&mask=" + mask;
	$('#ouTree').tree({ url: strUrl, checkable: checkable, checkbox: true});
});

function ozDlgOkFn(){
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
	if(defaultSids && defaultSids.length > 0){
		var unNodes = $('#ouTree').tree('getUnChecked', true);
		for(var j = 0; j < unNodes.length; j++){
			var nNode = unNodes[j];
			for ( var k = 0; k < defaultSids.length; k++ ) {
				var defaultSid = defaultSids[ k ];
				if ( nNode.sidValue === defaultSid.value ) {
					defaultSids.splice( k--, 1 );
					break;
				}
			}
		}
		for(var j = 0; j < nodes.length; j++){
			var sNode = nodes[j];
			for ( var k = 0; k < defaultSids.length; k++ ) {
				var defaultSid = defaultSids[ k ];
				if ( sNode.sidValue === defaultSid.value ) {
					defaultSids.splice( k--, 1 );
					break;
				}
			}
		}
		for ( var i = 0; i < defaultSids.length; i++ ) {
			var defaultSid = defaultSids[ i ];
			if(sids != '') 
				sids += ',';
			sids += defaultSid.value + ";";
			sids += defaultSid.name;
		}
	}
	return sids;
}	
</script>
</html>