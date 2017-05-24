<!DOCTYPE HTML >
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.component.auditlog"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css />
	<style type="text/css">
		th {
			text-align:center;
			border: 1px solid #CCCCCC;
			background: #E2F3C9;
			color: black;
			font-weight:bolder;
			padding-top:3px;
		}
		
		td {
			text-align: left;
			padding:2px;
			border: 1px solid #CCCCCC;
		}
		
		tr.even td {
			background: #EEFAE2;
		}
		
		tr.odd td {
			background: #FFFFFF;
		}
		.ui-tab-container-item{
			margin: 2px;
		}
	</style>
</head>
<body class="oz-body" style="background-color:#FFFFFF;height:100%;width:100%;overflow:auto;border:none;margin:0px;padding:0px;">
	<table style="width:800px;border-collapse:collapse;">
		<tr height="24px">
			<th width="36px"><oz:messageSource code="oz.index"/></th>
			<th width="60px"><oz:messageSource code="oz.component.auditlog.fields.eventtype"/></th>
			<th width="130px"><oz:messageSource code="oz.component.auditlog.fields.property"/></th>
			<th width="140px"><oz:messageSource code="oz.component.auditlog.fields.oldvalue"/></th>
			<th width="140px"><oz:messageSource code="oz.component.auditlog.fields.newvalue"/></th>
			<th width="80px"><oz:messageSource code="oz.component.auditlog.fields.user"/></th>
			<th width="110px"><oz:messageSource code="oz.component.auditlog.fields.timestamp"/></th>
			<th width="100px"><oz:messageSource code="oz.component.auditlog.fields.clientip"/></th>
		</tr>
		<tbody>
			<c:if test="${empty logs}">
				<tr height="24px">
					<td colspan="8" style="text-align:center">
						<b>没有审计日志</b>
					</td>
				</tr>
			</c:if>
			<c:if test="${!empty logs}">
				<c:forEach var="auditLog" items="${logs}" varStatus="status">
					<tr height="24px">
						<td style="text-align:center"><b>${status.index + 1}</b></td>
						<td title="${auditLog.eventTypeTitle}" style="text-align:center;">${auditLog.eventTypeTitle}</td>
						<td title="${auditLog.property}">${auditLog.property}</td>
						<td title="${auditLog.oldValue}">${auditLog.oldValue}</td>
						<td title="${auditLog.newValue}">${auditLog.newValue}</td>
						<td title="${auditLog.userName}">${auditLog.userName}</td>
						<td title="${auditLog.logTimestamp}">${auditLog.logTimestamp}</td>
						<td title="${auditLog.clientIp}">${auditLog.clientIp}</td>
					</tr>	
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</body>
<oz:js />
<script type="text/javascript">
$(function(){
	var rowIndex = 0;
	$("tbody tr").each(function(){
		if(rowIndex%2 == 0)
			$(this).removeClass("odd").addClass("even");
	    else
		    $(this).removeClass("even").addClass("odd");
	  	rowIndex++;	
	});
});	
</script>
</html>