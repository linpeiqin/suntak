<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.web.uicomponent"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssId="oz-app-icon"/> 
</head>
<body data-name="<oz:messageSource code="oz.web.uicomponent"/>">
	<html:form action="app/uicomponentAction.do" styleId="ozForm" styleClass="oz-form">
		<div class="oz-form-title" style="width:100%;padding:0px;text-align:center;height:32px;"><oz:messageSource code="oz.web.uicomponent"/></div>
		<div class="oz-form-fields" style="margin:4px;">
			<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:100%;margin:0;">
				<tr class="oz-form-tr">
					<td width="90px" class="oz-form-label-r"><oz:messageSource code="oz.web.uicomponent.fields.code"/>：</td>
					<td class="oz-property">
						${uiComponent.id}
					</td>
				</tr>
			
				<tr class="oz-form-tr">
					<td class="oz-form-label-r"><oz:messageSource code="oz.web.uicomponent.fields.name"/>：</td>
					<td class="oz-property">
						<span class="app-icon ${uiComponent.icon}"></span>&nbsp;${uiComponent.name}
					</td>
				</tr>
				<tr class="oz-form-tr">
					<td class="oz-form-label-r"><oz:messageSource code="oz.web.uicomponent.fields.type"/>：</td>
					<td>
						<c:if test="${uiComponent.UIComponentType=='widget'}">
							<oz:messageSource code="oz.web.uicomponent.widget"/>
						</c:if>
						<c:if test="${uiComponent.UIComponentType=='shortcut'}">
							<oz:messageSource code="oz.web.uicomponent.shortcut"/>
						</c:if>
						<c:if test="${uiComponent.UIComponentType=='navigation'}">
							<oz:messageSource code="oz.web.uicomponent.navigation"/>
						</c:if>
					</td>
				</tr>
				<tr class="oz-form-tr">
					<td class="oz-form-label-r"><oz:messageSource code="oz.web.uicomponent.fields.url"/>：</td>
					<td class="oz-property">
						${uiComponent.url}
					</td>
				</tr>
				<c:if test="${componentType=='shortcut'}">
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.web.uicomponent.fields.theme"/>：</td>
						<td class="oz-property">
							${uicomponent.theme}
						</td>
					</tr>
				</c:if>
				<c:if test="${componentType=='widget'}">
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.web.uicomponent.fields.width"/>：</td>
						<td class="oz-property">
							${uiComponent.width}
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.web.uicomponent.fields.height"/>：</td>
						<td class="oz-property">
							${uiComponent.height}
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.web.uicomponent.fields.showmoreicon"/>：</td>
						<td>
							<c:if test="${uiComponent.showMoreIcon}">
								<oz:messageSource code="oz.web.display"/>
							</c:if>
							<c:if test="${!uiComponent.showMoreIcon}">
								<oz:messageSource code="oz.web.hidden"/>
							</c:if>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.web.uicomponent.fields.showrefreshicon"/>：</td>
						<td>
							<c:if test="${uiComponent.showRefreshIcon}">
								<oz:messageSource code="oz.web.display"/>
							</c:if>
							<c:if test="${!uiComponent.showRefreshIcon}">
								<oz:messageSource code="oz.web.hidden"/>
							</c:if>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.web.uicomponent.fields.morehref"/>：</td>
						<td class="oz-property">
							${uiComponent.moreHref}
						</td>
					</tr>
				</c:if>
				<tr class="oz-form-tr">
					<td class="oz-form-label-r"><oz:messageSource code="oz.web.uicomponent.fields.accesscontrol"/>：</td>
					<td class="oz-property">
						<logic:present name="grants">
							<logic:iterate id="grant" name="grants" indexId="index">
								<span style="font-weight:bold;"><bean:write name="grant" property="grantType"/></span>:
								<bean:write name="grant" property="permissions"/><br/>
							</logic:iterate>
						</logic:present>
					</td>
				</tr>
				<tr class="oz-form-tr">
					<td class="oz-form-label-r"><oz:messageSource code="oz.web.uicomponent.fields.accesscontrolclazz"/>：</td>
					<td class="oz-property">
						${uiComponent.accessControlClazz}
					</td>
				</tr>
				<tr class="oz-form-tr">
					<td class="oz-form-label-r"><oz:messageSource code="oz.web.uicomponent.fields.description"/>：</td>
					<td class="oz-property">
						${uiComponent.description}
					</td>
				</tr>
			</table>
		</div>	
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