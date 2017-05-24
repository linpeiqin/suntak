<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"  tree="true" datePicker="true" tabs="true" attachment="true"/>
<html>
<head>
	<title>
		设备详细信息表
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssHref="/ems/common/css/ems-view.css"/>
</head>
<body class="oz-body" data-name="设备详细信息表">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/equipmentDetailsAction">
			<oz:tbSeperator/>
			<oz:tbSelect id="useDText" text="使用部门: " style="width :80;" options="useDSelect" blankOption="true" />
			<oz:tbSeperator/>
			<oz:tbSelect id="procedureText" text="工序: " style="width :80;" options="procedureSelect" blankOption="true" />
			<oz:tbSeperator/>
			<oz:tbSeperator/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="ems/equipmentDetailsAction" sortName="equipmentNo" fit="true"  excel="true" >
			<oz:column field="id" checkbox="false"  title="" width="27"  />
			<oz:column field="equipmentName" title="设备名称" width="80" sortable="true" />
			<oz:column field="equipmentNo" title="设备编号" width="80" sortable="true" />
			<oz:column field="specificationModel" title="规格型号" width="80" sortable="true" />
			<oz:column field="equipmentType" title="设备类别" width="80" sortable="true"/>
			<oz:column field="manufacturer" title="生产厂商" width="80" sortable="true" />
			<oz:column field="installationLocation" title="安装地点" width="80" sortable="true" />
			<oz:column field="startTime" title="购置时间" width="120" sortable="true" formatter="renderpublisherDate" />
			<oz:column field="acquisitionMode" title="购置方式" width="80" sortable="true"  />
			<oz:column field="useD" title="使用部门" width="80" sortable="true" />
			<oz:column field="remark" title="备注" width="80" sortable="true"/>
		</oz:grid>
	</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<script type="text/javascript">
	var id = '<%= request.getAttribute("id") %>';
	var method = '<%=request.getAttribute("method")%>';
	oz_grid_config.url = "<oz:contextPath/>/ems/equipmentDetailsAction.do?action=pageForEQList&id="+id+"&method="+method;
	function ozDlgOkFn() {
		var rows = OZ.View.getGridSelection();
		if (rows.length == 0) {
			oz.Msg.info("请选择设备！");
			return false;
		}
		return {
			equipmentName: rows[0].equipmentName,
			equipmentNo: rows[0].equipmentNo,
			specificationModel: rows[0].specificationModel,
			useD: rows[0].useD,
			equipmentId: rows[0].id
		};
	}
	function oz_Row_DBLClicked(rowIndex,rowData){
		ozDlgOkFn();
	}

	function initToolbar(){
		var equipName = '<ul class="oz-btn-mouseout" id="equipName"><li class="oz-btn-left"></li><li class="oz-btn-center">设备名称: </li><li class="oz-btn-center"><input id="equipmentNameText" style="width :100px;height:20px"/></li><li class="oz-btn-right"></li></ul><div class="oz-btn-seperator"></div>';
		var useD = '<ul class="oz-btn-mouseout" id="useD"><li class="oz-btn-left"></li><li class="oz-btn-center">使用部门: </li><li class="oz-btn-center"><input id="useDText" style="width :100px;height:20px"/></li><li class="oz-btn-right"></li></ul><div class="oz-btn-seperator"></div>';
		var procedure = '<ul class="oz-btn-mouseout" id="procedure"><li class="oz-btn-left"></li><li class="oz-btn-center">工序: </li><li class="oz-btn-center"><input id="procedureText" style="width :100px;height:20px"/></li><li class="oz-btn-right"></li></ul><div class="oz-btn-seperator"></div>';
		var equipNo = '<ul class="oz-btn-mouseout" id="equipNo"><li class="oz-btn-left"></li><li class="oz-btn-center">设备编号: </li><li class="oz-btn-center"><input id="equipNoText" style="width :100px;height:20px"/></li><li class="oz-btn-right"></li></ul><div class="oz-btn-seperator"></div>';
		var searchButton = '<div class="oz-tb-searchbutton-wrap"><ul><li><input type="text" id="ozQuery" name="ozQuery" class="searchquey" onkeydown="ozTB_Query_KeyDown(event)"></li><li id="ozBtnSearch" class="oz-btn-search" title="查询" onclick="ozTB_BtnSearch_Clicked()"><div class="oz-icon oz-icon-search"></div></li><li id="ozBtnSearchClear" class="oz-btn-search" title="清空" onclick="ozTB_BtnReset_Clicked()"><div class="oz-icon oz-icon-search-clear"></div>'
		var sButton = '<ul class="oz-btn" id="btnDoSearch" onclick="doSearch()"><li class="oz-btn-left"></li><li class="oz-btn-center oz-btn-icon"><div class="oz-icon oz-icon-0732"></div></li><li class="oz-btn-center"><span>查询</span></li><li class="oz-btn-right"></li></ul>';
//		$('.oz-tb').html(equipName+useD+procedure+equipNo+sButton);
//		$('.oz-tb').html(equipName+equipNo+sButton);
		$('#page-top :last(.oz-btn-seperator)').last().after(equipName+equipNo+sButton);
		$('.oz-tb').append(searchButton);
	}
	function  doSearch() {
		var searchQuery = {};
		if(null != $("#equipmentNameText").val() && $("#equipmentNameText").val().length > 0){
			searchQuery._LIS_equipmentName = $("#equipmentNameText").val();
		}else{
			searchQuery._NES_equipmentName= '-1';
		}
		if('-1' != $("#useDTextSEL").val() && $("#useDTextSEL").val().length > 0){
			searchQuery._EQS_ebsEntity_userDId = $("#useDTextSEL").val();
		}
		if('-1' != $("#procedureTextSEL").val() && $("#procedureTextSEL").val().length > 0){
			searchQuery._EQS_ebsEntity_userDId = $("#procedureTextSEL").val();
		}
		if(null != $("#equipNoText").val() && $("#equipNoText").val().length > 0){
			searchQuery._LIS_equipmentNo = $("#equipNoText").val();
		}
		searchQuery.dbftsParams = "";
		OZ.View.reloadGrid(searchQuery);
	}
	$(function(){
		initToolbar();
	});
</script>
</html>