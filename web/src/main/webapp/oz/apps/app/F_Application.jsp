<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" tabs="true" ex="oz-otabs"/>
<head>
	<title><oz:messageSource code="oz.web.application"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssId="oz-app-icon"/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.security.permission"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="app/applicationAction">
			<oz:tbSeperator/>
			<oz:tbButton id="btnBack"/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="app/applicationAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.mdu.security.permission"/></div>
			<div class="oz-form-fields" style="margin:4px;">
				<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:100%;margin:0;">
					<tr class="oz-form-tr">
						<td width="12%" class="oz-form-label-r"><oz:messageSource code="oz.web.application.fields.name"/>：</td>
						<td width="38%" class="oz-property">
							<span class="app-icon ${OZ_DOMAIN.icon}"></span>&nbsp;${OZ_DOMAIN.name}
						</td>
						<td width="12%" class="oz-form-label-r"><oz:messageSource code="oz.web.application.fields.version"/>：</td>
						<td width="38%" class="oz-property">
							${OZ_DOMAIN.version}
						</td>
					</tr>
					<tr class="oz-form-tr"> 
						<td class="oz-form-label-r"><oz:messageSource code="oz.web.application.fields.description"/>：</td>
						<td class="oz-property" colspan="3" >
							${OZ_DOMAIN.description}
						</td>
					</tr>
				</table>
			</div>
			<div class="ui-tab" style="margin:4px;border:1px solid #8DB2E3;border-bottom:0px solid #8DB2E3">	
				<div id="triggers" class="ui-tab-trigger" style="height:auto">
					<div class="ui-tab-trigger-inner">
						<ul>
							<li class="ui-tab-trigger-item" data-id="tab_01"><a hidefocus="hideFocus" href="javascript:void(0)"><span><oz:messageSource code="oz.web.application.tabs.permission"/></span></a></li>
							<li class="ui-tab-trigger-item" data-id="tab_02"><a hidefocus="hideFocus" href="javascript:void(0)"><span><oz:messageSource code="oz.web.application.tabs.uicomponents"/></span></a></li>
							<li class="ui-tab-trigger-item" data-id="tab_03"><a hidefocus="hideFocus" href="javascript:void(0)"><span><oz:messageSource code="oz.web.strategy"/></span></a></li>
							<li class="ui-tab-trigger-item" data-id="tab_04"><a hidefocus="hideFocus" href="javascript:void(0)"><span><oz:messageSource code="oz.web.application.tabs.documenttypes"/></span></a></li>
							<li class="ui-tab-trigger-item" data-id="tab_05"><a hidefocus="hideFocus" href="javascript:void(0)"><span><oz:messageSource code="oz.web.application.tabs.schedulejobs"/></span></a></li>
							<li class="ui-tab-trigger-item" data-id="tab_06"><a hidefocus="hideFocus" href="javascript:void(0)"><span><oz:messageSource code="oz.web.application.tabs.constants"/></span></a></li>
						</ul>
					</div>
				</div>
				<div class="ui-tab-container">
					<div class="ui-tab-container-item" style="line-height:1px;overflow:hidden;height:420px">
						<iframe id="IFRAME_01" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" src="<oz:contextPath/>/app/permissionAction.do?action=display&appId=${appId}">
						</iframe>
					</div>
					<div class="ui-tab-container-item" style="line-height:1px;overflow:hidden;height:420px">
						<iframe id="IFRAME_02" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" src="<oz:contextPath/>/app/uicomponentAction.do?action=display&appId=${appId}">
						</iframe>
					</div>
					<div class="ui-tab-container-item" style="line-height:1px;overflow:hidden;height:420px">
						<iframe id="IFRAME_03" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" src="<oz:contextPath/>/app/strategyAction.do?action=display&appId=${appId}">
						</iframe>
					</div>
					<div class="ui-tab-container-item" style="line-height:1px;overflow:hidden;height:420px">
						<iframe id="IFRAME_04" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" src="<oz:contextPath/>/app/documentTypeAction.do?action=display&appId=${appId}">
						</iframe>
					</div>
					<div class="ui-tab-container-item" style="line-height:1px;overflow:hidden;height:420px">
						<iframe id="IFRAME_05" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" src="<oz:contextPath/>/app/scheduleJobAction.do?action=display&appId=${appId}">
						</iframe>
					</div>
					<div class="ui-tab-container-item" style="line-height:1px;overflow:hidden;height:420px">
						<iframe id="IFRAME_06" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" src="<oz:contextPath/>/app/appConstAction.do?action=display&appId=${appId}">
						</iframe>
					</div>
				</div>
			</div>
			<html:hidden property="id" styleId="id"/><html:hidden property="name" styleId="name"/>
		</html:form>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
$(function(){
	$(".ui-tab").oTabs();
});
</script>
</html>