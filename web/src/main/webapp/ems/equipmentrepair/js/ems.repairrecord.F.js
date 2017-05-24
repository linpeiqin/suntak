/**
 * Created by linking on 2016/8/4.
 */
OZ.Form.resize = function (){
    $("#page-center").height($(window).height());
    $("#tabCat").tabs("resize",{width:$('#repairTable').width()});
}
function oz_GetTitle(json){
    return "设备维修记录表";
}
var strUrl2 = contextPath + "/ems/partReplaceAction.do?action=openPR";
var strUrl3 = contextPath + "/ems/equipmentDetailsAction.do?action=openAttach&edit=false";
$(function(){
    $("#tabCat").tabs();
    $("#tabCat").tabs("activeTab","tab_01");
    $("#tabCat").tabs("resize",{width:$('#repairTable').width()});
    loadSubPanel("IFRAME_02",strUrl2+"&id="+getFormId());
    loadSubPanel("IFRAME_03",strUrl3+"&id="+getEquipmentId());
    if ($("#billMode").val()==0){
        $("#billTypeSpan").html("生产开单");
    }
    if ($("#billMode").val()==1){
        $("#billTypeSpan").html("自开单");
    }

});

function getFormId(){
    return $('#id').val();
}
function getEquipmentId(){
    return $('#equipmentId').val();
}