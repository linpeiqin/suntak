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
				<td width="64%" valign="top">
					<div class="ui-tab-container" id="views" style="height:260px;width: 350px;overflow: hidden;">
						<c:if test="${param.shortcutGroup == 'true'}">
							<div class="ui-tab-container-item" >
								<div style="height:258px;width: 348px;overflow:auto;border:1px solid #8DB2E3;background-color:white;">
									<ul id="shortcutGroupTree"></ul>
								</div>
							</div>
						</c:if>
						<c:if test="${param.userInfo != 'false'}">
							<div class="ui-tab-container-item">
								<table style="width:100%">
									<tr>
										<td width="64%" valign="top">
											<div style="height:258px;width: 220px;overflow:auto;border:1px solid #8DB2E3;background-color:white;">
												<ul id="userInfoTree"></ul>
											</div>
										</td>
										<td width="36%" valign="top">
											<div style= "width:124px; height:258px;border:1px solid #8DB2E3;overflow:hidden;position: relative;"> 
												<input type="text" id="userInfoSearchCondition" onkeyup="findUserInfos()" style="width:124px;position:absolute; top:1px;border-width:0px; border-bottom : 1px solid #8DB2E3;background-color: white;z-index: 1000">
												<select id="userInfos" name="userInfos" multiple="multiple" style="width:128px;position:absolute; top:20px;left:-2px; height:240px;z-index:1;border : 1px solid #8DB2E3;outline: none;" ondblclick="onSelect_DblClicked('userInfos')"></select>
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
											<div style="height:258px;width: 220px;overflow:auto;border:1px solid #8DB2E3;background-color:white;">
												<ul id="groupTree"></ul>
											</div>
										</td>
										<td width="36%" valign="top">
											<div style= "width:124px; height:258px;border:1px solid #8DB2E3;overflow:hidden;position: relative;"> 
												<select id="groups" name="groups" multiple="multiple" style="width:128px;margin:-2px;height:262px;z-index:1" ondblclick="onSelect_DblClicked('groups')">
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
											<div style="height:258px;width: 348px;overflow:auto;border:1px solid #8DB2E3;background-color:white;">
												<ul id="ouTree"></ul>
											</div>
										</td>
									</tr>
								</table>
							</div>
						</c:if>
						<c:if test="${param.privateGroup == 'true'}">
							<div class="ui-tab-container-item">
								<div style="height:258px;width: 348px;overflow:auto;border:1px solid #8DB2E3;background-color:white;">
									<ul id="privateGroupTree"></ul>
								</div>
							</div>
						</c:if>
					</div>
				</td>
				<td width="12%" style="text-align:center; vertical-align:middle;">
					<input id="btnAdd" type="button" class="oz-form-button" value=" <oz:messageSource code="oz.add"/> > " onclick="onBtnAdd_Clicked()" style="cursor:pointer;"/><br /><br /><br />
					<input id="btnDelete" type="button" class="oz-form-button" value=" < <oz:messageSource code="oz.delete"/> " onclick="OZ.SELECT.removeSelected('addItems')" style="cursor:pointer;"/><br /><br /><br />
					<input id="btnClear" type="button" class="oz-form-button" value=" << <oz:messageSource code="oz.clearall"/> " onclick="OZ.SELECT.removeAll('addItems')" style="cursor:pointer;"/>
				</td>
				<td width="24%" class="oz-property">
					<div style= "width:130; height:258px;border: 1px solid #8DB2E3;overflow:hidden;position: relative;"> 
						<select id="addItems" name="addItems" multiple="multiple" style="width:134px;margin:-2px;height:262px;">
						</select>
					</div>	
				</td>
			</tr>
		</table>
	</div>
