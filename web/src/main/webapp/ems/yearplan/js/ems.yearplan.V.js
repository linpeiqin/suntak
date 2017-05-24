function oz_GetTitle(json){
    return "保养年计划";
}

function oz_Default_Open_Row(rowIndex,rowData,data){
	    var url = contextPath+"/ems/repairYearPlanAction.do?action=edit&id="+rowData.id;
	    new OZ.Dlg.create({
	        id:oz_grid_config.id + "_edit" + (new Date().getTime()),
	        width:1100, height:600,
	        title:"年计划",
	        url:url,
	        buttons:[{text:'关闭', handler:$.noop}],
	        maximizable:true
	    });
}

function oz_Default_Row_DBLClicked(rowIndex,rowData,data){
	return false;
}


function createLastPlan(){
	var myDate = new Date();
	var year = myDate.getFullYear() + 1;
	if(year != ''){
		var strUrl = contextPath + "/ems/repairYearPlanAction.do?action=checkExist";
		var title = '';
		$.getJSON(
				strUrl,
				{year:year},
				function(json){
					if(json.isExt){
						title = year+"年计划已存在是否重新生成？";
					}else{
						title = "确定要生成"+year+"年计划？";
					}
					OZ.Msg.confirm(title,function(){
						strUrl = contextPath + "/ems/repairYearPlanAction.do?action=createByYear";
						strUrl+="&timeStamp=" + new Date().getTime();
//						$(".oz-body").mask("系统正在处理，请稍侯... ..."); // 添加遮罩
						$.getJSON(
								strUrl,
								{year:year},
								function(json){
//									$(".oz-body").unmask(); // 撤销遮罩
									if(json.result){
										oz.Msg.info("操作成功！");
										ozTB_BtnRefresh_Clicked();
									}else{
										oz.Msg.info(json.msg);
									}
								}
							);
					});
				}
			);
	}
}