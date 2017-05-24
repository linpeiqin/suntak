<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title>修改办理意见</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="修改办理意见">
	<div class="oz-form-fields" style="margin:4px;">
		<textarea id="comment" name="comment" style="height:80px;width:295px">${comment}</textarea>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function ozDlgOkFn(){
	return $("#comment").val();
}
</script>
</html>