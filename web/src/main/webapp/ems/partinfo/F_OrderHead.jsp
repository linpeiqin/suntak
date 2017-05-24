<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"  easyui="true" />
<head>
	<title>设备使用记录</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css />
</head>
<body class="oz-body" data-name="设备使用记录">
<div id="page-center" class="oz-page-form">
	<html:form action="ems/orderHeadAction" styleId="ozForm" styleClass="oz-form">
		<div class="oz-form-fields2">
			<table class="oz-form-bordertable" style="width: 99%;height: 120px">
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
						<span class="equipmentClass" id="equipmentNoSpan">
							<bean:write name="orderHeadForm" property="equipmentDetails.equipmentNo"/>
						</span>
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
						<bean:write name="orderHeadForm" property="dateTimeStr" format="yyyy-MM-dd hh:mm:ss"/>
					</td>
					<td class="oz-form-label-l"><span class="equipmentClass">设备名称</span></td>
					<td class="oz-property">
						<span class="equipmentClass" id="equipmentNameSpan">
							<bean:write name="orderHeadForm" property="equipmentDetails.equipmentName"/>
						</span>
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
						<bean:write name="orderHeadForm" property="orderNo"/>
					</td>
					<td class="oz-form-label-l"><span class="inClass">供应商</span><span class="outClass">使用部门</span></td>
					<td class="oz-property">
						<logic:equal name="orderHeadForm" property="operation" value="0">
							<bean:write name="orderHeadForm" property="supplier"/>
						</logic:equal>
						<logic:equal name="orderHeadForm" property="operation" value="1">
							<bean:write name="orderHeadForm" property="useD"/>
						</logic:equal>
					</td>
					<td class="oz-form-label-l">领用人</td>
					<td class="oz-property">
						<bean:write name="orderHeadForm" property="useP"/>
					</td>
				</tr>
				<tr class="oz-form-tr">
					<td class="oz-form-label-l"><span class="inClass">入库类型</span><span class="outClass">出库类型</span></td>
					<td class="oz-property">
						<bean:write name="orderHeadForm" property="operationType"/>
					</td>
					<td class="oz-form-label-l">备注</td>
					<td  class="oz-property" colspan="3">
						<bean:write name="orderHeadForm" property="remark"/>
					</td>
				</tr>
			</table>
		</div>
		<div class="oz-form-tabs" style="margin-left: 6px;width:99%;height: 435px;border: 1px solid #99BBE8">
			<table id="partsGrid"></table>
		</div>
		<html:hidden property="id" styleId="id" />
		<html:hidden  property="operation" styleId="operation"/>
	</html:form>
</div>
</body>
<oz:js />
<oz:js jsSrc="/ems/common/js/common.util.js" />
<oz:js jsSrc="/ems/partinfo/js/ems.orderhead.F.js" />
<script type="text/javascript">
</script>
</html>