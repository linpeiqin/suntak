<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"  tree="true" datePicker="true"/>
<html>
<head>
	<title>
		故障字典
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssHref="/ems/common/css/ems-view.css"/>
</head>
<body class="oz-body" data-name="故障字典">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/faultDescAction" searchButton="nomal">
			<oz:tbButton id="btnBack" />
			<oz:tbSeperator />
			<oz:tbButton id="btnNew" />
			<oz:tbSeperator />
			<oz:tbButton id="btnDelete" />
			<oz:tbSeperator />
			<oz:tbButton id="btnRefresh" />
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="ems/faultDescAction"  fit="true"  excel="true" singleSelect="true"> 
			<oz:column field="id" checkbox="true" title="" width="27" />
			<oz:column field="faultTypeName" title="故障分类" width="150" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="appearanceSummary" title="现象摘要" width="420" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="apearanceDetail" title="现象详细" width="530" sortable="true" formatter="oz_DefaultFormatter" />
		</oz:grid>
	</div>
	<div id = "moveLine"class="oz-layout-split-north">
		<div class="oz-layout-mini-north">&nbsp;</div>
		</div>
	<div  class="oz-form-tabs">
		<iframe id="IFRAME_BOX"  height="100%" width="100%" frameborder="0">
        </iframe>
	</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/equipmentrepair/js/ems.faultdesc.V.js"/>
<script type="text/javascript">
</script>
</html>