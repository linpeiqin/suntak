<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true" easyui="true" />
<head>
<title>申购单</title>
<%@ include file="/oz/includes/meta.jsp"%>
<oz:css />
</head>
<body class="oz-body" data-name="申购单">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/pRHeadAction">
			<oz:tbButton id="btnSave" />
			<oz:tbSeperator/>
	        <oz:tbButton id="btnSubmitEBS" icon="oz-icon oz-icon-0121" onclick="onSubmitEBS(this,'pRHead')" text="同步EBS"/>
	  		<oz:tbSeperator/>
		</oz:toolbar>
		
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="ems/pRHeadAction" styleId="ozForm" styleClass="oz-form">
				<div class="oz-form-fields2">
					<table class="oz-form-bordertable" style="width: 99%;height: 120px">
							<tr class="oz-form-emptyTR">
								<td width="20%"></td>
								<td width="30%"></td>
								<td width="20%"></td>
								<td width="30%"></td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">组织名称</td>
								<td class="oz-property">
								    <bean:write name="pRHeadForm" property="orgName"  />
								</td>
								<td class="oz-form-label-l">单号</td>
								<td class="oz-property">
									<span id="prNoSpan">
									<bean:write name="pRHeadForm" property="prNo"/>
									</span>
								</td>
								
					        </tr>

					        <tr class="oz-form-tr">
								<td class="oz-form-label-l">币种</td>
								<td class="oz-property">
								    <html:select styleId="currencyCode" property="currencyCode" styleClass="oz-form-btField" style="width:100%">
									<html:optionsCollection name="currencySelect" label="name" value="value" />
									</html:select>
								</td>
								<td class="oz-form-label-l">汇率</td>
								<td class="oz-property">
								    <html:text styleClass="oz-form-Field"  property="poRate" styleId="poRate" style="width:99%"/>
								</td>
					        </tr>
					        <tr class="oz-form-tr">
								<td class="oz-form-label-l">申购部门</td>
								<td class="oz-property">
								    <html:select styleId="deptId" property="deptId" styleClass="oz-form-btField" style="width:100%">
									<html:optionsCollection name="departmentSelect" label="name" value="value" />
								</html:select>
								</td>
								<td class="oz-form-label-l">申请人 </td>
								<td class="oz-property">
								    <html:hidden property="applBy" styleId="applBy" />
									 <html:text styleClass="oz-form-btField"  property="applByName" styleId="applByName" style="width:100%" onclick="selectEmployees(this)" />
								</td>
					        </tr>
                           <tr>
								<td class="oz-form-label-l">申购日期 </td>
								<td class="oz-property">
									<bean:write name="pRHeadForm"  property="prDateStr" format="yyyy-MM-dd"/>
								</td>
							   <td class="oz-form-label-l"></td>
							   <td class="oz-property">
							   </td>
							</tr>
					        <tr class="oz-form-tr">
								<td class="oz-form-label-l">用处说明</td>
								<td class="oz-property" colspan="3">
								    <html:textarea styleClass="oz-form-Field"  property="needReason" styleId="appneedReasonlBy" style="width:100%"/>
								</td>
					        </tr> 
					
					   
					   <%--      <tr class="oz-form-tr">
								<td class="oz-form-label-l">备注 </td>
								<td class="oz-property" colspan="3">
								    <html:textarea styleClass="oz-form-Field"  property="remark" styleId="remark" style="width:100%"/>
								</td>
					        </tr> --%>
						</table>
				</div>
				<div class="oz-form-tabs" style="margin-left: 6px;width:99%;height:322px;border: 1px solid #99BBE8" >
					<iframe id="IFRAME_01"  style="margin-right: 6px"  height="99%"width="100%" frameborder="0">
					</iframe>
				</div>
			<html:hidden property="id" styleId="id" />
			<html:hidden property="pRLine1" styleId="pRLine1" />
			<html:hidden property="orgId" styleId="orgId" />
			<html:hidden property="oaType" styleId="oaType" value="2"/>
		</html:form>
	</div>
</body>
<oz:js />
<oz:js jsSrc="/ems/common/js/common.util.js" />
<oz:js jsSrc="/ems/partinfo/js/ems.prhead.FE.js" />
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<script type="text/javascript">
/* $(function(){
	var date = new Date();
    var seperator1 = "-";
    var year = date.getFullYear();
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = year + seperator1 + month + seperator1 + strDate;
	$("#prDateStr").val(currentdate);
}) */
</script>
</html>