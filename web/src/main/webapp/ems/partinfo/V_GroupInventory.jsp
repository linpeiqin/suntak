<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"  tree="true" datePicker="true" tabs="true" attachment="true"/>
<html>
<head>
	<title>
		集团库存
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssHref="/ems/common/css/ems-view.css"/>
</head>
<body class="oz-body" data-name="集团库存">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/groupInventoryAction" searchButton="none">
			<oz:tbButton id="btnRefresh"/>
			<oz:tbSeperator/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="ems/groupInventoryAction"  fit="true"  excel="true" pageSize="8" singleSelect="true">
			<oz:column field="id" checkbox="true" title="" width="27" />
			<oz:column field="organizationName" title="组织" width="180" />
			<oz:column field="partNo" title="单号" width="180" />
			<oz:column field="onhandQty" title="现有量" width="100" />
			<oz:column field="onroadQty" title="在途量" width="100" />
		</oz:grid>
	</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/partinfo/js/ems.groupinventory.V.js"/>
<script type="text/javascript">
</script>
</html>