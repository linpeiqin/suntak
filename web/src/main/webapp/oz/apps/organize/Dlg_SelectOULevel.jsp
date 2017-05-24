<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="dialog" tree="true" messager="true" select="true"/>
<head>
	<title><oz:messageSource code="hr.core.organize.position"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body">
	<div style="height:258px;overflow:auto;border:1px solid #8DB2E3;border-left-width:0px;border-top-width:0px;background-color:white;">
		<ul id="ouLevelTree"></ul>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
var _selectOULevel = null;
function ozDlgOkFn(){
	if(null == _selectOULevel){
		OZ.Msg.info("请选择一个级别");
		return false;
	}
	return {id:_selectOULevel.id, name:_selectOULevel.name};
}

$(function(){
	$('#ouLevelTree').tree({
		url: contextPath + '/organize/ouLevelAction.do?action=getLevelTree&parentId=${parentId}&excludeId=${excludeId}&timeStamp=' + new Date().getTime(),
		click:function(e, data){
			_selectOULevel = data;
		}
	});
});
</script>
</html>