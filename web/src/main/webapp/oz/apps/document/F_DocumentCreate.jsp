<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="page" messager="true" toolbar="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.document.documentdefinition"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
	<oz:css cssHref="/oz/apps/document/css/document.css"/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.document.documentdefinition"/>" style="overflow: auto;">
	<div id="page" class="oz-page">
		<logic:iterate id="definitions" name="ddList">
			<oz:js extend="true">
				var _ddListEmpty = false;
			</oz:js>
			<div class="ct">
				<div class="title" >
					<bean:write name="definitions" property="text"/>
				</div>
				<ul class="list" >
					<logic:iterate id="dd" name="definitions" property="children">
						<li class="ali" >
							<div class="abtn">
							<a class="alink" href="###" onclick="createNew(<bean:write name="dd" property="id"/>,'<bean:write name="dd" property="text"/>')" >
								<b class="alink-rc alink-rc-l"></b>
								<b class="alink-rc alink-rc-r"></b>
								<span><bean:write name="dd" property="text"/></span>
							</a></div>
						</li>
					</logic:iterate>					
				</ul>
				<div class="oz-clear"></div>
			</div>
		</logic:iterate>
		<logic:empty name="ddList">
			<oz:js extend="true">
				var _ddListEmpty = true;				
			</oz:js>
		</logic:empty>	
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function createNew(id, text){
	var strUrl = contextPath + "/document/documentInstanceAction.do?action=create&ddId=" + id;
	var data = ozWindow.option("data");
	if(data){
		if(data.paramData)
			strUrl += "&" + $.param(data.paramData);
	}
	openWindow(strUrl, '<oz:messageSource code="oz.new"/>' + text, false, text + "_" + id + "_" + new Date().getTime());
	ozWindow.close(); 
}

$(function(){
	if(_ddListEmpty){
		OZ.Msg.info("对不起，您目前尚未有可以新建的文档类型！");
		ozTB_BtnBack_Clicked();
	}
});
</script>
</html>