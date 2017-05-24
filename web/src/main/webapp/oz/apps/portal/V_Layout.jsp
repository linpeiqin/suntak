<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.portalmgm.constants.layout"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.portalmgm.constants.layout"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="module/layoutAction">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnNew"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnEnable" text="oz.enable" icon="oz-icon-0901" onclick="onBtnEnable_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnDisable" text="oz.disable" icon="oz-icon-0903" onclick="onBtnDisable_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnDelete"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="module/layoutAction" sortName="name" sortOrder="asc" fit="true">
			<oz:column field="id" checkbox="true" title=""/>
			<oz:column field="status" title="oz.portalmgm.layout.fields.status" width="45" formatter="statusFormatter"/>
			<oz:column field="name" title="oz.portalmgm.layout.fields.name" width="360" formatter="oz_DefaultFormatter"/>
			<oz:column field="iconClazz" title="oz.portalmgm.layout.fields.iconclazz" width="160" sortable="false"/>
			
		</oz:grid>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function statusFormatter(value, rowData){
	if(value == 0)
		return '<oz:messageSource code="oz.enable"/>';
	return '<oz:messageSource code="oz.disable"/>';
}

function onBtnDisable_Clicked(){
	var ids = OZ.View.getGridSelectionIds();
	if (null == ids || ids.length == 0) {
		OZ.Msg.info('<oz:messageSource code="oz.portalmgm.layout.msg.selected.isempty"/>');
		return;
	}
	
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.portalmgm.layout.msg.confirm.disabled"/>',
		function(){
			$.getJSON(
				contextPath + "/module/layoutAction.do?action=disable&timeStamp=" + new Date().getTime(),
				{ids:ids},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.portalmgm.layout.msg.disabled.success"/>');
						OZ.View.reloadGrid();
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			);
		}
	);
}

function onBtnEnable_Clicked(){
	var ids = OZ.View.getGridSelectionIds();
	if (null == ids || ids.length == 0) {
		OZ.Msg.info('<oz:messageSource code="oz.portalmgm.layout.msg.selected.isempty"/>');
		return;
	}
	
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.portalmgm.layout.msg.confirm.enabled"/>',
		function(){
			$.getJSON(
				contextPath + "/module/layoutAction.do?action=enable&timeStamp=" + new Date().getTime(),
				{ids:ids},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.portalmgm.layout.msg.enabled.success"/>');
						OZ.View.reloadGrid();
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			);
		}
	);
}
</script>
</html>