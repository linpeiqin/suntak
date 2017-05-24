<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view" datePicker="true"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.component.auditlog"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.component.auditlog"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="component/auditLogAction" searchButton="advance">
			<oz:tbSeperator/>
			<oz:tbButton id="btnBack"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnRefresh"/>
		</oz:toolbar>
	</div>
	<div id="page-top-extendContainer" class="oz-page-top-extendContainer" style="padding: 5px;">
		<html:form action="component/auditLogAction.do" styleId="thisForm" method="post">
         	<table border="0" cellpadding="1" cellspacing="2" >
            	<tr> 
					<td>
  						<table width="640px" border="0" cellpadding="2" cellspacing="2">
							<tr class="oz-form-emptyTR">
								<td width="80"></td>
								<td width="240"></td>
								<td width="80"></td>
								<td width="240"></td>
							</tr>
							<tr>
								<td class="oz-form-label"><oz:messageSource code="oz.component.auditlog.fields.parent"/>：</td>
								<td class="oz-property">
									<input type="text" id="_LIS_parentId" name="_LIS_parentId"/>
								</td>
								<td class="oz-form-label"><oz:messageSource code="oz.component.auditlog.fields.eventtype"/>：</td>
								<td class="oz-property">
									<select id="_LIS_eventType" name="_LIS_eventType">
										<option value=""><oz:messageSource code="oz.component.auditlog.eventtypes.all"/>
										<option value="CREATE"><oz:messageSource code="oz.component.auditlog.eventtypes.create"/>
										<option value="UPDATE"><oz:messageSource code="oz.component.auditlog.eventtypes.update"/>
										<option value="DELETE"><oz:messageSource code="oz.component.auditlog.eventtypes.delete"/>
									</select>
								</td>
							</tr>
							<tr>
								<td class="oz-form-label"><oz:messageSource code="oz.component.auditlog.fields.user"/>：</td>
								<td class="oz-property">
									<input type="text" id="_LIS_userName" name="_LIS_userName"/>
								</td>
								<td class="oz-form-label"><oz:messageSource code="oz.component.auditlog.fields.timestamp"/>：</td>
								<td class="oz-property">
									<input type="text" id="_GED_timestamp" name="_GED_timestamp" class="oz-dateTimeField" style="width:105px"/>
									~
									<input type="text" id="_LED_timestamp" name="_LED_timestamp" class="oz-dateTimeField" style="width:110px"/>
								</td>
							</tr>
							<tr>
								<td colspan="4" align="right" style="padding-top:4px">
									<oz:button buttonId="btnAdvanceSearchGo" text="oz.search" onclick="onBtnAdvanceSearchGo_Clicked()" width="62"></oz:button>
									&nbsp;
									<oz:button buttonId="btnAdvanceClear" text="oz.clear" onclick="onBtnAdvanceClear_Clicked()" width="62"></oz:button>
								</td>
							</tr>
						</table>												
					</td>
				</tr>
			</table>
		</html:form>		
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="component/auditLogAction" sortName="timestamp" sortOrder="desc" fit="true">
			<oz:column field="id" checkbox="true" title=""/>
			<oz:column field="parentId" title="oz.component.auditlog.fields.parent" sortable="true" width="240" formatter="auditLogRender"/>
			<oz:column field="eventType" title="oz.component.auditlog.fields.eventtype" sortable="true" width="80" formatter="auditLogRender" />
			<oz:column field="property" title="oz.component.auditlog.fields.property" sortable="true" width="120" formatter="auditLogRender" />
			<oz:column field="oldValue" title="oz.component.auditlog.fields.oldvalue" width="160" formatter="auditLogRender"/>
			<oz:column field="newValue" title="oz.component.auditlog.fields.newvalue" width="160" formatter="auditLogRender"/>
			<oz:column field="timestamp" title="oz.component.auditlog.fields.timestamp" width="128" formatter="auditLogRender"/>
			<oz:column field="userName" title="oz.component.auditlog.fields.user" sortable="true" width="120" formatter="auditLogRender"/>
			<oz:column field="clientIp" title="oz.component.auditlog.fields.clientip" width="130" formatter="auditLogRender"/>
		</oz:grid>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function auditLogRender(value, json){
	return '<div title="' + value + '">' + value + '</div>';
}

function oz_GetTitle(json){
	return json.source;
}

function onRow_DBLClicked(rowIndex, rowData, data){

}

function onBtnAdvanceSearchGo_Clicked(){
	var searchQuery = {};
	if(null != $("#_LIS_parentId").val() && $("#_LIS_parentId").val().length > 0){
		searchQuery._LIS_parentId = $("#_LIS_parentId").val();
	}
	if(null != $("#_LIS_eventType").val() && $("#_LIS_eventType").val().length > 0){
		searchQuery._LIS_eventType = $("#_LIS_eventType").val();
	}
	if(null != $("#_LIS_userName").val() && $("#_LIS_userName").val().length > 0){
		searchQuery._LIS_userName = $("#_LIS_userName").val();
	}
	if(null != $("#_GED_timestamp").val() && $("#_GED_timestamp").val().length > 0){
		searchQuery._GED_timestamp = $("#_GED_timestamp").val();
	}
	if(null != $("#_LED_timestamp").val() && $("#_LED_timestamp").val().length > 0){
		searchQuery._LED_timestamp = $("#_LED_timestamp").val();
	}
	searchQuery.dbftsParams = "";
	OZ.View.reloadGrid(searchQuery);
}

function onBtnAdvanceClear_Clicked(){
	thisForm.reset();
	ozTB_BtnReset_Clicked();
}

$(function(){
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
</script>
</html>