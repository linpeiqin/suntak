<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.portalmgm.homepage"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.portalmgm.homepage"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="module/portalAction">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnNew"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnEnable" text="oz.enable" icon="oz-icon-0901" onclick="onBtnEnable_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnDisable" text="oz.disable" icon="oz-icon-0903" onclick="onBtnDisable_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnLayoutMgm" text="oz.portalmgm.buttons.layoutmgm" icon="oz-icon-0602" onclick="onBtnLayoutMgm_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnPortletMgm" text="oz.portalmgm.buttons.portletmgm" icon="oz-icon-1310" onclick="onBtnPortletMgm_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnDelete"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="module/portalAction" sortName="name" sortOrder="asc" fit="true">
			<oz:column field="id" checkbox="true" title=""/>
			<oz:column field="status" title="oz.portalmgm.fields.status" width="60" formatter="statusFormatter"/>
			<oz:column field="name" title="oz.portalmgm.fields.name" width="360" formatter="oz_DefaultFormatter"/>
			<oz:column field="memos" title="oz.portalmgm.fields.memos" width="240" sortable="false"/>
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

function onBtnLayoutMgm_Clicked(){
	OZ.openWindow({
		id:"viewLayoutMgm",
		title:'<oz:messageSource code="oz.portalmgm.constants.layoutmgm"/>',
		url:contextPath+"/module/layoutAction.do?action=display",
		refresh:false
	});
}

function onBtnPortletMgm_Clicked(){
	OZ.openWindow({
		id:"viewPortletMgm",
		title:'<oz:messageSource code="oz.portalmgm.constants.portletmgm"/>',
		url:contextPath+"/module/portletAction.do?action=display",
		refresh:false
	});
}

function onBtnDisable_Clicked(){
	var ids = OZ.View.getGridSelectionIds();
	if (null == ids || ids.length == 0) {
		OZ.Msg.info('<oz:messageSource code="oz.portalmgm.msg.selected.isempty"/>');
		return;
	}
	
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.portalmgm.msg.confirm.disabled"/>',
		function(){
			$.getJSON(
				contextPath + "/module/portalAction.do?action=disable&timeStamp=" + new Date().getTime(),
				{ids:ids},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.portalmgm.msg.disabled.success"/>');
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
		OZ.Msg.info('<oz:messageSource code="oz.portalmgm.msg.selected.isempty"/>');
		return;
	}
	
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.portalmgm.msg.confirm.enabled"/>',
		function(){
			$.getJSON(
				contextPath + "/module/portalAction.do?action=enable&timeStamp=" + new Date().getTime(),
				{ids:ids},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.portalmgm.msg.enabled.success"/>');
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