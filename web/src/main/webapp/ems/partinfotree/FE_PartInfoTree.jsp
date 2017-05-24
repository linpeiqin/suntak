<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" />
<head>
	<title>配件关联树</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssHref="/ems/common/css/ems-util.css" />
	<style type="text/css">
		ul,li{margin:0px;padding:0px;}  
.slDiv{float:left;margin-top:5px;position:relative;}  
.slDiv #btnSelect{background:url("../images/selAppear.png") right no-repeat;width:125px;display:inline-block;text-indent:10px;}  
.slDiv .ulDiv{display:none;width:125px;border:1px solid #EEEEEE;border-radius:1px;background:#FFF;margin-top:8px;position:absolute;z-index:100;}  
.slDiv .ulDiv.ulShow{display:block;}  
.slDiv .ulDiv ul li{text-indent:10px;cursor:pointer;}  
.slDiv .ulDiv ul li:hover{background:#cbebf6;}  
	</style>
</head>
<body class="oz-body" data-name="配件关联树">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/partInfoTreeAction" defaultTB="editForm">
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="ems/partInfoTreeAction" styleId="ozForm" styleClass="oz-form">
			<div class="ems-form-main">
				<div class="ems-form-content">
					<div class="oz-form-fields2">
						<table  class="oz-form-bordertable" style="width: 97%;height: 130px">
							<tr  class="oz-form-tr">
								<td class="oz-form-label-l">上级设备或备件：</td>
								<td class="oz-property">
									<span class="oz-form-fields-span"><bean:write name="partInfoTreeForm" property="parentName"/></span>
									<input type="hidden" name="parentEqId" value="parent.equipmentId" />
								</td>
							</tr>

							<tr class="oz-form-tr">
								<td class="oz-form-label-l">是否专属：</td>
								<td>
									<html:radio property="isExclusive" styleId="radio11" value="1"/><label for="radio11" style="width:30px;">是</label>
									<html:radio property="isExclusive" styleId="radio12" value="0"/><label for="radio12" style="width:30px;">否</label>
								</td>
							</tr>
							<logic:equal name="partInfoTreeForm" property="type" value="0">
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">设备名称：</td>
								<td class="oz-property">
									<span id="equipmentNameSpan" style="float:left;width:70%">
									<bean:write name="partInfoTreeForm" property="name"/>
									</span>
									<input  type="button" class="oz-form-button" id="equipmentNameB" onclick="onSelectEquipment()" style="float:right;width:62px;height:21px;" value="选择设备"/>
									<html:hidden property="equipmentId" styleId="equipmentId" />
								</td>
							</tr>
							</logic:equal>
							<logic:equal name="partInfoTreeForm" property="type" value="1">
								<tr  class="oz-form-tr">
									<td class="oz-form-label-l">配件名称：</td>
									<td class="oz-property">
										<span id="partNameSpan" style="float:left;width:70%">
										<bean:write name="partInfoTreeForm" property="name"/>
										</span>
										<input  type="button" class="oz-form-button" id="partNameB" onclick="onsSelectPart()" style="float:right;width:62px;height:21px;" value="选择配件"/>
										<html:hidden property="partId" styleId="partId" />
									</td>
								</tr>
								<tr class="oz-form-tr">
									<td class="oz-form-label-l">分段：</td>
									<td class="oz-property">
										<div class="slDiv">  
										<html:text property="section" styleId="section" />
										  <div class="ulDiv">  
										    <ul>  
										      <c:forEach items="${sections }" var="section">
										       <li>${section.name }</li>  
										      </c:forEach>
										    </ul>  
										  </div>  
										</div>
									</td>
								</tr>
							</logic:equal>
							<logic:notEmpty name="partInfoTreeForm" property="parentName">
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">数量：</td>
								<td class="oz-property">
									<html:text property="qty" styleId="qty" styleClass="oz-form-btField formatToInt"/>
								</td>
							</tr>
							</logic:notEmpty>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">使用周期（月）：</td>
								<td class="oz-property">
									<html:text property="usePeriod" styleId="usePeriod" styleClass="oz-form-btField formatToInt"/>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<html:hidden property="id" styleId="id"/>
			<html:hidden property="parent.id" styleId="parent_id"/>
			<html:hidden property="type" styleId="type"/>
			<html:hidden property="organizationId" styleId="organizationId"/>
		</html:form>
	</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js" />
<script type="text/javascript">
$('.slDiv #section').on('click',function(){  
	  $(this).siblings('.ulDiv').toggleClass('ulShow');  
	});  
	$('.slDiv .ulDiv ul li').on('click',function(){
	  var selTxt=$(this).text();  
	  $('#section').val(selTxt);  
	  $('.ulDiv').removeClass('ulShow');  
	});
</script>
</html>