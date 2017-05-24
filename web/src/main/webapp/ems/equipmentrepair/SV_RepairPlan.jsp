<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"  tree="true" datePicker="true"/>
<html>
<head>
	<title>
		保养计划
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssHref="/ems/common/css/ems-view.css"/>
</head>
<body class="oz-body" data-name="保养计划">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/repairPlanAction" searchButton="none">
			<oz:tbButton id="btnRefresh"/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="ems/repairPlanAction" sortName="maintenanceLevel" fit="true"  excel="true" >
			<oz:column field="id" checkbox="true" title="" width="27" />
			<oz:column field="maintenaceLevelName" title="保养级别" width="60" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="equipmentDetails.equipmentName" title="设备名称" width="245" sortable="true" formatter="oz_DefaultFormatter"/>
			<oz:column field="equipmentDetails.equipmentNo" title="设备编号" width="100" sortable="true" formatter="oz_DefaultFormatter"/>
			<oz:column field="isOff" title="是否关闭" width="100" sortable="true" formatter="isOffFormatter" />
			<oz:column field="lastTimeStr" title="上次保养时间" width="100" sortable="true" formatter="renderpublisherDate2"/>
			<oz:column field="nextTimeStr" title="下次保养时间" width="100" sortable="true" formatter="renderpublisherDate2"/>
			<oz:column field="maintenanceUnit" title="保养单位" width="100" sortable="true" formatter="oz_DefaultFormatter"/>
			<oz:column field="maintenancePeson.name" title="保养人员" width="100" sortable="true" formatter="oz_DefaultFormatter"/>
			<oz:column field="workDescription" title="工作描述" width="200" sortable="true" formatter="oz_DefaultFormatter"/>
		</oz:grid>
	</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/equipmentrepair/js/ems.repairplan.V.js"/>
<script type="text/javascript">
    oz_grid_config.url = "<oz:contextPath/>/ems/repairPlanAction.do?action=page&viewType=sview";
</script>
</html>