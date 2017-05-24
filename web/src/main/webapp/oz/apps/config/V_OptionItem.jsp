<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view" tree="true"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.config.optionitem"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.config.optionitem"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="config/optionItemAction" searchButton="none">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnNew"></oz:tbButton>
			<oz:tbButton id="btnCopyToLocal" text="oz.config.optiongroup.button.copy.2.local" icon="oz-icon-1432" onclick="onBtnCopyToLocal_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnDelete"></oz:tbButton>
            <oz:tbSeperator></oz:tbSeperator>
            <oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<c:if test="${editFlag}">
			<oz:grid action="config/optionItemAction" sortName="orderNo" sortOrder="asc" fit="true" pagination="false">
				<oz:column field="id" checkbox="true" title=""/>
				<oz:column field="name" title="oz.config.optionitem.fields.name" sortable="true" width="150" formatter="render4OptionItem"/>
				<oz:column field="value" title="oz.config.optionitem.fields.value" sortable="true" width="150" formatter="render4OptionItem"/>
				<oz:column field="orderNo" title="oz.config.optionitem.fields.orderno" sortable="true" width="150" formatter="render4OptionItem"/>
				<oz:column field="defaultFlag" title="oz.config.optionitem.fields.defaultflag" width="120"/>
			</oz:grid>
		</c:if>
		<c:if test="${!editFlag}">
			<oz:grid action="config/optionItemAction" sortName="orderNo" sortOrder="asc" fit="true" pagination="false" rownumbers="true">
				<oz:column field="id" checkbox="false" title="" align="center"/>
				<oz:column field="name" title="oz.config.optionitem.fields.name" sortable="true" width="150" formatter="render4OptionItem"/>
				<oz:column field="value" title="oz.config.optionitem.fields.value" sortable="true" width="150" formatter="render4OptionItem"/>
				<oz:column field="orderNo" title="oz.config.optionitem.fields.orderno" sortable="true" width="150" formatter="render4OptionItem"/>
				<oz:column field="defaultFlag" title="oz.config.optionitem.fields.defaultflag" width="120"/>
			</oz:grid>
		</c:if>
	</div>
</body>
<script type="text/javascript">
var _groupName = "${groupName}";
var _groupCode = "${groupCode}";
var _unitId = "${unitId}";
var _editFlag = ${editFlag};
oz_grid_config.url = "<oz:contextPath/>/config/optionItemAction.do?action=page&groupCode=" + _groupCode + "&unitId=" + _unitId;
</script>
<oz:js/>
<script type="text/javascript">
function render4OptionItem(value, json){
	return '<a href="javascript:openOptionItem(' + json.id + ')">' + value + '</a>';
}

function onBtnSearch_Clicked(searchCondition){
	OZ.View.reloadGrid({group:_groupCode, dbftsParams:$("#ozQuery").val()});
}

function onBtnReset_Clicked(){
	OZ.View.reloadGrid({group:_groupCode, dbftsParams:""});
}

function onRow_DBLClicked(rowIndex, json){
	openOptionItem(json.id);
}

function onBtnNew_Clicked(){
	// 判断是否可以进行编辑
	if(!_editFlag){
		OZ.Msg.info(_groupName + ' <oz:messageSource code="oz.config.optiongroup.can.not.editable"/>');
		return;
	}
	var strUrl = contextPath + "/config/optionItemAction.do?action=create&groupCode=" + _groupCode + "&unitId=" + _unitId;
	openOptionItemDlg(strUrl, '<oz:messageSource code="oz.new"/><oz:messageSource code="oz.config.optionitem"/>');
}

function openOptionItem(id){
	var strUrl = contextPath + "/config/optionItemAction.do?action=open&id=" + id;
	if(!_editFlag){
		openOptionItemViewDlg(strUrl, '<oz:messageSource code="oz.view"/><oz:messageSource code="oz.config.optionitem"/>');
	}else{
		openOptionItemDlg(strUrl, '<oz:messageSource code="oz.view"/><oz:messageSource code="oz.config.optionitem"/>');
	}
}

function openOptionItemDlg(strUrl, title){
	strUrl += "&timeStamp=" + new Date().getTime();	
	new OZ.Dlg.create({ 
		id:"Dlg_OptionItem", 
		width:480, height:320,
		title:title,
		url: strUrl,
		onOk:function(result){
			OZ.View.reloadGrid();
		},
		onCancel:function(result){
			// do nothing...
		}
	});
}

function openOptionItemViewDlg(strUrl, title){
	strUrl += "&timeStamp=" + new Date().getTime();	
	new OZ.Dlg.create({ 
		id:"Dlg_OptionItem", 
		width:480, height:320,
		title:title,
		url: strUrl,
		buttons:[{text:'关闭', handler:$.noop}]
	});
}

function onBtnCopyToLocal_Clicked(){
	var ids = oz_GetGridSelectionIds();
	var msg = "";
	if(null == ids || ids.length == 0){
		msg = "您确定要将本类型下所有系统默认数据拷贝到本单位中吗？"
	}else{
		msg = "您确定要将选中的配置数据拷贝到本单位中吗？"
	}
	OZ.Msg.confirm(
		msg,
		function(){
			var strUrl = contextPath + "/config/optionItemAction.do?action=copy2Local&timeStamp=" + new Date().getTime();
			$.post(
				strUrl, 
				{groupCode:_groupCode, ids:ids},
				function(json){
					if(json.result == true){
						OZ.Msg.info("已成功将配置数据拷贝到本单位中,刷新后可查看到相应的配置数据.");
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			, "json");
		}
	);
}

function onBtnDelete_Clicked(btn, action){
	// 判断是否可以进行编辑
	if(!_editFlag){
		OZ.Msg.info(_groupName + ' <oz:messageSource code="oz.config.optiongroup.can.not.editable"/>');
		return;
	}
	ozTB_DefaultBtnDelete_Clicked(contextPath + "/config/optionItemAction.do");
}
</script>
</html>