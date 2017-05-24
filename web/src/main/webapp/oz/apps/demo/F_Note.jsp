<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="cn.demo.note"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="cn.demo.note"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="demo/noteAction">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack" text="返回"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="demo/noteAction.do" styleId="ozForm" styleClass="oz-form">
			<!-- 标题  -->
			<div class="oz-form-title"><oz:messageSource code="cn.demo.note"/></div>
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
							<html:text property="title" styleClass="oz-form-zdField" readonly="true"/>
						</td>
					</tr>
					<tr>
						<td class="oz-form-label">内&nbsp;&nbsp;&nbsp;&nbsp;容：</td>
						<td class="oz-property">
							<html:textarea property="content" styleClass="oz-form-zdField" readonly="true"></html:textarea>
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