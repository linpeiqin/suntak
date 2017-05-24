<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view" />
<html>
<head>
	<oz:css/>
</head>
<body class="oz-body" data-name="设备维修记录表">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/repairRecordAction" searchButton="none">
			<oz:tbButton id="btnNew"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnRefresh"/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="ems/repairRecordAction" sortName="status" fit="true" sortOrder="asc">
			<oz:column field="status" title="状态" width="80" sortable="true" formatter="formatStatus" />
			<oz:column field="equipmentDetails.equipmentName" title="设备名称" width="200" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="equipmentDetails.equipmentNo" title="设备编号" width="100" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="equipmentDetails.useD" title="使用部门" width="100" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="maintenanceNo" title="维修单号" width="120" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="maintenanceApplicant.name" title="维修申请人" width="120" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="distributor.name" title="分配人" width="100" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="maintenancePerson.name" title="维修人" width="100" sortable="true" formatter="oz_DefaultFormatter" />
		</oz:grid>
	</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/equipmentrepair/js/ems.repairrecord.V.js"/>
<script type="text/javascript">
    OZ.View.resize = function(){
        $("#page-center").height('300');
    }
</script>
</html>