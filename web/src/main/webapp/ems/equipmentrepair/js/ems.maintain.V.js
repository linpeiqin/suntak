function oz_GetTitle(json){
    return "保养记录表";
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
    if (!window.parent.OZ.View){
        return  -2;
    }
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

function isStatusFormatter(value, json){
    if(value == 0) return '<font color="red">待执行</font>';
    if(value == 1) return '<font color="green">已执行</font>';
}
