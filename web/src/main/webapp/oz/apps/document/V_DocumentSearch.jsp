<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="cn.oz.web.util.RequestUtils"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view" tree="true" datePicker="true"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.mdu.document.documentsearch"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.document.documentsearch"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="document/documentSearchAction" searchButton="none">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<div id="page-center-tree" class="oz-page-center-tree">
			<ul id="ozTree"></ul>
		</div>
		<div id="page-center-seperator" class="oz-page-center-seperator"></div>
		<div id="page-center-grid-top" class="oz-page-center-grid-top" style="height:auto;display: none;padding: 3px 0;">
			<html:form action="/document/documentSearchAction.do" styleId="thisForm" method="post">

			</html:form>
		</div>
		<div id="page-center-grid" class="oz-page-center-grid" style="position: relative;">
			<div id="searchGrid" ></div>
			<div id="infoTip" style="position: absolute;top: 0px;left:0px;width: 100%;height: 100%;text-align: center;vertical-align: middle;color: #AAAAAA;font-size: x-large;line-height: 90px;">&lt;&lt;&lt; 请先选择左边的文种类型</div>
		</div>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
var _defId = "";
var scope ="<%=RequestUtils.getIntParameter(request, "scope", 0) %>" 

function createQueryHtml(fields){
	var html = new Array();
	html.push('<table width="640px"  border="0" id="searchFormTable" class="oz-form-search">');
	html.push('    <tr class="oz-form-emptyTR">');
	html.push('        <td width="80"></td>');
	html.push('        <td width="240"></td>');
	html.push('        <td width="80"></td>');
	html.push('        <td width="240"></td>');
	html.push('    </tr>');
	
	for(var i = 0; i < fields.length; i++){
		html.push('    <tr>');
		html.push('        <td class="oz-form-label">' + fields[i].name + '：</td>');
		html.push('        <td class="oz-property">');
		html.push(getQueryFieldHtml(fields[i]));
		html.push('        </td>');
		i = i + 1;
		if(i >= fields.length){
			html.push('        <td class="oz-form-label"></td>');
			html.push('        <td class="oz-property">');
			html.push('        </td>');		
		}else{
			html.push('        <td class="oz-form-label">' + fields[i].name + '：</td>');
			html.push('        <td class="oz-property">');
			html.push(getQueryFieldHtml(fields[i]));
			html.push('        </td>');	
		}
		html.push('    </tr>');	
	}
	html.push('    <tr>');
	html.push('        <td colspan="4" align="right" style="padding-top:4px">');
	html.push('            <input id="btnAdvanceSearch" type="button" class="oz-form-button" value="搜索" onClick="onBtnAdvanceSearch_Clicked()" style="width:62px"/>');
	html.push('            &nbsp;');
	html.push('            <input id="btnAdvanceClear" type="button" class="oz-form-button" value="清空" onClick="onBtnAdvanceClear_Clicked()" style="width:62px"/>');
	html.push('        </td>');	
	html.push('    </tr>');
	html.push('</table>');
	
	$("#thisForm").html(html.join(""));
}

function getQueryFieldHtml(field){
	var html = "            ";
	if(field.type == "date"){
		html += '<input type="text" id="_GED_' + field.fieldId + '" name="_GED_' + field.fieldId + '" class="oz-form-field oz-dateField" style="width:111px"/>'
		html += ' ~ <input type="text" id="_LED_' + field.fieldId + '" name="_LED_' + field.fieldId + '" class="oz-form-field oz-dateField" style="width:111px"/>'
	}else if(field.type == "dateTime"){
		html += '<input type="text" id="_GED_' + field.fieldId + '" name="_GED_' + field.fieldId + '" class="oz-form-field oz-dateTimeField" style="width:111px"/>'
		html += ' ~ <input type="text" id="_LED_' + field.fieldId + '" name="_LED_' + field.fieldId + '" class="oz-form-field oz-dateTimeField" style="width:111px"/>'
	} else if (field.type == "int") {
		html += '<input type="text" id="_EQI_' + field.fieldId + '" name="_EQI_' + field.fieldId + '"/>'
	} else if (field.type == "long") {
		html += '<input type="text" id="_EQL_' + field.fieldId + '" name="_EQL_' + field.fieldId + '"/>'
	} else if (field.type == "double") {
		html += '<input type="text" id="_EQN_' + field.fieldId + '" name="_EQN_' + field.fieldId + '"/>'	
	}else{
		html += '<input type="text" id="_LIS_' + field.fieldId + '" name="_LIS_' + field.fieldId + '"/>'
	}
	return html;
}

