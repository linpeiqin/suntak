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