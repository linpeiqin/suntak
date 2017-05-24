/**
 * Created by linking on 2016/8/4.
 */
//页面重排
OZ.Form.resize = function (){
    $("#page-center").height($(window).height());
    $("#tabCat").tabs("resize",{width:$('#repairTable').width()});
}
//维修费用
function setMaintainValue(value) {
	$('#maintenanceCostSpan').html(value);
    $('#maintenanceCost').val(value);
}

function oz_GetTitle(json){
    return "设备维修记录表";
}
var strUrl2 = contextPath + "/ems/partReplaceAction.do?action=editPR";
var strUrl3 = contextPath + "/ems/equipmentDetailsAction.do?action=openAttach&edit=true";
$(function(){
    $("#tabCat").tabs();
    $("#tabCat").tabs("activeTab","tab_01");
    $("#tabCat").tabs("resize",{width:$('#repairTable').width(),height:288});
    loadSubPanel("IFRAME_02",strUrl2+"&id="+getFormId());
    loadSubPanel("IFRAME_03",strUrl3+"&id="+getEquipmentId());
    initOthers();
});
//保存前操作

function beforeSave(){
    var status =  $('#status').val();
    var value = $("#userScore").val();
    var userScore = parseInt(value);
    if(status==-1){
        if($('#equipmentId').val()==-1){
            oz.Msg.info("请选择设备");
            return false;
        }
    }
    if (status == 0){
        if ($('#maintenancePersonName').val()==''){
            oz.Msg.info("请先选择维修人");
            return false;
        }
    }
    if (status==1){
        var flag = $("#IFRAME_02")[0].contentWindow.checkData();
        if (!flag){
            return false;
        }
        var $data = $("#IFRAME_02")[0].contentWindow.getPartsGridData();
        if ($data.total>0)
             $("#partReplace1").val($.toJSON($data.rows));
    }
    if (userScore< 0 || userScore>100) {
        //return true;
        oz.Msg.info("请在用户评分处填入正确的评分（0-100）！");
        return false;
    }
}

function selectFaultDeal(obj) {
    var strUrl = contextPath + "/ems/faultDescAction.do?action=dlgFaultDesc";
    new OZ.Dlg.create({
        id: "dlg_faultdesc",
        width: 800, height: 600,
        title: '故障详细信息选择',
        url: strUrl,
        onOk: function (result) {
            selectedDeal(result);
        }, onCancel: function (result) {
            $(obj).val('');
        }
    });
}

function selectFaultDesc(obj) {
    var strUrl = contextPath + "/ems/faultDescAction.do?action=dlgFaultDesc";
    new OZ.Dlg.create({
        id: "dlg_faultdesc",
        width: 800, height: 600,
        title: '故障详细信息选择',
        url: strUrl,
        onOk: function (result) {
            selectedFault(result);
        }, onCancel: function (result) {
            $(obj).val('');
        }
    });
}

function getFormId(){
    return $('#id').val();
}
function getEquipmentId(){
    return $('#equipmentId').val();
}

function selectedFault(result){
	$('#faultDescription').val(result.apearanceDetail);
}
function selectedDeal(result){
	$('#faultSolve').val(result.dealDetail);
    $('#faultClass').val(result.faultType);
}


function afterSelectEquipment(result){
    for (var r in result){
        if (r=="equipmentId"){
            $("#equipmentId").val(result[r]);
        } else {
            $("#"+r+"Span").html(result[r]);
        }
    }
    loadSubPanel("IFRAME_03",strUrl3+"&id="+getEquipmentId());
}
//提交
function onUpdateRepair(){
    var id = $("#id").val();
    if (!saveFlag || id == -1){
        oz.Msg.info("请先保存");
        return false;
    }
    var status =  $('#status').val();
    status++;
    var apiUrl = contextPath+"/ems/repairRecordAction.do?action=updateStatus";
    apiUrl +="&timeStamp=" + new Date().getTime();
    var json ={status:status,id:id};
    $.getJSON(apiUrl,json,function(reJson){
        if (reJson!=null){
            oz.Msg.info(reJson.msg);
            if (reJson.flag==true){
                top.$('.oz-panel-body').dialog("destroy");
            }
        }
    });
}
var saveFlag = false;
//保存成功后
function onBtnSave_Success(json){
    $('#maintenanceNoSpan').html(json.maintenanceNo);
    saveFlag = true;
}
var repairRecordMethod ={
    disEditDiv:function(divId){
        $("#"+divId).mask(); // 添加遮罩
        $('#'+divId).find(':input').each(function(){
            var $obj = $(this);
            if ($obj.attr('id')=='maintenancePersonName'){
                $obj.attr('readonly',true).addClass('oz-form-zdField').removeClass('oz-form-btField');
            } else {
                $obj.attr('disabled',true).addClass('oz-form-zdField').removeClass('oz-form-btField');
            }

        });
    },
    doBillMode:function(){
        if ($('#id').val()==-1 || $("#billMode").val()==''){
            if (isMaintenancer){
                $("#billMode").val(0);
                $("#billTypeSpan").html("生产开单");
            }
            if (isRepair){
                $("#billMode").val(1);
                $("#billTypeSpan").html("自开单");
            }
        } else {
            if ($("#billMode").val()==0){
                $("#billTypeSpan").html("生产开单");
            }
            if ($("#billMode").val()==1){
                $("#billTypeSpan").html("自开单");
            }
        }
    },
    doTimeOccupy:function(){
        var timeOccupy = $("input[name='timeOccupy']:checked").val();
        if(typeof(timeOccupy) == 'undefined'){
            $("input[name='timeOccupy']:first").attr("checked",true);
            $("#downTime").addClass('oz-form-zdField').removeClass('oz-form-field');
        }
    },
    doRepairMode:function(){
        var va = $("input[name='repairMode']:checked").val();
        if(typeof(va) == 'undefined'){
            $("input[name='repairMode']:first").attr("checked",true);
            $("#maintenanceUnit").attr("disabled",true).addClass('oz-form-zdField').removeClass('oz-form-field');
        }
    }
}

