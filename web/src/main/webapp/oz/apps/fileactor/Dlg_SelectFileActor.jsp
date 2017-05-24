<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="org.springframework.web.bind.ServletRequestUtils"%>
<%@page import="cn.oz.web.util.RequestUtils"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="dialog" messager="true" tree="true" ex="oz-otabs"/>
<head>
	<title><oz:messageSource code="oz.oa.fxs.addressee"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css />
	<style type="text/css">
		.selectItem {
			cursor: pointer;
		}
		.selectItem.selected{
			background: #D4D4D4;
		}
	</style>
</head>
<body style="background-color: #F4FEFF;height:100%;width:100%;overflow:hidden;border:none;margin: 0px;padding: 0px;">
	<div >
		<div class="ui-tab">
				<div id="triggers" class="ui-tab-trigger">
					<div class="ui-tab-trigger-inner">
						<ul>
							<li class="ui-tab-trigger-item"><a hidefocus="hideFocus" href="javascript:void(0)"> <span>全部</span> </a>
							</li>
						</ul>
					</div>
				</div>
				<div class="ui-tab-container" id="views" style="height:300px;">
					<div class="ui-tab-container-item"  style="">
						<div style="width:284;height:226px;overflow:auto;">
					        <ul id="ouTree"></ul>
						</div>
					</div>
				</div>
		</div>
	</div>
</body>
<oz:js />
<script type="text/javascript">
var _checked = "";
function ozDlgOkFn(){	
	var exAdds = [],adds = [];
	var ouNodes = $('#ouTree').tree('getChecked');
	for(var i = 0; i < ouNodes.length; i++){
		adds.push({"name":ouNodes[i].text,"type":ouNodes[i].type,"value":(ouNodes[i].type +"_"+ ouNodes[i].id)});
	}
	return $.merge(exAdds,adds);
}
$(function(){
	var selecteds = ozWindow.option("selecteds");
	var nodeFilter = function(node){
		var find = false;
		if(selecteds){
			$.each(selecteds,function(i,item){
				if(item.name == node.text){
					find = true;
					node.checkbox = false;
					return false;
				}
			});
			if(find){
				//return false;
			}
		}
		return true;
	};
	$(".ui-tab").oTabs().bind("select",function(e,index,tab){
	});
	// 加载功能导航树
	var strUrl = contextPath + "/organize/ouTreeAction.do?action=getTree&timeStamp=" + new Date().getTime();
	strUrl += "&ouId=<%=ServletRequestUtils.getStringParameter(request, "ouId", "0") %>&ouType=<%=ServletRequestUtils.getStringParameter(request, "ouType", "BM") %>&userInfoFlag=<%=ServletRequestUtils.getBooleanParameter(request, "userInfo", true) %>&groupFlag=<%=RequestUtils.getBooleanParameter(request, "group", true) %>&treeType=sss";
	$('#ouTree').tree({url:strUrl,checkable: true, checkbox: true,nodeFilter:nodeFilter});
});
</script>
</html>