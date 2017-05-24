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
		<oz:toolbar action="ems/repairPlanAction" searchButton="true">
			<oz:tbButton id="btnBack"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnDelete"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnNew"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnRefresh"/>
<%-- 			<oz:tbSeperator/> --%>
<%-- 			<oz:tbButton id="btnDoPlan" text="执行计划" onclick="doPlan()" icon="oz-icon oz-icon-0119"/> --%>
<%-- 			<oz:tbSeperator/> --%>
<%-- 			<oz:tbButton id="btnSeeRecord" text="查看记录" onclick="seeRecord()" icon="oz-icon oz-icon-0116"/> --%>
			<oz:tbSeperator/>
			<oz:tbButton id="onbtnCreatePlanTime" icon="oz-icon oz-icon-0420" onclick="createLastPlanTime();" text="生成明年计划时间"/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="ems/repairPlanAction" sortName="createdDate" fit="true"  excel="true" >
			<oz:column field="id" checkbox="true" title="" width="27" />
			<oz:column field="equipmentDetails.equipmentName" title="设备名称" width="245" sortable="true" formatter="oz_DefaultFormatter"/>
			<oz:column field="equipmentDetails.equipmentNo" title="设备编号" width="100" sortable="true" formatter="oz_DefaultFormatter"/>
			<oz:column field="equipmentDetails.equipmentType" title="设备类别" width="150" sortable="true" formatter="oz_DefaultFormatter"/>
			<oz:column field="equipmentDetails.specificationModel" title="规格型号" width="150" sortable="true" formatter="oz_DefaultFormatter"/>
		</oz:grid>
	</div>
</body>
<oz:js />
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/equipmentrepair/js/ems.repairplan.V.js"/>
<script type="text/javascript">
	var classify = '<%= request.getAttribute("classify") %>';
	oz_grid_config.url = "<oz:contextPath/>/ems/repairPlanAction.do?action=page&classify="+classify;
</script>
</html>