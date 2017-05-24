<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"  tree="true" datePicker="true"/>
<html>
<head>
	<title>
		工程完工报告表
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="工程完工报告表">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/completionAction" searchButton="none">
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
		<oz:grid action="ems/completionAction" sortName="number" fit="true"  excel="true" >
			<oz:column field="id" checkbox="true" title="" width="27" />
			<oz:column field="number" title="编号" width="100" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="contractNumber" title="合同编号" width="260" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="projectName" title="工程项目名称" width="160" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="assetsNumber" title="数    量" width="160" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="ascriptionMD" title="归口管理部门" width="260" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="contractingUnit" title="承 包 单 位" width="160" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="constructionUnit" title="施 工 单 位" width="160" sortable="true" formatter="oz_DefaultFormatter" />
		</oz:grid>
	</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<oz:js jsSrc="/ems/completion/js/ems.completion.V.js"/>
<script type="text/javascript">
</script>
</html>