<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view" tree="true"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.config.datadict"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.config.datadict"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="config/dataDictAction" searchButton="normal">
			<oz:tbSeperator/>
			<oz:tbButton id="btnBack"/>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnNew"></oz:tbButton>
			<oz:tbButton id="btnDelete"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh" text=""></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<div id="page-center-tree" class="oz-page-center-tree">
			<ul id="naviTree">
			</ul>
		</div>
		<div id="page-center-seperator" class="oz-page-center-seperator"></div>
		<div id="page-center-grid" class="oz-page-center-grid">
			<oz:grid action="config/dataDictAction" sortName="orderNo" sortOrder="asc" fit="true" pagination="true">
				<oz:column field="id" checkbox="true" title=""/>
				<oz:column field="name" title="oz.config.optionitem.fields.name" sortable="true" width="160" formatter="oz_DefaultFormatter"/>
				<oz:column field="value" title="oz.config.optionitem.fields.value" sortable="true" width="160" formatter="oz_DefaultFormatter"/>
                <oz:column field="orderNo" title="oz.config.optionitem.fields.orderno" sortable="true" width="160" formatter="oz_DefaultFormatter"/>
				<oz:column field="defaultFlag" title="oz.config.optionitem.fields.defaultflag" width="120" formatter="render4DefaultValue"/>
			</oz:grid>
		</div>
	</div>
</body>
<script type="text/javascript">
var _parentId = <%= request.getAttribute("parentId") %>;
oz_grid_config.url = "<oz:contextPath/>/config/dataDictAction.do?action=page";
oz_grid_config.params = [{parentId:_parentId}];
</script>
<oz:js />
<script type="text/javascript">
function onBtnNew_Clicked(){
	var strUrl = contextPath + "/config/dataDictAction.do?action=create";
	strUrl += "&parentId=" + _parentId; 
	strUrl += "&timeStamp=" + new Date().getTime();
	OZ.openWindow({
		id: oz_grid_config.id + "_create" + (new Date().getTime()),
		title:'<oz:messageSource code="oz.new"/>' + ($("body").data("name")),
		url: strUrl, 
		refresh: true,
		beforeCloseFnName: "oz_Win_BeforeClose"
	});
}

function onBtnSearch_Clicked(searchCondition){
	OZ.View.reloadGrid({group:_groupCode, dbftsParams:$("#ozQuery").val()});
}

function onBtnReset_Clicked(){
	OZ.View.reloadGrid({group:_groupCode, dbftsParams:""});
}

function render4DefaultValue(value, json){
	if(value == "Y")
		return '<oz:messageSource code="oz.yes"/>';
	else
		return '<oz:messageSource code="oz.no"/>';
}

$(function(){
	$('#naviTree').tree({
		children:[{text:"<oz:messageSource code="oz.config.datadict"/>",id:"-1",children:true}],
		url: contextPath + '/config/dataDictAction.do?action=getParentTree&parentId=' + _parentId + '&timeStamp=' + new Date().getTime(),
		click:function(e, data){
			_parentId = data.id;
			OZ.View.reloadGrid({parentId:_parentId, dbftsParams:""});
		}
	});
});
</script>
</html>