<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true"/>
<head>
    <title>保养月计划表</title>
    <%@ include file="/oz/includes/meta.jsp"%>
    <oz:css/>
    <oz:css cssHref="/ems/common/css/ems-util.css"/>
</head>
<body class="oz-body" data-name="保养月计划表">
<div id="page-top" class="oz-page-top">

</div>
<div id="page-center" class="oz-page-form">
    <html:form action="ems/repairMonthPlanAction" styleId="ozForm" styleClass="oz-form">
        <div class="ems-form-main">
            <div class="ems-form-content">
                <div class="ems-form-title" style="margin-top: 10px;margin-bottom: 5px;">
               ${bean.planMonth } 保养月计划表
                </div>
                <div class="ems-form-body">
                    <table class="ems-form-table" style="width: 98%;">
                        <tr class="ems-form-table-headtr" >
                            <td rowspan="2" style="text-align: center;width:5%;">序号</td>
                            <td rowspan="2" style="text-align: center;width:5%;">工序</td>
                            <td rowspan="2" style="text-align: center;width:30%;">设备名称</td>
                            <td rowspan="2" style="text-align: center;width:5%;">设备编码</td>
                            <td rowspan="2" style="text-align: center;width:5%;">保养级别</td>
                            <td rowspan="2" style="text-align: center;width:10%;">预计保养日期</td>
                            <td colspan="${maxDate }" style="text-align: center;width:40%;">计划日期</td>
                        </tr>
                        <tr>
                        	<c:forEach begin="1" end="${maxDate }" var="d" step="1">
                        		<td style="text-align: center;">${d }</td>
                        	</c:forEach>
                        </tr>
                         <c:forEach items="${details }" var="it" varStatus="sta">
                        <tr>
                           		<td>${sta.index + 1 }</td>
                           		<td><input type="hidden" name="procedure" value="${it.PROCEDURE }" />${it.PROCEDURE }</td>
                           		<td style="text-align:left;">
                           		<input type="hidden" name="equipmentId" value="${it.EQUIPMENT_ID }" />
                           		<input type="hidden" name="equipmentName" value="${it.EQUIPMENT_NAME }" />
                           		${it.EQUIPMENT_NAME }</td>
                           		<td><input type="hidden" name="equipmentNo" value="${it.EQUIPMENT_NO }" />${it.EQUIPMENT_NO }</td>
                           		<td><input type="hidden" name="maintenaceLevel" value="${it.MAINTENACE_LEVEL }" />${it.MAINTENACE_LEVEL }</td>
                           		<td><input type="hidden" name="maintenaceDate" value="${it.MAINTENACE_DATE }" />${it.MAINTENACE_DATE }</td>
                           		<c:forEach begin="1" end="${maxDate }" var="d" step="1">
                           		   <c:set var="pd" value=",${d }," />
                           		   <c:if test="${fn:contains(it.MAINTENACE_DAY, pd)}">
                           		   <td><span class="oz-icon oz-icon-0929"></span></td>
                           		   </c:if>
                           		   <c:if test="${!fn:contains(it.MAINTENACE_DAY, pd)}">
                           		   <td>&nbsp;</td>
                           		   </c:if>
                           		</c:forEach>
                        </tr>
                        </c:forEach>
                    </table>
                    <div style="height: 100px"></div>
                </div>
            </div>
        </div>
        <html:hidden property="id" styleId="id"/>
       
   </html:form>
</div>
</body>

<oz:organizeJs></oz:organizeJs>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<oz:js jsSrc="/ems/monthplan/js/ems.monthplan.FE.js"/>
<script type="text/javascript">
</script>
</html>