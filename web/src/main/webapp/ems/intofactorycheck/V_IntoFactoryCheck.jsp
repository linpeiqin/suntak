<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"  tree="true" datePicker="true"/>
<html>
<head>
	<title>
		固定资产入厂验收报告表
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssHref="/oz/webui/jquery-plugins/loadmask/jquery.loadmask.css"/>
</head>
<body class="oz-body" data-name="固定资产入厂验收报告表">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/intoFactoryCheckAction" searchButton="none">
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
		<oz:grid action="ems/intoFactoryCheckAction" sortName="number" fit="true"  excel="true" >
			<oz:column field="id" checkbox="true" title="" width="27" />
			<oz:column field="type" title="类型" width="100" sortable="true" />
			<oz:column field="number" title="编号" width="100" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="contractNumber" title="合同编号" width="260" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="fixedAssetsName" title="固定资产名称" width="160" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="specificationModel" title="固定资产编号" width="160" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="fixedAssetsType" title="固定资产类别" width="260" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="fixedAssetsNo" title="固定资产编号" width="160" sortable="true" formatter="oz_DefaultFormatter" />
		</oz:grid>
	</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<oz:js jsSrc="/ems/intofactorycheck/js/ems.intofactorycheck.V.js"/>
<script type="text/javascript">
</script>
</html>