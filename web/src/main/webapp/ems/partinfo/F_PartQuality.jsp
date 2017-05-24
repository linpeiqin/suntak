<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true" />
<head>
<title>配件质量评价</title>
<%@ include file="/oz/includes/meta.jsp"%>
<oz:css />
<oz:css cssHref="/ems/common/css/ems-util.css" />
</head>
<body class="oz-body" data-name="配件质量评价">
<div id="page-top" class="oz-page-top">
	<oz:toolbar action="ems/partQualityAction" defaultTB="readForm">
	</oz:toolbar>
</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="ems/partQualityAction" styleId="ozForm"
			styleClass="oz-form">
			<div class="ems-form-main">
				<div class="ems-form-content">
					<div class="oz-form-fields2">
						<table class="oz-form-bordertable" style="width: 99%;height: 120px">
							<tr class="oz-form-emptyTR">
								<td width="20%"></td>
								<td width="30%"></td>
								<td width="20%"></td>
								<td width="30%"></td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">质量评价分类</td>
								<td class="oz-property" colspan="3">
									<bean:write name="partQualityForm" property="qualityTypeName"/>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">评价详细内容</td>
								<td class="oz-property" colspan="3">
									<bean:write name="partQualityForm" property="judgmentDetail"/>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">评价人</td>
								<td class="oz-property">
								<bean:write name="partQualityForm" property="createdBy"/>
								</td>
								<td class="oz-form-label-l">创建日期</td>
								<td class="oz-property">
								<bean:write name="partQualityForm" property="createdDate" format="yyyy-MM-dd"/>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<html:hidden property="id" styleId="id" />
			<html:hidden property="partId" styleId="partId"/>
		</html:form>
	</div>
</body>
<oz:js />
<oz:js jsSrc="/ems/common/js/common.util.js" />
<oz:js jsSrc="/ems/partinfo/js/ems.partQuality.F.js" />
</html>