<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"  tree="true" datePicker="true" tabs="true" attachment="true"/>
<html>
<head>
	<title>
		配件质量评价
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssHref="/ems/common/css/ems-view.css"/>
</head>
<body class="oz-body" data-name="配件质量评价">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/partQualityAction" searchButton="nomal">
			<oz:tbButton id="btnRefresh"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnDelete"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnNew" />
			<oz:tbSeperator/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="ems/partQualityAction" sortName="createdDate" fit="true"  excel="true" pageSize="8" singleSelect="true">
			<oz:column field="id" checkbox="true" title="" width="27" />
			<oz:column field="qualityTypeName" title="质量评价分类" width="120"  />
			<oz:column field="judgmentDetail" title="评价详细内容" width="100" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="createdBy" title="评价人" width="100" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="createdDate" title="创建时间" width="100" sortable="true" />
		</oz:grid>
	</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/partinfo/js/ems.partquality.V.js"/>
<script type="text/javascript">

</script>
</html>