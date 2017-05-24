<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.mdu.organize.joblevel"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.organize.joblevel"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="organize/jobLevelAction" searchButton="none">			
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnCopyToLocal" text="oz.config.optiongroup.button.copy.2.local" icon="oz-icon-1432" onclick="onBtnCopyToLocal_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="organize/jobLevelAction" sortName="name" sortOrder="asc" fit="true">
			<oz:column field="id" checkbox="true" title=""/>
			<oz:column field="name" title="oz.mdu.organize.joblevel.fields.name" width="160" sortable="true" formatter="render4JobLevel"/>
			<oz:column field="level" title="oz.mdu.organize.joblevel.fields.level" width="160" sortable="true" formatter="render4JobLevel"/>
		</oz:grid>
	</div>
</body>
<script type="text/javascript">
oz_grid_config.url = oz_grid_config.url + "&viewType=sjsj";
</script>
<oz:js/>
<script type="text/javascript">
var _baseUrl = contextPath + "/organize/jobLevelAction.do?action=";
function render4JobLevel(value, json){
	return '<a href="javascript:openJobLevel(' + json.id + ')">' + value + '</a>';
}

function onRow_DBLClicked(rowIndex, json){
	openJobLevel(json.id);
}

function openJobLevel(id){
	var strUrl = _baseUrl + "open&id=" + id + "&timeStamp=" + new Date().getTime();
	var title = '<oz:messageSource code="oz.view"/><oz:messageSource code="oz.mdu.organize.joblevel"/>';
	new OZ.Dlg.create({ 
		id:"Dlg_JobLevel", 
		width:480, height:320,
		title:title,
		url: strUrl,
		buttons:[{text:'<oz:messageSource code="oz.close"/>', handler:$.noop}]
	});
}

function onBtnCopyToLocal_Clicked(){
	var ids = oz_GetGridSelectionIds();
	var msg = "";
	if(null == ids || ids.length == 0){
		msg = "您确定要将所有职务级别数据拷贝到本单位中吗？"
	}else{
		msg = "您确定要将选中的职务级别数据拷贝到本单位中吗？"
	}
	OZ.Msg.confirm(
		msg,
		function(){
			var strUrl = _baseUrl + "copy2Local&timeStamp=" + new Date().getTime();
			$.post(
				strUrl, 
				{ids:ids},
				function(json){
					if(json.result == true){
						OZ.Msg.info("已成功将职务级别数据拷贝到本单位中,刷新后可查看到相应的配置数据.");
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			, "json");
		}
	);
}
</script>
</html>