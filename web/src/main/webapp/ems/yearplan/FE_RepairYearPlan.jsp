<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true"/>
<head>
    <title>保养年计划表</title>
    <%@ include file="/oz/includes/meta.jsp"%>
    <oz:css/>
    <oz:css cssHref="/ems/common/css/ems-util.css"/>
</head>
<body class="oz-body" data-name="保养年计划表">
<div id="page-top" class="oz-page-top">

</div>
<div id="page-center" class="oz-page-form">
    <html:form action="ems/intoFactoryAction" styleId="ozForm" styleClass="oz-form">
        <div class="ems-form-main">
            <div class="ems-form-content">
                <div class="ems-form-title" style="margin-top: 10px;margin-bottom: 5px;">
               ${bean.planYear } 保养年计划表
                </div>
                <div class="ems-form-body">
                    <table class="ems-form-table" style="width: 98%;">
                        <tr class="ems-form-table-headtr" >
                            <td rowspan="2" style="text-align: center;width:5%;">序号</td>
                            <td rowspan="2" style="text-align: center;width:5%;">工序</td>
                            <td rowspan="2" style="text-align: center;width:30%;">设备名称</td>
                            <td rowspan="2" style="text-align: center;width:5%;">设备编码</td>
                            <td colspan="12" style="text-align: center;width:40%;">月份（年度：${bean.planYear }）</td>
                        </tr>
                        <tr>
                        	<c:forEach begin="1" end="12" var="d" step="1">
                        		<td style="text-align: center;">${d }</td>
                        	</c:forEach>
                        </tr>
                        <c:if test="${!empty details}">
                        	 <c:forEach items="${details }" var="it" varStatus="sta">
                       	 		<tr>
                       	 		  <td>${sta.index + 1}</td>
                       	 		  <td>${it.PROCEDURE }</td>
                       	 		  <td style="text-align:left;">${it.EQUIPMENT_NAME }</td>
                       	 		  <td>${it.EQUIPMENT_NO }</td>
                        	 	<c:forEach begin="1" end="12" var="d" step="1">
                        	 		<c:set var="groupK" value="${it.EQUIPMENT_ID }@${d }" />
                        	 		<td style="text-align: center;">${groupMap[groupK] }</td>
                        	 	</c:forEach>
                        	 	</tr>
                        	 </c:forEach>
                        </c:if>
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