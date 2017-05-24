<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true" easyui="true" />
<head>
<title>申购单</title>
<%@ include file="/oz/includes/meta.jsp"%>
<oz:css />
<oz:css cssHref="/ems/common/css/ems-util.css" />
<oz:css cssHref="/ems/common/css/ems-view.css" />
</head>
<body class="oz-body" data-name="申购单">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/pRHeadAction" defaultTB="readForm">
	</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="ems/pRHeadAction" styleId="ozForm" styleClass="oz-form">
				<div class="oz-form-fields2">
					<table class="oz-form-bordertable" style="width: 99%;height: 120px">
							<tr class="oz-form-emptyTR">
								<td width="20%"></td>
								<td width="30%"></td>
								<td width="20%"></td>
								<td width="30%"></td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">组织名称</td>
								<td class="oz-property">
									<bean:write name="pRHeadForm" property="orgName"  />
								</td>
								<td class="oz-form-label-l">单号 </td>
								<td class="oz-property">
									<bean:write name="pRHeadForm" property="prNo"/>
								</td>
								
					        </tr>
					        <tr class="oz-form-tr">
								<td class="oz-form-label-l">币种</td>
								<td class="oz-property">
								    <bean:write name="pRHeadForm" property="currencyName"/>
								</td>
								<td class="oz-form-label-l">汇率</td>
								<td class="oz-property">
								    <bean:write name="pRHeadForm" property="poRate" format="0.00"/>
								</td>
					        </tr>
					        <tr class="oz-form-tr">
								<td class="oz-form-label-l">申购部门</td>
								<td class="oz-property">
								    <bean:write name="pRHeadForm" property="deptName"/>
								</td>
								<td class="oz-form-label-l">申请人 </td>
								<td class="oz-property">
								    <bean:write name="pRHeadForm" property="applByName"/>
								</td>
					        </tr>
							<tr>
								<td class="oz-form-label-l">申购日期 </td>
								<td class="oz-property">
									<bean:write name="pRHeadForm" property="prDateStr"/>
								</td>
								<td class="oz-form-label-l"></td>
								<td class="oz-property">
								</td>
							</tr>
					        <tr class="oz-form-tr">
								<td class="oz-form-label-l">用处说明</td>
								<td class="oz-property" colspan="3">
								    <bean:write name="pRHeadForm" property="needReason"/>
								</td>
					        </tr>
						</table>
				</div>
			<div class="oz-form-tabs" style="margin-left: 6px;width:99%;height:322px;border: 1px solid #99BBE8" >
				<iframe id="IFRAME_01"  style="margin-right: 6px"  height="99%"width="100%" frameborder="0">
				</iframe>
			</div>
			<html:hidden property="id" styleId="id" />
		</html:form>
	</div>
</body>
<oz:js />
<oz:js jsSrc="/ems/common/js/common.util.js" />
<oz:js jsSrc="/ems/partinfo/js/ems.prhead.F.js"/>
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<script type="text/javascript">
</script>
</html>