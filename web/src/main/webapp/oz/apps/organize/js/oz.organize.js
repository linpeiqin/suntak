/**
 * 组织结构处理
 * CD826 2010-08-11
 */
OZ.Organize = {
	/**
	 * 单选组织架构信息，选择范围为用户的数据权限范围
	 */
	selectOUInfo: function(onAfterSelected, richInputId){
		OZ.Organize.selectOUInfoWithUnitID(-1, "", onAfterSelected, richInputId);
	},
	
	/**
	 * 单选单位，选择范围为用户的数据权限范围
	 */
	selectUnit: function(onAfterSelected, richInputId){
		OZ.Organize.selectOUInfoWithUnitID(-1, "DW", onAfterSelected, richInputId);
	},
	
	/**
	 * 单选部门，选择范围为用户的数据权限范围
	 */
	selectDepartment: function(onAfterSelected, richInputId){
		OZ.Organize.selectOUInfoWithUnitID(-1, "BM", onAfterSelected, richInputId);
	},
	
	/**
	 * 单选组织架构信息，选择范围为本单位
	 */
	selectOUInfoLocal: function(onAfterSelected, richInputId){
		OZ.Organize.selectOUInfoWithUnitID(0, "", onAfterSelected, richInputId);
	},
	
	/**
	 * 单选单位，选择范围为本单位
	 */
	selectUnitLocal: function(onAfterSelected, richInputId){
		OZ.Organize.selectOUInfoWithUnitID(0, "DW", onAfterSelected, richInputId);
	},
	
	/**
	 * 单选部门，选择范围为本单位
	 */
	selectDepartmentLocal: function(onAfterSelected, richInputId){
		OZ.Organize.selectOUInfoWithUnitID(0, "BM", onAfterSelected, richInputId);
	},
	
	/**
	 * 单选组织架构信息，选择范围为指定单位
	 */
	selectOUInfoSpecial: function(ouId, onAfterSelected, richInputId){
		OZ.Organize.selectOUInfoWithUnitID(ouId, "", onAfterSelected, richInputId);
	},
	
	/**
	 * 单选单位，选择范围为指定单位
	 */
	selectUnitSpecial: function(ouId, onAfterSelected, richInputId){
		OZ.Organize.selectOUInfoWithUnitID(ouId, "DW", onAfterSelected, richInputId);
	},
	
	/**
	 * 单选部门，选择范围为指定单位
	 */
	selectDepartmentSpecial: function(ouId, onAfterSelected, richInputId){
		OZ.Organize.selectOUInfoWithUnitID(ouId, "BM", onAfterSelected, richInputId);
	},
	
	/**
	 * 单选组织架构信息，选择范围为全部单位
	 */
	selectOUInfoAllScope: function(onAfterSelected, richInputId){
		OZ.Organize.selectOUInfoWithUnitID(-2, "", onAfterSelected, richInputId);
	},
	
	/**
	 * 单选单位，选择范围为全部单位
	 */
	selectUnitAllScope: function(onAfterSelected, richInputId){
		OZ.Organize.selectOUInfoWithUnitID(-2, "DW", onAfterSelected, richInputId);
	},
	
	/**
	 * 单选部门，选择范围为全部单位
	 */
	selectDepartmentAllScope: function(onAfterSelected, richInputId){
		OZ.Organize.selectOUInfoWithUnitID(-2, "BM", onAfterSelected, richInputId);
	},
	
	/**
	 * 单选组织架构信
	 * @param ouId -1：表示根据用户的权限选择组织架构；0：表示选择当前人员所属单位的组织架构，其他值表示获取该单位中的组织架构
	 * @param onAfterSelected 回调函数
	 * @param richInputId 相应输入框的ID 
	 */
	selectOUInfoWithUnitID: function(ouId, ouType, onAfterSelected, richInputId){
		var strUrl = contextPath + "/organize/ouTreeAction.do?action=dlgSelectOUInfo&ouId=" + ouId;
		strUrl += "&ouType=" + ouType || "";
		strUrl += "&timeStamp=" + new Date().getTime();
		
		new OZ.Dlg.create({ 
			id:"dlg_selectOUInfo", width:300, height:330,
			title:"选择组织架构",
			url: strUrl,
			onOk:function(result){
				if((typeof onAfterSelected) == "function"){
					if(onAfterSelected.call(this, result)){
						if(null != richInputId && richInputId.length > 0)
							OZ.Organize.onAfterSelectOUInfo4RichInput(richInputId, result, false);
					}
				}else{
					if(null != richInputId && richInputId.length > 0)
						OZ.Organize.onAfterSelectOUInfo4RichInput(richInputId, result, true);
				}
			},
			onCancel:function(result){
				// do nothing...
			}
		});
	},
	
	/**
	 * 多选组织架构信息，选择范围为用户的数据权限范围
	 */
	selectOUInfos: function(onAfterSelected, richInputId, idValuesCallBack, idField, idRegex){
		OZ.Organize.selectOUInfosWithUnitID(-1, "", onAfterSelected, richInputId, idValuesCallBack, idField, idRegex);
	},
	
	/**
	 * 多选单位，选择范围为用户的数据权限范围
	 */
	selectUnits: function(onAfterSelected, richInputId, idValuesCallBack, idField, idRegex){
		OZ.Organize.selectOUInfosWithUnitID(-1, "DW", onAfterSelected, richInputId, idValuesCallBack, idField, idRegex);
	},
	
	/**
	 * 多选部门，选择范围为用户的数据权限范围
	 */
	selectDepartments: function(onAfterSelected, richInputId, idValuesCallBack, idField, idRegex){
		OZ.Organize.selectOUInfosWithUnitID(-1, "BM", onAfterSelected, richInputId, idValuesCallBack, idField, idRegex);
	},
	
	/**
	 * 多选组织架构信息，选择范围为本单位
	 */
	selectOUInfosLocal: function(onAfterSelected, richInputId, idValuesCallBack, idField, idRegex){
		OZ.Organize.selectOUInfosWithUnitID(0, "", onAfterSelected, richInputId, idValuesCallBack, idField, idRegex);
	},
	
	/**
	 * 多选单位，选择范围为本单位
	 */
	selectUnitsLocal: function(onAfterSelected, richInputId, idValuesCallBack, idField, idRegex){
		OZ.Organize.selectOUInfosWithUnitID(0, "DW", onAfterSelected, richInputId, idValuesCallBack, idField, idRegex);
	},
	
	/**
	 * 多选部门，选择范围为本单位
	 */
	selectDepartmentsLocal: function(onAfterSelected, richInputId, idValuesCallBack, idField, idRegex){
		OZ.Organize.selectOUInfosWithUnitID(0, "BM", onAfterSelected, richInputId, idValuesCallBack, idField, idRegex);
	},
	
	/**
	 * 多选组织架构信息，选择范围为指定单位
	 */
	selectOUInfosSpecial: function(ouId, onAfterSelected, richInputId, idValuesCallBack, idField, idRegex){
		OZ.Organize.selectOUInfosWithUnitID(ouId, "", onAfterSelected, richInputId, idValuesCallBack, idField, idRegex);
	},
	
	/**
	 * 多选单位，选择范围为指定单位
	 */
	selectUnitsSpecial: function(ouId, onAfterSelected, richInputId, idValuesCallBack, idField, idRegex){
		OZ.Organize.selectOUInfosWithUnitID(ouId, "DW", onAfterSelected, richInputId, idValuesCallBack, idField, idRegex);
	},
	
	/**
	 * 多选部门，选择范围为指定单位
	 */
	selectDepartmentsSpecial: function(ouId, onAfterSelected, richInputId, idValuesCallBack, idField, idRegex){
		OZ.Organize.selectOUInfosWithUnitID(ouId, "BM", onAfterSelected, richInputId, idValuesCallBack, idField, idRegex);
	},

	/**
	 * 多选组织架构信息，选择范围为全部单位
	 */
	selectOUInfosAllScope: function(onAfterSelected, richInputId, idValuesCallBack, idField, idRegex){
		OZ.Organize.selectOUInfosWithUnitID(-2, "", onAfterSelected, richInputId, idValuesCallBack, idField, idRegex);
	},
	
	/**
	 * 多选单位，选择范围为全部单位
	 */
	selectUnitsAllScope: function(onAfterSelected, richInputId, idValuesCallBack, idField, idRegex){
		OZ.Organize.selectOUInfosWithUnitID(-2, "DW", onAfterSelected, richInputId, idValuesCallBack, idField, idRegex);
	},
	
	/**
	 * 多选部门，选择范围为全部单位
	 */
	selectDepartmentsAllScope: function(onAfterSelected, richInputId, idValuesCallBack, idField, idRegex){
		OZ.Organize.selectOUInfosWithUnitID(-2, "BM", onAfterSelected, richInputId, idValuesCallBack, idField, idRegex);
	},
	
	/**
	 * 多选组织架构
	 * @param ouId -1：表示根据用户的权限选择组织架构；0：表示选择当前人员所属单位的组织架构，其他值表示获取该单位中的组织架构
	 * @param onAfterSelected 回调函数
	 * @param idValuesCallBack 获取已选的OUInfoID的回调函数
	 * @param idField 记录已选OUInfoID的字段
	 * @param idRegex 已选OUInfoID分隔符，默认采用,
	 */
	selectOUInfosWithUnitID: function(ouId, ouType, onAfterSelected, richInputId, idValuesCallBack, idField, idRegex){
		var strUrl = contextPath + "/organize/ouTreeAction.do?action=dlgSelectOUInfo&multi=y&ouId=" + ouId;
		strUrl += "&ouType=" + ouType || "";
		strUrl += "&timeStamp=" + new Date().getTime();
		
		// 获取已经选择的OUInfo
		var ouInfoIds = OZ.Organize.getIdValues(idValuesCallBack, idField, idRegex);
		if(null != ouInfoIds && ouInfoIds.length > 0)
			strUrl += "&ids=" + ouInfoIds;
				
		new OZ.Dlg.create({ 
			id:"dlg_selectOUInfo", 
			width:520, height:340,
			title:"选择组织架构",
			url: strUrl,
			onOk:function(result){
				if((typeof onAfterSelected) == "function"){
					if(onAfterSelected.call(this, result)){
						if(null != richInputId && richInputId.length > 0)
							OZ.Organize.onAfterSelectOUInfos4RichInput(richInputId, result, false);
					}
				}else{
					if(null != richInputId && richInputId.length > 0)
						OZ.Organize.onAfterSelectOUInfos4RichInput(richInputId, result, true);
				}
				
			},
			onCancel:function(result){
				// do nothing...
			}
		});
	},
	
	/**
	 * 获取OU的详细信息
	 * @param ouId OU的ID
	 * @param onAfterGetDetail 获取OU详细信息后需要调用的函数，参数为OUInfo的详细信息
	 */
	getOUInfoDetail: function(ouId, onAfterGetDetail){
		var strUrl = contextPath + "/organize/ouInfoAction.do?action=getOUInfoDetail";
		strUrl += "&timeStamp=" + new Date().getTime();
		$.getJSON(
			strUrl, 
			{id:ouId},
			function(json){
				if((typeof onAfterGetDetail) == "function"){
					onAfterGetDetail.call(this, json);
				}
			}
		);
	},
	
	/**
	 * 单选岗位信息，选择范围为用户的数据权限范围
	 */
	selectGroup: function(onAfterSelected, groupType){
		OZ.Organize.selectGroupWithOUInfoID(-1, onAfterSelected, groupType);
	},
	
	/**
	 * 单选岗位信息，选择范围为本单位
	 */
	selectGroupLocal: function(onAfterSelected, groupType){
		OZ.Organize.selectGroupWithOUInfoID(0, onAfterSelected, groupType);
	},
	
	/**
	 * 单选岗位信息，选择范围为指定单位
	 */
	selectGroupSpecial: function(ouId, onAfterSelected, groupType){
		OZ.Organize.selectGroupWithOUInfoID(ouId, onAfterSelected, groupType);
	},

	/**
	 * 单选岗位信息，选择范围为全部单位
	 */
	selectGroupAllScope: function(onAfterSelected, groupType){
		OZ.Organize.selectGroupWithOUInfoID(-2, onAfterSelected, groupType);
	},
	
	/**
	 * 单选岗位信息
	 * @param ouId -1：表示根据用户的权限选择；0：表示选择当前人员所属单位中的岗位，其他值表示获取该OU中的岗位
	 * @param onAfterSelected 回调函数
	 */
	selectGroupWithOUInfoID: function(ouId, onAfterSelected, groupType){
		var strUrl = contextPath + "/organize/groupAction.do?action=dlgSelectGroup&ouId=" + ouId;
		strUrl += "&groupType=" + (groupType || "");
		strUrl += "&timeStamp=" + new Date().getTime();
		new OZ.Dlg.create({ 
			id:"dlg_selectGroup", 
			width:410, height:340,
			title:"选择岗位",
			url: strUrl,
			onOk:function(result){
				if((typeof onAfterSelected) == "function"){
					onAfterSelected.call(this, result);
				}
			},
			onCancel:function(result){
				// do nothing...
			}
		});
	},
	
	/**
	 * 复选岗位信息，选择范围为用户的数据权限范围
	 */
	selectGroups: function(onAfterSelected, groupType, idValuesCallBack, idField, idRegex){
		OZ.Organize.selectGroupsWithOUInfoID(-1, onAfterSelected, groupType, idValuesCallBack, idField, idRegex);
	},
	
	/**
	 * 复选岗位信息，选择范围为本单位
	 */
	selectGroupsLocal: function(onAfterSelected, groupType, idValuesCallBack, idField, idRegex){
		OZ.Organize.selectGroupsWithOUInfoID(0, onAfterSelected, groupType, idValuesCallBack, idField, idRegex);
	},
	
	/**
	 * 复选岗位信息，选择范围为指定单位
	 */
	selectGroupsSpecial: function(ouId, onAfterSelected, groupType, idValuesCallBack, idField, idRegex){
		OZ.Organize.selectGroupsWithOUInfoID(ouId, onAfterSelected, groupType, idValuesCallBack, idField, idRegex);
	},

	/**
	 * 复选岗位信息，选择范围为全部单位
	 */
	selectGroupsAllScope: function(onAfterSelected, groupType, idValuesCallBack, idField, idRegex){
		OZ.Organize.selectGroupsWithOUInfoID(-2, onAfterSelected, groupType, idValuesCallBack, idField, idRegex);
	},
		
	/**
	 * 复选岗位信息
	 * @param ouId -1：表示根据用户的权限选择；0：表示选择当前人员所属单位中的岗位，其他值表示获取该OU中的岗位
	 * @param onAfterSelected 回调函数
	 * @param groupType 岗位类型
	 * @param idValuesCallBack 获取已选的岗位ID的回调函数
	 * @param idField 记录已选岗位ID的字段
	 * @param idRegex 已选岗位ID分隔符，默认采用,
	 */
	selectGroupsWithOUInfoID: function(ouId, onAfterSelected, groupType, idValuesCallBack, idField, idRegex){		
		var strUrl = contextPath + "/organize/groupAction.do?action=dlgSelectGroup&multi=y&ouId=" + ouId;
		strUrl += "&groupType=" + (groupType || "");
		strUrl += "&timeStamp=" + new Date().getTime();
		
		// 获取已经选择的岗位
		var groupIds = OZ.Organize.getIdValues(idValuesCallBack, idField, idRegex);
		if(null != groupIds && groupIds.length > 0)
			strUrl += "&ids=" + groupIds;
		
		new OZ.Dlg.create({ 
			id:"dlg_selectGroup", 
			width:614, height:340,
			title:"选择岗位",
			url: strUrl,
			onOk:function(result){
				if((typeof onAfterSelected) == "function"){
					onAfterSelected.call(this, result);
				}
			},
			onCancel:function(result){
				// do nothing...
			}
		});
	},
	
	/**
	 * 获取岗位的详细信息
	 * @param groupId 岗位的ID
	 * @param onAfterGetDetail 获取岗位详细信息后需要调用的函数，参数为Group的详细信息
	 */
	getGroupDetail: function(groupId, onAfterGetDetail){
		var strUrl = contextPath + "/organize/groupAction.do?action=getGroupDetail";
		strUrl += "&timeStamp=" + new Date().getTime();
		$.getJSON(
			strUrl, 
			{id:groupId},
			function(json){
				if((typeof onAfterGetDetail) == "function"){
					onAfterGetDetail.call(this, json);
				}
			 }
		);
	},
	
	/**
	 * 单选用户信息，选择范围为用户的数据权限范围
	 */
	selectUser: function(onAfterSelected, userType){
		OZ.Organize.selectUserWithOUInfoID(-1, onAfterSelected, userType);
	},
	
	/**
	 * 单选用户信息，选择范围为本单位
	 */
	selectUserLocal: function(onAfterSelected, userType){
		OZ.Organize.selectUserWithOUInfoID(0, onAfterSelected, userType);
	},
	
	/**
	 * 单选用户信息，选择范围为指定单位
	 */
	selectUserSpecial: function(ouId, onAfterSelected, userType){
		OZ.Organize.selectUserWithOUInfoID(ouId, onAfterSelected, userType);
	},

	/**
	 * 单选用户信息，选择范围为全部单位
	 */
	selectUserAllScope: function(onAfterSelected, userType){
		OZ.Organize.selectUserWithOUInfoID(-2, onAfterSelected, userType);
	},
	
	/**
	 * 单选用户信息
	 * @param ouId -1：表示根据用户的权限选择；0：表示选择当前人员所属单位中的用户，其他值表示获取该OU中的用户
	 * @param onAfterSelected 回调函数
	 */
	selectUserWithOUInfoID: function(ouId, onAfterSelected, userType){
		var strUrl = contextPath + "/organize/userInfoAction.do?action=dlgSelectUser&ouId=" + ouId;
		strUrl += "&userType=" + (userType || "");
		strUrl += "&timeStamp=" + new Date().getTime();
		
		new OZ.Dlg.create({
			id:"dlg_selectUser", width:410, height:346,
			title:"选择用户",
			url: strUrl,
			onOk:function(result){
				if((typeof onAfterSelected) == "function"){
					onAfterSelected.call(this, result);
				}
			},
			onCancel:function(result){
				// do nothing...
			}
		});
	},
	
	/**
	 * 复选用户信息，选择范围为用户的数据权限范围
	 */
	selectUsers: function(onAfterSelected, userType, idValuesCallBack, idField, idRegex){
		OZ.Organize.selectUsersWithOUInfoID(-1, onAfterSelected, userType, idValuesCallBack, idField, idRegex);
	},
	
	/**
	 * 复选用户信息，选择范围为本单位
	 */
	selectUsersLocal: function(onAfterSelected, userType, idValuesCallBack, idField, idRegex){
		OZ.Organize.selectUsersWithOUInfoID(0, onAfterSelected, userType, idValuesCallBack, idField, idRegex);
	},
	
	/**
	 * 复选用户信息，选择范围为指定单位
	 */
	selectUsersSpecial: function(ouId, onAfterSelected, userType, idValuesCallBack, idField, idRegex){
		OZ.Organize.selectUsersWithOUInfoID(ouId, onAfterSelected, userType, idValuesCallBack, idField, idRegex);
	},

	/**
	 * 复选用户信息，选择范围为全部单位
	 */
	selectUsersAllScope: function(onAfterSelected, userType, idValuesCallBack, idField, idRegex){
		OZ.Organize.selectUsersWithOUInfoID(-2, onAfterSelected, userType, idValuesCallBack, idField, idRegex);
	},
	
	/**
	 * 复选用户信息
	 * @param ouId -1：表示根据用户的权限选择；0：表示选择当前人员所属单位中的用户，其他值表示获取该OU中的用户
	 * @param onAfterSelected 回调函数
	 * @param userType 用户类型
	 * @param idValuesCallBack 获取已选的用户ID的回调函数
	 * @param idField 记录已选用户ID的字段
	 * @param idRegex 已选用户ID分隔符，默认采用,
	 */
	selectUsersWithOUInfoID: function(ouId, onAfterSelected, userType, idValuesCallBack, idField, idRegex){
		var strUrl = contextPath + "/organize/userInfoAction.do?action=dlgSelectUser&multi=y&ouId=" + ouId;
		strUrl += "&userType=" + (userType || "");
		strUrl += "&timeStamp=" + new Date().getTime();
		
		// 获取已经选择的用户
		var userIds = OZ.Organize.getIdValues(idValuesCallBack, idField, idRegex);
		if(null != userIds && userIds.length > 0)
			strUrl += "&ids=" + userIds;
		
		new OZ.Dlg.create({ 
			id:"dlg_selectUser", width:614, height:340,
			title:"选择用户",
			url: strUrl,
			onOk:function(result){
				if((typeof onAfterSelected) == "function"){
					onAfterSelected.call(this, result);
				}
			},
			onCancel:function(result){
				// do nothing...
			}
		});
	},	

	/**
	 * 获取用户的详细信息
	 * @param userId 用户的ID
	 * @param onAfterGetDetail 获取用户详细信息后需要调用的函数，参数为User的详细信息
	 */
	getUserDetail: function(userId, onAfterGetDetail){
		var strUrl = contextPath + "/organize/userInfoAction.do?action=getUserDetail";
		strUrl += "&timeStamp=" + new Date().getTime();
		$.getJSON(
			strUrl, 
			{id:userId},
			function(json){
				if((typeof onAfterGetDetail) == "function"){
					onAfterGetDetail.call(this, json);
				}
			}
		);
	},
	
	/**
	 * 单选人员信息，选择范围为用户的数据权限范围
	 */
	selectUserInfo: function(onAfterSelected, userType){
		OZ.Organize.selectUserInfoWithOUInfoID(-1, onAfterSelected, userType);
	},
	
	/**
	 * 单选人员信息，选择范围为本单位
	 */
	selectUserInfoLocal: function(onAfterSelected, userType){
		OZ.Organize.selectUserInfoWithOUInfoID(0, onAfterSelected, userType);
	},
	
	/**
	 * 单选人员信息，选择范围为指定单位
	 */
	selectUserInfoSpecial: function(ouId, onAfterSelected, userType){
		OZ.Organize.selectUserInfoWithOUInfoID(ouId, onAfterSelected, userType);
	},

	/**
	 * 单选人员信息，选择范围为全部单位
	 */
	selectUserInfoAllScope: function(onAfterSelected, userType){
		OZ.Organize.selectUserInfoWithOUInfoID(-2, onAfterSelected, userType);
	},
		
	/**
	 * 单选人员信息
	 * @param ouId -1：表示根据用户的权限选择；0：表示选择当前人员所属单位中的人员，其他值表示获取该OU中的人员
	 * @param onAfterSelected 回调函数
	 */
	selectUserInfoWithOUInfoID: function(ouId, onAfterSelected, userType){
		var strUrl = contextPath + "/organize/userInfoAction.do?action=dlgSelectUserInfo&ouId=" + ouId;
		strUrl += "&userType=" + (userType || "");
		strUrl += "&timeStamp=" + new Date().getTime();
		new OZ.Dlg.create({ 
			id:"dlg_selectUserInfo", 
			width:410, height:340,
			title:"选择人员",
			url: strUrl,
			onOk:function(result){
				if((typeof onAfterSelected) == "function"){
					onAfterSelected.call(this, result);
				}
			},
			onCancel:function(result){
				// do nothing...
			}
		});
	},
	
	/**
	 * 复选人员信息，选择范围为用户的数据权限范围
	 */
	selectUserInfos: function(onAfterSelected, userType, idValuesCallBack, idField, idRegex){
		OZ.Organize.selectUserInfosWithOUInfoID(-1, onAfterSelected, userType, idValuesCallBack, idField, idRegex);
	},
	
	/**
	 * 复选人员信息，选择范围为本单位
	 */
	selectUserInfosLocal: function(onAfterSelected, userType, idValuesCallBack, idField, idRegex){
		OZ.Organize.selectUserInfosWithOUInfoID(0, onAfterSelected, userType, idValuesCallBack, idField, idRegex);
	},
	
	/**
	 * 复选人员信息，选择范围为指定单位
	 */
	selectUserInfosSpecial: function(ouId, onAfterSelected, userType, idValuesCallBack, idField, idRegex){
		OZ.Organize.selectUserInfosWithOUInfoID(ouId, onAfterSelected, userType, idValuesCallBack, idField, idRegex);
	},

	/**
	 * 复选人员信息，选择范围为全部单位
	 */
	selectUserInfosAllScope: function(onAfterSelected, userType, idValuesCallBack, idField, idRegex){
		OZ.Organize.selectUserInfosWithOUInfoID(-2, onAfterSelected, userType, idValuesCallBack, idField, idRegex);
	},
		
	/**
	 * 复选人员信息
	 * @param ouId -1：表示根据用户的权限选择；0：表示选择当前人员所属单位中的人员，其他值表示获取该OU中的人员
	 * @param onAfterSelected 回调函数
	 * @param userType 人员类型
	 * @param idValuesCallBack 获取已选的人员ID的回调函数
	 * @param idField 记录已选人员ID的字段
	 * @param idRegex 已选人员ID分隔符，默认采用,
	 */
	selectUserInfosWithOUInfoID: function(ouId, onAfterSelected, userType, idValuesCallBack, idField, idRegex){
		var strUrl = contextPath + "/organize/userInfoAction.do?action=dlgSelectUserInfo&multi=y&ouId=" + ouId;
		strUrl += "&userType=" + (userType || "");
		strUrl += "&timeStamp=" + new Date().getTime();
		
		// 获取已经选择的人员
		var userInfoIds = OZ.Organize.getIdValues(idValuesCallBack, idField, idRegex);
		if(null != userInfoIds && userInfoIds.length > 0)
			strUrl += "&ids=" + userInfoIds;
		
		new OZ.Dlg.create({ 
			id:"dlg_selectUserInfo", width:614, height:340,
			title:"选择人员",
			url: strUrl,
			onOk:function(result){
				if((typeof onAfterSelected) == "function"){
					onAfterSelected.call(this, result);
				}
			},
			onCancel:function(result){
				// do nothing...
			}
		});
		
	},
					
	/**
	 * 获取人员的详细信息
	 * @param userInfoId 人员的ID
	 * @param onAfterGetDetail 获取人员详细信息后需要调用的函数，参数为UserInfo的详细信息
	 */
	getUserInfoDetail: function(userInfoId, onAfterGetDetail){
		var strUrl = contextPath + "/organize/userInfoAction.do?action=getUserInfoDetail";
		strUrl += "&timeStamp=" + new Date().getTime();
		$.getJSON(
			strUrl, 
			{id:userInfoId},
			function(json){
				if((typeof onAfterGetDetail) == "function"){
					onAfterGetDetail.call(this, json);
				}
			}
		);
	},
				
	/**
	 * 获取人员的详细信息
	 * @param userInfoId 人员的ID
	 * @param onAfterGetDetail 获取人员详细信息后需要调用的函数，参数为UserInfo的详细信息
	 */
	getUserInfosDetail: function(userInfoIds, onAfterGetDetail){
		var strUrl = contextPath + "/organize/userInfoAction.do?action=getUserInfosDetail";
		strUrl += "&timeStamp=" + new Date().getTime();
		$.getJSON(
			strUrl, 
			{ids:userInfoIds},
			function(json){
				if((typeof onAfterGetDetail) == "function"){
					onAfterGetDetail.call(this, json);
				}
			}
		);
	},
	
	onRichInputInit4Unit: function(richInputId){
		var ouIdField = $("#" + richInputId).data("richinput").idField;
		var ouNameField = $("#" + richInputId).data("richinput").nameField;
		var ouId = $("#" + ouIdField).val();
		if(null != ouId && ouId.length > 0){
			if(null != ouNameField && ouNameField.length > 0){
				value = $("#" + ouNameField).val();
			}
			$("#" + richInputId).richinput("addItem", [{id:ouId, value:value}]);
		}
	},
	
	onChange4Unit: function(e, items, changeItem){
		var ouIdField = $(this).data("richinput").idField;
		var ids =  $.map(items, function(ele, index){
			return ele.id;
		})
		if(null == ids || ids.length == 0)
			$("#" + ouIdField).val("-1");
		else
			$("#" + ouIdField).val(ids.join(","));
	},
	
	richInputFormat4Unit: function(data){
		if(typeof data == "string"){
			data = {value:data};
		}
		data.splitChar = this.options.splitChar;
		return $.render('<div unselectable="on" class="valueItem" style="color: black;" itemId="{{= this.id}}" itemValue="{{= this.value}}">{{= this.value}}</div>',data);
	},
	
	onAfterSelectOUInfo4RichInput: function(richInputId, result, updateIdField){
		$("#" + richInputId).richinput("clearAll");
		$("#" + richInputId).richinput("addItem",[{id:result.id,value:result.fullName}]);
		if(updateIdField){
			var ouIdField = $("#" + richInputId).data("richinput").idField;
			var ouNameField = $("#" + richInputId).data("richinput").nameField;
			if(null != ouIdField && ouIdField.length > 0){
				$("#" + ouIdField).val(result.id);
			}
			if(null != ouNameField && ouNameField.length > 0){
				$("#" + ouNameField).val(result.name);
			}
		}
	},
	
	onAfterSelectOUInfos4RichInput: function(richInputId, ouInfos, updateIdField){
		$("#" + richInputId).richinput("clearAll");
		var items = [];
		var ids = [];
		var names = [];
		for(var i = 0; i < ouInfos.length; i++){
			items[i] = {id:ouInfos[i].id, value:ouInfos[i].fullName};
			ids[i] = ouInfos[i].id;
			names[i] = ouInfos[i].fullName;
		}
		$("#" + richInputId).richinput("addItem", items);
		if(updateIdField){
			var ouIdField = $("#" + richInputId).data("richinput").idField;
			var ouNameField = $("#" + richInputId).data("richinput").nameField;
			if(null != ouIdField && ouIdField.length > 0){
				$("#" + ouIdField).val(ids.join(","));
			}
			if(null != ouNameField && ouNameField.length > 0){
				$("#" + ouNameField).val(names.join(","));
			}
		}
	},
	
	getIdValues: function(idValuesCallBack, idField, idRegex){
		var ids = [];
		if((typeof idValuesCallBack) == "function"){
			ids = idValuesCallBack.call(this);
		}else{
			idField = idField || "";
			if("" == idField)
				return "";			
			
			var tmpIds = $("#" + idField).val();
			if(null == tmpIds || tmpIds.length == 0)
				return "";
			
			idRegex = idRegex || ",";
			ids = tmpIds.split(idRegex);
		}
		
		if(null == ids || ids.length == 0)
			return "";
		return ids.join(";")
	},
	

	/**
	 * 显示姓名地址本
	 * @param multiple：是否是多选，默认为true
	 * @param onAfterSelected 回调函数 
	 */
	addressBook: function(onAfterSelected, ouId, multiple, param){
		ouId = ouId || 0;
		var strUrl = contextPath + "/organize/addressBookAction.do?action=addressBookDlg&ouId=" + ouId + "&" + $.param(param || {}, true);
		var width = "560";
		if(multiple){
			strUrl += "&multi=y";
		}else{
			width = "420";
			strUrl += "&multi=n";
		}
		strUrl += "&timeStamp=" + new Date().getTime();
				
		new OZ.Dlg.create({ 
			id:"dlg_AddressBook", 
			width:width, height:365,
			title:"姓名地址本",
			url: strUrl,
			onOk:function(result){
				if((typeof onAfterSelected) == "function"){
					onAfterSelected.call(this, result);
				}
			},
			onCancel:function(result){
				// do nothing...
			}
		});
	},	
	
	noUsed:false
};