<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.cmpn.ldap.config"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.cmpn.ldap.config"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ldap/ldapConfigAction">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="ldap/ldapConfigAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.cmpn.ldap.config"/></div>
			<div class="oz-form-fields">
				<table cellpadding="0">
					<tr class="oz-form-emptyTR"> 
						<td width="25%"></td>
						<td width="75%"></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.ldap.config.fields.enableflag"/>：</td>
						<td>
							<html:radio property="enabledFlag" styleId="enabledFlag" value="Y" disabled="true"/><oz:messageSource code="oz.enable"/>
							<html:radio property="enabledFlag" styleId="enabledFlag" value="N" disabled="true"/><oz:messageSource code="oz.disable"/>
						</td>
					</tr>
					<tr>
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.ldap.config.fields.domaincontroller"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="ldapConfigForm" property="domainController"/></span>
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.ldap.config.fields.namesuffix"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="ldapConfigForm" property="nameSuffix"/></span>
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.ldap.config.fields.username"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="ldapConfigForm" property="userName"/></span>
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.ldap.config.fields.userpwd"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="ldapConfigForm" property="userPwd"/></span>
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.ldap.config.fields.basedn"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="ldapConfigForm" property="baseDn"/></span>
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.ldap.config.fields.searchfilter"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="ldapConfigForm" property="searchFilter"/></span>
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.ldap.config.fields.ldaptype"/>：</td>
						<td class="oz-property">
							<html:select property="ldapType" styleId="ldapType" styleClass="egd-form-zdField" disabled="true" style="width:360px">
								<html:optionsCollection name="ldapTypes" label="name" value="value" />
							</html:select>
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.ldap.config.fields.loginattribute"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="ldapConfigForm" property="loginAttribute"/></span>
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.ldap.config.fields.mailattribute"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="ldapConfigForm" property="mailAttribute"/></span>
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.ldap.config.fields.dnattribute"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="ldapConfigForm" property="dnAttribute"/></span>
						</td>
					</tr>
				</table>			
			</div>
			<html:hidden property="id" styleId="id"/>
		</html:form>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
</script>
</html>