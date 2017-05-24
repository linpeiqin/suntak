/*
* 调用文件编号创建新的编号，其Code为编号的code,fieldId为系统自动写的字段
* callback 为回调函数
*/
function CreateNumber(code,fieldId,callback){
	
	var fieldValue=$('#'+fieldId).val();
	if (""==fieldValue){
		$.getJSON(
				contextPath + "/ems/fileNumberAction.do?action=CreateNumber&timeStamp=" + new Date().getTime(),
				{code:code},
				function(json){
					if(typeof json == 'String'){
						json = eval('(' + json + ')');
					}
					if(json.result == true){					
						$('#'+fieldId).val(json.fileNumber);
						if((typeof callback) == "function"){
							callback.call(this);
						}
						return true;
					}else{
						return false;
					}
				}
		);
	}else{
		if((typeof callback) == "function"){
			callback.call(this);
		}
	}

}
