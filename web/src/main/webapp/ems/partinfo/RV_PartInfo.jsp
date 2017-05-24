<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"  tree="true" datePicker="true" tabs="true" attachment="true"/>
<html>
<head>
	<title>
		配件详细信息
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssHref="/ems/common/css/ems-view.css"/>
</head>
<body class="oz-body" data-name="配件详细信息">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/partInfoAction" searchButton="nomal">
			<oz:tbButton id="btnBack"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnRefresh"/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="ems/partInfoAction" sortName="partNo" fit="true"  excel="true" singleSelect="true">
			<oz:column field="id" checkbox="true" title="" width="27" />
			<oz:column field="organizationName" title="组织" width="120" sortable="true" formatter="oz_DefaultFormatter"/>
			<oz:column field="partNo" title="配件编号" width="100" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="partName" title="配件名称" width="500" sortable="true" formatter="oz_DefaultFormatter"/>
			<oz:column field="currentInventory" title="当前库存" width="80" sortable="true" formatter="oz_DefaultFormatter"/>
			<oz:column field="price" title="单价" width="100" sortable="true"   formatter="moneyFormatter" />
			<oz:column field="countUnits" title="计量单位" width="80" sortable="true" formatter="oz_DefaultFormatter" />
		</oz:grid>
	</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<script type="text/javascript">
</script>
</html>