<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
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
  						<table width="640px" border="0" cellpadding="0" cellspacing="0">
							<tr class="oz-form-emptyTR">
								<td width="80"></td>
								<td width="240"></td>
								<td width="80"></td>
								<td width="240"></td>
							</tr>
							<tr>
								<td class="oz-form-label"><oz:messageSource code="oz.core.auditlog.fields.property"/>：</td>
								<td class="oz-property">
									<input type="text" id="_LIS_property" name="_LIS_property"/>
								</td>
								<td class="oz-form-label"><oz:messageSource code="oz.core.auditlog.fields.eventType"/>：</td>
								<td class="oz-property">
									<input type="text" id="_LIS_eventType" name="_LIS_action"/>
								</td>
							</tr>
							<tr>
								<td class="oz-form-label"><oz:messageSource code="oz.core.auditlog.fields.userName"/>：</td>
								<td class="oz-property">
									<input type="text" id="_LIS_userName" name="_LIS_userName"/>
								</td>
								<td class="oz-form-label"><oz:messageSource code="oz.core.auditlog.fields.timestamp"/>：</td>
								<td class="oz-property">
									<input type="text" id="_GED_timestamp" name="_GED_timestamp" class="oz-dateTimeField" style="width:112px"/>
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
			<oz:column field="userName" title="oz.core.auditlog.fields.userName" sortable="true" width="100" />
			<oz:column field="timestamp" title="oz.core.auditlog.fields.timestamp" sortable="true" width="120" />
			<oz:column field="eventType" title="oz.core.auditlog.fields.eventType" sortable="false" width="100" />
			<oz:column field="property" title="oz.core.auditlog.fields.property" sortable="true" width="100"/>
			<oz:column field="oldValue" title="oz.core.auditlog.fields.oldValue" sortable="true" width="350"/>
			<oz:column field="newValue" title="oz.core.auditlog.fields.newValue" sortable="true" width="350"/>
			<oz:column field="clientIp" title="IP" sortable="true" width="100"/>
		</oz:grid>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function oz_GetTitle(json){
	return json.source;
}

function onRow_DBLClicked(rowIndex, rowData, data){

}

function onBtnAdvanceSearchGo_Clicked(){
	var searchQuery = {};
	if(null != $("#_LIS_authorName").val() && $("#_LIS_authorName").val().length > 0){
		searchQuery._LIS_author$name = $("#_LIS_authorName").val();
	}
	if(null != $("#_LIS_source").val() && $("#_LIS_source").val().length > 0){
		searchQuery._LIS_source = $("#_LIS_source").val();
	}
	if(null != $("#_LIS_action").val() && $("#_LIS_action").val().length > 0){
		searchQuery._LIS_action = $("#_LIS_action").val();
	}
	if(null != $("#_GED_createdDate").val() && $("#_GED_createdDate").val().length > 0){
		searchQuery._GED_createdDate = $("#_GED_createdDate").val();
	}
	if(null != $("#_LED_createdDate").val() && $("#_LED_createdDate").val().length > 0){
		searchQuery._LED_createdDate = $("#_LED_createdDate").val();
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