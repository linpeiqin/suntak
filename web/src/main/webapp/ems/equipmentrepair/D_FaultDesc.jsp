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
		<oz:toolbar action="ems/partInfoAction" searchButton="nomal">
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="ems/faultDescAction"  sortName="faultType" fit="true"  excel="true" singleSelect="true" >
			<oz:column field="id" checkbox="true" title="" width="27" />
			<oz:column field="faultTypeName" title="故障分类" width="150" />
			<oz:column field="appearanceSummary" title="现象摘要" width="420" sortable="true"  />
			<oz:column field="apearanceDetail" hidden="true"/>
			<oz:column field="dealSummary" title="处理摘要" width="530" sortable="true" />
			<oz:column field="dealDetail" hidden="true"/>
		</oz:grid>
	</div>
	<div id = "moveLine"class="oz-layout-split-north">
		<div class="oz-layout-mini-north">&nbsp;</div>
		</div>
	<div >
		<iframe id="IFRAME_BOX"  height="100%" width="100%" frameborder="0">

        </iframe>
	</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/equipmentrepair/js/ems.faultdesc.D.js"/>
<script type="text/javascript">
</script>
</html>