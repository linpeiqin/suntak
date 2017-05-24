<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"  tree="true" datePicker="true"/>
<html>
<head>
	<title>
		保养记录表
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssHref="/ems/common/css/ems-view.css"/>
</head>
<body class="oz-body" data-name="保养记录表">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/maintainAction" searchButton="nomal">
			<oz:tbButton id="btnBack" />
			<oz:tbSeperator />
			<oz:tbButton id="btnRefresh" />
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="ems/maintainAction" sortName="id" fit="true"  excel="true" singleSelect="true"> 
			<oz:column field="id" checkbox="true" title="" width="27" />
			<oz:column field="equipmentDetails.equipmentName" title="设备名称" width="200" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="equipmentDetails.equipmentNo" title="设备编号" width="135" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="equipmentDetails.useD" title="使用部门" width="80" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="maintainLevel" title="保养级别" width="60" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="planDateStr" title="计划日期" width="80" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="executTimeStr" title="执行时间" width="130" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="status" title="状态" width="80" sortable="true" formatter="isStatusFormatter" />
			<oz:column field="maintainPerson.name" title="保养人" width="80" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="maintainResult" title="保养结果" width="200" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="mltUseState" title="物料使用情况" width="200" sortable="true" formatter="oz_DefaultFormatter" />
		</oz:grid>
	</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/equipmentrepair/js/ems.maintain.V.js"/>
<script type="text/javascript">
    var classify = '<%= request.getAttribute("classify") %>';
    oz_grid_config.url = "<oz:contextPath/>/ems/maintainAction.do?action=page&classify="+classify;
</script>
</html>