<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.mdu.businesshours"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.businesshours"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="module/businessHoursAction">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnViewHolidy" text="oz.mdu.businesshours.button.viewholiday" icon="oz-icon-0625" onclick="onBtnViewHoliday_Clicked()"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="module/businessHoursAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.mdu.businesshours"/></div>
			<div class="oz-form-fields">
				<table cellpadding="0" cellspacing="4">
					<tr class="oz-form-emptyTR"> 
						<td width="120"></td>
						<td width="480"></td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.businesshours.fields.workday"/>：</td>
						<td>
							<input type="checkbox" name="chkWeekDays" value="mon" disabled="disabled"><oz:messageSource code="oz.mdu.businesshours.weekday.mon"/>
							<input type="checkbox" name="chkWeekDays" value="tue" disabled="disabled"><oz:messageSource code="oz.mdu.businesshours.weekday.tue"/>
							<input type="checkbox" name="chkWeekDays" value="wed" disabled="disabled"><oz:messageSource code="oz.mdu.businesshours.weekday.wed"/>
							<input type="checkbox" name="chkWeekDays" value="thu" disabled="disabled"><oz:messageSource code="oz.mdu.businesshours.weekday.thu"/>
							<input type="checkbox" name="chkWeekDays" value="fri" disabled="disabled"><oz:messageSource code="oz.mdu.businesshours.weekday.fri"/>
							<input type="checkbox" name="chkWeekDays" value="sat" disabled="disabled"><oz:messageSource code="oz.mdu.businesshours.weekday.sat"/>
							<input type="checkbox" name="chkWeekDays" value="sun" disabled="disabled"><oz:messageSource code="oz.mdu.businesshours.weekday.sun"/>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-topLabel"><oz:messageSource code="oz.mdu.businesshours.fields.worktime"/>：</td>
						<td>
							<oz:messageSource code="oz.mdu.businesshours.am"/>:<span class="oz-form-fields-span">&nbsp;<bean:write name="businessHoursFrom" property="startTime_Hour_AM" format="00"/></span>:
								<span class="oz-form-fields-span"><bean:write name="businessHoursFrom" property="startTime_Mint_AM" format="00"/></span>
								&nbsp;~&nbsp;
								<span class="oz-form-fields-span"><bean:write name="businessHoursFrom" property="endTime_Hour_AM" format="00"/></span>:
								<span class="oz-form-fields-span"><bean:write name="businessHoursFrom" property="endTime_Mint_AM" format="00"/></span>
								<br/> 
							<oz:messageSource code="oz.mdu.businesshours.pm"/>:<span class="oz-form-fields-span">&nbsp;<bean:write name="businessHoursFrom" property="startTime_Hour_PM" format="00"/></span>:
								<span class="oz-form-fields-span"><bean:write name="businessHoursFrom" property="startTime_Mint_PM" format="00"/></span>
								&nbsp;~&nbsp;
								<span class="oz-form-fields-span"><bean:write name="businessHoursFrom" property="endTime_Hour_PM" format="00"/></span>:
								<span class="oz-form-fields-span"><bean:write name="businessHoursFrom" property="endTime_Mint_PM" format="00"/></span>
								<br/> 		
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-topLabel"><oz:messageSource code="oz.memos"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="businessHoursFrom" property="memos"/></span>
						</td>
						<td></td>
					</tr>
				</table>			
			</div>
			<html:hidden property="id" styleId="id"/><html:hidden property="sun" styleId="sun"/>
			<html:hidden property="mon" styleId="mon"/><html:hidden property="tue" styleId="tue"/>
			<html:hidden property="wed" styleId="wed"/><html:hidden property="thu" styleId="thu"/>
			<html:hidden property="fri" styleId="fri"/><html:hidden property="sat" styleId="sat"/>
		</html:form>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
$(function(){
	$("input[name='chkWeekDays']").each(function(){
		if($("#" + this.value).val() == "Y" || $("#" + this.value).val() == "y"){
			this.checked = true;
		} else{
			this.checked = false;
		}
	});
});

function onBtnViewHoliday_Clicked(){
	var strUrl = contextPath + "/module/holidayAction.do?action=display";
	OZ.openWindow({
		id: "viewHoliday" + (new Date().getTime()),
		title: '<oz:messageSource code="oz.mdu.businesshours.holiday"/>',
		url: strUrl, 
		refresh: true,
		beforeCloseFnName: "oz_Win_BeforeClose"
	});	
}
</script>
</html>