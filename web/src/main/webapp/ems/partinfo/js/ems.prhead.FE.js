function oz_GetTitle(json){
    return "备件采购申请";
}
function onBtnSave_Success(json){
    $('#prNoSpan').html(json.prNo);
}
var strUrl2 = contextPath + "/ems/pRLineAction.do?action=editPR";
$(function(){
    loadSubPanel("IFRAME_01",strUrl2);
});
function beforeSave(){
    var flag = $("#IFRAME_01")[0].contentWindow.checkData();
    if (!flag){
        return false;
    }
    var $data = $("#IFRAME_01")[0].contentWindow.getPartsGridData();
    if ($data.total>0)
         $("#pRLine1").val($.toJSON($data.rows));
}
function getFormId(){
    return $('#id').val();
}

function selectAgentPostion(obj,result){
    $(obj).val(result.vendorName);
    $("#vendorId").val(result.vendorId);
    $.getJSON(
        contextPath + "/ems/pRHeadAction.do?action=getVendorAddress",
        {vendorId:result.vendorId},
        function(json){
        if (json!=null){
        	appendToAddressSelect(json.addressList);
        }
    });
}
function appendToAddressSelect(addressList){
    var obj=document.getElementById('vendorSiteId');   
    if(obj.options.length>0)
      obj.options.length=0;
	var json = eval("("+addressList+")");
	$("#vendorSiteId").append("<option value=''></option>");
	for (var i=0;i<json.length;i++){
		$("#vendorSiteId").append("<option value='"+json[i].vendorSiteId+"'>"+json[i].vendorSiteName+"</option>"); 
	}
} 
function onChangeAddress()
{
	var vendorIda = document.getElementById('vendorId');
	var vendorSiteId = document.getElementById('vendorSiteId');
	var vendorSiteId_val = vendorSiteId.options[vendorSiteId.selectedIndex].value;
	 $.getJSON(
		        contextPath + "/ems/pRHeadAction.do?action=getVendorPeople",
		        {vendorId:vendorIda.value,vendorSiteId:vendorSiteId_val},
		        function(json){
		        if (json!=null){
		        	appendToPeopleSelect(json.peopleList);
		        }
		    });
}
function appendToPeopleSelect(peopleList){
    var obj=document.getElementById('vendorContactId');   
    if(obj.options.length>0)
      obj.options.length=0;
	var json = eval("("+peopleList+")");
	$("#vendorContactId").append("<option value=''></option>");
	for (var i=0;i<json.length;i++){
		$("#vendorContactId").append("<option value='"+json[i].vendorContactId+"'>"+json[i].vendorContactName+"</option>"); 
	}
} 