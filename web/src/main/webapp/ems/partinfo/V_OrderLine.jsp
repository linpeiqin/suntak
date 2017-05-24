<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"  tree="true" datePicker="true" tabs="true" attachment="true"/>
<html>
<head>
	<title>
		备件出入库记录
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssHref="/ems/common/css/ems-view.css"/>
</head>
<body class="oz-body" data-name="备件出入库记录">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/orderLineAction" searchButton="nomal">
			<oz:tbButton id="btnRefresh"/>
			<oz:tbSeperator/>
			<%--<oz:tbButton id="btnNewOut" icon="oz-icon oz-icon-0832" onclick="onBtnNewInOrOutClick(this,'out')" text="出库"/>
			<oz:tbSeperator/>--%>
			<oz:tbSelect id="selStatus" text="" value="status" blankOption="true">
				<oz:tbOption name="入库" value="0"/>
				<oz:tbOption name="出库" value="1"/>
			</oz:tbSelect>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="ems/orderLineAction"  fit="true"  excel="true" pageSize="8">
			<oz:column field="id" checkbox="true" title="" width="27" />
			<oz:column field="orderHead.id" hidden="true" />
			<oz:column field="orderHead.operation" hidden="true" />
			<oz:column field="orderHead.orderNo" title="单号" width="90" sortable="true" />
			<oz:column field="partNo" title="配件编号" width="80" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="partName" title="配件名称" width="300" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="orderHead.dateTime" title="记录时间" width="150" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="orderHead.supplier" title="供应商" width="200" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="orderHead.operationTypeName" title="出入库类型" width="80" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="qty" title="数量" width="50" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="UOMCode" title="单位" width="40" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="price" title="单价" width="80" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="amount" title="总价" width="80" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="currencyCode" title="币别" width="50" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="rate" title="汇率" width="40" sortable="true" formatter="oz_DefaultFormatter" />
		</oz:grid>
	</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/partinfo/js/ems.orderline.V.js"/>
<script type="text/javascript">
</script>
</html>