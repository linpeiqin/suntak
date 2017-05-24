<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="dialog"/>
<head>
	<title></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css />
</head>
<body style="background-color: #FFF;height:100%;width:100%;overflow:hidden;border:none;margin: 0px;padding: 0px;">
	<form id="thisForm">
		<table width="100%" style="background-color:#FFFFFF">
			<tr>
				<td style="padding:4px">
					<b><oz:messageSource code="oz.cmpn.mail.config.fields.from"/>:</b>
				</td>
			</tr>
			<tr>
				<td style="padding:4px">
					<input type="text" id="from" name="from" style="width:100%" class="oz-form-field">
				</td>
			</tr>
			<tr>
				<td style="padding:4px">
					<b><oz:messageSource code="oz.cmpn.mail.config.fields.to"/>:</b>
				</td>
			</tr>
			<tr>
				<td style="padding:4px">
					<input type="text" id="to" name="to" style="width:100%" class="oz-form-btField">
				</td>
			</tr>
			<tr>
				<td style="padding:4px">
					<b><oz:messageSource code="oz.cmpn.mail.config.fields.subject"/>:</b>
				</td>
			</tr>
			<tr>
				<td style="padding:4px">
					<input type="text" id="subject" name="subject" style="width:100%" class="oz-form-field" value="这是一封测试邮件">
				</td>
			</tr>
			<tr>
				<td style="padding:4px">
					<b><oz:messageSource code="oz.cmpn.mail.config.fields.mailconcept"/>:</b>
				</td>
			</tr>
			<tr>
				<td style="padding:4px">
					<textarea id="mailConcept" name="mailConcept" style="width:100%;height:82px">您好，这是一封来自OzPlatform的测试邮件，请不要回复，请点击 <a href='http://10.178.232.135:8080/oa/'>这里</a> 打开我们的系统,多谢合作。</textarea>
				</td>
			</tr>
		</table>
    </form>
</body>
<oz:js />
<script type="text/javascript">
function ozDlgOkFn(){
	var mailConcept = $("#mailConcept").val();
	if(null == mailConcept || mailConcept.length == 0){
		OZ.Msg.info('<oz:messageSource code="oz.cmpn.mail.msg.mailconcept.isempty"/>');
		return false;
	}

	var to = $("#to").val();
	if(null == to || to.length == 0){
		OZ.Msg.info('<oz:messageSource code="oz.cmpn.mail.msg.to.isempty"/>');
		return false;
	}
	
	return {to:to, from:$("#from").val(), subject:$("#subject").val(), mailConcept:mailConcept};
}
</script>
</html>