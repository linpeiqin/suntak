<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="form" easyui="true"/>
<html>
<head>
	<title>
		设备详细信息表
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssHref="/ems/common/css/ems-view.css"/>
</head>
<body class="oz-body" data-name="设备详细信息表">
	<div style="height:5%;"><b style="color:red">注释：请勾选你要选择的设备并点击确认</b></div>
	<div style="height:95%;">
	<table id="edGrid"></table>
	</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<oz:js jsSrc="/ems/equipmentdetails/js/ems.equipmentdetailsG.V.js" />
<script type="text/javascript">
	var contractNo = '<%= request.getAttribute("contractNo") %>';
	var fixedAssetsName = '<%= request.getAttribute("fixedAssetsName") %>';
	var specificationModel = '<%= request.getAttribute("specificationModel") %>';
	var equipmentNos = '<%= request.getAttribute("equipmentNos") %>';
	var lifeCycleId = '<%= request.getAttribute("lifeCycleId") %>';
	var type = '<%= request.getAttribute("type") %>';
</script>
</html>