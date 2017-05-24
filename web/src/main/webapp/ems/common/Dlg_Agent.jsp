<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="view" tree="true" datePicker="true" />
<head>
	<title>选择供应商</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" >
<div id="page-top" class="oz-page-top">
	<oz:toolbar action="ems/emsCommonAction" searchButton="nomal">
	</oz:toolbar>
</div>
<div id="page-center" class="oz-page-center">
	<oz:grid action="ems/emsCommonAction" sortName="vendorId" fit="true"  excel="true" >
		<oz:column field="vendorName" title="供应商名称" width="770" sortable="true" />
	</oz:grid>
</div>
</body>
<oz:js />
<script type="text/javascript">
oz_grid_config.url =  contextPath + "/ems/emsCommonAction.do?action=page&type=agent";
	function ozDlgOkFn(){
		var rows = OZ.View.getGridSelection();
		if (rows.length==0){
			oz.Msg.info("请选择供应商！");
			return false;
		}
		return {vendorId:rows[0].vendorId,vendorName:rows[0].vendorName};
	}
	function oz_Row_DBLClicked(rowIndex,rowData){
		ozDlgOkFn();
	}
</script>
</html>