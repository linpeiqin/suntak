<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.mdu.security.permission"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body data-name="<oz:messageSource code="oz.mdu.security.permission"/>">
	<html:form action="app/permissionAction.do" styleId="ozForm" styleClass="oz-form">
		<div class="oz-form-title" style="width:100%;padding:0px;text-align:center;height:32px;"><oz:messageSource code="oz.mdu.security.permission"/></div>
		<div class="oz-form-fields" style="margin:4px;">
			<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:100%;margin:0;">
				<tr class="oz-form-tr">
					<td width="20%" class="oz-form-label-r"><oz:messageSource code="oz.mdu.security.permission.fields.code"/>：</td>
					<td width="80%" class="oz-property">
						${permission.code}
					</td>
				</tr>
				<tr class="oz-form-tr"> 
					<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.security.permission.fields.name"/>：</td>
					<td class="oz-property">
						${permission.name}
					</td>
				</tr>
				<tr class="oz-form-tr"> 
					<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.security.permission.fields.status"/>：</td>
					<td class="oz-property">
						<c:if test="${permission.enable}">
							<oz:messageSource code="oz.enable"/>
						</c:if>
						<c:if test="${!permission.enable}">
							<oz:messageSource code="oz.disable"/>
						</c:if>
					</td>
				</tr>
				<tr class="oz-form-tr"> 
					<td class="oz-form-topLabel-r"><oz:messageSource code="oz.mdu.security.permission.fields.description"/>：</td>
					<td class="oz-property">
						${permission.description}
					</td>
				</tr>
			</table>
		</div>	
		<html:hidden property="code" styleId="code"/>
	</html:form>
</body>
<oz:js/>
<script type="text/javascript">
function ozDlgOkFn(){
	return true;
}

$(function(){
	
});
</script>
</html>