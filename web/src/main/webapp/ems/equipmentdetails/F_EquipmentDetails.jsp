<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true" />
<head>
<title>资产详细信息表</title>
<%@ include file="/oz/includes/meta.jsp"%>
<oz:css />
<oz:css cssHref="/ems/common/css/ems-util.css" />
</head>
<body class="oz-body" data-name="资产详细信息表">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/equipmentDetailsAction" defaultTB="readForm">
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
								<td class="oz-form-label-l">资产名称</td>
								<td class="oz-property">
								<bean:write name="equipmentDetailsForm" property="equipmentName"/>
								</td>
								<td class="oz-form-label-l">设备编号</td>
								<td class="oz-property">
								<bean:write name="equipmentDetailsForm" property="equipmentNo"/>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">规格型号</td>
								<td class="oz-property">
								<bean:write name="equipmentDetailsForm" property="specificationModel"/>
								</td>
								<td class="oz-form-label-l">资产类别</td>
								<td class="oz-property">
								<bean:write name="equipmentDetailsForm" property="equipmentType"/>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">生产厂商</td>
								<td class="oz-property">
								<bean:write name="equipmentDetailsForm" property="manufacturer"/>
								|<bean:write name="equipmentDetailsForm" property="brand"/>
								</td>
								<td class="oz-form-label-l">供应商</td>
								<td class="oz-property">
								<bean:write name="equipmentDetailsForm" property="suppliers"/>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td  class="oz-form-label-l">购置时间</td>
								<td class="oz-property">
								<bean:write name="equipmentDetailsForm" property="startTime" format="yyyy-MM-dd"/>
								</td>
								<td class="oz-form-label-l">机身编号</td>
								<td class="oz-property">
								<bean:write name="equipmentDetailsForm" property="serialNo"/>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">安装地点</td>
								<td class="oz-property">
									${ebsEntity.installSite}
								</td>
								<td class="oz-form-label-l">资产原值</td>
								<td class="oz-property">
									${ebsEntity.originalValue}
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td  class="oz-form-label-l">折旧方法</td>
								<td class="oz-property">
										${ebsEntity.deprectationMethod}
								</td>
								<td  class="oz-form-label-l">折旧年限</td>
								<td class="oz-property" >
										${ebsEntity.canUseLife}月
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td  class="oz-form-label-l">残值</td>
								<td class="oz-property">
									${ebsEntity.cost}
								</td>
								<td  class="oz-form-label-l">净值</td>
								<td class="oz-property">
										${ebsEntity.netWorth}
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">管理部门</td>
								<td class="oz-property">
								    <%--<bean:write name="equipmentDetailsForm" property="ebsEntity.managerD" />--%>
											${ebsEntity.managerD}
								</td>
								<td class="oz-form-label-l">使用部门</td>
								<td class="oz-property">
								    <%--<bean:write name="equipmentDetailsForm" property="ebsEntity.userD" />--%>
											${ebsEntity.userD}
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">资产别名</td>
								<td class="oz-property">
									<bean:write name="equipmentDetailsForm" property="equipmentAlias" />
								</td>
								<td class="oz-form-label-l">使用工序</td>
								<td class="oz-property">
									<bean:write name="equipmentDetailsForm" property="procedure" />
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">资产编号</td>
								<td class="oz-property">
									<bean:write name="equipmentDetailsForm" property="assetId" />
								</td>
								<td class="oz-form-label-l">使用情况</td>
								<td class="oz-property">
									<c:choose>
										<c:when test="${domain.type==0}">
											<span>待入厂</span>
										</c:when>
										<c:when test="${domain.type==1}">
											<span>待验收</span>
										</c:when>
										<c:when test="${domain.type==2}">
											<span>使用中</span>
										</c:when>
										<c:when test="${domain.type==3}">
											<span>已报废</span>
										</c:when>
										<c:when test="${domain.type==4}">
											<span>已出售</span>
										</c:when>
										<c:when test="${domain.type==5}">
											<span>待更新</span>
										</c:when>
										<c:when test="${domain.type==6}">
											<span>更新待验收</span>
										</c:when>
									</c:choose>

								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">备注</td>
								<td class="oz-property" colspan="3" height="92px">
								     <bean:write name="equipmentDetailsForm" property="remark" />
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<html:hidden property="id" styleId="id" />
		</html:form>
	</div>
</body>
<oz:js />
<oz:js jsSrc="/ems/common/js/common.util.js" />
<oz:js jsSrc="/ems/equipmentdetails/js/ems.equipmentdetails.F.js" />
</html>