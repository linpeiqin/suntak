<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true" easyui="true" />
<head>
<title>设备使用记录</title>
<%@ include file="/oz/includes/meta.jsp"%>
<oz:css />
</head>
<body class="oz-body" data-name="设备使用记录">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/orderHeadAction">
			<oz:tbButton id="btnSave" />
			<oz:tbSeperator />
			<oz:tbButton id="btnSelectEquipment" icon="oz-icon oz-icon-0323" text="选择设备" onclick="onSelectEquipment(this)"/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="ems/orderHeadAction" styleId="ozForm" styleClass="oz-form">
				<div class="oz-form-fields2">
					<table class="oz-form-bordertable" style="width: 99%;">
							<tr class="oz-form-emptyTR">
								<td width="10%"></td>
								<td width="25%"></td>
								<td width="10%"></td>
								<td width="25%"></td>
								<td width="10%"></td>
								<td width="20%"></td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">操作</td>
								<td class="oz-property">
								<span class="oz-form-fields-span">
									<logic:equal name="orderHeadForm" property="operation" value="0">入库</logic:equal>
									<logic:equal name="orderHeadForm" property="operation" value="1">出库</logic:equal>
								</span>
								</td>
								<td class="oz-form-label-l"><span class="equipmentClass">设备编号</span></td>
								<td class="oz-property">
									<span class="equipmentClass" id="equipmentNoSpan"><bean:write name="orderHeadForm" property="equipmentDetails.equipmentNo"/></span>
								</td>
								<td class="oz-form-label-l"><span class="equipmentClass">使用部门</span></td>
								<td class="oz-property">
									<span class="equipmentClass" id="useDSpan">
										<bean:write name="orderHeadForm" property="equipmentDetails.useD"/>
									</span>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">记录时间</td>
								<td class="oz-property">
									<html:text styleClass="oz-dateField"  property="dateTimeStr" styleId="dateTimeStr" style="width:100%"/>
								</td>
								<td class="oz-form-label-l"><span class="equipmentClass">设备名称</span></td>
								<td class="oz-property">
									<span class="equipmentClass" id="equipmentNameSpan"><bean:write name="orderHeadForm" property="equipmentDetails.equipmentName"/></span>
								</td>
								<td class="oz-form-label-l"><span class="equipmentClass">规格型号</span></td>
								<td class="oz-property">
									<span class="equipmentClass" id="specificationModelSpan">
										<bean:write name="orderHeadForm" property="equipmentDetails.specificationModel"/>
									</span>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">单号</td>
								<td class="oz-property">
									<html:text styleClass="oz-form-btField"  property="orderNo" styleId="orderNo" style="width:100%"/>
								</td>
								<td class="oz-form-label-l"><span class="inClass">供应商</span><span class="outClass">使用部门</span></td>
								<td class="oz-property">
									<html:select styleId="useD" property="useD" styleClass="oz-form-btField outClass" style="width:100%">
										<html:optionsCollection name="departmentSelect" label="name" value="value" />
									</html:select>
									<html:text styleClass="oz-form-btField inClass"  property="supplier" styleId="supplier" style="width:100%" onclick="selectAgent(this)"/>
								</td>
								<td class="oz-form-label-l">领用人</td>
								<td class="oz-property">
									<html:text styleClass="oz-form-field"  property="useP" styleId="useP" style="width:100%"/>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l"><span class="inClass">入库类型</span><span class="outClass">出库类型</span></td>
								<td class="oz-property">
									<html:select styleId="operationType" property="operationType" styleClass="oz-form-btField" style="width:100%">
										<html:optionsCollection name="operationSelect" label="name" value="value" />
									</html:select>
								</td>
								<td class="oz-form-label-l">备注</td>
								<td  class="oz-property" colspan="3">
									<html:text styleClass="oz-form-field"  property="remark" styleId="remark" style="width:100%"/>
								</td>
							</tr>
						</table>
				</div>
				<div class="oz-form-tabs"  style="margin-left: 6px;width:99%;height: 99%;border: 1px solid #99BBE8" >
					<table id="partsGrid"></table>
				</div>
			<html:hidden property="id" styleId="id" />
			<html:hidden  property="equipmentId" styleId="equipmentId"  value="-1"/>
			<html:hidden  property="operation" styleId="operation"/>
			<html:hidden  property="orderLines1" styleId="orderLines1"/>

		</html:form>
	</div>
</body>
<oz:js />
<oz:js jsSrc="/ems/common/js/common.util.js" />
<oz:js jsSrc="/ems/partinfo/js/ems.orderhead.FE.js" />
<script type="text/javascript">
</script>
</html>