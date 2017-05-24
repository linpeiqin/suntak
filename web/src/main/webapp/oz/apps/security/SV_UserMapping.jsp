<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.mdu.security.usermapping"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.security.usermapping"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar svFlag="true" action="security/userMappingAction" searchButton="none">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnAdd" text="oz.add" icon="oz-icon-0102" onclick="onBtnAdd_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnDelete"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="security/userMappingAction" sortName="mappingSystemId" sortOrder="asc" fit="true" pagination="false">
			<oz:column field="id" checkbox="true" title=""/>
			<oz:column field="mappingSystemId" title="oz.mdu.security.usermapping.fields.systemid" width="240" sortable="true" formatter="render4UserMapping"/>
			<oz:column field="mappingLoginName" title="oz.mdu.security.usermapping.fields.loginname" width="120" sortable="true" formatter="render4UserMapping"/>
		</oz:grid>
	</div>
</body>
<script type="text/javascript">
var _loginName = '<%= request.getAttribute("loginName") %>';
var _editFlag = '<%= request.getAttribute("editFlag") %>';
oz_grid_config.url = "<oz:contextPath/>/security/userMappingAction.do?action=page&loginName=" + _loginName;
</script>
<oz:js/>
<script type="text/javascript">
function render4UserMapping(value, rowData, rowIndex){
	var title = rowData.loginName + "-Mapping";
	var _href = "<a href='";
	_href += "javascript:OZ.openWindow({";
	_href += "url:\"" + OZ.addParamToUrl(oz_grid_config.path, "action=" + ozOpenActionName + "&id=" + rowData.id + "&editFlag=" + _editFlag) + "\",";
	_href += "title:\"" + title + "\",";
	_href += "id:\"" + oz_grid_config.id + rowData.id + "\",";
	_href += "tabTip:\"" + title + "\",";
	_href += "refresh:true,";
	_href += "data:\"UserMapping\",";
	_href += "beforeCloseFnName:\"oz_Win_BeforeClose\"";
	_href += "})";
	_href += "'>" + value + "</a>";
    return _href;
}

function onBtnAdd_Clicked(){
	var strUrl = contextPath + "/security/userMappingAction.do?action=create&loginName=" + _loginName;
	strUrl += "&timeStamp=" + new Date().getTime();
	OZ.openWindow({
		id: oz_grid_config.id + "_create" + (new Date().getTime()),
		title: '<oz:messageSource code="oz.mdu.security.usermapping"/>',
		url: strUrl,
		refresh: true,
		beforeCloseFnName: "oz_Win_BeforeClose",
		data:"UserMapping"
	});	
}
</script>
</html>