/**
 * Created by linking on 2016/8/4.
 */

function reloadGridSelf(idType,wid){
    reloadData(idType);
}

function reloadData(idType){
    var searchQuery = {};
    if ($("#ozQuery").val()!=""){
        searchQuery.dbftsParams = $("#ozQuery").val();
    }
    var wId = getWId();
    if (idType=="partId")
        searchQuery.partId = wId;
    if (idType=="equipmentId")
        searchQuery.equipmentId = wId;
    OZ.View.reloadGrid(searchQuery);
}
function getWId(){
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


function oz_Row_DBLClicked(rowIndex,rowData){
}