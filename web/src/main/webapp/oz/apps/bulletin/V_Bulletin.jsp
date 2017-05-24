<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
<head>
	<title>
		<oz:messageSource code="oz.mdu.bulletin"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.bulletin"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="module/bulletinAction" searchButton="normal">
			<oz:tbButton id="btnBack"/>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnNew"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRelease" text="oz.mdu.bulletin.buttons.release" icon="oz-icon-0124" onclick="onBtnRelease_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnOverdue" text="oz.mdu.bulletin.buttons.overdue" icon="oz-icon-0903" onclick="onBtnOverDue_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnViewNew" text="oz.mdu.bulletin.buttons.viewnew" icon="oz-icon-0429" onclick="onBtnViewNew_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnViewAll" text="oz.mdu.bulletin.buttons.viewall" icon="oz-icon-0429" onclick="onBtnViewAll_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnViewAdmin" text="oz.mdu.bulletin.buttons.viewadmin" icon="oz-icon-0429" onclick="onBtnViewAdmin_Clicked()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnDelete"></oz:tbButton>
			<oz:tbSeperator/>
			<oz:tbButton id="btnRefresh"/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="module/bulletinAction" sortName="releaseDate" sortOrder="desc" fit="true">
			<oz:column field="id" checkbox="true" title=""/>
			<oz:column field="status" title="oz.status" width="50" sortable="true" formatter="render4Status"/>
			<oz:column field="subject" title="oz.subject" width="300" sortable="true" formatter="oz_DefaultFormatter"/>
			<oz:column field="author_name" title="oz.author" width="200" sortable="true"/>
			<oz:column field="releaseDate" title="oz.mdu.bulletin.fields.releasedate" width="110" sortable="true"/>
		</oz:grid>
	</div>
</body>
<script type="text/javascript">
oz_grid_config.url = "<oz:contextPath/>/module/bulletinAction.do?action=page&viewType=<%=request.getAttribute("viewType")%>";
</script>
<oz:js/>
<script type="text/javascript">
var detail = <%=request.getAttribute("detail")%>;
function render4Status(value, json){
	if(value == 0)
		return '<oz:messageSource code="oz.mdu.bulletin.status.draft"/>';
	if(value == 1)
		return '<oz:messageSource code="oz.mdu.bulletin.status.release"/>'
	if(value == 2)
		return '<oz:messageSource code="oz.mdu.bulletin.status.expired"/>'
}

function onBtnRelease_Clicked(){
	var rows = OZ.View.getGridSelection();
	if (null == rows || rows.length == 0) {
		OZ.Msg.info('<oz:messageSource code="oz.mdu.bulletin.msg.release.noneselected"/>');
		return;
	}
	
	var ids=[];
	for(var i=0;i<rows.length;i++){
		ids.push(rows[i].id);
	}	
	
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.mdu.bulletin.msg.release.confirm"/>',
		function(){
			$.getJSON(
				contextPath + "/module/bulletinAction.do?action=release&timeStamp=" + new Date().getTime(),
				{ids:ids.join(";")},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.mdu.bulletin.msg.release.success"/>');
						OZ.View.reload();
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			);
		}
	);
}

function onBtnOverDue_Clicked(){
	var rows = OZ.View.getGridSelection();
	if (null == rows || rows.length == 0) {
		OZ.Msg.info('<oz:messageSource code="oz.mdu.bulletin.msg.overdue.noneselected"/>');
		return;
	}
	
	var ids=[];
	for(var i=0;i<rows.length;i++){
		ids.push(rows[i].id);
	}	
	
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.mdu.bulletin.msg.overdue.confirm"/>',
		function(){
			$.getJSON(
				contextPath + "/module/bulletinAction.do?action=overdue&timeStamp=" + new Date().getTime(),
				{ids:ids.join(";")},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.mdu.bulletin.msg.overdue.success"/>');
						OZ.View.reload();
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			);
		}
	);
}

function onBtnViewNew_Clicked(){
	window.open(contextPath + "/module/bulletinAction.do?action=display&viewType=zx", "_self");
}

function onBtnViewAll_Clicked(){
	window.open(contextPath + "/module/bulletinAction.do?action=display&viewType=sy", "_self");
}

function onBtnViewAdmin_Clicked(){
	window.open(contextPath + "/module/bulletinAction.do?action=display&viewType=gl", "_self");
}
</script>
</html>