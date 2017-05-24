<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" ex="oz-otabs"/>
<head>
	<title><oz:messageSource code="oz.mdu.organize.outype"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css />
</head>
<body class="oz-body" style="background-color:#FFFFFF;height:100%;width:100%;overflow:auto;border:none;margin:0px;padding:0px;">
	<div id="page" class="ui-tab">
		<div id="page-top" class="oz-page-top">
			<div id="triggers" class="ui-tab-trigger" style="height:28px;">
				<div class="ui-tab-trigger-inner">
					<ul>
						<li class="ui-tab-trigger-item"><a hidefocus="hideFocus" href="javascript:void(0)"><span id="myAppTitle"><oz:messageSource code="oz.mdu.organize.outype.unit"/></span></a></li>
						<li class="ui-tab-trigger-item"><a hidefocus="hideFocus" href="javascript:void(0)"><span id="myAppTitle"><oz:messageSource code="oz.mdu.organize.outype.department"/></span></a></li>
					</ul>
				</div>
			</div>
		</div>
		<div id="page-center" class="oz-page-center" style="overflow:hidden;position:relative;">
			<div class="ui-tab-container" id="views" style="height:100%">
				<div class="ui-tab-container-item" style="padding:0px">
					<iframe id="IFRAME_UNIT" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" src="<oz:contextPath/>/config/optionItemAction.do?action=display&groupCode=ORG_DWLX&unitId=-1">
					</iframe>									
				</div>
				<div class="ui-tab-container-item" style="padding:0px">
					<iframe id="IFRAME_DEPATMENT" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" src="<oz:contextPath/>/config/optionItemAction.do?action=display&groupCode=ORG_BMLX&unitId=-1">
					</iframe>
				</div>
			</div>
		</div>
	</div>	
</body>
<oz:js />
<script type="text/javascript">
function ozDlgOkFn(){	
	return true; 
}

$(function(){
	$(".ui-tab").oTabs().bind("select",function(e, index){
		_tabIndex = index;
	});
});	
</script>
</html>