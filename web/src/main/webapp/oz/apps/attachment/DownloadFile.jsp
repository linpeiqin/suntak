<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title>下载文件</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body onload="init()">
    <form id="thisForm">
        <div>
        </div>
    </form>
</body>
<oz:js/>
<script type="text/javascript">
var errorMsg = '';
<logic:present name="errorMsg">
	errorMsg = '<bean:write name="errorMsg"/>';
</logic:present>
function init(){
    if(errorMsg.length > 0){
    	if(OZ.Msg){
    		 OZ.Msg.slide(errorMsg);   // 下载附件异常
    	}else{
    		alert(errorMsg);
    		window.close();
    	}
    }
}
</script>
</html>