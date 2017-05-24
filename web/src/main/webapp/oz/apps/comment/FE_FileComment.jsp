<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true" attachment="true"/>
<head>
	<title>编辑意见</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="module/commentAction">
			<oz:tbButton id="btnBack"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnSave"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="module/commentAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title">批示语</div>
			<div class="oz-form-fields">
				<table cellpadding="0">
					<tr class="oz-form-emptyTR"> 
						<td width="120"></td>
						<td width="640"></td>
						<td></td>
					</tr>
					<tr> 
						<td class="oz-form-label">批示语：</td>
						<td class="oz-property">
							<html:text property="comment" styleClass="oz-form-btField"/>
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
<script type="text/javascript">
</script>
</html>