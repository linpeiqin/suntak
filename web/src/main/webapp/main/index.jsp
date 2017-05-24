<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="cn.oz.web.util.RequestUtils"%>
<%@page import="cn.oz.organize.UserInfo"%>
<%@page import="java.util.List"%>
<%@page import="cn.oz.UserContextHolder"%>
<%@page import="cn.oz.UserContext"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="mainPage" ex="oz-otabs" />
<html>
<head>
<title><oz:systemConfiguration key="system.title" />--<oz:systemConfiguration key="system.version.no" /></title>
<meta name="keywords" content="OzFM" />
<meta name="description" content="崇达设备管理（ems）"/>
<meta name="copyright" content="OZ Wizards Group Copyright (c) 2014" />
<%@ include file="/oz/includes/meta.jsp"%>
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<oz:css />
<oz:css cssHref="/main/themes/default/icon.css" />
<oz:css cssHref="/main/themes/default/menu.css" />
<oz:css cssHref="/main/themes/default/index.css" />
<oz:css cssHref="/main/themes/default/nav-tree.css" />
<oz:css cssHref="/main/themes/default/loading.css" />
<oz:css cssHref="/oz/webui/oz/css/oz-icons.css"/>
</head>
<body style="overflow: hidden;">
    <div id="loadingCover" style="width: 100%; height: 100%;">
        <div id="loadingLogo"></div>
        <div id="loadingText">Loading ...</div>
        <div id="loadingBarContainer">
            <div id="loadingBar" style="width: 0%;"></div>
        </div>
        <div id="loadingTips">0%</div>
    </div>
    <div id="mainPage">
        <div class="oz-layout-west main-left"  data-layout-region='{"noheader":false,"collapsible":true,"margins":"0 1 0 0","title":"功能菜单","width":180}'>
           <ul id="permissionTree"></ul>
        </div>
        <div class="oz-layout-center" data-layout-region='{"margins":"0 0 0 0","border":false}' style="overflow: hidden;">
            <div id="mainTabs" data-tabs='{"fit":true}' style="display: none"></div>
        </div>
    </div>
    <iframe id="blank" name="blank" style="width: 0; height: 0; visibility: hidden;" src="about:blank" scrolling="no" frameborder="0"></iframe>
    <div id="menu" class="contextmenu ozpanel_shadow " tabindex="0">
        <ul>
			<li class="closeMenu"><a href="#close" ><b class="oz-icon" ></b>关闭</a></li>
			<li class="closeOtherMenu"><a href="#closeOther" ><b class="oz-icon"></b>关闭其他</a></li>
			<li class="closeAllMenu"><a href="#closeAll" ><b class="oz-icon" ></b>关闭所有</a></li>
        </ul>
    </div>
</body>
<script>
var _redirectUrl = "<%=request.getAttribute("redirectUrl")%>";
var _tabs = "<%=RequestUtils.getStringParameter(request, "tabs", "")%>";
var _urls = "<%=RequestUtils.getStringParameter(request, "urls", "")%>";
var _titles = "<%=RequestUtils.getStringParameter(request, "titles", "")%>";
var indexMaxWidth = "<oz:systemConfiguration key="system.index.maxwidth"/>";
</script>
<oz:js />
<oz:js jsSrc="/oz/webui/oz/page/oz.template.index.js" />
<oz:js jsSrc="/main/js/oz.page.index.js" />
<script type="text/javascript">

$(function() {
	var pageIndex = oz.page.index;
	pageIndex.setMaxWidth(indexMaxWidth);
	pageIndex.setProcess("0%");
	// 布局
	$("#mainPage").layout();
	pageIndex.setProcess("5%");
	// 调整布局
	pageIndex.resize();
	// 加载主页面
	pageIndex.initAppTab();
	pageIndex.setProcess("40%");
	// 加载导航权限
	pageIndex.initNavTree();
	// 初始化右键菜单
	pageIndex.initAppTabMenu();
	pageIndex.setProcess("80%");

	// 初始化切换用户操作
	pageIndex.initSwitchUser();
	// 初始化Tab的辅助操作
	pageIndex.initAppTabHelper();
	// 定义窗口调整方法
	$(window).resize(pageIndex.resize);
	pageIndex.setProcess("100%");
	$("#loadingCover").fadeOut(1500);
	// 打开初始的页面
	pageIndex.openInitTab();
});

</script>
</html>