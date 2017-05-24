function getId(){
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

function reloadData(data){
    $('#faultTypeName').html(data.faultTypeName);
    $('#appearanceSummary').html(data.appearanceSummary);
    $('#apearanceDetail').html(data.apearanceDetail);
    $('#dealSummary').html(data.dealSummary);
    $('#dealDetail').html(data.dealDetail);

}