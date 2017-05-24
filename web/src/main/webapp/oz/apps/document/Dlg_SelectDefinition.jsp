<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="dialog" tree="true" messager="true"/>
<head>
	<title>新建选择</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css />
</head>
<body style="background-color: #FFFFFF;height:100%;width:100%;overflow:hidden;border:none;margin: 0px;padding: 0px;">
	<div style="width:288;height:260px;overflow:auto;">
		<ul id="fdTree"></ul>
	</div>
</body>
<oz:js />
<script type="text/javascript">
$(function(){
	var strUrl = contextPath + '/document/documentMappingAction.do?action=getTreeNode&timeStamp=' + new Date().getTime()
	$('#fdTree').tree({ url: strUrl,
		beforeselected:function(e,data){
			if(data.type != "dd"){
				return false;
			}
		}
	});
});
function ozDlgOkFn(){
	var node = $('#fdTree').tree('getSelected');
	if(node){
		return {id:node.id,name:node.text};
	}else{
		OZ.Msg.alert("对不起，请选择。");
		return false;
	}
}
</script>
</html>