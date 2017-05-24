<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
	<oz:ui templete="page"/>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><oz:systemConfiguration key="system.title"></oz:systemConfiguration>-<oz:systemConfiguration key="system.version.no"></oz:systemConfiguration></title>
        <oz:css/>
	</head>
<body>
</body>
<oz:js/>
<script type="text/javascript">
$(function(){
	var key = '<%=request.getAttribute("key")%>';
	var errorMsg = '<oz:messageSource code="oz.mdu.integrated.thirdsystem.foward.errormsg.nulloption"/>';

	try{
		OZ.Msg.confirm(errorMsg,function(){
			redirect(key);
		},function(){
			closeMe();
		});
	}catch(e){
		if(confirm(errorMsg)){
			redirect(key);
		}else{
			closeMe();
		}
	}
});

function redirect(key){
	var config = {
		id : "redirectToUserMapping",
		title : '<oz:messageSource code="oz.mdu.integrated.thirdsystem.window.title.create"/>',
		url : contextPath + "/security/userMappingAction.do?action=create&useCurUser=true&systemId="+key+"&timeStamp=" + new Date().getTime(),
		refresh : true,
		closeable : true
	};

	try{
		ozWindow.open(config);
	}catch(e){
		window.opener.ozWindow.open(config);
	}
	closeMe();
}

function closeMe(){
	try{
		ozWindow.close();
	}catch(e){
		window.close();
	}
} 

</script>
</html>