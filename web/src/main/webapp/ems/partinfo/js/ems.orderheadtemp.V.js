/**
 * Created by linking on 2016/8/4.
 */
function oz_GetTitle(json){
    return "配件领用出库";
}

function onBtnNewInOrOutClick(action,type){
    ozTB_DefaultBtnNew_Clicked(action,contextPath + "/ems/orderHeadTempAction.do?action=create");
}

function oz_Default_Open_Row(rowIndex,rowData,data){
    new OZ.Dlg.create({
        id:oz_grid_config.id+rowData.id,
        width:1000, height:650,
        title:oz_GetTabTitle(rowData),
        url: OZ.addParamToUrl(contextPath + "/ems/orderHeadTempAction.do","action=edit&id=" + rowData.id),
        buttons:[{text:'关闭', handler:$.noop}],
        maximizable:true
    });
}

function formatEbsStatus(value,json){
    if(value==-1|| value=="")
        return "<a style= 'color: black'>未同步</a>";
    else if (value==0)
        return "<a style= 'color: grey'>同步失败</a>";
    else if (value==1)
        return "<a style= 'color: green'>同步成功</a>";
}
