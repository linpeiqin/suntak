<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view" datePicker="true"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.cmpn.sms.sendrecord"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.cmpn.sms.sendrecord"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="sms/smsSendRecordAction" searchButton="advance">
			<oz:tbSeperator/>
			<oz:tbButton id="btnBack"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnRefresh"/>
		</oz:toolbar>
		<div id="page-top-extendContainer" class="oz-page-top-extendContainer" style="height:60px;">
			<html:form action="sms/smsSendRecordAction.do" styleId="thisForm" method="post">
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
									<td class="oz-form-label"><oz:messageSource code="oz.cmpn.sms.sendrecord.fields.authorname"/>：</td>
									<td class="oz-property">
										<input type="text" id="_LIS_authorName" name="_LIS_authorName"/>
									</td>
									<td class="oz-form-label"><oz:messageSource code="oz.cmpn.sms.sendrecord.fields.createddate"/>：</td>
									<td class="oz-property">
										<input type="text" id="_GED_createdDate" name="_GED_createdDate" class="oz-dateTimeField" style="width:112px"/>
										~
										<input type="text" id="_LED_createdDate" name="_LED_createdDate" class="oz-dateTimeField" style="width:110px"/>
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
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="sms/smsSendRecordAction" sortName="createdDate" sortOrder="desc" fit="true">
			<oz:column field="id" checkbox="true" title=""/>
			<oz:column field="author_name" title="oz.cmpn.sms.sendrecord.fields.authorname" sortable="true" width="100"  formatter="oz_DefaultFormatter"/>
			<oz:column field="createdDate" title="oz.cmpn.sms.sendrecord.fields.createddate" sortable="true" width="120" />
			<oz:column field="mobiles" title="oz.cmpn.sms.sendrecord.fields.mobiles" sortable="false" width="320"  formatter="oz_DefaultFormatter"/>
			<oz:column field="content" title="oz.cmpn.sms.sendrecord.fields.content" sortable="true" width="320"/>
			<oz:column field="sendResult" title="oz.cmpn.sms.sendrecord.fields.sendresult" sortable="true" width="80"/>
		</oz:grid>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function oz_GetTitle(json){
	return json.mobiles;
}
function onBtnAdvanceSearchGo_Clicked(){
	var searchQuery = {};
	if(null != $("#_LIS_authorName").val() && $("#_LIS_authorName").val().length > 0){
		searchQuery._LIS_author$name = $("#_LIS_authorName").val();
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