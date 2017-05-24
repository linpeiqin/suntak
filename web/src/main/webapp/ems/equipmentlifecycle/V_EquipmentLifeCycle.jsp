<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"  tree="true" datePicker="true"/>
<html>
<head>
	<title>
		设备生命周期
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="设备生命周期">
<div id="page-top" class="oz-page-top">
	<oz:toolbar action="ems/equipmentLifeCycleAction" searchButton="nomal">
		<oz:tbButton id="btnRefresh"/>
		<oz:tbSeperator/>
		<oz:tbSelect id="btnNewLifeCycleSelect"  text="" options="lifeCycleSelect" blankOption="true"/>
		<oz:tbButton id="btnAddLifeCycle" text="添加" icon="oz-icon oz-icon-0511" onclick="newLifeCycleType()"/>
		<oz:tbSeperator/>
	</oz:toolbar>
</div>
<div id="page-center" class="oz-page-center">
	<oz:grid action="ems/equipmentLifeCycleAction" sortName="type" fit="true"  excel="true" sortOrder="asc">
		<oz:column field="id" checkbox="true" title="" width="27" />
		<oz:column field="typeName" title="阶段" width="80" sortable="true"   />
		<oz:column field="createdBy" title="创建人" width="100" sortable="true"   />
		<oz:column field="createdDate" title="创建时间" width="130" sortable="true"   formatter="renderpublisherDate"/>
		<oz:column field="remark" title="内容" width="250" sortable="true" />
		<oz:column field="oaDate" title="OA审批时间" width="130" sortable="true"   formatter="renderpublisherDate"/>
		<oz:column field="oaType" title="OA审批结果" width="100" sortable="true"  formatter="OATypeFommater" />
		<oz:column field="ebsDate" title="同步EBS时间" width="130" sortable="true"  formatter="renderpublisherDate" />
		<oz:column field="ebsType" title="EBS同步结果" width="100" sortable="true" formatter="EBSTypeFommater"  />

	</oz:grid>
</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<oz:js jsSrc="/ems/equipmentlifecycle/js/ems.equipmentlifecycle.V.js"/>
<script type="text/javascript">
</script>
</html>