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
		<div id="page-center-grid" class="oz-page-center-grid">
			<oz:grid action="ems/partInfoAction"  fit="true"  excel="true" singleSelect="true">
				<oz:column field="id" checkbox="true" title="" width="27" />
				<oz:column field="organizationName" title="组织" width="120" sortable="true" />
				<oz:column field="category1" title="大类" width="100" sortable="true" />
				<oz:column field="category2" title="小类" width="100" sortable="true" />
				<oz:column field="partNo" title="配件编号" width="100" sortable="true"/>
				<oz:column field="partName" title="配件名称" width="500" sortable="true" />
				<oz:column field="onhandQty" title="本地现有量" width="80" sortable="true"   align="right"/>
				<oz:column field="price" title="单价" width="100" sortable="true"   formatter="moneyFormatter" align="right" />
				<oz:column field="onroadQty" title="本地在途量" width="80" sortable="true"  align="right" />
				<oz:column field="totalOnhandQty" title="集团总现有量" width="80" sortable="true"  align="right"/>
				<oz:column field="countUnits" title="计量单位" width="80" sortable="true"  />
			</oz:grid>
		</div>
		<div id ="moveLine"class="oz-layout-split-north" style="position: absolute">
			<div class="oz-layout-mini-north">&nbsp;</div>
		</div>
		<div id="tabCt" class="border" style="position: absolute">
			<div data-tab-panel='{"id":"tab_00","title":"集团库存","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
				<iframe id="IFRAME_00" class="oz-tab-iframe" height="100%" width="100%" frameborder="0">
				</iframe>
			</div>
			<div data-tab-panel='{"id":"tab_01","title":"出入库记录","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
				<iframe id="IFRAME_01" class="oz-tab-iframe" height="100%" width="100%" frameborder="0">
				</iframe>
			</div>
			<div data-tab-panel='{"id":"tab_02","title":"更换记录","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
				<iframe id="IFRAME_02" class="oz-tab-iframe" height="100%" width="100%" frameborder="0">
				</iframe>
			</div>
			<div data-tab-panel='{"id":"tab_03","title":"附件","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
				<iframe id="IFRAME_03" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" >
				</iframe>
			</div>
			<div data-tab-panel='{"id":"tab_04","title":"质量评价","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
				<iframe id="IFRAME_04" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" >
				</iframe>
			</div>
		</div>
	</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/partinfo/js/ems.partinfo.V.js"/>
<script type="text/javascript">
</script>
</html>