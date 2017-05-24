<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true" />
<head>
<title>配件详细信息表</title>
<%@ include file="/oz/includes/meta.jsp"%>
<oz:css />
<oz:css cssHref="/ems/common/css/ems-util.css" />
</head>
<body class="oz-body" data-name="配件详细信息表">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/partInfoAction">
			<oz:tbSeperator />
			<oz:tbButton id="btnSave" />
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="ems/partInfoAction" styleId="ozForm" styleClass="oz-form">
			<div class="ems-form-main">
				<div class="ems-form-content">
					<div class="oz-form-fields2">
						<table class="oz-form-bordertable" style="width: 99%;height: 120px">
							<tr class="oz-form-emptyTR">
								<td width="20%"></td>
								<td width="30%"></td>
								<td width="20%"></td>
								<td width="30%"></td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">配件类型</td>
								<td class="oz-property"><html:text styleClass="oz-form-btField"
										property="partType" styleId="partType"
										style="width:100%"></html:text>
								</td>
								<td class="oz-form-label-l">关联设备型号</td>
								<td class="oz-property"><html:text styleClass="oz-form-btField"
										property="relation" styleId="relation"
										style="width:100%"></html:text>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">配件名称</td>
								<td class="oz-property"><html:text styleClass="oz-form-btField"
										property="partName" styleId="partName"
										style="width:100%"></html:text>
								</td>
								<td class="oz-form-label-l">配件编号</td>
								<td class="oz-property"><html:text styleClass="oz-form-btField"
										property="partNo" styleId="partNo"
										style="width:100%"></html:text>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">规格型号</td>
								<td class="oz-property"><html:text styleClass="oz-form-field"
										property="type" styleId="type"
										style="width:100%" ></html:text>
								</td>
								<td class="oz-form-label-l">计量单位</td>
								<td class="oz-property"><html:text styleClass="oz-form-field"
										property="countUnits" styleId="countUnits" style="width:100%"></html:text>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">当前库存</td>
								<td class="oz-property"><html:text
										styleClass="oz-form-btField formatToInt"
										property="currentInventory" styleId="currentInventory" style="width:100%"></html:text>
								</td>
								<td class="oz-form-label-l">单价</td>
								<td class="oz-property"><html:text styleClass="oz-form-Field formatToMoney"
										property="price" styleId="price"
										style="width:100%"></html:text>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">生产厂商</td>
								<td class="oz-property"><html:text styleClass="oz-form-Field"
										property="supplier" styleId="supplier"  onclick="selectAgent(this)" style="width:100%"></html:text>
								</td>
								<td class="oz-form-label-l">经销商</td>
								<td class="oz-property"><html:text styleClass="oz-form-Field "
										property="agent" styleId="agent" onclick="selectAgent(this)"
										style="width:100%"></html:text>
								</td>
							</tr>
							
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">配件更换周期</td>
								<td class="oz-property"><html:text styleClass="oz-form-Field formatToInt"
										property="changedCycle" styleId="changedCycle" 
										style="width:85%"></html:text>&nbsp天
								</td>
								<td class="oz-form-label-l">存储位置</td>
								<td class="oz-property"><html:text styleClass="oz-form-Field"
										property="stockArea" styleId="stockArea"
										style="width:100%"></html:text>
								</td>
							</tr>
						
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">最小库存</td>
								<td class="oz-property"><html:text styleClass="oz-form-Field formatToInt"
										property="minInventory" styleId="minInventory"
										style="width:100%"></html:text>
								</td>
								<td class="oz-form-label-l">最大库存</td>
								<td class="oz-property"><html:text styleClass="oz-form-Field formatToInt"
										property="maxInventory" styleId="maxInventory"
										style="width:100%"></html:text>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">备注</td>
								<td  class="oz-property" colspan="3"><html:textarea styleClass="oz-form-field"
										property="remark" styleId="remark" style="width:100%"></html:textarea>
								</td>
							<tr>
				
						</table>
						 <div style="height: 100px"></div>
					</div>
				</div>
			</div>
			<html:hidden property="id" styleId="id" />
		</html:form>
	</div>
</body>
<oz:js />
<oz:js jsSrc="/ems/common/js/common.util.js" />
<oz:js jsSrc="/ems/partinfo/js/ems.partinfo.FE.js" />
</html>