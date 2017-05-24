
function loadSubPanel(iframeId, strUrl){
    var iframeObj = $("#" + iframeId).get(0);
    iframeObj.src = strUrl + "&timeStamp=" + new Date().getTime();
}

function oz_Default_Open_Row(rowIndex,rowData,data){
    new OZ.Dlg.create({
        id:oz_grid_config.id + "_create" + (new Date().getTime())+rowData.id,
        width:1000, height:650,
        title:oz_GetTabTitle(rowData),
        url: OZ.addParamToUrl(oz_grid_config.path,"action="+ozOpenActionName+"&id=" + rowData.id),
        buttons:[{text:'关闭', handler:$.noop}],
        maximizable:true
    });
}
    

function ozTB_DefaultBtnNew_Clicked(action,url){
    var url = url|| OZ.addParamToUrl(action, "action=create");
    new OZ.Dlg.create({
        id:oz_grid_config.id + "_create" + (new Date().getTime()),
        width:1000, height:650,
        title:"新建" + ($("body").data("name") || "文档"),
        url: url,
        buttons:[{text:'关闭', handler:$.noop}],
        maximizable:true
    });
}
function oz_Row_DBLClicked(rowIndex,rowData){
}