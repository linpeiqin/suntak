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
		<oz:select value="curValue" property="ozSelect" options="options" style="width:100%;height:100%;" multiple="true"></oz:select>
	</body>
<oz:js/>		
<script type="text/javascript">
function ozDlgOkFn(){
	var selectValue = $("#ozSelect").val();
	if(null == selectValue){
		OZ.Msg.alert('<oz:messageSource code="oz.msg.selected.isnull"/>');
        return false;
	}else{
		return selectValue.join(";");
	}
}
</script>
</html>