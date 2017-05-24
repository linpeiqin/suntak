<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.module.example.domain.Example"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.module.example.domain.Example"/>">
	<div id="page-top" class="oz-page-top">
		<!-- 工具条 -->
		<oz:toolbar action="module/exampleAction">
			<oz:tbSeperator></oz:tbSeperator>
			<!-- 工具条按钮 -->
			<oz:tbButton id="btnBack" text="返回"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="module/exampleAction.do" styleId="ozForm" styleClass="oz-form">
			<!-- 标题  -->
			<div class="oz-form-title"><oz:messageSource code="oz.module.example.domain.Example"/></div>
			<!-- 表单域  -->
			<div class="oz-form-fields">
				<table cellpadding="0" >
					<tr class="oz-form-emptyTR"> 
						<th width="80"></th>
						<th width="720"></th>
					</tr>
					<tr>
						<td class="oz-form-label">标&nbsp;&nbsp;&nbsp;&nbsp;题：</td>
						<td class="oz-property">
							<html:text property="subject" styleClass="oz-form-zdField" readonly="true"/>
						</td>
					</tr>
				</table>			
			</div>
			<html:hidden property="id" styleId="id"/>
		</html:form>
	</div>
</body>
<oz:js/>
</html>