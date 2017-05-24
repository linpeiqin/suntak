<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.cmpn.ad.config"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.cmpn.ad.config"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ad/winADConfigAction">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnSave"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="ad/winADConfigAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.cmpn.ad.config"/></div>
			<div class="oz-form-fields">
				<table cellpadding="0">
					<tr class="oz-form-emptyTR"> 
						<td width="25%"></td>
						<td width="40%"></td>
						<td width="35%"></td>
					</tr>					
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.ad.config.fields.adsso"/>：</td>
						<td>
							<html:radio property="adSSO" styleId="adSSO" value="Y"/><oz:messageSource code="oz.enable"/>
							<html:radio property="adSSO" styleId="adSSO" value="N"/><oz:messageSource code="oz.disable"/>
						</td>
						<td class="oz-guideline">
							&nbsp;
						</td>
					</tr>
					<tr id="TR_DC">
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.ad.config.fields.domaincontroller"/>：</td>
						<td class="oz-property">
							<html:text property="domainController" styleId="domainController" styleClass="oz-form-field"/>
						</td>
						<td class="oz-guideline">
							例如：192.168.0.1
						</td>
					</tr>
					<tr id="TR_WINS"> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.ad.config.fields.wins"/>：</td>
						<td class="oz-property">
							<html:text property="wins" styleId="wins" styleClass="oz-form-field"/>
						</td>
						<td class="oz-guideline">
							例如：192.168.0.1,192.168.0.2
						</td>
					</tr>
					<tr id="TR_DN">
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.ad.config.fields.domainname"/>：</td>
						<td class="oz-property">
							<html:text property="domainName" styleId="domainName" styleClass="oz-form-field"/>
						</td>
						<td class="oz-guideline">
							例如：OZ
						</td>
					</tr>
					<tr id="TR_UN">
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.ad.config.fields.username"/>：</td>
						<td class="oz-property">
							<html:text property="userName" styleId="userName" styleClass="oz-form-field"/>
						</td>
						<td class="oz-guideline">
						</td>
					</tr>
					<tr id="TR_UP">
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.ad.config.fields.userpwd"/>：</td>
						<td class="oz-property">
							<html:text property="userPwd" styleId="userPwd" styleClass="oz-form-field"/>
						</td>
						<td class="oz-guideline">
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