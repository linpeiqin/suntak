<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" ex="oz-otabs"/>
<head>
	<title><oz:messageSource code="oz.config.optionitem"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css />
</head>
<body class="oz-body" style="background-color:#FFFFFF;height:100%;width:100%;overflow:auto;border:none;margin:0px;padding:0px;">
	<div id="page" class="ui-tab">
		<div id="page-top" class="oz-page-top">
			<div id="triggers" class="ui-tab-trigger" style="height:28px;">
				<div class="ui-tab-trigger-inner">
					<ul>
						<c:if test="${isUnitAdmin && isDM}">
							<li class="ui-tab-trigger-item"><a hidefocus="hideFocus" href="javascript:void(0)"><span id="myAppTitle">本单位数据</span></a></li>
						</c:if>
						<li class="ui-tab-trigger-item"><a hidefocus="hideFocus" href="javascript:void(0)"><span id="myAppTitle">系统默认数据</span></a></li>
					</ul>
				</div>
			</div>
		</div>
		<div id="page-center" class="oz-page-center" style="overflow:hidden;position:relative;">
			<table width="100%" height="100%">
				<tr>
					<td>
						<div class="ui-tab-container" id="views" style="height:100%;overflow: hidden;">
							<c:if test="${isUnitAdmin && isDM}">
								<div class="ui-tab-container-item" style="padding:0px;height:100%">
									<iframe id="IFRAME_OI_LOCAL" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" data-src="<oz:contextPath/>/config/optionItemAction.do?action=display&groupCode=${groupCode}&unitId=${unitId}">
									</iframe>									
								</div>
							</c:if>
							<div class="ui-tab-container-item" style="padding:0px;height:100%">
								<iframe id="IFRAME_OI_DEFAULT" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" data-src="<oz:contextPath/>/config/optionItemAction.do?action=display&groupCode=${groupCode}&unitId=-1">
								</iframe>
							</div>
						</div>		
					</td>
				</tr>
				<tr height="32px">
					<td>
						<div style="border-bottom:1px solid #99BBE8;height:100%;background-color:#EEEEEE;color:gray;padding:6px">
							配置说明：对于分级管理的配置项，如果本单位没有配置数据则使用系统默认数据；其它则统一使用系统默认数据。
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>	
</body>
<oz:js />
<script type="text/javascript">
function ozDlgOkFn(){	
	return true; 
}

$(function(){
	$(".ui-tab").oTabs().bind("select",function(e, index, tab, view){
		_tabIndex = index;
		var i = $("iFrame",view);
		if(i.data("loaded") === true){
			return;
		}
		i.attr("src",i.data("src"));
		i.data("loaded",true);
	});
});	
</script>
</html>