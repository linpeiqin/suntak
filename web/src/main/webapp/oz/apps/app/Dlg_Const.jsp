<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.web.const"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssId="oz-app-icon"/> 
</head>
<body data-name="<oz:messageSource code="oz.web.const"/>">
	<div class="oz-form-title" style="width:100%;padding:0px;text-align:center;height:32px;"><oz:messageSource code="oz.web.const"/></div>
	<div class="oz-form-fields" style="margin:4px;">
		<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:100%;margin:0;">
			<tr class="oz-form-tr">
				<td width="20%" class="oz-form-label-r">key：</td>
				<td width="80%" class="oz-property">
					${key}
				</td>
			</tr>
			<tr class="oz-form-tr"> 
				<td class="oz-form-label-r">value：</td>
				<td class="oz-property">
					<input id="value" value="${value}" class="oz-form-field">
				</td>
			</tr>
		</table>
	</div>
	<input type="hidden" id="key" value="${key}">
</body>
<oz:js/>
<script type="text/javascript">
var _result = null;
function ozDlgOkFn(){
	if(null == _result){
		$.post(
			contextPath + "/app/appConstAction.do?action=saveValue&timeStamp=" + new Date().getTime(), 
			{key:$("#key").val(), value:$("#value").val()},
			function(json){
				if(json.result == true){
					_result = json;
					OZ.Dlg.fireButtonEvent(0, "Dlg_AppConst");
				}else{
					OZ.Msg.info(json.msg);
				}
			},
			"json"
		);
		return false;
	}else{
		return _result;
	}
}

$(function(){
	
});
</script>
</html>