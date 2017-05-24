function reloadGridSelf(parentId){
    reloadData(parentId);
}
function reloadData(parentId){
    var searchQuery = {};
    if ($("#ozQuery").val()!=""){
        searchQuery.dbftsParams = $("#ozQuery").val();
    }
    var eid = getParentId()||parentId;
    if (eid)
        searchQuery.parentId= eid;
    OZ.View.reloadGrid(searchQuery);
}
function getParentId(){
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

function onAddRelation(){
    var parentId = getParentId();
    if (!parentId){
        return false;
    }
    var strUrl = contextPath + "/ems/equipmentDetailsAction.do?action=dlgEquipmentY&id="+parentId;
    new OZ.Dlg.create({
        id:"dlg_equipment",
        width:900, height:600,
        title:'选择设备',
        url: strUrl,
        onOk:function(result){
            afterSelectEquipment(result.equipmentId,parentId);
        },onCancel:function(result){
        }
    });
}

function afterSelectEquipment(equipmentId,parentId){
    var strUrl = contextPath + "/ems/equipmentDetailsAction.do?action=addRelation";
    var json = {};
        json.equipmentId = equipmentId;
        json.parentId = parentId;
    $.getJSON(strUrl,json,function(reJson){
            oz.Msg.info(reJson.msg);
          reloadData(parentId);
    });
}

function onDeleteRelation(){
    var equipmentId = getEquipmentId();
    var parentId = getParentId();
    if (!parentId || !equipmentId){
        return false;
    }
    var strUrl = contextPath + "/ems/equipmentDetailsAction.do?action=deleteRelation";
    var json = {};
    json.equipmentId = equipmentId;
    json.parentId = parentId;
    $.getJSON(strUrl,json,function(reJson){
        oz.Msg.info(reJson.msg);
        reloadData(parentId)
    });
}

function getEquipmentId(){
    var rows = OZ.View.getGridSelection();
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