/**
 * Created by linking on 2016/8/4.
 */
function oz_GetTitle(json){
    return "s设备关系";
}

function reloadData(equipmentId){
    var searchQuery = {};
    if ($("#ozQuery").val()!=""){
        searchQuery.dbftsParams = $("#ozQuery").val();
    }
    var eid = getEquipmentId()||equipmentId;
    if (eid)
        searchQuery.equipmentId = eid;
    OZ.View.reloadGrid(searchQuery);
}
function getEquipmentId(){
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
function reloadGridSelf(equipmentId){
    reloadData(equipmentId);
}

function onBtnSearch_Clicked(searchCondition){
    reloadData();
}

function onBtnReset_Clicked(){
    $("#ozQuery").val("");
    reloadData();
}