/**
 * Acl
 * CD826 2010-08-16
 */
OZ.Acl = {
	onBtnEditAcl_Clicked: function(entityId, entityClazz, mask, ctrlId, idid){
		if((typeof getOzEntityId) == "function"){
			entityId = getOzEntityId.call(this);
		}
		
		if(null == entityId || entityId.length == 0 || entityId == -1){
			if(null != idid && idid.length > 0)
				entityId = $("#" + idid).val();
			if(null == entityId || entityId.length == 0 || entityId == -1){
				OZ.Msg.info("文档保存后才能够使用该功能。");
				return;
			}
		}
		
		var strUrl = contextPath + "/acl/aclAction.do?action=dlgAcl&entityId=" + entityId;
		strUrl += "&entityClazz=" + entityClazz + "&mask=" + mask + "&editFlag=y";
		strUrl += "&timeStamp=" + new Date().getTime();

		new OZ.Dlg.create({ 
			id:"dlg_EntityAcl", 
			width:420, height:462,
			title:"存取控制列表",
			url: strUrl,
			onOk:function(result){
				strUrl = contextPath + "/acl/aclAction.do?action=updateAcl";
				$.post(
					strUrl + "&timeStamp=" + new Date().getTime(),
					{entityId:entityId, entityClazz:entityClazz, mask:mask, sids:result},
					function(json){
						if(json.result == true){
							// OZ.Msg.info("设置成功。");
							$("#" + ctrlId).val(json.sids);
						}else{
							OZ.Msg.info(json.msg);
						}
					},
					"json"
				);
			},onCancel:function(result){
				// do nothing...
			}
		});
	},
	
	onBtnViewAcl_Clicked: function(entityId, entityClazz, mask){
		if((typeof getOzEntityId) == "function"){
			entityId = getOzEntityId.call(this);
		}
		
		var strUrl = contextPath + "/acl/aclAction.do?action=dlgAcl&entityId=" + entityId;
		strUrl += "&entityClazz=" + entityClazz + "&mask=" + mask + "&editFlag=n";
		strUrl += "&timeStamp=" + new Date().getTime();
		new OZ.Dlg.create({ 
			id:"dlg_EntityAcl", width:420, height:462,
			title:"存取控制列表",
			url: strUrl,
			buttons:[{text:"关闭",handler:$.noop}]
		});
	},
						
	noUsed:false
};