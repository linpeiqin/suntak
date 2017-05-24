<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"  tree="true" datePicker="true"/>
<html>
<head>
	<title>
		保养年计划表
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="保养年计划表">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/repairYearPlanAction" searchButton="none">
			<oz:tbButton id="btnBack"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnDelete"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnRefresh"/>
			<oz:tbSeperator/>
			<oz:tbButton id="onbtnCreateYearPlan" icon="oz-icon oz-icon-0420" onclick="createLastPlan();" text="生成明年计划"/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="ems/repairYearPlanAction" sortName="id" fit="true"  excel="true" sortOrder="asc">
			<oz:column field="id" checkbox="true" title="" width="27" />
			<oz:column field="planYear" title="计划年" width="100" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="planTime" title="做计划时间" width="260" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="status" title="状态" width="160" sortable="true" formatter="statusFormatter" />
			<oz:column field="plannerName" title="计划者姓名" width="160" sortable="true" formatter="oz_DefaultFormatter" />
		</oz:grid>
	</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/yearplan/js/ems.yearplan.V.js"/>
<script type="text/javascript">
function statusFormatter(value, json){
	if(value == 0) return '未提交';
	if(value == 1) return '已提交';
}
</script>
</html>