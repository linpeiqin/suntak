function onUserInfoTree_Clicked(ouId){
	var node = $('#userInfoTree').tree('getSelected');
	if(null == node)
        return;
	if(node.type != "DW" && node.type != "dw" && node.type != "BM" && node.type != "bm")
		return;
	
	var selOptionObj = document.getElementById("userInfos");
    selOptionObj.length = 0;
    var strUrl = contextPath + "/organize/userInfoAction.do?action=findUserInfoByOUInfo&cascade=y&timeStamp=" + new Date().getTime();
    $.getJSON(
		strUrl, 
		{ouId:ouId},
		function(json){
			allUserInfos = json.userInfos;
			if(allUserInfos.length > 0){
				for(var i = 0; i < allUserInfos.length; i++){
					selOptionObj.options[selOptionObj.length] = new Option(allUserInfos[i].name, allUserInfos[i].id);
				}
			}
		}
	);
}

function findUserInfos(){
	var searchCondition = $("#userInfoSearchCondition").val();
	if(null == searchCondition || searchCondition.length < 1)
		return;
	
	var selOptionObj = document.getElementById("userInfos");
    selOptionObj.length = 0;
    var strUrl = contextPath + "/organize/userInfoAction.do?action=findUserInfoBySearch&timeStamp=" + new Date().getTime();
    $.getJSON(
		strUrl, 
		{searchCondition:searchCondition},
		function(json){
			allUserInfos = json.userInfos;
			if(allUserInfos.length > 0){
				OZ.SELECT.removeAll("userInfos");
				for(var i = 0; i < allUserInfos.length; i++){
					if(!OZ.SELECT.isExist("userInfo", allUserInfos[i].id)){
						selOptionObj.options[selOptionObj.length] = new Option(allUserInfos[i].name, allUserInfos[i].id);
					}
				}
			}
		}
	);	
}

function onGroupTree_Clicked(ouId){
	var node = $('#groupTree').tree('getSelected');
	if(null == node)
        return;
	if(node.type != "DW" && node.type != "dw" && node.type != "BM" && node.type != "bm")
		return;
	
	var selOptionObj = document.getElementById("groups");
    selOptionObj.length = 0;
    var strUrl = contextPath + "/organize/groupAction.do?action=findGroupByOUInfo&timeStamp=" + new Date().getTime();
    $.getJSON(
		strUrl, 
		{ouId:ouId},
		function(json){
			allGroups = json.groups;
			if(allGroups.length > 0){
				for(var i = 0; i < allGroups.length; i++){
					selOptionObj.options[selOptionObj.length] = new Option(allGroups[i].name, allGroups[i].id);
				}
			}
		}
	);
}

function onShortcutGroupTree_Clicked(groupId){
	var node = $('#shortcutGroupTree').tree('getSelected');
	if(null == node)
        return;
	
	var selOptionObj = document.getElementById("shortcutGroupMembers");
    selOptionObj.length = 0;
    var strUrl = contextPath + "/organize/privateGroupAction.do?action=findMembers&timeStamp=" + new Date().getTime();
    $.getJSON(
		strUrl, 
		{groupId:groupId, group:loadGroup, ouInfo:loadOUInfo, userInfo:loadUserInfo},
		function(json){
			allUserInfos = json.userInfos;
			if(allUserInfos.length > 0){
				for(var i = 0; i < allUserInfos.length; i++){
					selOptionObj.options[selOptionObj.length] = new Option(allUserInfos[i].name, allUserInfos[i].id);
				}
			}
		}
	);
}

