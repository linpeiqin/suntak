<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"  tree="true" />
<html>
<head>
	<title>
		<oz:messageSource code="oz.module.useronline"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.module.useronline"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="module/userOnlineAction" searchButton="none">
			<oz:tbButton id="btnBack"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnRefresh"/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<div id="page-center-tree" class="oz-page-center-tree">
			<ul id="ouInfoTree"></ul>
		</div>
		<div id="page-center-seperator" class="oz-page-center-seperator"></div>
		<div id="page-center-grid" class="oz-page-center-grid">
			<oz:grid action="module/userOnlineAction"  sortName="createdDate"  sortOrder="desc" fit="true" pageSize="2">
				<oz:column field="id" checkbox="true" title=""/>
				<oz:column field="name" title="oz.module.useronline.fields.name" width="100"  />
				<oz:column field="ouName" title="oz.module.useronline.fields.ouname" width="180"  />
				<oz:column field="loginTime" title="oz.module.useronline.fields.login.time" width="150"  />
				<oz:column field="durationTime" title="oz.module.useronline.fields.duration.time" width="140" />
				<oz:column field="clientIp" title="oz.module.useronline.fields.client.ip" width="130" />
			</oz:grid>
		</div>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function onRow_DBLClicked(){
	// 禁用掉
}
$('#ouInfoTree').tree({
	url: contextPath + '/organize/ouTreeAction.do?action=getTree&timeStamp=' + new Date().getTime(),
	click:function(e, data){
		OZ.View.reloadGrid({ouId:data.id || -1, dbftsParams:""});
	}
});
</script>
</html>