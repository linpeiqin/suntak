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
					<b><oz:messageSource code="oz.cmpn.sms.config.fields.mobiles"/>:</b>
				</td>
			</tr>
			<tr>
				<td style="padding:4px">
					<input type="text" id="mobiles" name="mobiles" style="width:100%" class="oz-form-btField">
				</td>
			</tr>
			<tr>
				<td style="padding:4px">
					<b><oz:messageSource code="oz.cmpn.sms.config.fields.sms.content"/>:</b>
				</td>
			</tr>
			<tr>
				<td style="padding:4px">
					<textarea id="content" name="content" style="width:100%;height:82px">这是一个测试短信。</textarea>
				</td>
			</tr>
		</table>
    </form>
</body>
<oz:js />
<script type="text/javascript">
	function ozDlgOkFn(){
		var content = $("#content").val();
		if(null == content || content.length == 0){
			OZ.Msg.info('<oz:messageSource code="oz.cmpn.sms.msg.content.isempty"/>');
			return false;
		}

		var mobiles = $("#mobiles").val();
		if(null == mobiles || mobiles.length == 0){
			OZ.Msg.info('<oz:messageSource code="oz.cmpn.sms.msg.mobiles.isempty"/>');
			return false;
		}
		
		return {mobiles:mobiles, content:content};
	}
</script>
</html>