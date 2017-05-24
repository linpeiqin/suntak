<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="page" datePicker="true" timePicker="true"/>
<head>
	<title>
		<oz:messageSource code="oz.mdu.personalschedule.constants.view.month"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssHref="/oz/themes/default/calendar.css"/>
</head>
<body id="calendarBody">
	<table id="monthTb" class="oz-calendar" width="100%" height="100%"  border="0" cellspacing="0" cellpadding="0" style="vertical-align:top;">
  		<tr>
    		<td height="29">
	    		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		  			<tr class="oz-calendar-icon oz-calendar-toolsbarBg">
		    			<td width="10" height="22">&nbsp;</td>
		    			<td width="32">
		    				<div class="oz-calendar-previous" onClick="thisPage.preButton()"></div>
		    			</td>
		    			<td width="32">
		    				<div class="oz-calendar-next" onClick="thisPage.nextButton()"></div>
		    			</td>
		    			<td width="90" class="oz-calendar-date" id='curDate'></td>
				    	<td width="20">
					    	<div class="oz-calendar-dateSelect">
					    		<input type="text" class="oz-calendar-datepicker" id="dateElect" style="margin-top:0px"/>
					    	</div>
				    	</td>
		    			<td width="5">&nbsp;</td>
		    			<td width="50">
		    				<div class="oz-calendar-today" onclick="thisPage.todayButton()"><oz:messageSource code="oz.mdu.personalschedule.buttons.today"/></div>
		    			</td>
		    			<td width="60">
		    				<div class="oz-calendar-add" onclick="onBtnNew_Click('MAINTAIN')">保养&nbsp;&nbsp;</div>
		    			</td>
						<td width="60">
							<div class="oz-calendar-add" onclick="refresh()">刷新&nbsp;&nbsp;</div>
						</td>
		    			<td width="800">&nbsp;</td>
		  			</tr>
				</table>
    		</td>
  		</tr>
		<tr id="weekTr">
	    	<td height="18">
	        	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="oz-calendar-erectTop">
	          		<tr>
	          			<td><div>星期日</div></td>
	            		<td><div>星期一</div></td>
	            		<td><div>星期二</div></td>
	            		<td><div>星期三</div></td>
	            		<td><div>星期四</div></td>
	            		<td><div>星期五</div></td>
	            		<td><div>星期六</div></td>
	            		<td id='topOverflow' style='display:none;' width='16'>&nbsp;</td>
	          		</tr>
	        	</table>
	        </td>
		</tr>
	</table>
	<!--提示框的dom-->
	<div id="calendarMsg" style="display:none;" class="oz-calendarInfo-wrap">
		<div class="calendarInfo-top">
	    	<div class="oz-calendar-v info-top-L"></div>
	    	<div class="oz-calendar-a info-top-C">
	    		<div id="msgTop" style="display:none;" class="oz-calendar-corner-top"></div>
	    	</div>
	    	<div class="oz-calendar-v info-top-R"></div>
		</div>
		<div class="calendarInfo-main">
	    	<div class="oz-calendar-v info-main-L">
	    		<div id="msgLeft" style="display:none;" class="oz-calendar-corner-left"></div>
	    	</div>
	    	<div class="info-main-C">
	    		<table width="100%" border="0" cellspacing="3" cellpadding="0">
	          		<tr>
	            		<td height="22">
	            			<div class="oz-calendarinfo-T" id="divShowCurDate">当前选择日期</div>
	            			<div class="oz-calendar-v oz-calendar-close" onClick="msgUtil.divMsgClose()"></div>
	            		</td>
	          		</tr>
	          		<tr>
	            		<td valign="top">
	  			          	<div class="oz-calendarinfo-C" id="msgDivContent">
	            			</div>
	            		</td>
	          		</tr>
	          		<tr>
	            		<td height="22" class="oz-calendar-link" id="divMsgButton"></td>
	          		</tr>
	        	</table>
	    	</div>
	    	<div class="oz-calendar-v info-main-R">
	    		<div id="msgRight" style="display:none;" class="oz-calendar-corner-right"></div>
	    	</div>
		</div>
		<div class="calendarInfo-bottom">
	    	<div class="oz-calendar-v info-bottom-L"></div>
	    	<div class="oz-calendar-a info-bottom-C">
	    		<div id="msgBottom" style="display:none;" class="oz-calendar-corner-bottom"></div>
	    	</div>
	    	<div class="oz-calendar-v info-bottom-R"></div>
		</div>
	</div>
</body>
<oz:js/>
<oz:js jsId="oz-lunar"/>
<oz:js jsSrc="/ems/equipmentrepair/js/date.js"/>
<oz:js jsSrc="/ems/equipmentrepair/js/dateUtil.js"/>
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/equipmentrepair/js/msgUtil.js"/>
<oz:js jsSrc="/ems/equipmentrepair/js/monthView.js"/>
<oz:js jsSrc="/ems/equipmentrepair/js/ems.repairplan.view.js"/>
</html>