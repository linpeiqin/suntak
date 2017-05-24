/**
 * Created by linking on 2016/8/4.
 */
function oz_GetTitle(json){
    return "备品备件";
}
var strUrl0 = contextPath + "/ems/groupInventoryAction.do?action=display";
var strUrl1 = contextPath + "/ems/orderLineAction.do?action=display";
var strUrl2 = contextPath + "/ems/partReplaceAction.do?action=display";
var strUrl3 = contextPath + "/ems/partInfoAction.do?action=openAttach";
var strUrl4 = contextPath + "/ems/partQualityAction.do?action=display";
$(function(){
    $("#tabCt").tabs();
    $("#tabCt").tabs("activeTab","tab_00");
    loadSubPanel("IFRAME_00",strUrl0);
    loadSubPanel("IFRAME_01",strUrl1);
    loadSubPanel("IFRAME_02",strUrl2);
    loadSubPanel("IFRAME_03",strUrl3);
    loadSubPanel("IFRAME_04",strUrl4);
});

function oz_Row_DBLClicked(rowIndex,rowData){
    initTabs(rowData.partNo,rowData.id);
}

function initTabs(partNo,partId){
    $("#IFRAME_00")[0].contentWindow.reloadGridSelf(partNo);
    $("#IFRAME_01")[0].contentWindow.reloadGridSelf(partNo);
    $("#IFRAME_02")[0].contentWindow.reloadGridSelf("partId",partId);
    loadSubPanel("IFRAME_03",strUrl3+"&id="+partId);
    $("#IFRAME_04")[0].contentWindow.reloadGridSelf(partNo);
}

//重写视图尺寸方法
OZ.View.resize = function(){
    var ch = $(window).height()-$("#page-top").height();
    var cw = $(window).width();
    $("#page-center").height(ch);
    $("#page-center-grid").height(ch/2).width(cw).css("left",0);
    $("#moveLine").css("top",ch/2);
    $("#tabCt").css("top",ch/2+5).height(ch/2-5).width(cw);
    var param = {width:cw,height:ch/2-5,top:ch/2+5};
    $("#tabCt").tabs("resize",param);
    if(typeof(oz_grid_config) != "undefined"){
        $("#" + oz_grid_config.id).grid("resize");
    }
}

function oz_Default_Open_Row(rowIndex,rowData,data){
    new OZ.Dlg.create({
        id:oz_grid_config.id+rowData.id,
        width:800, height:400,
        title:oz_GetTabTitle(rowData),
        url: OZ.addParamToUrl(oz_grid_config.path,"action="+ozOpenActionName+"&id=" + rowData.id),
        buttons:[{text:'关闭', handler:$.noop}],
        maximizable:true
    });
}