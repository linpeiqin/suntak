<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="view"/>
<head>
	<title>文件编号管理</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" name="文件编号管理">
<div id="page" class="oz-page">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/fileNumberAction" searchButton="normal">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnNew" text="新建"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnDelete" text="删除"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh" text="刷新"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
			<oz:grid action="ems/fileNumberAction" sortName="numberOrder" sortOrder="asc" fit="true" >
				<oz:column field="id" checkbox="true"/>
				<oz:column field="numberName" title="序号" width="40" formatter="showNo" />
				<oz:column field="numberOrder" title="排序号" width="60" sortable="true" formatter="oz_DefaultFormatter" />
				<oz:column field="subject" title="编号名称" width="160" sortable="true" formatter="oz_DefaultFormatter" />
				<oz:column field="numberCode" title="编号代码" width="140" sortable="true"/>
				<oz:column field="numberPrefix" title="编号前缀" width="120" sortable="true"/>
				<oz:column field="serial" title="当前序号" width="80" sortable="true"/>
				<oz:column field="numberPostfix" title="编号后缀" width="120" sortable="true"/>
			</oz:grid>

	</div>
</div>
</body>
<oz:js/>
<script type="text/javascript">

function showNo(value,json,rowindex){
	return rowindex+1;
}

</script>
</html>