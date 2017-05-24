<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"  tree="true" datePicker="true"/>
<html>
<head>
	<title>
		设备维修记录表
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssHref="/ems/common/css/ems-view.css"/>
</head>
<body class="oz-body" data-name="设备维修记录表">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/repairRecordAction" searchButton="true">
			<oz:tbButton id="btnBack"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnDelete"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnNew"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnRefresh"/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="ems/repairRecordAction" sortName="id" fit="true"  excel="true" >
			<oz:column field="id" checkbox="true" title="" width="27" />
			<oz:column field="status" title="状态" width="80" sortable="true" formatter="formatStatus" />
			<oz:column field="equipmentDetails.equipmentName" title="设备名称" width="180" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="equipmentDetails.equipmentNo" title="设备编号" width="100" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="equipmentDetails.useD" title="使用部门" width="80" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="maintenanceNo" title="维修单号" width="120" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="eDegreeName" title="紧急程度" width="80" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="maintenanceApplicant.name" title="维修申请人" width="80" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="distributor.name" title="分配人" width="80" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="maintenanceTime" title="送修时间" width="130" sortable="true" formatter="renderpublisherDate" />
			<oz:column field="startTime" title="开始时间" width="130" sortable="true" formatter="renderpublisherDate" />
			<oz:column field="endTime" title="完成时间" width="130" sortable="true" formatter="renderpublisherDate" />
			<oz:column field="maintenanceCost" title="维修费用" width="100" sortable="true" formatter="moneyFormatter" />
			<oz:column field="faultDescription" title="故障描述" width="140" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="downTime" title="停机时长" width="120" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="maintenaceLevelName" title="维修级别" width="100" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="maintenancePerson.name" title="维修人" width="100" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="maintenanceUnit" title="维修单位" width="140" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="faultClassName" title="故障类别" width="100" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="faultSolve" title="故障分析及处理" width="160" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="userScore" title="用户评分" width="100" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="userOpinion" title="用户意见" width="160" sortable="true" formatter="oz_DefaultFormatter" />
		</oz:grid>
	</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/equipmentrepair/js/ems.repairrecord.V.js"/>
<script type="text/javascript">
	var classify = '<%= request.getAttribute("classify") %>';
	oz_grid_config.url = "<oz:contextPath/>/ems/repairRecordAction.do?action=page&classify="+classify;
</script>
</html>