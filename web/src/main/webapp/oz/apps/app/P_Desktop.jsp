<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="page"/>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
	<title><oz:systemConfiguration key="system.title" />--<oz:systemConfiguration key="system.version.no" /></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css cssHref="/oz/webui/bootstrap/2.0.4/css/bootstrap.css" />
	<oz:css cssHref="/oz/webui/jquery-plugins/gridster/0.1.0/jquery.gridster.css" />
	<oz:css cssHref="/oz/apps/app/css/sprite.css" />
	<oz:css cssHref="/oz/apps/app/css/desktop.css" />
	<oz:css cssHref="/oz/apps/app/css/desktopEx.css" />
	<oz:css cssHref="/oz/apps/app/css/widget.css" />
	<oz:css cssHref="/oz/apps/app/css/icon.css" />
</head>
<body>
	<div id="desktop">
		<div id="desktopWrapper"></div>
		<div id="navbar" style="left:428px; width:212px;">
			<div class="indicator-wrapper">
				<div id="indicatorContainer" class="indicator-container nav-current-3">
					<a class="indicator indicator-1" href="###" hidefocus="true" customacceptdrop="1" cmd="switch" index="0" title="桌面1">
						<span class="indicator-icon-bg"></span>
						<span class="indicator-icon indicator-icon-1">1</span>
					</a> 
					<a class="indicator indicator-2" href="###" hidefocus="true"	customacceptdrop="1" cmd="switch" index="1" title="桌面2">
						<span class="indicator-icon-bg"></span>
						<span class="indicator-icon indicator-icon-2">2</span>
					</a>
					<a class="indicator indicator-3" href="###" hidefocus="true" customacceptdrop="1" cmd="switch" index="2" title="桌面3">
						<span class="indicator-icon-bg"></span>
						<span class="indicator-icon indicator-icon-3">3</span>
					</a>
					<a class="indicator indicator-4" href="###" hidefocus="true" customacceptdrop="1" cmd="switch" index="3" title="桌面4">
						<span class="indicator-icon-bg"></span>
						<span class="indicator-icon indicator-icon-4">4</span>
					</a>
					<a class="indicator indicator-5" href="###" hidefocus="true" customacceptdrop="1" cmd="switch" index="4" title="桌面5">
						<span class="indicator-icon-bg"></span>
						<span class="indicator-icon indicator-icon-5">5</span>
					</a>
					<a class="indicator indicator-edit" href="###" hidefocus="true" cmd="edit" title="编辑"></a>
					<a class="indicator indicator-manage" href="###" hidefocus="true" cmd="manage" title="全局视图"></a>
				</div>
			</div>
		</div>
	</div>	
</body>
<oz:js/>
<oz:js jsSrc="/oz/webui/jquery-plugins/gridster/0.1.0/jquery.gridster.js"/>
<oz:js jsSrc="/oz/apps/app/js/desktop.js"/>
<oz:js jsId="jquery-json"/>
<script type="text/javascript">
// TODO 任务：
// 1. 更多图标的处理;
// 2. Widget图标;
// 3. 待办文件的样式;
// 4. 今日日程的样式;

function refresh(data){
	data.widgetId && window[data.widgetId] && window[data.widgetId].widget && window[data.widgetId].widget.load();
}

var desktopConfigs = {
	items : <%= request.getAttribute("desktopData") %>,
	gridster : {
		widget_margins : [ 16, 5 ],
		widget_base_dimensions : [ 130, 130 ],
		min_cols : 6,
		min_rows : 20
	}
};

$(function() {
	$.desktopManager = new $.app.desktopManager(desktopConfigs);
	$.desktopManager.setEdit(false);
});
</script>
</html>