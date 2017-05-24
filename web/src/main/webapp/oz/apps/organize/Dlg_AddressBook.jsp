<!doctype html>
<%@page import="org.springframework.web.bind.ServletRequestUtils"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="dialog" tree="true" messager="true" select="true" ex="oz-otabs"/>
<head>
	<title><oz:messageSource code="oz.mdu.organize.addressbook"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<style type="text/css">
	.ui-tab-trigger-inner .ui-tab-trigger-item span {
		width: 64px;
	}
	</style>
</head>
<body class="oz-body" style="background-color:#FFF;height:100%;width:100%;border:none;margin:0px;padding:0px;overflow:hidden;">
	<div class="ui-tab">	
		<div id="triggers" class="ui-tab-trigger">
			<div class="ui-tab-trigger-inner">
				<ul>
					<c:if test="${param.shortcutGroup == 'true'}">
						<li class="ui-tab-trigger-item" data-id="tab_SG"><a hidefocus="hideFocus" href="javascript:void(0)"><span>快捷组</span></a></li>
					</c:if>
					<c:if test="${param.userInfo != 'false'}">
						<li class="ui-tab-trigger-item" data-id="tab_UserInfo"><a hidefocus="hideFocus" href="javascript:void(0)"><span>人员</span></a></li>
					</c:if>
					<c:if test="${param.group != 'false'}">
						<li class="ui-tab-trigger-item" data-id="tab_Group"><a hidefocus="hideFocus" href="javascript:void(0)"><span>岗位</span></a></li>
					</c:if>
					<c:if test="${param.ou != 'false'}">
						<li class="ui-tab-trigger-item" data-id="tab_OUInfo"><a hidefocus="hideFocus" href="javascript:void(0)"><span>部门</span></a></li>
					</c:if>
					<c:if test="${param.privateGroup == 'true'}">
						<li class="ui-tab-trigger-item" data-id="tab_PG"><a hidefocus="hideFocus" href="javascript:void(0)"><span>私有组</span></a></li>
					</c:if>
				</ul>
			</div>
		</div>		
		<table style="width:100%;background-color:#FFFFFF" cellpadding="0" cellspacing="0">
			<tr>
				<td width="100%" valign="top">
					<div class="ui-tab-container" id="views" style="height:260px;width:403px;overflow: hidden;">
						<c:if test="${param.shortcutGroup == 'true'}">
							<div class="ui-tab-container-item" >
								<div style="height:258px;width:401px;overflow:auto;border:1px solid #8DB2E3;background-color:white;">
									<ul id="shortcutGroupTree"></ul>
								</div>
							</div>
						</c:if>
						<c:if test="${param.userInfo != 'false'}">
							<div class="ui-tab-container-item">
								<table style="width:100%">
									<tr>
										<td width="64%" valign="top">
											<div style="height:258px;width:250px;overflow:auto;border:1px solid #8DB2E3;background-color:white;">
												<ul id="userInfoTree"></ul>
											</div>
										</td>
										<td width="36%" valign="top">
											<div style= "width:147px; height:258px;border:1px solid #8DB2E3;overflow:hidden;position: relative;"> 
												<input type="text" id="userInfoSearchCondition" onkeyup="findUserInfos()" style="width:147px;position:absolute; top:1px;border-width:0px; border-bottom : 1px solid #8DB2E3;background-color: white;z-index: 1000">
												<select id="userInfos" name="userInfos" size="13" style="width:150px;position:absolute; top:20px;left:-2px; height:240px;z-index:1;border : 1px solid #8DB2E3;outline: none;" ondblclick="onSelect_DblClicked('userInfos')"></select>
											</div>
										</td>
									</tr>
								</table>
							</div>
						</c:if>
						<c:if test="${param.group != 'false'}">
							<div class="ui-tab-container-item" >
								<table style="width:100%">
									<tr>
										<td width="64%" valign="top">
											<div style="height:258px;width:250px;overflow:auto;border:1px solid #8DB2E3;background-color:white;">
												<ul id="groupTree"></ul>
											</div>
										</td>
										<td width="36%" valign="top">
											<div style= "width:147px; height:258px;border:1px solid #8DB2E3;overflow:hidden;position: relative;"> 
												<select id="groups" name="groups" size="14" style="width:150px;margin:-2px;height:262px;z-index:1" ondblclick="onSelect_DblClicked('groups')">
												</select>
											</div>
										</td>
									</tr>
								</table>		
							</div>
						</c:if>
						<c:if test="${param.ou != 'false'}">
							<div class="ui-tab-container-item" >
								<table style="width:100%">
									<tr>
										<td width="100%" valign="top">
											<div style="height:258px;width:401px;overflow:auto;border:1px solid #8DB2E3;background-color:white;">
												<ul id="ouTree"></ul>
											</div>
										</td>
									</tr>
								</table>
							</div>
						</c:if>
						<c:if test="${param.privateGroup == 'true'}">
							<div class="ui-tab-container-item">
								<div style="height:258px;width:401px;overflow:auto;border:1px solid #8DB2E3;background-color:white;">
									<ul id="privateGroupTree"></ul>
								</div>
						</c:if>
					</div>
				</td>
			</tr>
		</table>
	</div>
