<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
<title>保养记录表</title>
<%@ include file="/oz/includes/meta.jsp"%>
<oz:css />
<oz:css cssHref="/ems/common/css/ems-util.css" />
<oz:css cssHref="/ems/common/css/ems-view.css" />
</head>
<body class="oz-body" data-name="保养记录表">
	<div id="page-top" class="oz-page-top">
	<oz:toolbar action="ems/maintainAction" defaultTB="readForm">
<%-- 		<oz:tbSeperator /> --%>
<%-- 		<oz:tbButton id="btnSeePlan" icon="oz-icon oz-icon-0116" text="查看保养计划" onclick="onSeePlan(this)"/> --%>
 	</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
				<html:form action="ems/maintainAction" styleId="ozForm" styleClass="oz-form">
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
								<td class="oz-property" >
									<bean:write name="maintainForm" property="equipmentDetails.equipmentName" />
								</td>
								<td class="oz-form-label-l">设备编号</td>
								<td class="oz-property">
								    <bean:write name="maintainForm" property="equipmentDetails.equipmentNo" />
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">使用部门</td>
								<td class="oz-property" >
								     <bean:write name="maintainForm" property="equipmentDetails.useD" />
								</td>
								<td class="oz-form-label-l">保养级别</td>
								<td class="oz-property" >
									 <bean:write name="maintainForm" property="maintainLevel" />
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">系统计划日期</td>
								<td class="oz-property" >
									 <bean:write name="maintainForm" property="planDateStr" format="yyyy-MM-dd"/>
								</td>
								<td class="oz-form-label-l">执行时间</td>
								<td class="oz-property" >
									 <bean:write name="maintainForm" property="executTimeStr" format="yyyy-MM-dd HH:mm:ss"/>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">保养人</td>
								<td class="oz-property" >
									 <bean:write name="maintainForm" property="maintainPerson.name" />
								</td>
								<td class="oz-form-label-l">状态</td>
								<td class="oz-property" >
									 <logic:equal name="maintainForm" property="status" value="0"><font color="red">待执行</font></logic:equal>
									 <logic:equal name="maintainForm" property="status" value="1"><font color="green">已执行</font></logic:equal>
								</td>
							</tr>
							</table>
					</div>
				    <div class="oz-form-tabs" style="margin-left: 6px;width:99%;height:360px;border: 1px solid #99BBE8" >
					<jsp:include  page="F_MaintainContent.jsp"/>
			        </div>
					<div class="oz-form-fields2">
					     <table class="oz-form-bordertable" style="width: 99%">
					       <tr class="oz-form-emptyTR">
								<td width="10%"></td>
								<td width="40%"></td>
								<td width="10%"></td>
								<td width="40%"></td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l" >保养结果</td>
								<td class="oz-property"  >
									 <bean:write name="maintainForm" property="maintainResult" />
										
								</td>
								<td class="oz-form-label-l" >物料使用情况</td>
								<td class="oz-property"  >
									 <bean:write name="maintainForm" property="mltUseState" />
								</td>
							</tr>
					     </table>
					      <table class="oz-form-bordertable" style="width: 99%">
					       <tr class="oz-form-emptyTR">
								<td width="20%"></td>
								<td width="20%"></td>
								<td width="20%"></td>
								<td width="20%"></td>
								<td width="20%"></td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l" >工序验收</td>
								<td class="oz-form-label-l" >工艺确认</td>
								<td class="oz-form-label-l" >品保确认</td>
								<td class="oz-form-label-l" >设备责任人</td>
								<td class="oz-form-label-l" >设备部审核</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-property"  >
									  <bean:write name="maintainForm" property="processAccept" />
								</td>
								<td class="oz-property"  >
									 <bean:write name="maintainForm" property="processValidate" />
								</td>
								<td class="oz-property"  >
									 <bean:write name="maintainForm" property="qaVerificate" />
								</td>
								<td class="oz-property"  >
								 	<bean:write name="maintainForm" property="equipmentRP" />
								</td>
								<td class="oz-property"  >
									 <bean:write name="maintainForm" property="equipmentAudit" />
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l" >日期</td>
								<td class="oz-form-label-l" >日期</td>
								<td class="oz-form-label-l" >日期</td>
								<td class="oz-form-label-l" >日期</td>
								<td class="oz-form-label-l" >日期</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-property"  >
									 <bean:write name="maintainForm" property="acceptDate"  format="yyyy-MM-dd"/>
								</td>
								<td class="oz-property"  >
									 <bean:write name="maintainForm" property="validateDate" format="yyyy-MM-dd" />
								</td>
								<td class="oz-property"  >
									 <bean:write name="maintainForm" property="verificateDate" format="yyyy-MM-dd" />
								</td>
								<td class="oz-property"  >
									 <bean:write name="maintainForm" property="rpDate"  format="yyyy-MM-dd"/>
								</td>
								<td class="oz-property"  >
									 <bean:write name="maintainForm" property="auditDate" format="yyyy-MM-dd"/>
								</td>
							</tr>
					     </table>
				   </div>
				</div>
			</div>
			<html:hidden property="id" styleId="id" />
			<html:hidden property="repairPlanId" styleId="repairPlanId" />
			<html:hidden property="equipmentDetails" styleId="equipmentDetails" />
			<html:hidden  property="maintainPerson.id" styleId="maintainPersonId"/>
		</html:form>
	</div>
</body>
<oz:js />
<oz:js jsSrc="/ems/common/js/common.util.js" />
<oz:js jsSrc="/ems/equipmentrepair/js/ems.maintain.F.js" />
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<script type="text/javascript">
</script>
</html>