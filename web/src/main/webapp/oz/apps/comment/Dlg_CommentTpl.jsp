<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title>常用批示语</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="常用批示语">
	<html:form action="module/commentTplAction.do" styleId="ozForm">
		<div class="oz-form-title" style="width:100%;padding:0px;text-align:center;height:32px;">常用批示语</div>
		<div class="oz-form-fields" style="margin:4px;">
			<html:textarea property="comment" styleId="comment" styleClass="oz-form-btField" style="height:80px;width:455px"></html:textarea>
		</div>
		<html:hidden property="id" styleId="id"/><html:hidden property="type" styleId="type"/><html:hidden property="ownerId" styleId="ownerId"/>
	</html:form>
</body>
<oz:js/>
<script type="text/javascript">
var _result = null;
function ozDlgOkFn(){
	if(null == _result){
		if(!OZ.Form.validate()) {
			return false;
		}
		var saveUrl = contextPath + "/module/commentTplAction.do?action=saveByAjax";
		OZ.Form.save({url:saveUrl, showMsg:false});
		return false;
	}else{
		return _result;
	}
}

function onBtnSave_Success(json){
	if(json.result){
		_result = json;
		OZ.Dlg.fireButtonEvent(0, "Dlg_CommentTpl");
	}else{
		OZ.Msg.info(json.msg);
	}
}
</script>
</html>