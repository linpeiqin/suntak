<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view" tree="true" datePicker="true"/>
<html>
<head>
	<title>
		辅机关联
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssHref="/ems/common/css/ems-view.css"/>
</head>
<body class="oz-body" data-name="辅机关联">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/equipmentDetailsAction" searchButton="nomal">
			<oz:tbButton id="btnDeleteRelation" icon="oz-icon oz-icon-0530"  onclick="onDeleteRelation()" text="解除关联"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnAddRelation" icon="oz-icon oz-icon-0529"  onclick="onAddRelation()" text="添加关联"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnRefresh"/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="ems/equipmentDetailsAction" sortName="equipmentName" fit="true"  excel="true">
			<oz:column field="id" checkbox="false"  title="" width="27"  />
			<oz:column field="equipmentName" title="设备名称" width="300" sortable="true"  />
			<oz:column field="equipmentNo" title="设备编号" width="200" sortable="true"/>
			<oz:column field="specificationModel" title="规格型号" width="300" sortable="true" />
		</oz:grid>
	</div>
	
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/equipmentdetails/js/ems.equipmentdetails.SV.js"/>
<script type="text/javascript">
	oz_grid_config.url = "<oz:contextPath/>/ems/equipmentDetailsAction.do?action=pageForEQ";
</script>
</html>