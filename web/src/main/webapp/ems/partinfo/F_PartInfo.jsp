<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true" />
<head>
<title>配件详细信息表</title>
<%@ include file="/oz/includes/meta.jsp"%>
<oz:css />
<oz:css cssHref="/ems/common/css/ems-util.css" />
</head>
<body class="oz-body" data-name="配件详细信息表">
	<div id="page-center" class="oz-page-form">
		<html:form action="ems/partInfoAction" styleId="ozForm"
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
								<td class="oz-form-label-l">配件名称</td>
								<td class="oz-property" colspan="3">
									<bean:write name="partInfoForm" property="partName"/>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">大类</td>
								<td class="oz-property">
									<bean:write name="partInfoForm" property="category1"/>
								</td>
								<td class="oz-form-label-l">小类</td>
								<td class="oz-property">
									<bean:write name="partInfoForm" property="category2"/>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">配件编号</td>
								<td class="oz-property">
									<bean:write name="partInfoForm" property="partNo"/>
								</td>
								<td class="oz-form-label-l">计量单位</td>
								<td class="oz-property">
									<bean:write name="partInfoForm" property="countUnits"/>
								</td>
							</tr>
							<tr class="oz-form-tr">
								<td class="oz-form-label-l">当前库存</td>
								<td class="oz-property">
									<bean:write name="partInfoForm"
										property="currentInventory"  format="0"/>
								</td>
								<td class="oz-form-label-l">单价</td>
								<td class="oz-property">
								<bean:write name="partInfoForm"
										property="price"   format="0.00"/>
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
<oz:js jsSrc="/ems/partinfo/js/ems.partinfo.F.js" />
</html>