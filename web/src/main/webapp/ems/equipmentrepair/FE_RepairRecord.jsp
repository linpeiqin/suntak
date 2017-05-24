<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="form" datePicker="true" timePicker="true" tabs="true" easyui="true"/>
<html>
<head>
<title>设备维修记录表</title>
<%@ include file="/oz/includes/meta.jsp"%>
<oz:css />
<oz:css cssHref="/ems/common/css/ems-util.css" />
<oz:css cssHref="/ems/common/css/ems-view.css" />
</head>
<body class="oz-body" data-name="设备维修记录表">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/repairRecordAction">
			<oz:tbSeperator />
			<oz:tbButton id="btnSave" />
			<oz:tbSeperator />
			<oz:tbButton id="btnSelectEquipment" icon="oz-icon oz-icon-0323" text="选择设备" onclick="onSelectEquipment(this)"/>
			<oz:tbSeperator />
			<oz:tbButton id="btnUpdateRepair" icon="oz-icon oz-icon-0323" text="提交" onclick="onUpdateRepair(this)"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnDistribution" text="分配维修人员" onclick="doDistribution()" icon="oz-icon oz-icon-0119"/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="ems/repairRecordAction" styleId="ozForm" styleClass="oz-form">
			<div class="ems-form-main">
				<div class="ems-form-content">
					<div id="submitMaintenance" class="oz-form-fields2" style="margin-top: 3px;text-align: left" >
						<table class="oz-form-bordertable" style="width: 99%;">
							<tr class="oz-form-emptyTR">
								<td width="20%"></td>
								<td width="30%"></td>
								<td width="20%"></td>
								<td width="30%"></td>
							</tr>
				    		<tr class="oz-form-tr">
								<td class="oz-form-label-l">设备编号</td>
								<td class="oz-property">
									<span class="equipmentClass" id="equipmentNoSpan"><bean:write name="repairRecordForm" property="equipmentDetails.equipmentNo"/></span>
								</td>
							    <td class="oz-form-label-l">设备名称</td>
								<td class="oz-property">
									<span class="equipmentClass" id="equipmentNameSpan"><bean:write name="repairRecordForm" property="equipmentDetails.equipmentName"/></span>
								</td>
							</tr>
							<tr class="oz-form-tr">
							    <td class="oz-form-label-l">使用部门</td>
								<td class="oz-property">
									<span class="equipmentClass" id="useDSpan"><bean:write name="repairRecordForm" property="equipmentDetails.useD"/></span>
								</td>
								<td class="oz-form-label-l">规格型号</td>
								<td class="oz-property">
									<span class="equipmentClass" id="specificationModelSpan"><bean:write name="repairRecordForm" property="equipmentDetails.specificationModel"/></span>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">开单方式</td>
								<td class="oz-property">
									<span id="billTypeSpan"></span>
								</td>
								<td class="oz-form-label-l">分配人</td>
								<td class="oz-property">
									<span id="distributorSpan"><bean:write name="repairRecordForm" property="distributor.name"/></span>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">紧急度</td>
								<td class="oz-property">
								    <html:select styleId="eDegree" property="eDegree" styleClass="oz-form-btField" style="width:100%">
								           <html:optionsCollection name="eDegreeSelect" label="name" value="value" />
									</html:select>
								</td>
										
								<td class="oz-form-label-l">维修单号</td>
								<td class="oz-property">
									<span id="maintenanceNoSpan">
										<bean:write name="repairRecordForm" property="maintenanceNo"/>
									</span>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">维修申请人</td>
								<td class="oz-property">
									<bean:write name="repairRecordForm" property="maintenanceApplicant.name"/>
								</td>
								<td class="oz-form-label-l">开单时间</td>
								<td class="oz-property"><html:text styleClass="oz-form-btField oz-dateTimeField"
										property="maintenanceTimeStr" styleId="maintenanceTimeStr"
										style="width:100%"></html:text>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">故障描述</td>
								<td class="oz-property" colspan="3"><html:textarea styleClass="oz-form-field"
										property="faultDescription" styleId="faultDescription"  style="width:100%;"></html:textarea>
								</td>
							</tr>
						</table>
					</div>
					<div id="repairTable" class="oz-form-tabs"  style="margin-left: 6px;width: 99%;text-align: left">
						<div id="tabCat" class="border" data-tabs='{"height":290}'>
							<div data-tab-panel='{"id":"tab_01","title":"基本信息","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
								<table  class="oz-form-bordertable" style="width:100%;">
									<tr class="oz-form-emptyTR">
										<td width="20%"></td>
										<td width="30%"></td>
										<td width="20%"></td>
										<td width="30%"></td>
									</tr>
									<tr class="oz-form-tr">
										<td class="oz-form-label-l">维修单位</td>
										<td style="white-space: nowrap" class="oz-property">
										<html:radio styleClass="oz-form-field" styleId="repairMode"  property="repairMode" value="0"  style="width:10%"/>
										<label style="width:10%;vertical-align:middle; text-align:center;line-height:20px;">自修</label>
										<html:radio styleClass="oz-form-field" styleId="repairMode"  property="repairMode" value="1"  style="width:10%"/>
										<label style="width:10%;vertical-align:middle; text-align:center;line-height:20px;">外修</label>
												<html:text
														styleClass="oz-form-zdField" property="maintenanceUnit" disabled="true"
														styleId="maintenanceUnit" style="width:50%"></html:text>
										</td>
										<td class="oz-form-label-l">维修人</td>
										<td class="oz-property"><html:text
												styleClass="oz-form-field" property="maintenancePerson.name"
												styleId="maintenancePersonName" style="width:100%"></html:text></td>
									</tr>
									<tr class="oz-form-tr">
										<td class="oz-form-label-l">维修状态</td>
										<td style="white-space: nowrap" class="oz-property">
												<html:radio styleClass="oz-form-field" styleId="maintenaceState"  property="maintenaceState" value="0"  style="width:10%"/>
												<label style="width:10%;vertical-align:middle; text-align:center;line-height:20px;">进行中</label>
												<html:radio styleClass="oz-form-field" styleId="maintenaceState"  property="maintenaceState" value="1" style="width:10%"/>
												<label style="width:10%;vertical-align:middle; text-align:center;line-height:20px;">已完成</label>
										</td>
										<td class="oz-form-label-l">维修级别</td>
										<td class="oz-property">
											<html:select styleId="maintenaceLevel" property="maintenaceLevel" styleClass="oz-form-field" style="width:100%">
												<html:optionsCollection name="maintenaceLevelSelect"  label="name" value="value" />
											</html:select>
										</td>
									</tr>
									<tr class="oz-form-tr">
										<td class="oz-form-label-l">故障类别</td>
										<td class="oz-property" >
												<html:select styleId="faultClass" property="faultClass" styleClass="oz-form-field-select" style="width:100%" disabled="true">
													<html:optionsCollection name="faultClassSelect" label="name" value="value"  />
												</html:select>
										</td>
										<td class="oz-form-label-l">维修费用</td>
										<td class="oz-property"><span id="maintenanceCostSpan">
										<bean:write name="repairRecordForm" property="maintenanceCost" format="0.00" />
										</span>
										</td>
									</tr>
									<tr class="oz-form-tr">
										<td class="oz-form-label-l">开始时间</td>
										<td class="oz-property"><html:text
												styleClass="oz-dateTimeField  oz-form-btField" property="startTimeStr"
												styleId="startTimeStr" style="width:100%"></html:text>
										</td>
										<td class="oz-form-label-l">完成时间</td>
										<td class="oz-property"><html:text
												styleClass="oz-dateTimeField oz-form-btField" property="endTimeStr"
												styleId="endTimeStr" style="width:100%" ></html:text></td>
									</tr>
									<tr class="oz-form-tr">
										<td class="oz-form-label-l">占用生产时间</td>
										<td class="oz-property">
										<html:radio styleClass="oz-form-field" styleId="timeOccupy"  property="timeOccupy" value="0"  style="width:10%"/>
										<label style="width:10%;vertical-align:middle; text-align:center;line-height:20px;">否</label>
										<html:radio styleClass="oz-form-field" styleId="timeOccupy"  property="timeOccupy" value="1"  style="width:10%"/>
										<label style="width:10%;vertical-align:middle; text-align:center;line-height:20px;">是</label>
										</td>
										<td class="oz-form-label-l">停机时长</td>
										<td class="oz-property"><html:text
												styleClass="oz-form-field" property="downTime" readonly="true"
												styleId="downTime" style="width:60%"></html:text>（分钟）
										</td>
									</tr>
									<tr class="oz-form-tr">
										<td class="oz-form-label-l">故障分析及处理</td>
										<td class="oz-property" colspan="3"><html:textarea
												styleClass="oz-form-field" property="faultSolve"
												styleId="faultSolve" style="width:90%" ></html:textarea>
												<oz:linkButton onclick="selectFaultDeal(this)" text="oz.btn.select"></oz:linkButton>
										</td>
									</tr>
								</table>
							</div>
							<div data-tab-panel='{"id":"tab_02","title":"更换配件","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
								<iframe id="IFRAME_02" class="oz-tab-iframe" height="100%"width="100%" frameborder="0">
								</iframe>
							</div>
							<div data-tab-panel='{"id":"tab_03","title":"维修附件","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
								<iframe id="IFRAME_03" class="oz-tab-iframe" height="100%"width="100%" frameborder="0">
								</iframe>
							</div>
					</div>
				</div>
					<div id="beenRepaired" class="oz-form-fields2" style="margin-top: 3px;text-align: left">
						<table class="oz-form-bordertable" style="width: 99%;">
							<tr class="oz-form-tr">
									<td class="oz-form-label-l">用户评分</td>
									<td class="oz-property"><html:text styleClass="oz-form-field formatToInt"
											property="userScore" styleId="userScore"
											style="width:100%"></html:text>
									</td>
									<td class="oz-property" colspan="2" style="color:blue" >
									(*满分100分，请给出客观评价！)
									</td>
								</tr>
								<tr>
									<td class="oz-form-label-l">用户意见</td>
									<td class="oz-property" colspan="3"><html:textarea styleClass="oz-form-field"
											property="userOpinion" styleId="userOpinion"
											style="width:100%"></html:textarea>
									</td>
								</tr>
						</table>
					</div>
				</div>
			</div>
			
			<html:hidden property="id" styleId="id" />
			<html:hidden property="status" styleId="status" />
			<html:hidden property="organizationId" styleId="organizationId" />
			<html:hidden property="createdDate" styleId="createdDate" />
			<html:hidden property="equipmentDetails.id" styleId="equipmentId"/>
			<html:hidden property="maintenanceApplicant.id" styleId="maintenanceApplicantId"/>
			<html:hidden property="maintenanceApplicant.name" styleId="maintenanceApplicantName"/>
			<html:hidden property="maintenancePerson.id" styleId="maintenancePersonId"/>
			<html:hidden property="partReplace1" styleId="partReplace1" />
			<html:hidden property="billMode" styleId="billMode" />
			<html:hidden property="distributor.id" styleId="distributorId" />
			<html:hidden property="distributor.name" styleId="distributorName" />
			<html:hidden property="maintenanceCost" styleId="maintenanceCost" />
		</html:form>
	</div>
</body>
<oz:organizeJs/>
<oz:js />
<oz:js jsSrc="/ems/common/js/common.util.js" />
<oz:js jsSrc="/ems/equipmentrepair/js/ems.repairrecord.FE.js" />
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<script type="text/javascript">
    var isMaintenancer = <%=request.getAttribute("isMaintenancer")%>;
    var isDistributor = <%=request.getAttribute("isDistributor")%>;
    var isRepair = <%=request.getAttribute("isRepair")%>;
</script>
</html>