<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"   datePicker="true"/>
<html>
<head>
	<title>
		保养计划时间
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssHref="/ems/common/css/ems-view.css"/>
</head>
<body class="oz-body" data-name="保养计划时间">
<c:if test="${barShow }">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/repairPlanAction" searchButton="true">
			<oz:tbButton id="btnNew"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnRefresh"/>
		</oz:toolbar>
	</div>
</c:if>
	<div id="page-center" class="oz-page-center">
	<oz:grid action="ems/repairPlanAction" fit="true"  excel="true" rownumbers="true">
		<oz:column field="id" checkbox="true" title="" width="27" />
		<oz:column field="repairPlanRule.maintenaceLevel" title="保养级别" width="60" sortable="true" formatter="renderpublisherDate2" />
		<oz:column field="planDate" title="系统计划日期" width="120" sortable="true" formatter="renderpublisherDate2" />
		<oz:column field="actualDate" title="人工调整日期" width="120" sortable="true" formatter="renderpublisherDate2" />
		<oz:column field="status" title="状态" width="120" sortable="true" formatter="isOffFormatter" />
	</oz:grid>
	</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/equipmentrepair/js/ems.repairplan.V.js"/>
<script type="text/javascript">
	var planId = '<%= request.getAttribute("planId") %>';
	oz_grid_config.url = "<oz:contextPath/>/ems/repairPlanAction.do?action=pageTime&planId="+planId;
</script>
</html>