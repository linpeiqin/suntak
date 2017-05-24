<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" attachment="true" select="true" dialog="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.bulletin"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css />
</head>
<body class="oz-body">
<div id="page" class="oz-page">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="module/bulletinAction">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack" text="返回"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnEdit"></oz:tbButton>
			<oz:tbButton id="btnOverdue" text="oz.mdu.bulletin.buttons.overdue" icon="oz-icon-0903" onclick="onBtnOverDue_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnDelete"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<div  style="width:100%;">
			<html:form action="module/bulletinAction.do" styleId="ozForm" styleClass="oz-form">
				<div style="margin:10px;line-height: 23px;border: 1px solid #76ABD3;padding:20px;">
					<h1 class="title" style="text-align:center;font-weight: bolder;font-size:26px;padding:15px; ">
						<bean:write name="bulletinForm" property="subject"/>
					</h1>
					<div>
						<p style="border-top:1px solid #EEF6F9;padding-top:4px;text-align:center;color:gray;">
							<span style="float:left;display:block;">
								<oz:messageSource code="oz.mdu.bulletin.fields.expireddate"/>：<bean:write name="bulletinForm" property="expiredDateTime"/>
							</span>
							<span style="float:right;display:block;">
								<bean:write name="bulletinForm" property="publisher.name"/>(<bean:write name="bulletinForm" property="publisher.ouName"/>)&nbsp;&nbsp;
								<oz:messageSource code="oz.mdu.bulletin.fields.releaseinfo"/>
								<bean:write name="bulletinForm" property="releaseDateTime"/>
							</span>							
						</p>
					</div>
					<div style="clear:both;height:1px;line-height: 1px;"></div>					
					<div style="padding:5px 0;border-bottom:1px solid #EEF6F9;border-top:1px solid #EEF6F9;padding-bottom:12px">
						<div style="width:940px;word-wrap: break-word;overflow:hidden;margin:2px;" id="contentArea"></div>
					</div>
					<oz:attachment id="ATTACHMENT" render="false" style="margin:0;padding:0;height:120px;width:100%;border-top:1px solid #76ABD3" readOnly="true">
					<logic:present name="ATTACHMENT">
						<logic:notEmpty name="ATTACHMENT">
							<div>
								<span style="font-weight:bold;"><oz:messageSource code="oz.attachments"/>:</span>
								<p style="margin-left: 30px;">
									<logic:iterate id="att" name="ATTACHMENT">
										<a style="text-decoration: underline;" href="javascript:OZ.Attachment.downloadAttachment(<bean:write name="att" property="id" format="#"/>);"><bean:write name="att" property="fileName"/></a>(<bean:write name="att" property="fileSize"/>)<br>
									</logic:iterate>
								</p>
							</div>
						</logic:notEmpty>
					</logic:present>
				</oz:attachment>
			</div>
			<html:hidden property="id" styleId="id"/>
			<html:hidden property="content" styleId="content"/>
		</html:form>
		</div>
	</div>
</div>
</body>
<oz:js/>
<script type="text/javascript">
function onBtnOverDue_Clicked(){
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.mdu.bulletin.msg.overdue.confirm.single"/>',
		function(){
			$.getJSON(
				contextPath + "/module/bulletinAction.do?action=overdue&timeStamp=" + new Date().getTime(),
				{id:$("#id").val()},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.mdu.bulletin.msg.overdue.success"/>', null, function(){
							ozTB_BtnBack_Clicked();
						});
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			);
		}
	);	
}

function onBtnDelete_Clicked(){
	OZ.Msg.confirm(
		'<oz:messageSource code="oz.mdu.bulletin.msg.delete.confirm.single"/>',
		function(){
			$.getJSON(
				contextPath + "/module/bulletinAction.do?action=delete&timeStamp=" + new Date().getTime(),
				{id:$("#id").val()},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.core.msg.delete.success"/>', null, function(){
							ozTB_BtnBack_Clicked();
						});
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			);
		}
	);
}

function renderPre(fieldIds, preId, defaultContent){
	if($("#" + preId).length > 0){
		var content = $("#" + fieldIds).val();
		if(null == content || content.length == 0){
			content = defaultContent || "";
			$("#" + preId).html('<pre class="oz-form-pre" style="color:gray;">' + content + '</pre>');
		}else{ 
			$("#" + preId).html('<pre class="oz-form-pre">' + content.replace(/\n/ig,"<br>") + '</pre>');
		}
	}
}

function openWindow(id, url, title){
	var strUrl = contextPath + url;
	OZ.openWindow({
		id: id,
		title: title,
		url: strUrl, 
		refresh: false,
		beforeCloseFnName: "oz_Win_BeforeClose"
	});	
}

$(function(){
	renderPre("content", "contentArea");	
});
</script>
</html>