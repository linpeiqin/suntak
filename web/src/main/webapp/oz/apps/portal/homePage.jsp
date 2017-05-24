<!DOCTYPE html >
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="portal" />
<head>
	<title><oz:messageSource code="oz.portalmgm.constants.homepage"/></title>
    <%@ include file="/oz/includes/meta.jsp"%>
	<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
	<oz:css/> 
</head>
<body style="overflow: auto;height: auto;">
<div id="mainContainer" class="oz-portlet-container"></div>
<div style="clear: both;"></div>
<div id="module_temp" style="display: none;" class="oz-portlet-box">
	<div class="oz-portlet-outerbox oz-portlet">
  		<div class="oz-portlet-innerbox">
  			<div class="oz-portlet-box-content">
	   			<div class="oz-portlet-titleBar">
	    			<div class="oz-portlet-btn-more more">  					
	  				</div>
	  				<div class="oz-portlet-title">
	    				<span class="oz-portlet-icon"><b class="oz-icon"></b></span>&nbsp;<span class="title" ></span>
	    			</div>
	    			<div class="oz-portlet-buttonBar"> 
	  					<a class="oz-portlet-btn state-btn" onclick="OZ.Portlet.toggleModule(this)" title="折叠/展开"></a>
	    				<a class="oz-portlet-btn close-btn"  onclick="OZ.Portlet.removeModule(this)" title="隐藏"></a>
	  					<a class="oz-portlet-btn refresh-btn"  onclick="OZ.Portlet.refreshModule(this)" title="刷新"></a>
	  				</div>
	   			</div>
	    		<div class="oz-portlet-body-outer">
			   		<div class="oz-portlet-body"></div>
		    	</div>
	    	</div>
		</div>
	</div>
</div>
</body>
<oz:organizeJs></oz:organizeJs>
<oz:js/>
<oz:js jsSrc="/oz/apps/portal/js/portal.js"/>
<script type="text/javascript">
var _modules={};
<logic:iterate id="portlet" name="portlets">
	<logic:equal name="portlet" property="status" value="0">
		_modules.m<bean:write name="portlet" property="id" format="#" /> = {
			portletId : <bean:write name="portlet" property="id" format="#" />,
			title:"<bean:write name="portlet" property="name"/>", 
			url :"<bean:write name="portlet" property="urlPath" filter="false"/>",
			icon:"<bean:write name="portlet" property="icon"/>",
			hrefMore:"<bean:write name="portlet" property="hrefMore" filter="false"/>",
			showHead:"<bean:write name="portlet" property="minWindow"/>"
		};
	</logic:equal>
</logic:iterate>

function ozRefresh(data){
	if(data && data.moduleId){
		refreshPortlet(data.moduleId);
	}
}

function refreshPortlet(moduleId){
	if(typeof moduleId == "string"){
		OZ.Portlet.loadContent($("#"+moduleId +"Div"));
	}
}

var _homePageId = <%= request.getAttribute("homePageId") %>;

$(function(){
	var _configData = <%= request.getAttribute("configData") %>;
	_configData.layoutId =  '<%= request.getAttribute("layoutId") %>';
	
	OZ.Portlet.setDesginMode(false);

	// 初始化页面
	if(_homePageId != -1){
		setTimeout(function(){
			OZ.Portlet.loadPage(_configData);
			$(".oz-portlet-box").live({
				"hover":function(ev){
					if(ev.type == 'mouseenter'){  
						$(this).addClass("oz-portlet-box-hover"); 
					}
					if(ev.type == 'mouseleave'){  
						$(this).removeClass("oz-portlet-box-hover");
					}
				}
			});
		},1000)
	}

})
</script>
</html>