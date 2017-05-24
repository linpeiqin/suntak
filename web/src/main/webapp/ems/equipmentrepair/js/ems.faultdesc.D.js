OZ.View.resize = function(vheight){
    var ch = $(window).height()-$("#page-top").height()-100;
    if($("#page-center-tree").length){
        $("#page-center,#page-center-tree,#page-center-seperator").height(ch);
        $("#page-center-grid,#page-center-grid-top").width($(window).width()-$("#page-center-tree").width()-$("#page-center-seperator").width());
        var gridTop = $("#page-center-grid-top");
        var h2 = gridTop.is(":visible") ? gridTop.outerHeight(true) : 0;//border+padding+content
        $("#page-center-grid").css("top",h2).height((ch - h2));
    }else{
        $extendContainer = $("#page-top-extendContainer");
        var h2 = $extendContainer.is(":visible") ? $extendContainer.outerHeight(true) : 0;//border+padding+content
        if (vheight){
            $("#page-center").height(vheight);
        } else {
            $("#page-center").height((ch-h2)/2);
        }
    }
    if(typeof(oz_grid_config) != "undefined"){
        $("#" + oz_grid_config.id).grid("resize");
    }
}

var strUrl = contextPath + "/ems/faultDescAction.do?action=dfFaultDesc";
function loadSubFrame(iframeId, strUrl){
    var iframeObj = $("#" + iframeId).get(0);
    iframeObj.src = strUrl + "&timeStamp=" + new Date().getTime();
}

$(function(){
    loadSubFrame("IFRAME_BOX",strUrl);

});
function oz_Row_DBLClicked(rowIndex,rowData){
    $("#IFRAME_BOX")[0].contentWindow.reloadData(rowData);
}



function ozDlgOkFn(){
    var rows = OZ.View.getGridSelection();
    if (rows.length==0){
        oz.Msg.info("请选择一条故障详细信息！");
        return false;
    }
    return {faultType:rows[0].faultType,apearanceDetail:rows[0].apearanceDetail,dealDetail:rows[0].dealDetail};
}

