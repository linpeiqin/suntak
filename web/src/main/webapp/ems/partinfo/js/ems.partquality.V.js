function oz_GetTitle(json){
    return "备件质量评价";
}
function ozTB_DefaultBtnNew_Clicked(action,url){
    var partId = getPartId();
    if (partId==false){
        return ;
    }
    var url = url|| OZ.addParamToUrl(action, "action=create&partId="+partId);
    new OZ.Dlg.create({
        id:oz_grid_config.id + "_create" + (new Date().getTime()),
        width:600, height:400,
        title:"新建" + ($("body").data("name") || "文档"),
        url: url,
        buttons:[{text:'关闭', handler:$.noop}]
    });
}
function oz_Default_Open_Row(rowIndex,rowData,data){
    new OZ.Dlg.create({
        id:oz_grid_config.id+rowData.id,
        width:600, height:400,
        title:oz_GetTabTitle(rowData),
        url: OZ.addParamToUrl(oz_grid_config.path,"action="+ozOpenActionName+"&id=" + rowData.id),
        buttons:[{text:'关闭', handler:$.noop}]
    });
}
function getPartId(){
    var rows = window.parent.OZ.View.getGridSelection();
    if (rows.length==0){
        oz.Msg.info("请选择需要操作的数据！");
        return false;
    }
    if (rows.length>1){
        oz.Msg.info("请选择一个需要操作的数据记录！");
        return false;
    }
    return  rows[0].id;
}
function reloadGridSelf(partNo){
    reloadData(partNo);
}
function reloadData(partNo){
    var searchQuery = {};
    searchQuery.partId = getPartId()||partNo;
    OZ.View.reloadGrid(searchQuery);
}