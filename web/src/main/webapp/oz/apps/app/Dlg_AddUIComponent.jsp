<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="cn.oz.apps.UIComponent"%>
<%@ page import="cn.oz.apps.Application"%>
<%@ page import="java.util.List"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" messager="true" ex="oz-otabs"/>
<head>
	<title></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssId="oz-app-icon"/>
	<oz:css cssHref="/oz/apps/app/css/addUIComponent.css"/>
</head>
<body class="oz-body oz-form" style="background-color: #F4FEFF;height:100%;width:100%;overflow:hidden;border:none;margin: 0px;padding: 0px;background-color: white;">
	<div class="ui-tab" style="margin:0px">	
		<div id="triggers" class="ui-tab-trigger" style="height:auto">
			<div class="ui-tab-trigger-inner">
				<ul>
					<li class="ui-tab-trigger-item" data-id="tab_01"><a hidefocus="hideFocus" href="javascript:void(0)"><span>快捷方式</span></a></li>
					<li class="ui-tab-trigger-item" data-id="tab_02"><a hidefocus="hideFocus" href="javascript:void(0)"><span>小插件</span></a></li>
				</ul>
			</div>
		</div>
		<div class="ui-tab-container" style="position:absolute;top:30px;bottom:0;width:100%;overflow:auto;">
			<div class="ui-tab-container-item">
				<div id="uiComponents" >
					<c:forEach var="app" items="${uiCmpnGroups}">
						<c:if test="${not empty app.shortCuts}">
							<dl>
								<dt>${app.groupName}：</dt>
								<dd>
									<div class="cmpnList">
										<c:forEach var="cmpn" items="${app.shortCuts}">
											<div>
												<input id="${cmpn.id}" type="checkbox" class="oz-uicomponent" value="${cmpn.id}" title="快捷方式:${cmpn.name}">
												<label for="${cmpn.id}" style="cursor:pointer" title="快捷方式:${cmpn.name}">${cmpn.name}</label>
											</div>	
										</c:forEach>
									</div>
								</dd>
							</dl>
						</c:if>
					</c:forEach>
				</div>
			</div>
			<div class="ui-tab-container-item">
				<div id="uiComponents">
					<c:forEach var="app" items="${uiCmpnGroups}">
						<c:if test="${not empty app.widgets}">
							<dl>
								<dt>${app.groupName}：</dt>
								<dd>
									<div class="cmpnList">
										<c:forEach var="cmpn" items="${app.widgets}">
											<div>
												<input id="${cmpn.id}" type="checkbox" class="oz-uicomponent" value="${cmpn.id}" title="小插件:${cmpn.name}">
												<label for="${cmpn.id}" style="cursor:pointer" title="小插件:${cmpn.name}">${cmpn.name}</label>
											</div>	
										</c:forEach>
									</div>
								</dd>
							</dl>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>	
</body>
<oz:js/>
<script type="text/javascript">
function ozDlgOkFn(){
	var uiCmpnIds = [];
	$(".oz-uicomponent").each(function(index){
		if($(this).attr("checked")){
			uiCmpnIds.push($(this).attr("id"));
		}
	});
	if(uiCmpnIds.length == 0){
		OZ.Msg.alert("请选择所要添加的应用");
        return false;	
	}else{
		return uiCmpnIds.join(";");
	}
}

$(function(){
	$(".ui-tab").oTabs().bind("select",function(e,index,tab){
		// onPageActive(tab.data("id"), true);
	});
});
</script>
</html>