function initOthers(){
    var status =  $('#status').val();
    if (status == -1){
        if (!isMaintenancer && !isRepair){
            repairRecordMethod.disEditDiv('submitMaintenance');
        }
        repairRecordMethod.disEditDiv('repairTable');
        repairRecordMethod.disEditDiv('beenRepaired');
    }
    if (status == 0){
        repairRecordMethod.disEditDiv('submitMaintenance');
        repairRecordMethod.disEditDiv('repairTable');
        repairRecordMethod.disEditDiv('beenRepaired');
        $('#maintenancePersonName').attr('readonly',true).addClass('oz-form-zdField').removeClass('oz-form-btField');
    }
    if (status == 1){
        if (!isRepair){
            repairRecordMethod.disEditDiv('repairTable');
        }
        repairRecordMethod.disEditDiv('submitMaintenance');
        repairRecordMethod.disEditDiv('beenRepaired');
        $('#maintenancePersonName').attr('readonly',true).addClass('oz-form-zdField').removeClass('oz-form-btField');
    }
    if (status == 2){
        if (!isMaintenancer){
            repairRecordMethod.disEditDiv('beenRepaired');
        }
        repairRecordMethod.disEditDiv('submitMaintenance');
        repairRecordMethod.disEditDiv('repairTable');
    }
    if (status == 3){
        repairRecordMethod.disEditDiv('submitMaintenance');
        repairRecordMethod.disEditDiv('repairTable');
        repairRecordMethod.disEditDiv('beenRepaired');
    }
    repairRecordMethod.doBillMode();
    repairRecordMethod.doTimeOccupy();
    repairRecordMethod.doRepairMode();
}

$("input[name='timeOccupy']").click(function(){
    var val = $(this).val();
    if(val == 0){
        $("#downTime").val("");
        $("#downTime").addClass('oz-form-zdField').removeClass('oz-form-field');
    }else{
        var startTimeStr = $("#startTimeStr").val();
        var endTimeStr = $("#endTimeStr").val();
        var hour = timeDifference(startTimeStr,endTimeStr);
        $("#downTime").val(hour);
        $("#downTime").addClass('oz-form-field').removeClass('oz-form-zdField');
    }
})

String.prototype.stringToDate = function(){

    return new Date(Date.parse(this.replace(/-/g, "/")));

}

$("#startTimeStr").change(function(){
    var timeOccupy = $("input[name='timeOccupy']:checked").val();
    if(timeOccupy == 1){
        var startTimeStr = $(this).val();
        var endTimeStr = $("#endTimeStr").val();
        var hour = timeDifference(startTimeStr,endTimeStr);
        $("#downTime").val(hour);
    }
})

$("#endTimeStr").change(function(){
    var timeOccupy = $("input[name='timeOccupy']:checked").val();
    if(timeOccupy == 1){
        var startTimeStr = $("#startTimeStr").val();
        var endTimeStr = $(this).val();
        var hour = timeDifference(startTimeStr,endTimeStr);
        $("#downTime").val(hour);
    }
})

$("input[name='repairMode']").click(function(){
    var val = $(this).val();
    if(val == 0){
        $("#maintenanceUnit").attr("disabled",true).addClass('oz-form-zdField').removeClass('oz-form-field');
    }else{
        $("#maintenanceUnit").attr("disabled",false).addClass('oz-form-field').removeClass('oz-form-zdField');
    }
})

function timeDifference(startTimeStr,endTimeStr){
    var hour = "";
    if(startTimeStr != "" && endTimeStr != ""){
        var stime = startTimeStr.stringToDate();
        var etime = endTimeStr.stringToDate();
        if(stime > etime){
            oz.Msg.info('选择时间异常！');
        }else{
            var total = (etime - stime)/1000;
            hour = (total/(60)).toFixed(2);
        }
    }
    return hour;
}

function distribution(user){
     $('#maintenancePersonName').val(user.name);
     $('#maintenancePersonId').val(user.id);
}
function doDistribution(){
    var strUrl = contextPath + "/ems/repairRecordAction.do?action=GroupView"
    new OZ.Dlg.create({
        id:"select_employee",
        width:350, height:400,
        title:'维修人员选择',
        url: strUrl,
        onOk:function(result){
            distribution(result);
        },onCancel:function(result){
        }
    });
}