function onPrivateGroupTree_Clicked(groupId){
	var node = $('#privateGroupTree').tree('getSelected');
	if(null == node)
        return;
	
	var selOptionObj = document.getElementById("privateGroupMembers");
    selOptionObj.length = 0;
    var strUrl = contextPath + "/organize/privateGroupAction.do?action=findMembers&timeStamp=" + new Date().getTime();
    $.getJSON(
		strUrl, 
		{groupId:groupId, group:loadGroup, ouInfo:loadOUInfo, userInfo:loadUserInfo},
		function(json){
			allUserInfos = json.userInfos;
			if(allUserInfos.length > 0){
				for(var i = 0; i < allUserInfos.length; i++){
					selOptionObj.options[selOptionObj.length] = new Option(allUserInfos[i].name, allUserInfos[i].id);
				}
			}
		}
	);
}

var checkPGFilter = function(node){
	if(window.checkPG===false){
		if("public" == node.type || "private" == node.type){
			node.checkbox = false;
		}
	}
	return true;
};

function onPageActive(pageId, editFlag , tab){
	var tabloaded = tab.data("tabloaded");	
	if(pageId == "tab_UserInfo"){
		if(tabloaded !== true){
			var strUrl = contextPath + '/organize/ouTreeAction.do?action=getTree&timeStamp=' + new Date().getTime();
			strUrl += "&ouId="+_ouId;
			$('#userInfoTree').tree({
				url: strUrl,
				click:function(e, data){
					onUserInfoTree_Clicked(data.id);
				}
			});
		}
		_addType = "UserInfo";
		_selectId = "userInfos";
	}else if(pageId == "tab_Group"){
		if(tabloaded !==true){
			var strUrl = contextPath + '/organize/ouTreeAction.do?action=getTree&timeStamp=' + new Date().getTime();
			strUrl += "&ouId="+_ouId;
			$('#groupTree').tree({
				url: strUrl,
				click:function(e, data){
					onGroupTree_Clicked(data.id);
				}
			});
		}
		_addType = "Group";
		_selectId = "groups";
	}else if(pageId == "tab_OUInfo"){
		if(tabloaded !==true){
			var strUrl = contextPath + '/organize/ouTreeAction.do?action=getTree&timeStamp=' + new Date().getTime();
			strUrl += "&ouId="+_ouId;
			$('#ouTree').tree({
				url:strUrl,
				checkbox:_multi,
				cascade:false,
				click:function(e, data){
					if($(data.target).find('.oz-tree-checkbox').hasClass('oz-tree-checkbox1')){
						$(data.target).find('.oz-tree-checkbox').removeClass('oz-tree-checkbox1').addClass('oz-tree-checkbox0');
					}else{
						$(data.target).find('.oz-tree-checkbox').removeClass('oz-tree-checkbox0').addClass('oz-tree-checkbox1');
					}
				}
			});			
		}
		_addType = "OUInfo";
		_selectId = "";
	}else if(pageId == "tab_SG"){
		// 便捷组的处理
		if(tabloaded !== true){
			var strUrl = contextPath + '/organize/privateGroupAction.do?action=getTree&type=public&timeStamp=' + new Date().getTime();
			strUrl += "&loadMembers=" + loadShortcutGroupMember + "&userInfo=" + loadUserInfo + "&group=" + loadGroup + "&ouInfo=" + loadOUInfo;
			$('#shortcutGroupTree').tree({
				url: strUrl,
				checkbox:_multi,
				nodeFilter:checkPGFilter
			});
		}
		_addType = "SG";
		_selectId = "";
	} else if (pageId == "tab_PG") {
		// 私有组的处理
		if(tabloaded !== true){
			var strUrl = contextPath + '/organize/privateGroupAction.do?action=getTree&timeStamp=' + new Date().getTime();
			strUrl += "&loadMembers=" + loadPrivateGroupMember + "&userInfo=" + loadUserInfo + "&group=" + loadGroup + "&ouInfo=" + loadOUInfo;
			$('#privateGroupTree').tree({
				url: strUrl,
				checkbox:_multi,
				nodeFilter:checkPGFilter
			});
		}
		_addType = "PG";
		_selectId = "";
	}
	tab.data("tabloaded", true);
}