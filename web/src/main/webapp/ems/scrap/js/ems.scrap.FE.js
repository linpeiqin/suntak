function beforeSave(){
	if(!$('#serialNumber').val()){
		oz.Msg.info("请选择待报废设备");
		return false;
	}
}

function afterAgentChange(obj,result){
	$("#agent").val(result.vendorName);
	$("#agentId").val(result.vendorId);
}
function afterManufacturerChange(obj,result){
	$("#manufacturer").val(result.vendorName);
	$("#manufacturerId").val(result.vendorId);
}

function onManufacturerClick(){
	$("#manufacturer").val('');
	$("#manufacturerId").val('');
}

function onAgentClick(){
	$("#agent").val('');
	$("#agentId").val('');
}
function btnMaSelect(obj,afterEvent){
	var value = $(obj).val();
	if(value=='选择'){
		$(obj).val('手输');
		$('#manufacturer').removeAttr("onclick");
		onManufacturerClick();
	}else{
		$(obj).val('选择');
		$('#manufacturer').attr('onClick','selectAgent(this,afterManufacturerChange)');
	}
}
function btnAgSelect(obj,afterEvent){
	var value = $(obj).val();
	if(value=='选择'){
		$(obj).val('手输');
		$('#agent').removeAttr("onclick");
		onAgentClick();
	}else{
		$(obj).val('选择');
		$('#agent').attr('onClick','selectAgent(this,afterAgentChange)');
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
		title:'选择待入厂设备',
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

function onBtnSave_Success(json){

	if(json.result==true){
		$('#lifeCycleId').val(json.lifeCycleId);
		$('#id').val(json.id);
		$('#numberSpan').html(json.number);
	}
}