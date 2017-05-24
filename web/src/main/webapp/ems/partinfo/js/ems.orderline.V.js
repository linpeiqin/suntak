/**
 * Created by linking on 2016/8/4.
 */
function oz_GetTitle(json){
    return "备件出入库记录";
}
function reloadGridSelf(partNo){
    reloadData(partNo);
}
$("#selStatusSEL").change(function(){
    reloadData();
});

function onBtnSearch_Clicked(searchCondition){
    reloadData();
}

function onBtnReset_Clicked(){
    $("#ozQuery").val("");
    reloadData();
}
function reloadData(partNo){
    var searchQuery = {};
    if ($("#selStatusSEL").val()!=-1){
        searchQuery._EQI_orderHead_operation = $("#selStatusSEL").val();
    }
    if ($("#ozQuery").val()!=""){
        searchQuery.dbftsParams = $("#ozQuery").val();
    }
    searchQuery.partId = getPartId()||partNo;
    OZ.View.reloadGrid(searchQuery);
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

function oz_Default_Open_Row(rowIndex,rowData,data){
    new OZ.Dlg.create({
        id:oz_grid_config.id+rowData.id,
        width:1000, height:650,
        title:oz_GetTabTitle(rowData),
        url: OZ.addParamToUrl(contextPath + "/ems/orderHeadAction.do","action="+ozOpenActionName+"&id=" + rowData.orderHead.id),
        buttons:[{text:'关闭', handler:$.noop}],
        maximizable:true
    });
}

