<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<%
	String idnum = String.valueOf(new Date().getTime());
%>
<div id="SendSMS<%=idnum%>">
	<div style="padding:4px;text-align:left;margin-bottom:4px">
		<table width="100%" style="background-color:#FFFFFF">
			<tr>
				<td style="padding:4px" colspan="2">
					<b><oz:messageSource code="oz.cmpn.sms.sendrecord.fields.userinfos"/>:</b>
				</td>
			</tr>
			<tr>
				<td style="padding:4px">
					<input type="text" id="userInfoNames" name="userInfoNames" style="width:100%" class="oz-form-field" readonly="readonly">
				</td>
				<td style="padding:4px" width="62px">
					<input id="btnSelect" type="button" class="oz-form-button" value='<oz:messageSource code="oz.select"/>' onClick="OZ.Organize.selectUserInfos(onAfterSelectSMSUserInfos)" style="width:62px;height:21px;"/>
				</td>
			</tr>
			<tr>
				<td style="padding:4px" colspan="2">
					<b><oz:messageSource code="oz.cmpn.sms.config.fields.sms.content"/>:</b>
				</td>
			</tr>
			<tr>
				<td style="padding:4px" colspan="2">
					<textarea id="content" name="content" style="width:100%;height:82px"></textarea>
				</td>
			</tr>
			<tr>
				<td style="padding:4px;text-align:center;" colspan="2">
					<input id="btnSendSMS" type="button" class="oz-form-button" value='<oz:messageSource code="oz.cmpn.sms.config.buttons.send"/>' onClick="onBtnSendSMS_Clicked()" style="width:62px;height:21px;"/>
					&nbsp;
					<input id="btnSMSClear" type="button" class="oz-form-button" value='<oz:messageSource code="oz.clear"/>' onClick="onBtnSMSClear_Clicked()" style="width:62px;height:21px;"/>
				</td>
			</tr>
		</table>
	</div>
</div>
<script type="text/javascript">
var _userInfoIds = "";
function onAfterSelectSMSUserInfos(userInfos){
	_userInfoIds = "";
	var userNames = "";
	for(var i = 0; i < userInfos.length; i++){
		if(i > 0){
			_userInfoIds += ",";
			userNames += ",";
		}
		_userInfoIds += userInfos[i].id;
		userNames += userInfos[i].name;
	}
	$("#userInfoNames").val(userNames);
}

function onBtnSendSMS_Clicked(){
	var content = $("#content").val();
	if(null == content || content.length == 0){
		OZ.Msg.info('<oz:messageSource code="oz.cmpn.sms.msg.content.isempty"/>');
		return false;
	}
	
	if(null == _userInfoIds || _userInfoIds.length == 0){
		OZ.Msg.info('<oz:messageSource code="oz.cmpn.sms.msg.userinfos.isempty"/>');
		return false;
	}

	var strUrl = contextPath + "/sms/smsSendRecordAction.do?action=sendSMS&timeStamp=" + new Date().getTime();
	$.getJSON(
		strUrl, 
		{userInfoIds:_userInfoIds, content:content},
		function(json){
			if(json.result == true){
				OZ.Msg.info(json.msg);
				$("#userInfoNames").val("");
				 _userInfoIds = "";
			}else{
				OZ.Msg.info(json.msg);
			}
		}
	);
}

function onBtnSMSClear_Clicked(){
	$("#userInfoNames").val("");
	_userInfoIds = "";
	$("#content").val(""); 
}
</script>