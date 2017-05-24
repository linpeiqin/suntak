<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" timePicker="true"/>
<head>
	<title>保养计划</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssHref="/oz/themes/default/calendar.css"/>
	<oz:css cssHref="/ems/common/css/ems-util.css" />
	<oz:css cssHref="/ems/common/css/ems-view.css" />
</head>
<body class="oz-body" data-name="保养计划">
<div id="page" class="oz-page">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/repairPlanAction" defaultTB="readForm">
			<oz:tbSeperator />
			<oz:tbButton id="btnSeeMaintain" icon="oz-icon oz-icon-0323" text="查看保养记录" onclick="onSeeMaintain(this)"/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="ems/repairPlanAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-fields2">
				<table  class="oz-form-bordertable" style="width: 98%;height: 40%" >
					<tr class="oz-form-emptyTR">
						<td width="20%"></td>
						<td width="30%"></td>
						<td width="20%"></td>
						<td width="30%"></td>
					</tr>
					<tr>
						<td class="oz-form-label-l"><span class="equipmentClass">设备名称</span></td>
						<td class="oz-property">
							<span class="equipmentClass" id="equipmentNameSpan"><bean:write name="repairPlanForm" property="equipmentDetails.equipmentName"/></span>
						</td>
						<td class="oz-form-label-l"><span class="equipmentClass">设备编号</span></td>
						<td class="oz-property">
							<span class="equipmentClass" id="equipmentNoSpan"><bean:write name="repairPlanForm" property="equipmentDetails.equipmentNo"/></span>
						</td>
					</tr>
					<tr>
						<td class="oz-form-label-l"><span class="equipmentClass">规格型号</span></td>
						<td class="oz-property">
							<span class="equipmentClass" id="specificationModelSpan">
								<bean:write name="repairPlanForm" property="equipmentDetails.specificationModel"/>
							</span>
						</td>
						<td class="oz-form-label-l"><span class="equipmentClass">使用部门</span></td>
						<td class="oz-property">
							<span class="equipmentClass" id="useDSpan">
								<bean:write name="repairPlanForm" property="equipmentDetails.useD"/>
							</span>
						</td>
					</tr>
					<tr>
						<td class="oz-form-label-l">起始月</td>
						<td class="oz-property" colspan="3">
							<span class="startIndexClass" id="startIndexSpan">
								<bean:write name="repairPlanForm" property="startIndex" format="0"/>
							</span>
						</td>
					</tr>
					<tr>
						<td class="oz-form-label-l">保养方式</td>
						<td colspan="3">
							<ul>
								<c:forEach items="${maintenaceLevelSelect }" var="lvl">
									<c:if test="${ruleMap[lvl.name]!=null}">
										<li style="margin-top: 5px;">
											${lvl.name }&nbsp;
											<span id="span_${lvl.value }">
												执行日：${ruleMap[lvl.name].dayNum }（号）&nbsp;
												间隔：
												${ruleMap[lvl.name].interval}（月）&nbsp;
											</span>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</td>
					</tr>
				</table>
			</div>
			<div style="border:1px solid #76ABD3; width: 98%;height: 56%;margin-left: 5px" >
				<iframe class="oz-tab-iframe" id="iframe1" height="100%" width="100%" frameborder="0">
				</iframe>
			</div>
			<html:hidden styleId="id" property="id"/>
			<html:hidden styleId="type" property="type"/>
			<html:hidden styleId="maintainId" property="maintainId"/>
			<html:hidden styleId="equipmentId" property="equipmentId" value="-1"/>
		</html:form>
	</div>
</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js" />
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/equipmentrepair/js/ems.repairplan.FE.js" />
<script type="text/javascript">
    $(function(){
        loadSubPanel("iframe1",contextPath + "/ems/repairPlanAction.do?action=displayTime&planId="+$('#id').val()+"&barShow=${barShow}");
    });

	function onSeeMaintain(){
		var mtId = $("#maintainId").val();
        new OZ.Dlg.create({
            id:mtId + "open" ,
            width:1000, height:650,
            title:"保养记录",
            url: contextPath+"/ems/maintainAction.do?action=open&id="+mtId,
            buttons:[{text:'关闭', handler:$.noop}],
            maximizable:true
        });
	}
</script>
</html>