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
			<oz:tbButton id="btnSave"></oz:tbButton>
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
							<input type="checkbox" name="chkWeekDays" value="mon" onclick="onWeekDays_Clicked()"><oz:messageSource code="oz.mdu.businesshours.weekday.mon"/>
							<input type="checkbox" name="chkWeekDays" value="tue" onclick="onWeekDays_Clicked()"><oz:messageSource code="oz.mdu.businesshours.weekday.tue"/>
							<input type="checkbox" name="chkWeekDays" value="wed" onclick="onWeekDays_Clicked()"><oz:messageSource code="oz.mdu.businesshours.weekday.wed"/>
							<input type="checkbox" name="chkWeekDays" value="thu" onclick="onWeekDays_Clicked()"><oz:messageSource code="oz.mdu.businesshours.weekday.thu"/>
							<input type="checkbox" name="chkWeekDays" value="fri" onclick="onWeekDays_Clicked()"><oz:messageSource code="oz.mdu.businesshours.weekday.fri"/>
							<input type="checkbox" name="chkWeekDays" value="sat" onclick="onWeekDays_Clicked()"><oz:messageSource code="oz.mdu.businesshours.weekday.sat"/>
							<input type="checkbox" name="chkWeekDays" value="sun" onclick="onWeekDays_Clicked()"><oz:messageSource code="oz.mdu.businesshours.weekday.sun"/>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-topLabel"><oz:messageSource code="oz.mdu.businesshours.fields.worktime"/>：</td>
						<td>
							<oz:messageSource code="oz.mdu.businesshours.am"/>:
								<html:select property="startTime_Hour_AM" styleId="startTime_Hour_AM" styleClass="egd-form-btField" style="width:45px">
								 	<html:optionsCollection name="AMHours" label="name" value="value" />
								</html:select>
								:
								<html:select property="startTime_Mint_AM" styleId="startTime_Mint_AM" styleClass="egd-form-btField" style="width:45px">
								 	<html:optionsCollection name="Minutes" label="name" value="value" />
								</html:select>
								&nbsp;~&nbsp;
								<html:select property="endTime_Hour_AM" styleId="endTime_Hour_AM" styleClass="egd-form-btField" style="width:45px">
								 	<html:optionsCollection name="AMHours" label="name" value="value" />
								</html:select>
								:
								<html:select property="endTime_Mint_AM" styleId="endTime_Mint_AM" styleClass="egd-form-btField" style="width:45px">
								 	<html:optionsCollection name="Minutes" label="name" value="value" />
								</html:select><br/> 
							<oz:messageSource code="oz.mdu.businesshours.pm"/>:
								<html:select property="startTime_Hour_PM" styleId="startTime_Hour_PM" styleClass="egd-form-btField" style="width:45px">
								 	<html:optionsCollection name="AMHours" label="name" value="value" />
								</html:select>
								:
								<html:select property="startTime_Mint_PM" styleId="startTime_Mint_PM" styleClass="egd-form-btField" style="width:45px">
								 	<html:optionsCollection name="Minutes" label="name" value="value" />
								</html:select>
								&nbsp;~&nbsp;
								<html:select property="endTime_Hour_PM" styleId="endTime_Hour_PM" styleClass="egd-form-btField" style="width:45px">
								 	<html:optionsCollection name="AMHours" label="name" value="value" />
								</html:select>
								:
								<html:select property="endTime_Mint_PM" styleId="endTime_Mint_PM" styleClass="egd-form-btField" style="width:45px">
								 	<html:optionsCollection name="Minutes" label="name" value="value" />
								</html:select><br/> 		
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-topLabel"><oz:messageSource code="oz.memos"/>：</td>
						<td class="oz-property">
							 <html:textarea property="memos" styleClass="oz-form-field"/>
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

function onWeekDays_Clicked(){
	$("input[name='chkWeekDays']").each(function(){
		if(this.checked)
			$("#" + this.value).val("Y");
		else
			$("#" + this.value).val("N");
	});
}

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

function onBtnTest_Clicked(){
	var strUrl = contextPath + "/module/businessHoursAction.do?action=testCalcUsedTime&timeStamp=" + new Date().getTime();
	$.getJSON(
		strUrl, 
		{},
		function(json){
		}
	);
}
</script>
</html>