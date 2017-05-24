<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="view" tree="true" datePicker="true" />
<head>
	<title>选择申请人</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" >
<div id="page-top" class="oz-page-top">
	<oz:toolbar action="ems/emsCommonAction" searchButton="nomal">
	</oz:toolbar>
</div>
<div id="page-center" class="oz-page-center">
	<oz:grid action="ems/emsCommonAction" sortName="employeeId" fit="true"  excel="true" >
		<oz:column field="fullName" title="申请人" width="770" sortable="true" />
	</oz:grid>
</div>
</body>
<oz:js />
<script type="text/javascript">
oz_grid_config.url =  contextPath + "/ems/emsCommonAction.do?action=page&type=employees";
	function ozDlgOkFn(){
		var rows = OZ.View.getGridSelection();
		if (rows.length==0){
			oz.Msg.info("请选择申请人！");
			return false;
		}
		return {employeeId:rows[0].employeeId,fullName:rows[0].fullName};
	}
	function oz_Row_DBLClicked(rowIndex,rowData){
		ozDlgOkFn();
	}
</script>
</html>