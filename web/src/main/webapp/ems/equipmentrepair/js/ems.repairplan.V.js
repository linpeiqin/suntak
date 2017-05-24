/**
 * Created by linking on 2016/8/4.
 */
function oz_GetTitle(json){
		return "保养计划";
}
function isOffFormatter(value, json){
    if(value == 0) return '未执行';
    if(value == 1) return '已执行';
}
function reloadData(equipmentId){
    var searchQuery = {};
    if ($("#ozQuery").val()!=""){
        searchQuery.dbftsParams = $("#ozQuery").val();
    }

    var eid = getEquipmentId()||equipmentId;
    if (eid)
        searchQuery.equipmentId = eid;
    OZ.View.reloadGrid(searchQuery);
}

function getEquipmentId(){
    if (!window.parent.OZ.View){
        return  -1;
    }
    var rows = window.parent.OZ.View.getGridSelection();
    if (rows.length==0){
        oz.Msg.info("请选择需要操作的数据！");
        return false;
    }
    if (rows.length>1){
        oz.Msg.info("请选择一个需要操作的数据记录！");
        return false;
    }
    return  rows[0].id;
}

function checkEquipmentId(){
    if (!window.parent.OZ.View){
        return  -1;
    }
    var rows = window.parent.OZ.View.getGridSelection();
    if (rows.length==0){
        oz.Msg.info("请选择需要操作的数据！");
        return false;
    }
    if (rows.length>1){
        oz.Msg.info("请选择一个需要操作的数据记录！");
        return false;
    }
    var equipmentId = rows[0].id;
    if(equipmentId != ''){
    	 var notExt = equipmentId;
    	var strUrl = contextPath + "/ems/repairPlanAction.do?action=checkData";
		$.ajax({
            type: "post",
            async: false,
            url: strUrl,
            data: {equipmentId:equipmentId},
            dataType: "json",
            success: function (json) {
            	if(json.isExt){
            		oz.Msg.info("请该设备已做保养计划，请勿重复添加！");
            		notExt = false;
				}
            },
            error: function (err) {
                alert(err);
            }
        });
		return notExt;
    }
    return  equipmentId;
}

function reloadGridSelf(equipmentId){
    reloadData(equipmentId);
}

function onBtnSearch_Clicked(searchCondition){
    reloadData();
}

function onBtnReset_Clicked(){
    $("#ozQuery").val("");
    reloadData();
}

function doPlan(){
    var rows = OZ.View.getGridSelection();
    if (rows.length==0){
        oz.Msg.info("请选择需要操作的数据！");
        return false;
    }
    if (rows.length>1){
        oz.Msg.info("请选择一个需要操作的数据记录！");
        return false;
    }
    var row =  rows[0];
    var id = row.id;
    var type = row.type;
    var isOff = row.isOff;
    var nextTime = row.nextTime;
    var curTime = new Date();
    var d1 = new Date(nextTime.replace(/\-/g, "\/"));
    var d2 = curTime;
    if(isOff==0){
    if(d1 <=d2){
        openMaintain(id);
    } else {
        oz.Msg.confirm("下次保养时间还未到，是否确认提前保养",function(){
            openMaintain(id);
        },function(){},"是否保养");
    }
    }
    else 
    {
        oz.Msg.info("该计划已经被执行过了！","已被执行！",function(){});
    }
}
function openMaintain(id) {
    var url = contextPath+"/ems/maintainAction.do?action=create&repairPlanId="+id;
    new OZ.Dlg.create({
        id:oz_grid_config.id + "_create" + (new Date().getTime()),
        width:1000, height:650,
        title:"新建保养记录",
        url: url,
        buttons:[{text:'关闭', handler:$.noop}]
    });
}
function seeRecord(){
    var rows = OZ.View.getGridSelection();
    if (rows.length==0){
        oz.Msg.info("请选择需要操作的数据！");
        return false;
    }
    if (rows.length>1){
        oz.Msg.info("请选择一个需要操作的数据记录！");
        return false;
    }

    var mtid = rows[0].maintainId || -1;
    if (mtid==-1){
        oz.Msg.info("请选择已关闭的记录查看，未关闭记录不存在保养记录！");
        return false;
    }
    var url = contextPath+"/ems/maintainAction.do?action=open&id="+mtid;
    new OZ.Dlg.create({
        id:oz_grid_config.id + "_open" + (new Date().getTime()),
        width:1000, height:650,
        title:"保养记录",
        url: url,
        buttons:[{text:'关闭', handler:$.noop}]
    });
}
function ozTB_DefaultBtnNew_Clicked(action,url){
	var eid = checkEquipmentId();
	if(eid){
		 var url = url|| OZ.addParamToUrl(action, "action=create");
		    url = url + "&equipmentId="+eid;
		    url = url + "&barShow=false";
		    new OZ.Dlg.create({
		        id:oz_grid_config.id + "_create" + (new Date().getTime()),
		        width:550, height:600,
		        title:"新建" + ($("body").data("name") || "文档"),
		        url: url,
		        buttons:[{text:'关闭', handler:$.noop}]
		    });
	}
   
}

function oz_Default_Open_Row(rowIndex,rowData,data){
    new OZ.Dlg.create({
        id:oz_grid_config.id+rowData.id,
        width:550, height:600,
        title:oz_GetTabTitle(rowData),
        url: OZ.addParamToUrl(oz_grid_config.path,"action="+ozOpenActionName+"&id=" + rowData.id + "&barShow=false"),
        buttons:[{text:'关闭', handler:$.noop}]
    });
}
function createLastPlanTime(){
	var myDate = new Date();
	var year = myDate.getFullYear() + 1;
	if(year != ''){
		var strUrl = contextPath + "/ems/repairPlanAction.do?action=createPlanTimeByYear";
//		$(".oz-body").mask("系统正在处理，请稍侯... ..."); // 添加遮罩
		$.getJSON(
				strUrl,
				{year:year},
				function(json){
//					$(".oz-body").unmask(); // 撤销遮罩
					if(json.flag){
						oz.Msg.info("操作成功！");
					}else{
						
					}
				}
			);
	}
}
