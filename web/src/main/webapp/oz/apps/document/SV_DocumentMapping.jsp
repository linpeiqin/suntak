<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
	<oz:ui templete="view" />
	<head>
		<title>文种映射定义</title>
		<%@ include file="/oz/includes/meta.jsp"%>
		<oz:css/>
	</head>
	<body class="oz-body" data-name="文种映射定义">
		<div id="page" class="oz-page">
			<div id="page-top" class="oz-page-top">
				<oz:toolbar svFlag="true" action="document/documentMappingAction">
					<oz:tbSeperator></oz:tbSeperator>
					<oz:tbButton id="btnNew" text="新建"></oz:tbButton>
					<oz:tbSeperator></oz:tbSeperator>
					<oz:tbButton id="btnDelete" text="删除"></oz:tbButton>
					<oz:tbSeperator></oz:tbSeperator>
					<oz:tbButton id="btnRefresh" text="刷新"></oz:tbButton>
				</oz:toolbar>				
			</div>
			<div id="page-center" class="oz-page-center">
				<oz:grid action="document/documentMappingAction" sortName="itemId" sortOrder="asc" fit="true">
					<oz:column field="id" checkbox="true"/>
					<oz:column field="name" title="oz.mdu.document.dm.field.name" width="160" sortable="false" formatter="oz_DefaultFormatter"/>
					<oz:column field="source" title="oz.mdu.document.dm.field.source" width="220" sortable="false" />
					<oz:column field="target" title="oz.mdu.document.dm.field.target" width="220" sortable="false" />
				</oz:grid>
			</div>
		</div>
	</body>
	<oz:js/>
<script type="text/javascript">
var _sourceId = '<%= request.getAttribute("sourceId") %>';
var _viewType = '<%= request.getAttribute("viewType") %>';
oz_grid_config.url = "<oz:contextPath/>/document/documentMappingAction.do?action=page&sourceId=" + _sourceId;
</script>
	<script type="text/javascript">
	
	function onBtnDelete_Clicked(action){
		ozTB_DefaultBtnDelete_ClickedEx(OZ.addParamToUrl(action, "action=delete&sourceId=" + _sourceId));
	}
	
	function onBtnNew_Clicked(action){
		var strUrl = contextPath + "/document/documentMappingAction.do?action=dlgSelectDefinition&sourceId=" + _sourceId;
		strUrl += "&timeStamp=" + new Date().getTime();
		
		new OZ.Dlg.create({ 
			id:"dlg_Mapping", 
			width:300, height:272,
			title:'添加映射',
			url: strUrl,
			onOk:function(result){
				strUrl = OZ.addParamToUrl(action, "action=create&sourceId=" + _sourceId+"&targetId=" + result+"&timeStamp=" + new Date().getTime());
				OZ.openWindow({
					id: oz_grid_config.id + "_create" + (new Date().getTime()),
					title:"新建" + ($("body").data("name") || "文档"),
					url: strUrl, 
					refresh: true,
					beforeCloseFnName: "oz_Win_BeforeClose",
					data:"documentMapping"
				});
			},
			onCancel:function(result){
				// do nothing...
			}
		});
	}
	
	function onBtnRelated_Clicked(){
		var strUrl = contextPath + "/document/documentDefAction.do?action=dlgRelated&ddId=" + _ddId;
		strUrl += "&timeStamp=" + new Date().getTime();

		new OZ.Dlg.create({ 
			id:"dlg_Related", 
			width:300, height:272,
			title:'<oz:messageSource code="oz.mdu.document.dd.related.dlg.title"/>',
			url: strUrl,
			onOk:function(result){
				strUrl = contextPath + "/document/documentDefAction.do?action=addRelated&timeStamp=" + new Date().getTime();
				$.getJSON(
					strUrl, 
					{ddId:_ddId, ids:result},
					function(json){
						if(json.result == true){
							OZ.View.reload();
						}else{
							OZ.Msg.info(json.msg);
						}
					}
				);
			},
			onCancel:function(result){
				// do nothing...
			}
		});
	}
	$(function(){

	});
	</script>
</html>