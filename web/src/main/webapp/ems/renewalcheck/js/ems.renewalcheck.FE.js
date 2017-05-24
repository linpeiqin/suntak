$("input[name='isImported']").change(function(){
    var isImported = $(this).val();
    if (isImported==1){
        $("#customsNo").addClass("oz-form-btField").removeClass("oz-form-zdField").attr("readonly",false);
    } else {
        $("#customsNo").addClass("oz-form-zdField").removeClass("oz-form-btField").val('').attr("readonly",true);
    }
});
function onBtnSave_Success(json){

    if(json.result==true){
        $('#lifeCycleId').val(json.lifeCycleId);
        $('#id').val(json.id);
        $('#numberSpan').html(json.number);
    }
}
function beforeSave(){
    if(!$('#serialNumber').val()){
        oz.Msg.info("请选择待验收设备");
        return false;
    }
}
function onSelectEQ(obj,type){
    var strUrl = contextPath + "/ems/equipmentDetailsAction.do?action=dlgEquipmentG";
    var contractNo = $('#contractNumber').val();
    var fixedAssetsName = $('#fixedAssetsName').val();
    var specificationModel = $('#specificationModel').val();
    strUrl += "&contractNo="+contractNo;
    strUrl += "&fixedAssetsName="+fixedAssetsName;
    strUrl += "&specificationModel="+specificationModel;
    strUrl += "&type="+type;
    if ($("#equipmentNos").val()){
        strUrl +="&equipmentNos="+$("#equipmentNos").val();
    }
    if( $('#lifeCycleId').val()){
        strUrl +="&lifeCycleId="+$("#lifeCycleId").val();
    }
    new OZ.Dlg.create({
        id:"dlgEquipmentG",
        width:700, height:600,
        title:'选择待更新设备',
        url: strUrl,
        onOk:function(results){
            afterSelectEQ(results);
        },onCancel:function(results){

        }
    });
}
function afterSelectEQ(results){
    var serialNumber = "";
    var sum = 0;
    for(var i=0;i<results.length;i++){
        if (results[i].equipmentNo) {
            serialNumber += results[i].equipmentNo + ',';
            sum++;
        }
    }
    $('#serialNumberSpan').html(serialNumber);
    $('#serialNumber').val(serialNumber);
    $("#equipmentNos").val($.toJSON(results));
    $('#assetsNumber').val(sum);
}
