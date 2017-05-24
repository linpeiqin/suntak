<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="dialog" select="true"/>
<html>
	<head>
		<title></title>
		<oz:css/>
	</head>
	<body class="oz-body">
		<oz:select value="curValue" property="ozSelect" options="options" size="12" style="width:100%" ondblclick="onDblClicked()"></oz:select>
	</body>
<oz:js/>		
<script type="text/javascript">
var defaultBtnIndex = "${defaultBtnIndex}";
function onDblClicked(){
	if(null == defaultBtnIndex || defaultBtnIndex.length == 0)
		defaultBtnIndex = 0;
	else
		defaultBtnIndex = parseInt(defaultBtnIndex);
	OZ.Dlg.fireButtonEvent(defaultBtnIndex, ozWindow.getId());
}

function ozDlgOkFn(){
	var selectObj = document.getElementById("ozSelect");
	var selectedCount = 0;
	var len = selectObj.length;
	for(var i = 0; i < len; i++){
		if(selectObj.options[i].selected){
			var resultArray = new Array();
			resultArray[0] = selectObj.options[i].text;
			resultArray[1] = selectObj.options[i].value; 
			return resultArray;
		}
	}
	if(selectedCount == 0)
		OZ.Msg.alert('<oz:messageSource code="oz.msg.selected.isnull"/>');
	return false;
}
</script>
</html>