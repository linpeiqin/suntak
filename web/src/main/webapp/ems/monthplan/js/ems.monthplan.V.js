function oz_GetTitle(json){
    return "保养月计划";
}

function oz_Default_Open_Row(rowIndex,rowData,data){
    var url = contextPath+"/ems/repairMonthPlanAction.do?action=edit&id="+rowData.id;
    new OZ.Dlg.create({
        id:oz_grid_config.id + "_edit" + (new Date().getTime()),
        width:1100, height:600,
        title:"月计划",
        url:url,
        buttons:[{text:'关闭', handler:$.noop}],
        maximizable:true
    });
}

function oz_Default_Row_DBLClicked(rowIndex,rowData,data){
	return false;
}