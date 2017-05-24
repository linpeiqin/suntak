<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" tree="true" messager="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.organize.ouinfo"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" style="background-color: #F4FEFF;height:100%;width:100%;overflow:hidden;border:none;margin: 0px;padding: 0px;">
	<div style="width:288;height:260px;overflow:auto;">
		<ul id="ouTree"></ul>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
var _ouId = <%= request.getAttribute("ouId") %>;
var _ouType = "<%= request.getAttribute("ouType") %>";

$(function(){
	var strUrl = contextPath + "/organize/ouTreeAction.do?action=getTree&timeStamp=" + new Date().getTime();
	strUrl += "&ouId=" + _ouId + "&ouType=" + _ouType;
	$('#ouTree').tree({url:strUrl});
});

function ozDlgOkFn(){
	var node = $('#ouTree').tree('getSelected');
	if(node){
		// 判断选择的信息是否符合
		if(null != _ouType && _ouType.length > 0){
			if(node.type != _ouType){
				if(_ouType == "DW" || _ouType == "dw")
					OZ.Msg.alert('<oz:messageSource code="oz.mdu.organize.ouinfo.msg.select.not.unit"/>');
				else
					OZ.Msg.alert('<oz:messageSource code="oz.mdu.organize.ouinfo.msg.select.not.department"/>');
				return false;
			}
		}else{
			if(node.type != "DW" && node.type != "dw" && node.type != "BM" && node.type != "bm"){
				OZ.Msg.alert('<oz:messageSource code="oz.mdu.organize.ouinfo.msg.select.not.ouinfo"/>');
				return false;
			}
		}
		return node;
	}else{
		OZ.Msg.alert('<oz:messageSource code="oz.mdu.organize.ouinfo.msg.select.not.ouinfo"/>');
		return false;
	}
}
</script>
</html>