<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="view" />
<head>
<title>更换配件</title>
<%@ include file="/oz/includes/meta.jsp"%>
<oz:css />
<oz:css cssHref="/ems/common/css/ems-view.css" />
</head>
<body class="oz-body" data-name="更换配件">
<div id="page-top" class="oz-page-top">
	<oz:toolbar action="ems/partReplaceAction" searchButton="none">
		<oz:tbButton id="btnRefresh"/>
	</oz:toolbar>
</div>
<div id="page-center" class="oz-page-center">
	<oz:grid action="ems/partReplaceAction" sortName="partName" fit="true"  excel="true" >
		<oz:column field="id" checkbox="true" title="" width="27" />
		<oz:column field="repairRecord.endTime" title="维修结束时间" width="140" sortable="true" />
		<oz:column field="repairRecord.maintenanceNo" title="维修单号" width="130" sortable="true" />
		<oz:column field="repairRecord.equipmentDetails.equipmentNo" title="设备编号" width="100" sortable="true" />
		<oz:column field="repairRecord.equipmentDetails.equipmentName" title="设备名称" width="500" sortable="true" />
		<oz:column field="partName" title="配件名称" width="500" sortable="true" />
		<oz:column field="qty" title="数量" width="100" sortable="true" />
	</oz:grid>
</div>
</body>
<oz:js />
<oz:js jsSrc="/ems/common/js/common.util.js" />
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<oz:js jsSrc="/ems/equipmentrepair/js/ems.partreplace.V.js" />
<script type="text/javascript">
</script>
</html>