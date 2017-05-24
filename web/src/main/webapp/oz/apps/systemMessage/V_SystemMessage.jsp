<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.mdu.systemmessage"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.systemmessage"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="module/systemMessageAction" searchButton="normal">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnSetReaded" text="oz.mdu.systemmessage.buttons.setreaded" icon="oz-icon-0701" onclick="onBtnSetReadedFlag_Clicked(false)"></oz:tbButton>
			<oz:tbButton id="btnSetAllReaded" text="oz.mdu.systemmessage.buttons.setallreaded" icon="oz-icon-0710" onclick="onBtnSetReadedFlag_Clicked(true)"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnDelete"></oz:tbButton>
			<oz:tbButton id="btnClear" text="oz.clear" icon="oz-icon-1431" onclick="onBtnClear_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh" text=""></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="module/systemMessageAction" sortName="createdDate" sortOrder="desc" fit="true">
			<oz:column field="id" checkbox="true" title=""/>
			<oz:column field="read" title="" width="25" sortable="true" formatter="readIconFormatter"/>
<%-- 			<oz:column field="read" title="oz.mdu.systemmessage.fields.readflag" width="40" sortable="true" formatter="readFormatter"/> --%>
			<oz:column field="subject" title="oz.mdu.systemmessage.fields.subject" width="400" sortable="true" formatter="oz_DefaultFormatter2"/>
			<oz:column field="author_name" title="oz.mdu.systemmessage.fields.sender" width="120" formatter="boldFormatter"/>
			<oz:column field="createdDate" title="oz.mdu.systemmessage.fields.sendedDate" width="150" formatter="boldFormatter"/>
		</oz:grid>
	</div><b title=""></b>
</body>
<oz:js/>
<script type="text/javascript">
function readIconFormatter(value){
	if(value)
		return "<span title='<oz:messageSource code="oz.mdu.systemmessage.readflag.yes"/>' class='oz-icon oz-icon-0240'></span>";
	else
		return  "<span title='<oz:messageSource code="oz.mdu.systemmessage.readflag.no"/>'  class='oz-icon oz-icon-0239'></span>";
}
function readFormatter(value, json){
	if (value)
		return '<oz:messageSource code="oz.mdu.systemmessage.readflag.yes"/>';
	else
		return '<b><oz:messageSource code="oz.mdu.systemmessage.readflag.no"/></b>';
}
function oz_DefaultFormatter2(value, rowData, rowIndex, data){
	var v =boldFormatter(value,rowData);
	return oz_DefaultFormatter(v, rowData, rowIndex, data);
}
function boldFormatter(value,json){
	if(!json.read)
		return "<b>"+value+"</b>";
	else
		return value;
}
function onBtnSetReadedFlag_Clicked(isAll){
	var ids = [];
	var confirmMsg = '<oz:messageSource code="oz.mdu.systemmessage.msg.setallreaded.confirm"/>'; 
	if(!isAll){
		var rows = OZ.View.getGridSelection();
		if (null == rows || rows.length == 0) {
			OZ.Msg.info('<oz:messageSource code="oz.mdu.systemmessage.msg.readed.noneselected"/>');
			return;
		}
		
		for(var i=0;i<rows.length;i++){
			ids.push(rows[i].id);
		}
		confirmMsg = '<oz:messageSource code="oz.mdu.systemmessage.msg.setreaded.confirm"/>'; 
	}
	
	OZ.Msg.confirm(
		confirmMsg,
		function(){
			$.getJSON(
				contextPath + "/module/systemMessageAction.do?action=setReaded&timeStamp=" + new Date().getTime(),
				{ids:ids.join(";")},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.mdu.systemmessage.msg.setreaded.success"/>');
						OZ.View.reload();
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			);
		}
	);	
}

function onBtnClear_Clicked(){
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.mdu.systemmessage.msg.clear.confirm"/>',
		function(){
			$.getJSON(
				contextPath + "/module/systemMessageAction.do?action=deleteAll&timeStamp=" + new Date().getTime(),
				{},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.mdu.systemmessage.msg.clear.success"/>');
						OZ.View.reload();
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			);
		}
	);
}
</script>
</html>