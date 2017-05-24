<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.cmpn.mail"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.cmpn.mail"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="mail/mailSendAction">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
	</div>
</body>
<oz:js/>
<script type="text/javascript">

$(function(){
	var strUrl = contextPath + "/mail/mailSendAction.do?action=dlgSendMail&timeStamp=" + new Date().getTime();
	new OZ.Dlg.create({
		id:"Dlg_SendMail", 
		width:360, height:360,
		title:'<oz:messageSource code="oz.cmpn.mail.dlg.title.test"/>',
		url: strUrl,
		onOk:function(result){
			strUrl = contextPath + "/mail/mailSendAction.do?action=sendMail&timeStamp=" + new Date().getTime();
			$.post(
				strUrl, 
				result,
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.cmpn.mail.sendmail.success"/>');
					}else{
						OZ.Msg.info(json.msg);
					}
				},
				"json"
			);
		},
		onCancel:function(result){}
	});
});
</script>
</html>