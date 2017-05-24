<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="view"/>
<head>
	<title><oz:messageSource code="oz.mdu.reminder"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.reminder"/>">
<div id="page" class="oz-page">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar svFlag="true" action="module/reminderAction" searchButton="none">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnAdd" text="oz.add" icon="oz-icon-0102" onclick="onBtnAdd_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnDelete"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="module/reminderAction" sortName="reminderDate" sortOrder="desc" fit="true">
			<oz:column field="id" checkbox="true"/>
			<oz:column field="status" title="oz.mdu.reminder.fields.status" width="60" formatter="formatter4Status"/>
			<oz:column field="reminderDate" title="oz.mdu.reminder.fields.reminderdate" width="120" formatter="formatter4Open"/>
			<oz:column field="recipienter_name" title="oz.mdu.reminder.fields.recipienter" width="100" formatter="formatter4Open"/>			
			<oz:column field="content" title="oz.mdu.reminder.fields.content" width="486" formatter="formatter4Open"/>
		</oz:grid>
	</div>
</div>
</body>
<script type="text/javascript">
var _srcFileId = "<%= request.getAttribute("srcFileId") %>"; 
var _editFlag = "<%= request.getAttribute("editFlag") %>";
oz_grid_config.url = "<oz:contextPath/>/module/reminderAction.do?action=page&srcFileId=" + _srcFileId;
</script>
<oz:js/>
<script type="text/javascript">
function formatter4Status(value, json){
	if(value == 0){
		return '<oz:messageSource code="oz.mdu.reminder.constants.status.on"/>';
	}else if(value == 9){
		return '<oz:messageSource code="oz.mdu.reminder.constants.status.expired"/>';
	}
	return value;
}

function formatter4Open(value, json){
	return "<a href='javascript:openReminder(" + json.id + ")'>" + value + "</a>";
}

function openReminder(id){
	var strUrl = contextPath + "/module/reminderAction.do?action=dlgOpen&id=" + id;
	strUrl += "&editFlag=" + _editFlag;
	new OZ.Dlg.create({
		id:"dlgReminder",
		width:420, height:360,
		title:'<oz:messageSource code="oz.mdu.reminder"/>',
		url: strUrl,
		onOk:function(result){
			if(result){
				ozTB_BtnRefresh_Clicked();
			}
		},onCancel:function(result){

		}
	});
}

function onBtnAdd_Clicked(){
	var strUrl = contextPath + "/module/reminderAction.do?action=dlgAdd&srcFileId=" + _srcFileId;
	new OZ.Dlg.create({
		id:"dlgReminder",
		width:420, height:360,
		title:'<oz:messageSource code="oz.mdu.reminder.constants.new"/>',
		url: strUrl,
		onOk:function(result){
			if(result){
				ozTB_BtnRefresh_Clicked();
			}
		},onCancel:function(result){

		}
	});
}

function formatter4Subject(value, rowData, rowIndex){
	var title = oz_GetTabTitle(rowData);
	var _href = "<a href='";
	_href += "javascript:OZ.openWindow({";
	_href += "url:\""+OZ.addParamToUrl(oz_grid_config.path,"action=" + ozOpenActionName + "&id=" + rowData.id) + "\",";
	_href += "title:\""+title+"\",";
	_href += "id:\"" + oz_grid_config.id+rowData.id + "\",";
	_href += "tabTip:\"" + title + "\",";
	_href += "refresh:true,";
	_href += "data:\"taskcase\",";
	_href += "beforeCloseFnName:\"oz_Win_BeforeClose\"";
	_href += "})";
	_href += "'>" + value + "</a>";
    return _href;
}

</script>
</html>