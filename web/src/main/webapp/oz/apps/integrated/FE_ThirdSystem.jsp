<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.mdu.integrated.thirdsystem"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="module/thirdSystemAction">
			<oz:tbButton id="btnBack"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnSave"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="module/thirdSystemAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.mdu.integrated.thirdsystem"/></div>
			<div class="oz-form-fields">
				<table cellpadding="0">
					<tr class="oz-form-emptyTR"> 
						<td width="120"></td>
						<td width="640"></td>
						<td></td>
					</tr>
					<logic:present parameter="editUrl">
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.integrated.thirdsystem.fields.name"/>：</td>
						<td class="oz-property">
							<html:text property="name" styleClass="oz-form-ztField" readonly="true"/>
						</td>
						<td></td>
					</tr>
					</logic:present>
					<logic:notPresent parameter="editUrl">
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.integrated.thirdsystem.fields.name"/>：</td>
						<td class="oz-property">
							<html:text property="name" styleClass="oz-form-btField"/>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.integrated.thirdsystem.fields.key"/>：</td>
						<td class="oz-property">
							<html:text property="key" styleClass="oz-form-btField"/>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label">管理员：</td>
						<td class="oz-property">
							<oz:acl entityClazz="cn.oz.module.integrated.domain.ThirdSystem" style="width:550px;float:left;" idid="id"></oz:acl>
						</td>
						<td></td>
					</tr>
					</logic:notPresent>
					<tr> 
						<td class="oz-form-topLabel"><oz:messageSource code="oz.mdu.integrated.thirdsystem.fields.loginurl"/>：</td>
						<td class="oz-property">
							<html:text property="loginUrl" styleClass="oz-form-btField"/>
							<p style="color: #999;">占位符说明：{0}为用户名称，{1}为用户密码。</p>
						</td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-topLabel"><oz:messageSource code="oz.mdu.integrated.thirdsystem.fields.description"/>：</td>
						<td class="oz-property">
							<html:textarea property="description"  rows="8" style="width:100%;" cols="80"></html:textarea>
						</td>
						<td></td>
					</tr>
				</table>			
			</div>
			<html:hidden property="id" styleId="id"/>
		</html:form>
	</div>
</body>
<oz:js/>
</html>