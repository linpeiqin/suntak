<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.mdu.organize.userinfo.relation"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.organize.userinfo.relation"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar svFlag="true" action="organize/userInfoRelationAction" searchButton="none">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbSelect id="btnRelationType" text="oz.mdu.organize.userinfo.relation.button.lable.relationtype" value="relationType" blankOption="true" options="relationTypeOptions" onchange="onRelationType_changed()">
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
		<oz:grid action="organize/userInfoRelationAction" sortOrder="asc" fit="true" pagination="false">
			<oz:column field="id" checkbox="true" title=""/>
			<oz:column field="relationType" title="oz.mdu.organize.userinfo.relation.fields.relationtype" width="160" sortable="true" formatter="relationFormatter"/>
			<oz:column field="rhUserInfo_name" title="oz.mdu.organize.userinfo.relation.fields.userinfoname" width="160" sortable="true" formatter="relationFormatter"/>
		</oz:grid>
	</div>
</body>
<script type="text/javascript">
var _userInfoId = <%= request.getAttribute("userInfoId") %>;
var _editFlag = <%= request.getAttribute("editFlag") %>;
oz_grid_config.url = "<oz:contextPath/>/organize/userInfoRelationAction.do?action=page&userInfoId=" + _userInfoId;
</script>
<oz:js/>
<script type="text/javascript">
function relationFormatter(value, row, rowIndex){
	return "<a href='javascript:updateRelation(" + row.id + ")'>" + value + "</a>";
}

function onRelationType_changed(){
	var relationType = $("#btnRelationTypeSEL").val();
	if(relationType == "-1")
		relationType = "";
	OZ.View.reloadGrid({relationType:relationType});
}

function onBtnAdd_Clicked(){
	var strUrl = contextPath + "/organize/userInfoRelationAction.do?action=dlgAdd&relationType=" + $("#btnRelationTypeSEL").val();
	strUrl += "&userInfoId=" + _userInfoId;
	strUrl += "&timeStamp=" + new Date().getTime();
	
	new OZ.Dlg.create({
		id:"dlg_AddUserInfoRelation", 
		width:320, height:240,
		title:'<oz:messageSource code="oz.mdu.organize.userinfo.relation"/>',
		url: strUrl,
		onOk:function(result){
			strUrl = contextPath + "/organize/userInfoRelationAction.do?action=add&timeStamp=" + new Date().getTime();
			$.getJSON(
				strUrl,
				{userInfoId:_userInfoId, relationType:result.relationType, rhUserInfoId:result.userInfoId, authorizations:result.authzCodes},
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

function updateRelation(id){
	if(!_editFlag)
		return;
	
	var strUrl = contextPath + "/organize/userInfoRelationAction.do?action=editDlg";
	strUrl += "&userInfoId=" + _userInfoId + "&id=" + id;
	strUrl += "&timeStamp=" + new Date().getTime();
	new OZ.Dlg.create({
		id:"dlg_EditUserInfoRelation", 
		width:320, height:240,
		title:'<oz:messageSource code="oz.mdu.organize.userinfo.relation"/>',
		url: strUrl,
		onOk:function(result){
			strUrl = contextPath + "/organize/userInfoRelationAction.do?action=update&timeStamp=" + new Date().getTime();
			$.getJSON(
				strUrl,
				{userInfoId:_userInfoId, id:id, relationType:result.relationType, rhUserInfoId:result.userInfoId, authorizations:result.authzCodes},
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
	ozTB_DefaultBtnDelete_ClickedEx(contextPath + "/organize/userInfoRelationAction.do?action=delete&userInfoId=" + _userInfoId + "&timeStamp=" + new Date().getTime());
}

function onRow_DBLClicked(rowIndex,rowData){
	updateRelation(rowData.id);
}
</script>
</html>