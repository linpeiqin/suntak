<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true" />
<head>
<title>设备详细信息表</title>
<%@ include file="/oz/includes/meta.jsp"%>
<oz:css />
<oz:css cssHref="/ems/common/css/ems-util.css" />
</head>
<body class="oz-body" data-name="设备详细信息表">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/equipmentDetailsAction">
			<oz:tbSeperator />
			<oz:tbButton id="btnSave" />
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="ems/equipmentDetailsAction" styleId="ozForm"
			styleClass="oz-form">
			<div class="ems-form-main">
				<div class="ems-form-content">
					<div class="oz-form-fields2">
						<table class="oz-form-bordertable" style="width: 99%">
							<tr class="oz-form-emptyTR">
								<td width="20%"></td>
								<td width="30%"></td>
								<td width="20%"></td>
								<td width="30%"></td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">设备名称</td>
								<td class="oz-property">
									<html:text property="equipmentName" styleId="equipmentName" styleClass="oz-form-btField" />
								</td>
								<td class="oz-form-label-l">机身编号</td>
								<td class="oz-property">
									<html:text property="serialNo" styleId="serialNo" styleClass="oz-form-field" />
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">规格型号</td>
								<td class="oz-property">
									<html:text property="specificationModel" styleId="specificationModel" styleClass="oz-form-btField" />
								</td>
								<td class="oz-form-label-l">设备类别</td>
								<td class="oz-property">
									<html:select property="equipmentType" styleId="equipmentType">
										<html:optionsCollection name="fixedAssetsTypeSelect" label="name" value="value" />
									</html:select>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">生产厂商</td>
								<td class="oz-property">
									<html:text property="manufacturer" styleId="manufacturerrer" styleClass="oz-form-btField"/>
									<%--<html:text styleClass="oz-form-field oz-form-btField" property="manufacturer" styleId="manufacturer"  style="width:100%" onclick="selectAgent(this,afterAgentChange)" ></html:text>--%>
								</td>
								<td class="oz-form-label-l">供应商</td>
								<td class="oz-property">
									<%--<html:text property="suppliers" styleId="suppliers" styleClass="oz-form-btField"/>--%>
									<html:text styleClass="oz-form-field oz-form-btField" property="suppliers" readonly="TRUE" styleId="suppliers"  style="width:100%" onclick="selectAgent(this,afterAgentChange)" ></html:text>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td  class="oz-form-label-l">购置时间</td>
								<td class="oz-property">
									<html:text property="startTime" styleId="startTime" styleClass="oz-dateField"/>
								</td>
								<td class="oz-form-label-l"><%--购置方式--%></td>
								<td class="oz-property">
									<%--<html:text property="acquisitionMode" styleId="acquisitionMode" styleClass="oz-form-btField"/>--%>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td  class="oz-form-label-l">单价</td>
								<td class="oz-property">
										<html:text property="originalValue" styleId="originalValue" styleClass="oz-form-btField formatToMoney"/>
								</td>
								<td colspan="2">
									<table>
									<tr>
										<td class="oz-form-label-l" width="25%">币别</td>
										<td class="oz-property" width="25%">
											<html:select property="currency" styleId="currency" styleClass="oz-form-btField">
												<html:optionsCollection name="currencyOptions" value="value" label="name"/>
											</html:select>
										</td>
										<td class="oz-form-label-l" width="25%">税率</td>
										<td class="oz-property" width="25%">
											<html:text property="tax"  styleId="tax" readonly="true" styleClass="oz-form-zdField formatToMoney"/>
										</td>
									</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td class="oz-form-label-l">设备别名</td>
								<td class="oz-property">
									<html:text property="equipmentAlias" styleId="equipmentAlias" styleClass="oz-form-field"/>
								</td>
								<td class="oz-form-label-l">工序</td>
								<td class="oz-property">
									<html:text property="procedure" styleId="procedure" styleClass="oz-form-field"/>
								</td>
							</tr>


							<tr>
								<td class="oz-form-label-l">备注</td>
								<td class="oz-property" colspan="3"><html:textarea styleClass="oz-form-field"
										property="remark" styleId="remark" style="width:100%;" ></html:textarea>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<html:hidden property="id" styleId="id" />
			<html:hidden property="suppliersId" styleId="suppliersId" />
			<html:hidden property="type" styleId="type" value="0" />
			<html:hidden property="organizationId" styleId="organizationId" />
			<html:hidden property="scrapState" styleId="scrapState" value="0"/>
		</html:form>
	</div>
</body>
<oz:organizeJs></oz:organizeJs>
<oz:js />
<oz:js jsSrc="/ems/common/js/common.util.js" />
<oz:js jsSrc="/ems/equipmentdetails/js/ems.equipmentdetails.FE.js" />
<script type="text/javascript">
   $(function() {
		var allBox = $(":checkbox");
		allBox.click(function() {
			allBox.removeAttr("checked");
			$(this).attr("checked", "checked");
		});
		$(":button").click(function() {
			alert($(":checkbox:checked").val());
		});
	   $('#currency').change(function () {
		   if($(this).val()=='CNY'){
				$('#tax').attr('readonly',true).removeClass('oz-form-btField').addClass('oz-form-zdField').val('');
		   }else{
			   $('#tax').attr('readonly',false).removeClass('oz-form-zdField');
		   }
	   })
	});

   function onSelectOUInfo(result){
	   return true;
   }
	function afterAgentChange(obj,result,obj1) {
		$('#suppliersId').val(result.vendorId);
		$(obj).val(result.vendorName);
	}
</script>
</html>