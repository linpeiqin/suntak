<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view" tree="true">
<html>
<head>
	<title><oz:messageSource code="cn.demo.note"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css /> 
	<!-- 放置页面的私有样式 
	<style type="text/css">
		
	</style>
	<link type="text/css" rel="stylesheet" href="cssLink.css" />
	-->
</head>
<body class="oz-body" data-name="<oz:messageSource code="cn.demo.note"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="demo/noteAction" searchButton="advance">
			<oz:tbSeperator/>
			<oz:tbButton id="btnNew" />
			<oz:tbButton id="btnImport"  tip="cn.demo.note.none" icon="oz-icon-0627" onclick="onBtnImport_Clicked()" />
			<oz:tbButton id="btnDelete"/>
			<oz:tbButton id="btnRefresh"/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<div id="page-center-tree" class="oz-page-center-tree">
			<ul id="classifiedTree">
				<li data-node='{"id":"tagtpl","nodeCls":"tree-root-bg"}'><span>演示模块</span>
					<ul>
						<li data-node='{"id":"demo1","title":"icon16","href":"/demo/noteAction.do"}'><span>记事本</span></li>
					</ul>
				</li>
				<li data-node='{"id":"sysmodules","nodeCls":"tree-root-bg","state":"closed"}'><span>系统应用</span>
				</li>
			</ul>
			<script type="text/javascript">
				var oz_tree_config = {"id":"classifiedTree"};
			</script>
		</div>
		<div id="page-center-seperator" class="oz-page-center-seperator"></div>
		<div id="page-center-grid" class="oz-page-center-grid">
			<oz:grid action="demo/noteAction" sortName="holidayDate" sortOrder="desc" fit="true">
				<oz:column field="id" checkbox="true"/>
				<oz:column field="title" title="cn.demo.note.grid.title" sortable="true" width="120"  formatter="oz_DefaultFormatter"/>
				<oz:column field="authorName" title="cn.oz.author" sortable="false" width="160"/>
				<oz:column field="createdDate" title="cn.oz.createdDate" sortable="false" width="120" />
			</oz:grid>
		</div>
	</div>
</body>
<oz:js />
<!-- 放置页面的私有脚本  -->
<script type="text/javascript">
function onBtnImport_Clicked(){
	
}
</script>
<!--
 <script type="text/javascript" src="" />
  -->
</html>
</oz:ui>