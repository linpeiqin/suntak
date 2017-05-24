<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.mdu.security.usermapping"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.security.usermapping"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="security/userMappingAction" defaultTB="readForm">
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="security/userMappingAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.mdu.security.usermapping"/></div>
			<div class="oz-form-fields">
				<table cellpadding="0">
					<tr class="oz-form-emptyTR"> 
						<td width="180"></td>
						<td width="360"></td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.security.usermapping.fields.systemid"/>：</td>
						<td class="oz-property">
							<logic:empty name="thirdSystemOptions">
								<html:text property="mappingSystemId" styleId="mappingSystemId" styleClass="oz-form-zdField" readonly="true"/>							
							</logic:empty>
							<logic:notEmpty name="thirdSystemOptions">
								<html:select property="mappingSystemId" styleId="mappingSystemId"  styleClass="oz-form-zdField" disabled="true">
									<html:optionsCollection name="thirdSystemOptions" label="name"  value="value" />
								</html:select>
							</logic:notEmpty>						
						</td>
						<td>
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.security.usermapping.fields.loginname"/>：</td>
						<td class="oz-property">
							<html:text property="mappingLoginName" styleId="mappingLoginName" styleClass="oz-form-zdField" readonly="true"/>						
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.security.usermapping.fields.loginurl"/>：</td>
						<td class="oz-property">
							<html:text property="loginUrl" styleId="loginUrl" styleClass="oz-form-zdField" readonly="true"/>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-topLabel"><oz:messageSource code="oz.mdu.security.usermapping.fields.memos"/>：</td>
						<td class="oz-property">
							<html:textarea property="memos" styleClass="oz-form-zdField" rows="2" readonly="true"/>
						</td>
						<td></td>
					</tr>
				</table>			
			</div>
			<html:hidden property="id" styleId="id"/><html:hidden property="loginName" styleId="loginName"/>
			<html:hidden property="mappingUserId" styleId="mappingUserId"/>
			<html:hidden property="mappingUserName" styleId="mappingUserName"/>
			<html:hidden property="mappingPassword" styleId="mappingPassword"/>
		</html:form>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
$(function(){
	
});
</script>
</html>