function oz_GetTitle(json){
    return "备件采购申请";
}
var strUrl2 = contextPath + "/ems/pRLineAction.do?action=openPR";
$(function(){
	loadSubPanel("IFRAME_01",strUrl2+"&id="+getFormId());
});

function getFormId(){
    return $('#id').val();
}
