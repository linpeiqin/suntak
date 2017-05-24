<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true" tabs="true"/>
<head>
<title>设备维修记录表</title>
<%@ include file="/oz/includes/meta.jsp"%>
<oz:css />
<oz:css cssHref="/ems/common/css/ems-util.css" />
<oz:css cssHref="/ems/common/css/ems-view.css" />
</head>
<body class="oz-body" data-name="设备维修记录表">
	<div id="page-center" class="oz-page-form">
		<html:form action="ems/repairRecordAction" styleId="ozForm" styleClass="oz-form">
			<div class="ems-form-main">
				<div class="ems-form-content">
					<div  class="oz-form-fields2">
						<table class="oz-form-bordertable" style="width: 99%; text-align: left">
							<tr class="oz-form-emptyTR">
								<td width="20%"></td>
								<td width="30%"></td>
								<td width="20%"></td>
								<td width="30%"></td>
							</tr>
				    		<tr class="oz-form-tr">
								<td class="oz-form-label-l"><span class="equipmentClass">设备编号</span></td>
								<td class="oz-property">
								<span class="equipmentClass" id="equipmentNoSpan"> 
								<bean:write name="repairRecordForm" property="equipmentDetails.equipmentNo" /> 
								</span>
								</td>
							    <td class="oz-form-label-l"><span class="equipmentClass">设备名称</span></td>
								<td class="oz-property">
									<span class="equipmentClass" id="equipmentNameSpan"><bean:write name="repairRecordForm" property="equipmentDetails.equipmentName"/></span>
								</td>
							</tr>
							<tr class="oz-form-tr">
							    <td class="oz-form-label-l"><span class="equipmentClass">使用部门</span></td>
								<td class="oz-property">
									<span class="equipmentClass" id="useDSpan">
										<bean:write name="repairRecordForm" property="equipmentDetails.useD"/>
									</span>
								</td>
								<td class="oz-form-label-l"><span class="equipmentClass">规格型号</span></td>
								<td class="oz-property">
									<span class="equipmentClass" id="specificationModelSpan">
										<bean:write name="repairRecordForm" property="equipmentDetails.specificationModel"/>
									</span>
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
									<bean:write name="repairRecordForm" property="eDegreeName" />
								</td>
								<td class="oz-form-label-l">维修单号</td>
								<td class="oz-property">
								<bean:write name="repairRecordForm" property="maintenanceNo" />
							</td>
								
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">维修申请人</td>
								<td class="oz-property">
								<bean:write name="repairRecordForm" property="maintenanceApplicant.name" />
								</td>
								<td class="oz-form-label-l">开单时间</td>
								<td class="oz-property">
								<bean:write name="repairRecordForm" property="maintenanceTimeStr" format="yyyy-MM-dd" />
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">故障描述</td>
								<td class="oz-property" colspan="3">
								<bean:write name="repairRecordForm" property="faultDescription" />
								</td>
							</tr>
						</table>
					</div>
					<div id="repairTable" class="oz-form-tabs"  style="margin-left: 6px;width: 99%;">
						<div id="tabCat" class="border" data-tabs='{"height":230}' >
							<div data-tab-panel='{"id":"tab_01","title":"基本信息","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
								<table class="oz-form-bordertable"style="width: 100%;text-align: left">
									<tr class="oz-form-emptyTR">
										<td width="20%"></td>
										<td width="30%"></td>
										<td width="20%"></td>
										<td width="30%"></td>
									</tr>
									<tr class="oz-form-tr">
										<td class="oz-form-label-l">维修单位</td>
										<td style="white-space: nowrap" class="oz-property">
										<html:radio styleClass="oz-form-field" styleId="repairMode"  property="repairMode" value="0"  style="width:10%" disabled="true"/>
										<label style="width:10%;vertical-align:middle; text-align:center;line-height:20px;">自修</label>
										<html:radio styleClass="oz-form-field" styleId="repairMode"  property="repairMode" value="1"  style="width:10%" disabled="true"/>
										<label style="width:10%;vertical-align:middle; text-align:center;line-height:20px;">外修</label>
											:<bean:write name="repairRecordForm" property="maintenanceUnit"  />
										</td>
										<td class="oz-form-label-l">维修人</td>
										<td class="oz-property">
										<bean:write name="repairRecordForm" property="maintenancePerson.name" />
									</tr>
									<tr class="oz-form-tr">
										<td class="oz-form-label-l">维修状态</td>
										<td style="white-space: nowrap" class="oz-property">
												<html:radio styleClass="oz-form-Field" styleId="maintenaceState"  property="maintenaceState" value="0"  style="width:10%" disabled="true"/>
												<label style="width:10%;vertical-align:middle; text-align:center;line-height:20px;">进行中</label>
												<html:radio styleClass="oz-form-Field" styleId="maintenaceState"  property="maintenaceState" value="1" style="width:10%" disabled="true"/>
												<label style="width:10%;vertical-align:middle; text-align:center;line-height:20px;">已完成</label>
										</td>
										<td class="oz-form-label-l">维修级别</td>
										<td class="oz-property">
											<bean:write name="repairRecordForm" property="maintenaceLevelName"  />
										</td>
									</tr>
									<tr class="oz-form-tr">
										<td class="oz-form-label-l">故障类别</td>
										<td class="oz-property">
											<bean:write name="repairRecordForm" property="faultClassName"  />
										</td>
										<td class="oz-form-label-l">维修费用</td>
										<td class="oz-property">
										<bean:write name="repairRecordForm" property="maintenanceCost" format="0.00" />
										</td>
									</tr>
									<tr class="oz-form-tr">
										<td class="oz-form-label-l">开始时间</td>
										<td class="oz-property">
										<bean:write name="repairRecordForm" property="startTimeStr" format="yyyy-MM-dd"/>
										</td>
										<td class="oz-form-label-l">完成时间</td>
										<td class="oz-property">
										<bean:write name="repairRecordForm" property="endTimeStr" format="yyyy-MM-dd" />
									</tr>
									<tr class="oz-form-tr">
										<td class="oz-form-label-l">占用生产时间</td>
										<td class="oz-property">
										<html:radio styleClass="oz-form-field" styleId="timeOccupy"  property="timeOccupy" value="0"  style="width:10%" disabled="true"/>
										<label style="width:10%;vertical-align:middle; text-align:center;line-height:20px;">否</label>
										<html:radio styleClass="oz-form-field" styleId="timeOccupy"  property="timeOccupy" value="1"  style="width:10%" disabled="true"/>
										<label style="width:10%;vertical-align:middle; text-align:center;line-height:20px;">是</label>
										</td>
										<td class="oz-form-label-l">停机时长</td>
										<td class="oz-property">
										<bean:write name="repairRecordForm" property="downTime" />
										</td>
									</tr>
									<tr class="oz-form-tr">
										<td class="oz-form-label-l">故障分析及处理</td>
										<td class="oz-property" colspan="3">
										<bean:write name="repairRecordForm" property="faultSolve" />
										</td>
									</tr>
								</table>
							</div>
							<div data-tab-panel='{"id":"tab_02","title":"更换配件","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
								<iframe id="IFRAME_02" class="oz-tab-iframe" height="100%" width="100%" frameborder="0">
								</iframe>
							</div>
							<div data-tab-panel='{"id":"tab_03","title":"维修附件","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
								<iframe id="IFRAME_03" class="oz-tab-iframe" height="100%" width="100%" frameborder="0">
								</iframe>
							</div>
						</div>
					</div>
					<div class="oz-form-fields2" style="margin-top: 3px;">
						<table class="oz-form-bordertable" style="width: 99%;text-align: left">
						<tr class="oz-form-tr">
							<td class="oz-form-label-l">用户评分</td>
							<td class="oz-property">
								<bean:write name="repairRecordForm" property="userScore" />
							</td>
							<td class="oz-property" colspan="2" style="color:blue" >
								(*满分100分，请给出客观评价！)
							</td>
						</tr>
						<tr>
							<td class="oz-form-label-l">用户意见</td>
							<td class="oz-property" colspan="3">
								<bean:write name="repairRecordForm" property="userOpinion" />
							</td>
						</tr>
						</table>
					</div>
				</div>
			</div>
			<html:hidden property="id" styleId="id" />
			<html:hidden property="equipmentDetails.id" styleId="equipmentId"/>
			<html:hidden property="billMode" styleId="billMode"/>
		</html:form>
	</div>
</body>
<oz:js />
<oz:js jsSrc="/ems/common/js/common.util.js" />
<oz:js jsSrc="/ems/equipmentrepair/js/ems.repairrecord.F.js" />
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<script type="text/javascript">
</script>
</html>