<!DOCTYPE HTML >
<%@page import="cn.oz.web.util.RequestUtils"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
<title>Tiff查看器</title>
<%@ include file="/oz/includes/meta.jsp"%>
<oz:css />
<style type="text/css">
.page-element {
	padding: 24px 0;
}
.page-image {
	border: 1px #DADADA solid;
	cursor: text;
	margin: 0 8px;
}
.goog-inline-block {
	position: relative;
	display: -moz-inline-box;
	display: inline-block;
}
#page-center {
	background-color: #EBEBEB;
	border: 0;
	height: 100%;
	outline: none;
	overflow: auto;
	text-align: center;
	width: 100%;
}
#content-pane {
	text-align: center;
}
</style>
<style type="text/css" media="print">
.page-image {
	border: 0;
	margin: 0;
}
.oz-page-top{
	display: none;
}
</style>
</head>
<body class="oz-body" >
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="form/designerAction" searchButton="none" svFlag="true">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnZoomIn" text="放大" icon="oz-icon-0936" onclick="zoom(200)"/>
			<oz:tbButton id="btnZoomOut" text="缩小" icon="oz-icon-0935" onclick="zoom(-200)"/>
			<oz:tbButton id="btnZoomReset" text="默认" icon="oz-icon-0925" onclick="resetzoom()"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnDownFile" text="下载" icon="oz-icon-1128" onclick="downfile()"/>
			<!-- oz:tbButton id="btnDownFile" text="打印" icon="oz-icon-0835" onclick="printfile()" -->
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<div id="page-pane">
		
		</div>
	</div>
</body>
<oz:js />
<oz:js jsId="jquery-lazyload"/>
<script type="text/javascript">
	var displayData = <%=request.getAttribute("displayData")%>;
	var width = 700;
	$(function(){
		width = ($("#page-pane").width()-60);
		if(width > 1400){
			width = parseInt(width / 2);
		}
		if(displayData){
			var height = parseInt(width * displayData.thHeight / displayData.thWidth);
			for(var i=1;i<=displayData.numPages;i++){
				var src = '?action=page&path='+encodeURIComponent(displayData.path)+'&page='+i+'&code='+displayData.code;
				$("#page-pane").append('<div class="page-element goog-inline-block" style="width:'+(width+20)+'px;" data-page="'+i+'""><img class="page-image" src="'+contextPath+'/oz/webui/oz/images/transparent.gif" data-original="'+src+'" style="width:'+width+'px;height:'+height+'px"></div>');
			}
			$(".page-image").lazyload({container:"#page-center",load:function(){
				$(this).css("height","");
				$(this).attr("loaded","true");
			}});
		}
		$(window).resize(function(){
			width = ($("#page-pane").width()-60);
			if(width > 1400){
				width = width / 2;
			}
			refresh();
		});
	});
	function resetzoom(){
		width = ($("#page-pane").width()-60);
		if(width > 1400){
			width = parseInt(width / 2);
		}
		refresh();
	}
	function zoom(z){
		width = width + z;
		refresh();
	}
	function downfile(){
		var src = '?action=down&path='+encodeURIComponent(displayData.path);
		window.open(src);
	}
	function printfile(){
		$("#page-center").css("height","auto");
		$(".page-element,.page-image").css("width","100%");
		$(".page-image").trigger("appear");
		window.print();
		$(window).resize();
	}
	function refresh(){
		var height = parseInt(width * displayData.thHeight / displayData.thWidth);
		$(".page-image").width(width).not(function(){return this.loaded==true}).height(height);
		$(".page-element").width(width+20);
		$("#page-pane").trigger("scroll");
	}
</script>
</html>