<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" ex="bootstrap"/>
<head>
	<title>系统管理员工具</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>	
</head>
<body class="oz-body" data-name="系统管理员工具">
<div id="page" class="oz-page">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="admin/sysAdminToolsAction">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<div style="margin:10px;">
			<span style="font-weight:bold;font-size:18px">&nbsp;组织架构</span>
			<hr style="margin:0px;border-top:2px solid #EEEEEE">
			<div style="margin:4px">
				<button class="btn btn-primary btn-small" type="button" onclick="onBtnRebuildFullInfo_Clicked();">重新计算组织架构的全称和全编码</button>
			</div>
		</div>
		<div style="margin:10px;">
			<span style="font-weight:bold;font-size:18px">&nbsp;服务器信息</span>
			<hr style="margin:0px;border-top:2px solid #EEEEEE">
			<div style="margin:4px">
				<button class="btn btn-primary btn-small" type="button" onclick="onBtnGetServerCode_Clicked();">服务器机器码</button>
			</div>
		</div>
		<div style="margin:10px;">
			<span style="font-weight:bold;font-size:18px">&nbsp;打开测试页面</span>
			<hr style="margin:0px;border-top:2px solid #EEEEEE">
			<div style="margin:4px">
				<input id="testPageUrl" name="testPageUrl" style="width:320px">
				<button class="btn btn-primary btn-small" type="button" onclick="onBtnTestPageGo_Clicked();">打开</button>
			</div>
		</div>
	</div>
</div>
</body>
<oz:js/>								
<script type="text/javascript">
function onBtnRebuildFullInfo_Clicked(){
	OZ.Msg.confirm(
		'重新计算组织架构的全称/全编码等信息会耗费一定的时间,您确认执行吗?',
		function(){
			if(!$(".oz-body").isMasked())
				$(".oz-body").mask('系统正在努力处理，请稍候...');
			$.getJSON(
				contextPath + "/organize/ouInfoAction.do?action=rebuildFullInfos&timeStamp=" + new Date().getTime(),
				{},
				function(json){
					OZ.Msg.info('系统重新计算完毕', null, function(){
						$(".oz-body").unmask();
						OZ.View.reload();
					});
				}
			);
		}
	);
}

function onBtnGetServerCode_Clicked(){
	var strUrl = contextPath + "/admin/getServerCodeAction.do";
	openWindow(strUrl, "服务器机器码", false);
}

function onBtnTestPageGo_Clicked(){
	var testUrl = $("#testPageUrl").val();
	if(null == testUrl || testUrl.length == 0){
		OZ.Msg.info('请输入所要打开的页面地址');
		return;
	}
	openWindow(contextPath + testUrl, "测试页面", false);
}
</script>
</html>