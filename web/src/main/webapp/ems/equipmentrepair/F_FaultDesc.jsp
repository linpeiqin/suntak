<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
<title>数据字典</title>
<%@ include file="/oz/includes/meta.jsp"%>
<oz:css />
<oz:css cssHref="/ems/common/css/ems-util.css" />
<oz:css cssHref="/ems/common/css/ems-view.css" />
</head>
<body class="oz-body" data-name="数据字典">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/faultDescAction" defaultTB="readForm">
	</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="ems/faultDescAction" styleId="ozForm" styleClass="oz-form">
			<div class="ems-form-main">
				<div class="ems-form-content">
					<div class="oz-form-fields2">
						<table class="oz-form-bordertable" style="width: 99%">
							<tr class="oz-form-emptyTR">
								<td width="30%"></td>
								<td width="70%"></td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">故障分类</td>
								<td class="oz-property">
								<bean:write name="faultDescForm" property="faultTypeName" />
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">现象摘要</td>
								<td class="oz-property">
								<bean:write name="faultDescForm" property="appearanceSummary" />
								</td>
							</tr>
							<tr class="oz-form-tr" height="85px">
								<td class="oz-form-label-l" >现象详细</td>
								<td class="oz-property"  height="85px" >
								<bean:write name="faultDescForm" property="apearanceDetail" />
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">处理摘要</td>
								<td class="oz-property">
								<bean:write name="faultDescForm" property="dealSummary" />
								</td>
							</tr>
							<tr class="oz-form-tr"  >
								<td class="oz-form-label-l" height="85px">处理详细</td>
								<td class="oz-property" height="85px" >
								<bean:write name="faultDescForm" property="dealDetail" />
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
<oz:js jsSrc="/ems/equipmentrepair/js/ems.faultdesc.F.js" />
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<script type="text/javascript">
</script>
</html>