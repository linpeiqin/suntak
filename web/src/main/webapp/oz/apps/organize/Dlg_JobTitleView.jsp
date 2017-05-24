<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.mdu.organize.jobtitle"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.organize.jobtitle"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="organize/jobTitleAction" searchButton="none">			
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnCopyToLocal" text="oz.config.optiongroup.button.copy.2.local" icon="oz-icon-1432" onclick="onBtnCopyToLocal_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="organize/jobTitleAction" sortName="name" sortOrder="asc" fit="true">
			<oz:column field="id" checkbox="true" title=""/>
			<oz:column field="name" title="oz.mdu.organize.jobtitle.fields.name" width="160" sortable="true" formatter="render4JobTitle"/>
			<oz:column field="code" title="oz.mdu.organize.jobtitle.fields.code" width="160" sortable="true" formatter="render4JobTitle"/>
		</oz:grid>
	</div>
</body>
<script type="text/javascript">
oz_grid_config.url = oz_grid_config.url + "&viewType=sjsj";
</script>
<oz:js/>
<script type="text/javascript">
var _baseUrl = contextPath + "/organize/jobTitleAction.do?action=";
function render4JobTitle(value, json){
	return '<a href="javascript:openJobTitle(' + json.id + ')">' + value + '</a>';
}

function onRow_DBLClicked(rowIndex, json){
	openJobTitle(json.id);
}

function openJobTitle(id){
	var strUrl = _baseUrl + "open&id=" + id + "&timeStamp=" + new Date().getTime();
	var title = '<oz:messageSource code="oz.view"/><oz:messageSource code="oz.mdu.organize.jobtitle"/>';
	new OZ.Dlg.create({ 
		id:"Dlg_JobTitle", 
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
		msg = "您确定要将所有职务配置数据拷贝到本单位中吗？"
	}else{
		msg = "您确定要将选中的职务配置数据拷贝到本单位中吗？"
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
						OZ.Msg.info("已成功将职务配置数据拷贝到本单位中,刷新后可查看到相应的配置数据.");
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