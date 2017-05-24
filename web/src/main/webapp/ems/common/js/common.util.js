/**
 * 格式化金额
 */
$.FormatMoney = function($cell) {  
    var reg = /[\$,%]/g;  
    var key = parseFloat( String($cell).replace(reg, '')).toFixed(4); // toFixed小数点后两位
    return isNaN(key) ? '' : key;  
};  

/**
 * 格式化数字
 */
$.FormatInt = function($cell){
	var reg = /[\$,%]/g;  
    var key = parseInt( String($cell).replace(reg, ''));
    return isNaN(key) ? '' : key;  
}
/**
 * 格式化浮点型
 */
$.FormatDouble = function($cell){
    var reg = /[\$,%]/g;  
    var key = parseFloat( String($cell).replace(reg, '')).toFixed(2); // toFixed小数点后两位  
    return isNaN(key) ? '' : key;  
}


$('.formatToInt').blur(function(){
	var priceFormat = $.FormatInt($(this).val());
	$(this).val(priceFormat);
})

$('.formatToMoney').blur(function(){
	var priceFormat = $.FormatMoney($(this).val());
	$(this).val(priceFormat);
})

$('.formatToDouble').blur(function(){
	var priceFormat = $.FormatMoney($(this).val());
	$(this).val(priceFormat);
})

function onSubmitEBS(btn,fileName,type){
	var id = $("#id").val();
	var equipmentLifeCycleId = $('#equipmentLifeCycleId').val();
	var oaType = $('#oaType').val();
	if(oaType!=2){
		oz.Msg.info("OA审批通过后才可以进行EBS同步");
		return;
	}
	if (id == -1){
		oz.Msg.info("请先保存！");
		return;
	}
	var apiUrl = OZ.addParamToUrl(getTbAction(btn), "action=submitEBS");
	apiUrl +="&timeStamp=" + new Date().getTime();
	var json ={id:id,fileName:fileName,type:type,equipmentLifeCycleId:equipmentLifeCycleId};
	$(".oz-body").mask("系统正在处理，请稍侯... ..."); // 添加遮罩
	$.getJSON(apiUrl,json,function(reJson){
		$(".oz-body").unmask(); // 撤销遮罩
		if (reJson!=null){
			oz.Msg.info(reJson.msg,null,function () {
                if (reJson.flag=="Y")
				top.$('.oz-panel-body').dialog("destroy");
			});
		}
	});

}

function onSubmitOA(templateCode,fileName,formMain){
	var id = $("#id").val();
	if (id == -1){
		oz.Msg.info("请先保存！");
		return;
	}

	var apiUrl = contextPath+"/ems/seeyonAction.do?action=callOaInterface"
	apiUrl +="&timeStamp=" + new Date().getTime();
	var json ={id:id,fileName:fileName,templateCode:templateCode,formMain:formMain};
	$(".oz-body").mask("系统正在处理，请稍侯... ..."); // 添加遮罩
	$.getJSON(apiUrl,json,function(reJson){
		$(".oz-body").unmask(); // 撤销遮罩
		if (reJson!=null){
			oz.Msg.info(reJson.msg,null,function () {
					if(reJson.result==true){
						top.$('.oz-panel-body').dialog("destroy");
					}
			});
		}
	});

}

function selectEmployee(obj){
	var strUrl = contextPath + "/ems/emsCommonAction.do?action=dlgEmployee";
	new OZ.Dlg.create({
		id:"dlg_employee",
		width:800, height:600,
		title:'采购员选择',
		url: strUrl,
		onOk:function(result){
			$("#agentId").val(result.personId);
			$(obj).val(result.personName);
		},onCancel:function(result){
			$(obj).val('');
			$("#agentId").val('');
		}
	});
}


function selectEmployees(obj){
	var strUrl = contextPath + "/ems/emsCommonAction.do?action=dlgEmployees";
	new OZ.Dlg.create({
		id:"dlg_employees",
		width:800, height:600,
		title:'申请人选择',
		url: strUrl,
		onOk:function(result){
			$("#applBy").val(result.employeeId);
			$(obj).val(result.fullName);
		},onCancel:function(result){
			$(obj).val('');
			$("#applBy").val('');
		}
	});
}
function selectAgent(obj,cb){
	var strUrl = contextPath + "/ems/emsCommonAction.do?action=dlgAgent";
	new OZ.Dlg.create({
		id:"dlg_agent",
		width:800, height:600,
		title:'供应商选择',
		url: strUrl,
		onOk:function(result){
			if (typeof cb === "function"){
				cb.call(this,obj,result);
			} else{
				afterDefSelectAgent(obj,result);
			}
		},onCancel:function(result){
//			$(obj).val('');
		}
	});
}

function afterDefSelectAgent(obj,result){
	$(obj).val(result.vendorName);
}
function afterAgentChange(obj,result){
	$(obj).val(result.vendorName);
	$('#agentId').val(result.vendorId);
}

function onSelectEquipment(){
	var strUrl = contextPath + "/ems/equipmentDetailsAction.do?action=dlgEquipment";
	new OZ.Dlg.create({
		id:"dlg_equipment",
		width:900, height:600,
		title:'选择设备',
		url: strUrl,
		onOk:function(result){
			afterSelectEquipment(result);
		},onCancel:function(result){
		}
	});
}

function afterSelectEquipment(result){
	for (var r in result){
		if (r=="equipmentId"){
			$("#equipmentId").val(result[r]);
		} else {
			$("#"+r+"Span").html(result[r]);
		}
	}

}

function onsSelectPart(checkboxBln){
	var strUrl = contextPath + "/ems/partInfoAction.do?action=dlgPartInfo&checkboxBln=checkboxBln";
	new OZ.Dlg.create({
		id:"dlg_partInfo",
		width:600, height:600,
		title:'选择配件',
		url: strUrl,
		onOk:function(results){
			afterSelectPartInfo(results);
		},onCancel:function(results){
		}
	});
}

function afterSelectPartInfo(results){
var result = results[0];
	for (var r in result){
		if (r=="partId"){
			$("#partId").val(result[r]);
		}else {
			$("#"+r+"Span").html(result[r]);
		}
	}
}

function appendInsToBoor(){
	$('.panel-title').addClass('panel-with-icon').after('<a href="javascript:void(0)" class="panel-icon icon-add" onclick="selectPart()"/>');
}

