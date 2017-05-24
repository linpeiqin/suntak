<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true" />
<head>
<title>扩展技术参数</title>
<%@ include file="/oz/includes/meta.jsp"%>
<oz:css />
<oz:css cssHref="/ems/common/css/ems-util.css" />
</head>
<body class="oz-body" data-name="扩展技术参数">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/technicalParamsAction">
			<oz:tbSeperator />
			<oz:tbButton id="btnSave" />
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="ems/technicalParamsAction" styleId="ozForm"
			styleClass="oz-form">
			<div class="ems-form-main">
				<div class="ems-form-content">
					<div class="oz-form-fields2">
						<table class="oz-form-bordertable" style="width: 97%;">
							<tr class="oz-form-emptyTR">
								<td width="30%"></td>
								<td width="70%"></td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">参数</td>
								<td class="oz-property">
									<html:text styleClass="oz-form-btField" property="technicalParam" styleId="technicalParam"  style="width:100%"></html:text>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">值</td>
								<td class="oz-property">
									<html:text styleClass="oz-form-btField" property="paramValue" styleId="paramValue" style="width:100%"></html:text>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<html:hidden property="id" styleId="id" />
			<html:hidden property="equipmentId" styleId="equipmentId" value="${equipmentId}"/>
		</html:form>
	</div>
</body>
<oz:js />
<oz:js jsSrc="/ems/common/js/common.util.js" />
</html>