<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title><oz:messageSource code="oz.mdu.organize.group"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.organize.group"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar svFlag="true" action="organize/groupAction" searchButton="none">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnAdd" text="oz.add" icon="oz-icon-0205" onclick="onBtnAdd_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnAddFromTpl" text="oz.mdu.organize.userinfo.tabs.groups.button.add.from.tpl" icon="oz-icon-0218" onclick="onBtnAddFromTpl_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnSaveTpl" text="oz.mdu.organize.userinfo.tabs.groups.button.savetpl" icon="oz-icon-0217" onclick="onBtnSaveTpl_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnDelete"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="organize/groupAction" sortName="name" sortOrder="asc" fit="true" pagination="false">
			<oz:column field="id" checkbox="true"/>
			<oz:column field="status" title="oz.status" width="60" sortable="false" formatter="groupStatusFormatter"/>
			<oz:column field="name" title="oz.mdu.organize.group.fields.name" width="240" sortable="true" formatter="groupNameFormatter"/>
			<oz:column field="ouFullName" title="oz.mdu.organize.group.fields.ouinfo" width="360"/>
		</oz:grid>
	</div>
</body>
<script type="text/javascript">
var _userInfoId = '${userInfoId}';
oz_grid_config.url = "<oz:contextPath/>/organize/groupAction.do?action=page&viewType=ByUserInfo&userInfoId=" + _userInfoId;
</script>
<oz:organizeJs></oz:organizeJs>
<oz:js />
<script type="text/javascript">
function groupStatusFormatter(value, json){
	if(value == 0)
		return '<oz:messageSource code="oz.enable"/>';
	return '<oz:messageSource code="oz.disable"/>';
}

function onBtnAdd_Clicked(){
	OZ.Organize.selectGroups(function(groups){
		if(null == groups || groups.length == 0)
			return;
		
		var selectedGroupIds = "";
		for(var i = 0; i < groups.length; i++){
			if(i > 0)
				selectedGroupIds += ",";
			selectedGroupIds += groups[i].id;
		}
		
		$.post(
			contextPath + "/organize/userInfoAction.do?action=addGroup&timeStamp=" + new Date().getTime(), 
			{userInfoId:_userInfoId, groupIds:selectedGroupIds},
			function(json){
				if(json.result == true){
					OZ.View.reload();
				}else{
					OZ.Msg.info(json.msg);
				}
			}
		, "json");
	});
}

function onBtnAddFromTpl_Clicked(){
	var strUrl = contextPath + "/organize/groupTemplateAction.do?action=selectGroupTpl&multi=y&timeStamp=" + new Date().getTime();	
	new OZ.Dlg.create({ 
		id:"Dlg_SelectGroupTpls", 
		width:320, height:240,
		title:"<oz:messageSource code="oz.mdu.organize.userinfo.tabs.groups.button.add.from.tpl"/>",
		url: strUrl,
		onOk:function(result){
			$.post(
				contextPath + "/organize/userInfoAction.do?action=addGroup&timeStamp=" + new Date().getTime(),	
				{userInfoId:_userInfoId, groupTplIds:result},
				function(json){
					if(json.result == true){
						OZ.View.reload();
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			, "json");
		},
		onCancel:function(result){
			// do nothing...
		}
	});
}

function onBtnSaveTpl_Clicked(){
	var strUrl = contextPath + "/organize/groupTemplateAction.do?action=create&userInfoId=" + _userInfoId;
	strUrl += "&timeStamp=" + new Date().getTime();
	var title = '<oz:messageSource code="oz.new"/><oz:messageSource code="oz.mdu.organize.grouptemplate"/>';
	new OZ.Dlg.create({ 
		id:"Dlg_GroupTemplate", 
		width:480, height:335,
		title:title,
		url: strUrl,
		onOk:function(result){
			OZ.View.reloadGrid();	
		},
		onCancel:function(result){
			// do nothing...
		}
	});
}

function onBtnDelete_Clicked(){
	var rows = OZ.View.getGridSelection();
	if (null == rows || rows.length == 0) {
		OZ.Msg.info('请先选择所要删除的岗位');
		return;
	}
	
	var ids=[];
	for(var i=0;i<rows.length;i++){
		ids.push(rows[i].id);
	}
	OZ.Msg.confirm(
		'您确认要删除这些岗位吗?',
		function(){
			$.getJSON(
				contextPath + "/organize/userInfoAction.do?action=removeGroup&timeStamp=" + new Date().getTime(),
				{userInfoId:_userInfoId, groupIds:ids.join(",")},
				function(json){
					if(json.result == true){
						OZ.View.reload();				
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			);
		}
	);
}

function onRow_DBLClicked(rowIndex,rowData){
	oz_Default_Row_DBLClicked(rowIndex,rowData,"group");
}

function groupNameFormatter(value, rowData, rowIndex){
	return oz_DefaultFormatterEx(value, rowData, rowIndex, "group");
}
</script>
</html>