</body>
<oz:js/>
<oz:js jsSrc="/oz/apps/organize/js/addressBook.js"></oz:js>
<script type="text/javascript">
var _multi = false;
var _addType = "";
var _selectId = "";
var _ouId="<%=ServletRequestUtils.getStringParameter(request, "ouId", "0") %>";
<c:if test="${param.showPrivateGroupMember != 'true'}">
var loadPrivateGroupMember = false;								
</c:if>
<c:if test="${param.showPrivateGroupMember == 'true'}">
var loadPrivateGroupMember = true;
</c:if>
<c:if test="${param.showShortcutGroupMember != 'true'}">
var loadShortcutGroupMember = false;								
</c:if>
<c:if test="${param.showShortcutGroupMember == 'true'}">
var loadShortcutGroupMember = true;
</c:if>

<c:if test="${param.group != 'false'}">
var loadGroup = true;								
</c:if>
<c:if test="${param.group == 'false'}">
var loadGroup = false;
</c:if>
<c:if test="${param.ou != 'false'}">
var loadOUInfo = true;								
</c:if>
<c:if test="${param.ou == 'false'}">
var loadOUInfo = false;
</c:if>
<c:if test="${param.userInfo != 'false'}">
var loadUserInfo = true;								
</c:if>
<c:if test="${param.userInfo == 'false'}">
var loadUserInfo = false;
</c:if>

function onSelect_DblClicked(sourceObjId){
	_selectId = sourceObjId
	OZ.Dlg.fireButtonEvent(0, "dlg_AddressBook");
}

function ozDlgOkFn(){
	if(_addType == "OUInfo"){
		var node = $('#ouTree').tree('getSelected');
		if(null == node){
			OZ.Msg.alert('请先选择');
	        return false;
		}
		
		var value = node.id + "." + _addType;
		var text = node.name;
		var values = value.split(".");
		return {id : value, name : text , value : { id : values[0] , type : values[1] ,text : text}};
	}else if(_addType == "SG" || _addType == "PG"){		// 便捷组或私有组
		var node = null;
		if(_addType == "SG")
			node = $('#shortcutGroupTree').tree('getSelected');
		else
			node = $('#privateGroupTree').tree('getSelected');		
		if(null == node){
			OZ.Msg.alert('请先选择');
	        return false;
		}
		var value = node.id;
		var text = node.name;
		var values = value.split(".");
		// alert("id=" + value + ", name=" + text + ", valueId=" + values[0] + ", valueType=" + values[1] + ", valueText=" + text);
		return {id : value, name : text , value : { id : values[0] , type : values[1] ,text : text}};
	}else{
		var selectedObj = document.getElementById(_selectId);
		if (selectedObj == null){
			return false;
		}
		
		// 这里这么处理主要是考虑的便捷组或私有组的成员显示时已经做了处理，所以不用添加
		var sourceType = _addType;
		if(null != sourceType && sourceType.length > 0){
			sourceType = "." + sourceType;
		}else{
			sourceType = "";
		}
		
		for (var i = 0; i < selectedObj.length; i++){
			if (selectedObj.options[i].selected){
				var value = selectedObj.options[i].value + sourceType;
				var text = selectedObj.options[i].text;
				var values = value.split(".");
				return {id : value, name : text , value : { id : values[0] , type : values[1] ,text : text}};
			}
		}
		
		OZ.Msg.alert('请选择');
	    return false;
	}	
}

$(function(){
	$(".ui-tab").oTabs().bind("select",function(e,index,tab){
		onPageActive(tab.data("id"), true , tab);
	});
});
</script>
</html>