var baseConfig =  {
	    "pagination": true,
	    "frozenColumns": [],
	    "rownumbers": false,
	    "nowrap": false,
	   "sortOrder": "desc",
	    "id": "searchGrid",
	    "fit": true,
	    "url": contextPath + "/document/documentSearchAction.do?action=search&scope="+scope,
	    "path": contextPath + "/document/documentSearchAction.do",
	    "border": false,
	    "excel":true
};

function onBtnAdvanceSearch_Clicked(){
	var store = $('#'+oz_grid_config.id).data("widget-grid").store;	
	store.params = $("#thisForm").serializeArray();
	store.load();
}

function onBtnAdvanceClear_Clicked(){
	thisForm.reset();
	ozTB_BtnReset_Clicked();
}

function oz_DefaultFormatterEx(value, rowData, rowIndex, data){
	data = data || "";
	return "<a href='javascript:oz_OpenGridRow(\""+rowIndex+"\",\"" + data + "\")'>" + value + "</a>";
}

function oz_Default_Open_Row(rowIndex,rowData){
	OZ.openWindow({
		id: oz_grid_config.id+rowData.id,
		title: rowData.subject,
		url: OZ.addParamToUrl(contextPath+"/document/documentSearchAction.do","action=open&id="+_defId+"&fiId=" + rowData.formInstanceId),
		refresh: true,
		beforeCloseFnName:"oz_Win_BeforeClose"
	});
}

function treeNodeClick(e, data){
	if(!data.leaf){
		_defId="";
		return;
	}
	if(data.id == _defId){
		return;
	}
	_defId = data.id;
	//OZ.View.reloadGrid({group:_groupCode, dbftsParams:""});
	$.getJSON(contextPath + '/document/documentSearchAction.do?action=query&timeStamp=' + new Date().getTime(),{id:_defId},function(result){
		$("#searchGrid").remove();
		$("#searchFormTable tr").not(":first").remove();
		$("#page-center-grid-top").hide();
		if(result.queryFields.length==0 || result.resultColumns.length==0){
			$("#infoTip").text("该文种未配置查询信息。").show();
			return;
		}else{
			$("#infoTip").hide();
		}
		$("#page-center-grid").append('<div id="searchGrid" ></div>');
		window.oz_grid_config =$.extend({},baseConfig);
		window.oz_grid_config.url=contextPath +"/document/documentSearchAction.do?action=search&scope="+scope+"&id="+_defId;
		window.oz_grid_config.path=contextPath +"/document/documentSearchAction.do?scope="+scope+"&id="+_defId;
		createQueryHtml(result.queryFields)
		
		var cols =  [{
	        "checkbox": true,
	        "text": "",
	        "dataIndex": "id",
	        "sortable": false
	    }];
		$.each(result.resultColumns,function(item){
			var col = {
			        "width": this.width,
			        "text": this.name,
			        "dataIndex": this.field,
			        "sortable": true,
			        "renderer":oz_DefaultFormatter
			    };
			cols.push(col);
		});
		window.oz_grid_config.columns=cols;
		oz_DefaultGrid_Init();
		$("#page-center-grid-top").show();
		oz_DefaultPage_Resize();
		
		//绑定日期时间域
	    if($.datepicker){
	        $(".oz-dateField[readonly!='readonly']").datepicker({
	            showAnim:'',
	            showButtonPanel: false,
	            changeMonth: true,
	            changeYear: true,
	            showTime: false
	        });
	        $(".oz-dateTimeField[readonly!='readonly']").datepicker({
	            showAnim:'',
	            showButtonPanel: true,
	            changeMonth: true,
	            changeYear: true,
	            showTime: true
	        });
	    }
		
	});
}

$(function(){
	$('#ozTree').tree({
		url: contextPath + '/document/documentSearchAction.do?action=getDefinitionTree&timeStamp=' + new Date().getTime(),
		click:treeNodeClick
	});
});
</script>
</html>