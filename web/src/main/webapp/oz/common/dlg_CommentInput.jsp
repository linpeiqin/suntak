<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="dialog"/>
<head>
	<title></title>
	<oz:css />
</head>
<body style="background-color: #F4FEFF;height:100%;width:100%;overflow:hidden;border:none;margin: 0px;padding: 0px;">
	<form id="thisForm">
		<table width="100%" style="background-color:#FFFFFF" >
			<tr>
				<td>
					<fieldset>
						<textarea id="comments" name="comments" rows="12" style="width:100%"></textarea>
					</fieldset>
				</td>
			</tr>
		</table>
    </form>
</body>
<oz:js />
<script type="text/javascript">
function ozDlgOkFn(){
	var comments = $("#comments").val();
	if(null == comments || comments.length == 0){
		OZ.Msg.info("对不起，请输入意见。");
		return false;
	}else{
		var resultArray = new Array();
		resultArray[0] = comments;
		return resultArray;
	}
}
</script>
</html>