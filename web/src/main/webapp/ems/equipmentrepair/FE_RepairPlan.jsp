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
		<oz:toolbar action="ems/repairPlanAction">
			<oz:tbSeperator/>
			<oz:tbButton id="btnSave"/>
			<c:if test="${selShow }">
				<oz:tbSeperator />
				<oz:tbButton id="btnSelectEquipment" icon="oz-icon oz-icon-0323" text="选择设备" onclick="onSelectEquipment(this)"/>
			</c:if>
			
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
					<%--<tr>
						<td class="oz-form-label-l">保养人</td>
						<td class="oz-property" colspan="3">
							<html:text styleId="maintenancePeson" property="maintenancePeson.name" styleClass="oz-form-btField" onclick="OZ.Organize.selectUserInfoWithOUInfoID(-1, doDistribution);" style="width:100%"/>
						</td>
					</tr>--%>
					<tr>
						<td class="oz-form-label-l">起始月</td>
						<td class="oz-property" colspan="3">
							<html:select styleId="startIndex" property="startIndex" styleClass="oz-form-btField" style="width:100%">
										<html:optionsCollection name="intervalSelect" label="name" value="value" />
									</html:select>
						</td>
					</tr>
					<tr>
						<td class="oz-form-label-l">保养方式</td>
						<td colspan="3">
							<ul>
							<c:forEach items="${maintenaceLevelSelect }" var="lvl">
								<li style="margin-top: 5px;">
									<input type="checkbox" name="maintenaceLevel_${lvl.value }" id="maintenaceLevel_${lvl.value }" value="${lvl.name }" lvlValue="${lvl.value }" 
									<c:if test="${ruleMap[lvl.name]!=null && ruleMap[lvl.name].status eq '0' }">checked</c:if> onclick="levelClick(this);" />${lvl.name }&nbsp;
									<span id="span_${lvl.value }">
									执行日：<input type="text" name="dayNum_${lvl.value }" id="dayNum_${lvl.value }" onblur="checkDayNum(this);" value="${ruleMap[lvl.name].dayNum }" style="width:40px;">（号）&nbsp;
									间隔：
									<select name="interval_${lvl.value }" id="interval_${lvl.value }"> 
									<c:forEach begin="1" end="12" step="1" var="interval">
										<option value="${interval }" ${ruleMap[lvl.name].interval eq interval?'selected':'' }>${interval }</option>
									</c:forEach>
									</select>（月）&nbsp;
									</span>
								</li>
							</c:forEach>
							</ul>
						</td>
					</tr>
				<%--	<tr>
						<td class="oz-form-label-l">工作描述</td>
						<td class="oz-property" colspan="3">
							<html:textarea styleClass="oz-form-btField"  property="workDescription" styleId="workDescription" style="width:100%"/>
						</td>
					</tr>--%>
				</table>
			</div>
			<div style="border:1px solid #76ABD3; width: 98%;height: 100%;margin-left: 5px" >
			<iframe class="oz-tab-iframe" id="iframe1" height="100%" width="100%" frameborder="0">
			</iframe>
			</div>
			<html:hidden styleId="id" property="id"/>
			<html:hidden styleId="equipmentId" property="equipmentDetails.id"/>
			<html:hidden styleId="maintenancePesonId" property="maintenancePeson.id"/>
			<html:hidden property="intervalUnit" styleId="intervalUnit"/>
		</html:form>
	</div>
</div>
</body>
<oz:organizeJs/>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js" />
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/equipmentrepair/js/ems.repairplan.FE.js" />
<script type="text/javascript">
$(function(){
	init();
    loadSubPanel("iframe1",contextPath + "/ems/repairPlanAction.do?action=displayTime&planId="+$('#id').val()+"&barShow=${barShow}");
});
var checkNum = 0;
function init(){
    <c:forEach items="${maintenaceLevelSelect }" var="lvl">
    var levelChecked = $("#maintenaceLevel_${lvl.value}").is(":checked");
    if(!levelChecked){
        disabledItems('${lvl.value}',false);
    }else{
    	checkNum++;
    }
    </c:forEach>
}


function initInterval(index,bln){
	var levelChecked = $("#maintenaceLevel_"+index).is(":checked");
    if(levelChecked){
    	if(bln)
			checkNum ++;
	}else{
		if(checkNum > 0){
			if(bln)
				checkNum --;
		}
	}
	 <c:forEach items="${maintenaceLevelSelect }" var="lvl">
		 var levelChecked1 = $("#maintenaceLevel_${lvl.value}").is(":checked");
		 if(levelChecked1){
			 $("#interval_${lvl.value}").val(checkNum);
		 }
	 </c:forEach>
}
</script>
</html>