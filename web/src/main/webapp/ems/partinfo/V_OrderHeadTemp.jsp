<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"  tree="true" datePicker="true" tabs="true" attachment="true"/>
<html>
<head>
	<title>
		配件领用出库
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssHref="/ems/common/css/ems-view.css"/>
</head>
<body class="oz-body" data-name="配件领用出库">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/orderHeadTempAction" searchButton="nomal">
			<oz:tbButton id="btnBack"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnRefresh"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnDelete"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnNewOut" icon="oz-icon oz-icon-0832" onclick="onBtnNewInOrOutClick(this,'out')" text="出库"/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="ems/orderHeadTempAction" sortName="id" fit="true"  excel="true">
			<oz:column field="id" checkbox="true" title="" width="27" />
			<oz:column field="ebsState" title="ebs同步状态" width="130" sortable="true" formatter="formatEbsStatus" />
			<oz:column field="orderNo" title="单号" width="130" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="equipmentDetails.equipmentName" title="设备名称" width="320" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="dateTime" title="记录时间" width="150" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="equipmentDetails.useD" title="使用部门" width="100" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="useP.name" title="领用人" width="100" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="operationTypeName" title="出库类型" width="80" sortable="true" formatter="oz_DefaultFormatter" />
		</oz:grid>
	</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/partinfo/js/ems.orderheadtemp.V.js"/>
<script type="text/javascript">
</script>
</html>