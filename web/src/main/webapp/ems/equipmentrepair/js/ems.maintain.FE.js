function oz_GetTitle(json){
    return "保养记录表";
}
function getFormId(){
    return $('#id').val();
} 
function beforeSave()
{
	  if ($('#equipmentId').val()=='-1'){
	        oz.Msg.info("请选择设备!");
	        return false;
	    }
}
function doDistribution(user){
	$('#maintainPerson').val(user.name);
	$('#maintainPersonId').val(user.id);
}