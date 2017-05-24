function oz_GetTitle(json){
    return "集团库存";
}

function getPartNo(){
    var rows = window.parent.OZ.View.getGridSelection();
    if (rows.length==0){
        oz.Msg.info("请选择需要操作的数据！");
        return false;
    }
    if (rows.length>1){
        oz.Msg.info("请选择一个需要操作的数据记录！");
        return false;
    }
    return  rows[0].partNo;
}
function reloadGridSelf(partNo){
    reloadData(partNo);
}
function reloadData(partNo){
    var searchQuery = {};
    searchQuery.partNo = getPartNo()||partNo;
    OZ.View.reloadGrid(searchQuery);
}

function oz_Row_DBLClicked(rowIndex,rowData){
}