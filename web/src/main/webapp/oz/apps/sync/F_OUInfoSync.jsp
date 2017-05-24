<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true" tabs="true" richinput="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.organize.ouinfo"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.organize.ouinfo"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ldap/ouInfoSyncAction">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack" text="返回"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="ldap/ouInfoSyncAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.mdu.organize.ouinfo.unit"/></div>
			<div class="oz-form-fields">
				<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:800px;table-layout:fixed;border-top-width:0px">
					<tr class="oz-form-locate-tr">
						<td width="11%" style="border-left:1px solid white;border-right:0px solid white"></td>
						<td width="35%" style="border-right:0px solid white"></td>
						<td width="11%" style="border-right:0px solid white"></td>
						<td width="" style="border-right:1px solid white;"></td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.ouinfo.fields.name"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="ouInfoSyncForm" property="ouInfo.name"/></span>
						</td>
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.ouinfo.fields.abbrname"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="ouInfoSyncForm" property="adName"/></span>
						</td>
					</tr>
					<tr class="oz-form-tr"> 
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.ouinfo.fields.code"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="ouInfoSyncForm" property="mode" format="#"/></span>
						</td> 
						<td class="oz-form-label-r"><oz:messageSource code="oz.mdu.organize.ouinfo.fields.orderno"/>：</td>
						<td class="oz-property">
							<span class="oz-form-fields-span"><bean:write name="ouInfoSyncForm" property="notification" format="#"/></span>
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

$(function(){

});
</script>
</html>