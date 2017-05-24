function onBtnNewClick(){
    ozTB_DefaultBtnNew_Clicked(contextPath + "/ems/pRHeadAction.do?action=create");
}
function oz_Row_DBLClicked(rowIndex,rowData){
}

function oz_Default_Open_Row(rowIndex,rowData,data){
	new OZ.Dlg.create({
        id:oz_grid_config.id+rowData.pRHead.id,
        width:1000, height:650,
        title:"申购单",
        url:contextPath + "/ems/pRHeadAction.do?action=open&id="+rowData.pRHead.id,
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
