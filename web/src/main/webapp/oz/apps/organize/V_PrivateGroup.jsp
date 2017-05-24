<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.mdu.organize.privategroup"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.organize.privategroup"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="organize/privateGroupAction.do?type=${param.type}&_a=none" searchButton="none" defaultTB="view">
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="organize/privateGroupAction" sortName="name" sortOrder="asc" fit="true">
			<oz:column field="id" checkbox="true" title=""/>
			<oz:column field="name" title="oz.mdu.organize.privategroup.fields.name" width="320" sortable="true" formatter="oz_DefaultFormatter"/>
		</oz:grid>
	</div>
</body>
<script type="text/javascript">
oz_grid_config.url = oz_grid_config.url + "&type=${param.type}";
</script>
<oz:js/>
</html>