</body>
<oz:js/>
<oz:js jsSrc="/oz/apps/organize/js/addressBook.js"></oz:js>
<script type="text/javascript">
var _multi = true;
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
<c:if test="${param.checkPG == 'false'}">
var checkPG = false;
</c:if>
function onBtnAdd_Clicked(){
	if(_addType == "OUInfo"){		// 组织架构
		var nodes = $('#ouTree').tree('getChecked', true);
		if(null == nodes || nodes.length == 0){
			OZ.Msg.alert('请先选择');
	        return null;
	    }
		
		for(var i = 0; i < nodes.length; i++){
			var ouId = nodes[i].id + "." + _addType;
			var destObj = document.getElementById("addItems");		
			var isExist = false;
			for(var j = 0; j < destObj.length; j++){
				if(destObj.options[j].value == ouId){
					isExist = true;
					break;
				}
			}
			if(!isExist){
				var len = destObj.length;
				destObj.options[len] = new Option(nodes[i].name, ouId);
			}
			$(nodes[i].target).find('.oz-tree-checkbox').removeClass('oz-tree-checkbox1').addClass('oz-tree-checkbox0');
		}
	}else if(_addType == "SG" || _addType == "PG"){		// 便捷组或私有组
			var nodes = null;
			if(_addType == "SG")
				nodes = $('#shortcutGroupTree').tree('getChecked', true);
			else
				nodes = $('#privateGroupTree').tree('getChecked', true);
			if(null == nodes || nodes.length == 0){
				OZ.Msg.alert('请先选择');
		        return null;
		    }
			
			for(var i = 0; i < nodes.length; i++){
				var id = nodes[i].id;
				var destObj = document.getElementById("addItems");
				var isExist = false;
				for(var j = 0; j < destObj.length; j++){
					if(destObj.options[j].value == id){
						isExist = true;
						break;
					}
				}
				if(!isExist){
					var len = destObj.length;
					destObj.options[len] = new Option(nodes[i].name, id);
				}
				$(nodes[i].target).find('.oz-tree-checkbox').removeClass('oz-tree-checkbox1').addClass('oz-tree-checkbox0');
			}
	}else{
		addOption(_selectId, _addType);
	}
}

function onSelect_DblClicked(sourceObjId){	
	addOption(sourceObjId, _addType);
}

function addOption(sourceObjId, sourceType){
	var sourceObj = document.getElementById(sourceObjId);
	var destObj = document.getElementById("addItems");
	if (sourceObj == null || destObj == null){
		return;
	}
	
	// 这里这么处理主要是考虑的便捷组或私有组的成员显示时已经做了处理，所以不用添加
	if(null != sourceType && sourceType.length > 0){
		sourceType = "." + sourceType;
	}else{
		sourceType = "";
	}
	
	for (var i = 0; i < sourceObj.length; i++){
		if (sourceObj.options[i].selected){
			var selValue = sourceObj.options[i].value + sourceType;
			if(!OZ.SELECT.isExist("addItems", selValue)){
				destObj.options[destObj.length] = new Option(sourceObj.options[i].text, selValue);
			}
			sourceObj.options[i].selected = false;
		}
	}
}

function ozDlgOkFn(){
	var selOptionObj = document.getElementById("addItems");
	var option = null;
	var len = selOptionObj.length;
	if(len == 0){
		OZ.Msg.alert('请选择');
        return false;
    }

	var addItems = new Array();
	for(var i = 0; i < len; i++){
		var value = selOptionObj.options[i].value;
		var text = selOptionObj.options[i].text;
		var values = value.split(".");
		addItems[i] = {id : value, name : text , value : { id : values[0] , type : values[1] ,text : text}};
	}
	for(var i = 0; i < len; i++){
		// alert("id=" + addItems[i].id + ", name=" + addItems[i].name + ", valueId=" + addItems[i].value.id + ", valueType=" + addItems[i].value.type + ", valueText=" + addItems[i].value.text);
	}
	return addItems;
}

$(function(){
	var selecteds = ozWindow.option("selecteds");
	if(selecteds){
		var selOptionObj = document.getElementById("addItems");
		$.each(selecteds,function(i,item){
			selOptionObj.options[selOptionObj.length] = new Option(item.name, item.id);
		});
	}
	
	$(".ui-tab").oTabs().bind("select",function(e,index,tab){
		onPageActive(tab.data("id"), true , tab);
	});
});
</script>
</html>