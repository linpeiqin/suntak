<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" messager="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.businesshours.holiday"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body oz-form" style="background-color: #F4FEFF;height:100%;width:100%;overflow:hidden;border:none;margin: 0px;padding: 0px;">
	<table width="100%" style="background-color:#FFFFFF" >
		<tr>
			<td style="padding-left:8px">
				<fieldset>
					<legend><oz:messageSource code="oz.mdu.businesshours.holiday.fields.import.datas"/>：</legend>
					<textarea id="holidays" name="holidays" style="width:100%;height:120px"></textarea>
				</fieldset>
			</td>
		</tr>
		<tr>
			<td style="padding-left:8px">
				<oz:messageSource code="oz.mdu.businesshours.holiday.fields.import.date.formate.info"/>
			</td>
		</tr>
	</table>
</body>
<oz:js/>
<script type="text/javascript">
function ozDlgOkFn(){
	var holidays = $("#holidays").val();
	if(null == holidays || holidays == 0){
		OZ.Msg.info('<oz:messageSource code="oz.mdu.businesshours.holiday.msg.import.datas.isnull"/>');
		return false;
	}else{
		return holidays.replace(/\r\n|\r|\n/g,";");
	}
}
</script>
</html>