<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.mdu.organize.ouinfo"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.organize.ouinfo"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar svFlag="true" action="organize/ouManagerAction" searchButton="none">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbSelect id="btnManagerType" text="oz.mdu.organize.ouinfo.button.lable.managertype" value="managerType" blankOption="true" options="managerTypeOptions" onchange="onManagerType_changed()">
    		</oz:tbSelect>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnAdd" text="oz.add" icon="oz-icon-0102" onclick="onBtnAdd_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnDelete"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="organize/ouManagerAction" sortOrder="asc" fit="true" pagination="false">
			<oz:column field="id" checkbox="true" title=""/>
			<oz:column field="managerType" title="oz.mdu.organize.oumanager.fields.managertype" width="160" sortable="true"/>
			<oz:column field="userInfo_name" title="oz.mdu.organize.oumanager.fields.userinfoname" width="160" sortable="true"/>
		</oz:grid>
	</div>
</body>
<script type="text/javascript">
var _ouId = <%= request.getAttribute("ouId") %>;
var _editFlag = <%= request.getAttribute("editFlag") %>;
oz_grid_config.url = "<oz:contextPath/>/organize/ouManagerAction.do?action=page&ouId=" + _ouId;
</script>
<oz:js/>
<script type="text/javascript">
function onManagerType_changed(){
	var managerType = $("#btnManagerTypeSEL").val();
	if(managerType == "-1")
		managerType = "";
	OZ.View.reloadGrid({managerType:managerType});
}

function onBtnAdd_Clicked(){
	var strUrl = contextPath + "/organize/ouManagerAction.do?action=dlgAdd&managerType=" + $("#btnManagerTypeSEL").val();
	strUrl += "&ouId=" + _ouId;
	strUrl += "&timeStamp=" + new Date().getTime();
	
	new OZ.Dlg.create({
		id:"dlg_AddOUManager", 
		width:260, height:172,
		title:'<oz:messageSource code="oz.mdu.organize.oumanager.dlg.addmanager.title"/>',
		url: strUrl,
		onOk:function(result){
			strUrl = contextPath + "/organize/ouManagerAction.do?action=add&timeStamp=" + new Date().getTime();
			$.getJSON(
				strUrl,
				{managerType:result.managerType,userInfoId:result.userInfoId,ouId:_ouId},
				function(json){
					if(json.result == true){
						OZ.View.reload();
		    		}else{
		    			OZ.Msg.info(json.msg);
       				}
       			});
		},onCancel:function(result){
		
		}
	}); 
}

function onBtnDelete_Clicked(){
	ozTB_DefaultBtnDelete_ClickedEx(contextPath + "/organize/ouManagerAction.do?action=delete&ouId=" + _ouId + "&timeStamp=" + new Date().getTime());
}

function onRow_DBLClicked(rowIndex,rowData){
	// Do nothing
}
</script>
</html>