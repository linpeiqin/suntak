<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" easyui="true" />
<head>
<title>设备使用记录</title>
<%@ include file="/oz/includes/meta.jsp"%>
<oz:css />
</head>
<body class="oz-body" data-name="设备使用记录">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/orderHeadTempAction">
			<oz:tbButton id="btnSave" />
			<oz:tbSeperator />
			<oz:tbButton id="btnSelectEquipment" icon="oz-icon oz-icon-0323" text="选择设备" onclick="onSelectEquipment(this)"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnSubmitEBS" icon="oz-icon oz-icon-0121" onclick="onSubmitEBS(this,'noTempTable','partLYCK')" text="同步EBS"/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="ems/orderHeadTempAction" styleId="ozForm" styleClass="oz-form">
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
									<logic:equal name="orderHeadTempForm" property="operation" value="0">入库</logic:equal>
									<logic:equal name="orderHeadTempForm" property="operation" value="1">出库</logic:equal>
								</span>
								</td>
								<td class="oz-form-label-l"><span class="equipmentClass">设备编号</span></td>
								<td class="oz-property">
									<span class="equipmentClass" id="equipmentNoSpan"><bean:write name="orderHeadTempForm" property="equipmentDetails.equipmentNo"/></span>
								</td>
								<td class="oz-form-label-l"><span class="equipmentClass">使用部门</span></td>
								<td class="oz-property">
									<span class="equipmentClass" id="useDSpan">
										<bean:write name="orderHeadTempForm" property="equipmentDetails.useD"/>
									</span>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">记录时间</td>
								<td class="oz-property">
									<bean:write name="orderHeadTempForm" property="dateTimeStr" format="yyyy-MM-dd hh:mm:ss"/>
								</td>
								<td class="oz-form-label-l"><span class="equipmentClass">设备名称</span></td>
								<td class="oz-property">
									<span class="equipmentClass" id="equipmentNameSpan"><bean:write name="orderHeadTempForm" property="equipmentDetails.equipmentName"/></span>
								</td>
								<td class="oz-form-label-l"><span class="equipmentClass">规格型号</span></td>
								<td class="oz-property">
									<span class="equipmentClass" id="specificationModelSpan">
										<bean:write name="orderHeadTempForm" property="equipmentDetails.specificationModel"/>
									</span>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">单号</td>
								<td class="oz-property">
									<span id="orderNoSpan">
										<bean:write name="orderHeadTempForm" property="orderNo"/>
									</span>
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
									<html:text styleClass="oz-form-field"  property="useP.name" styleId="usePName" onclick="OZ.Organize.selectUserInfoWithOUInfoID(-1, doDistribution);" style="width:100%"/>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l"><span class="inClass">入库类型</span><span class="outClass">出库类型</span></td>
								<td class="oz-property">
									<bean:write name="orderHeadTempForm" property="operationType"/>
								</td>
								<td class="oz-form-label-l">备注</td>
								<td  class="oz-property" colspan="3">
									<html:text styleClass="oz-form-field"  property="remark" styleId="remark" style="width:100%"/>
								</td>
							</tr>
						</table>
				</div>
				<div  class="oz-form-tabs"  style="margin-left: 6px;width:99%;height: 420px;border: 1px solid #99BBE8" >
					<table id="partsGrid"></table>
				</div>
			<html:hidden property="id" styleId="id" />
			<html:hidden  property="equipmentDetails.id" styleId="equipmentId"/>
			<html:hidden  property="operation" styleId="operation"/>
			<html:hidden  property="orderLineTemps1" styleId="orderLineTemps1"/>
			<html:hidden  property="organizationId" styleId="organizationId"/>
			<html:hidden  property="useP.id" styleId="usePId"/>
			<html:hidden property="oaType" styleId="oaType" value="2"/>
		</html:form>
	</div>
</body>
<oz:organizeJs/>
<oz:js />
<oz:js jsSrc="/ems/common/js/common.util.js" />
<oz:js jsSrc="/ems/partinfo/js/ems.orderheadtemp.FE.js" />
<script type="text/javascript">

</script>
</html>