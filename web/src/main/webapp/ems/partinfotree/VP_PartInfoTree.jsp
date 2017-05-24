<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"  tree="true" datePicker="true"/>
<html>
<head>
	<title>
		设备配件
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssHref="/ems/common/css/ems-view.css"/>
</head>
<body class="oz-body" data-name="设备配件">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/repairPlanAction" searchButton="none">
			<oz:tbButton id="btnRefresh"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnAddPart" icon="oz-icon oz-icon-1207" text="加入配件" onclick="onAddEPClick('1')"/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="ems/partInfoTreeAction" sortName="qty" sortOrder="asc" fit="true" >
				<oz:column field="type" title="类型" sortable="true" width="100" formatter="render4Type"/>
				<oz:column field="name" title="名称" sortable="true" width="360" />
				<oz:column field="qty" title="数量" sortable="true" width="100" />
				<oz:column field="section" title="分段" sortable="true" width="60" formatter="oz_DefaultFormatter"/>
				<oz:column field="usePeriod" title="使用周期" sortable="true" width="100" />
				<oz:column field="replaceDateTime" title="上次更换日期" sortable="true" width="100"/>
				<oz:column field="nextReDateTime" title="下次更换日期" sortable="true" width="100"/>
			</oz:grid>
	</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/partinfotree/js/ems.partinfotree.V.js"/>
<script type="text/javascript">
var _equipmentId = '<%= request.getAttribute("equipmentId") %>';
var flag = true;
oz_grid_config.url = "<oz:contextPath/>/ems/partInfoTreeAction.do?action=page&flag="+flag;
oz_grid_config.params = [{equipmentId:_equipmentId}];
function render4Type(value, json){
	if(value == 0)
		return '设备';
	else
		return '配件';
}

function oz_Row_DBLClicked(rowIndex,rowData){
	return false;
}

function onAddEPClick(){
	var rows = window.parent.OZ.View.getGridSelection();
	if(rows[0] == null){
		oz.Msg.info("请选择设备！");
		return false;
	}
	var equipmentId = rows[0].id;
	var url = contextPath + "/ems/partInfoTreeAction.do?action=customCreate";
	url += "&equipmentId=" + equipmentId;
	url += "&timeStamp=" + new Date().getTime();
	var url = url|| OZ.addParamToUrl(action, "action=customCreate");
	new OZ.Dlg.create({
		id:oz_grid_config.id + "_create" + (new Date().getTime()),
		width:400, height:350,
		title:"新建" + ($("body").data("name") || "文档"),
		url: url,
		onOk:function(result){
			if((typeof onAfterSelected) == "function"){
				onAfterSelected.call(this, result);
			}
		},
		onCancel:function(result){
			// do nothing...
		}
	});
}
</script>