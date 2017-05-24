/**
 * Created by xsw on 2016/8/22.
 */
function oz_GetTitle(json){
    return "设备生命周期";
}
oz_grid_config.url = contextPath + "/ems/equipmentLifeCycleAction.do?action=page";
function getEquipmentId(){
    var rows = window.parent.OZ.View.getGridSelection();
    if (rows.length==0){
        oz.Msg.info("请选择需要操作的数据！");
        return false;
    }
    return  rows[0].id;
}

function getEquipmentType(){
    var rows = window.parent.OZ.View.getGridSelection();
    if (rows.length==0){
        oz.Msg.info("请选择需要操作的数据！");
        return false;
    }
    return  rows[0].type;
}

function getEquipmentNo(){
    var rows = window.parent.OZ.View.getGridSelection();
    if (rows.length==0){
        oz.Msg.info("请选择需要操作的数据！");
        return false;
    }
    return  rows[0].equipmentNo;
}
function reloadGridSelf(equipmentId){
    reloadData(equipmentId);
}
$("#btnNewLifeCycleSelectSEL").change(function(){
    reloadData(false);
});

function onBtnSearch_Clicked(searchCondition){
    reloadData();
}

function onBtnReset_Clicked(){
    $("#ozQuery").val("");
    reloadData();
}

function reloadData(equipmentId){
    var searchQuery = {};
    if ($("#btnNewLifeCycleSelectSEL").val()!=-1){
        searchQuery._EQS_type = $("#btnNewLifeCycleSelectSEL").val();
    }
    if ($("#ozQuery").val()!=""){
        searchQuery.dbftsParams = $("#ozQuery").val();
    }
    var eid = getEquipmentId()||equipmentId;
    if (eid)
        searchQuery.equipmentId = eid;
    OZ.View.reloadGrid(searchQuery);
}

function newLifeCycleType(){
    var equipmentId = getEquipmentId();
    if (!equipmentId) return false;
    var lifeCycle = $('#btnNewLifeCycleSelectSEL').val();
    if (lifeCycle==-1){
        oz.Msg.info("请选择生命周期！");
        return false;
    }
    if (!canCreate(getEquipmentType(),lifeCycle)){
        oz.Msg.info("请选择相应的操作！");
        return false;
    }
    var url = contextPath+"/ems/"+lifeCycle+"Action.do?action=create&equipmentId="+equipmentId;
    new OZ.Dlg.create({
        id:oz_grid_config.id + "_create" + (new Date().getTime()),
        width:1000, height:700,
        title:"新建" + $("#btnNewLifeCycleSelectSEL   option:selected").text(),
        url:url,
        buttons:[{text:'关闭', handler:$.noop}],
        maximizable:true
    });
}

function canCreate(type,lifeCycle){
    var json ={intoFactory:0,intoFactoryCheck:1,internalTransfer:2,scrap:2,renewal:5,renewalCheck:6,completion:7,completionCheck:8,intoFactoryAndCheck:0,renewalAndCheck:5};
    if (json[lifeCycle]==type) return true;
    return false;
}
function oz_Default_Open_Row(rowIndex,rowData,data){
    var url = contextPath+"/ems/"+rowData.type+"Action.do?action=open&lifeCycleId="+rowData.id;
    new OZ.Dlg.create({
        id:oz_grid_config.id+rowData.id,
        width:1000, height:600,
        title:oz_GetTabTitle(rowData),
        url: url,
        buttons:[{text:'关闭', handler:$.noop}],
        maximizable:true
    });
}

function OATypeFommater(value, json){
	 if (value==null || value=="")
		 return "";
	 else if(value=="0"){
         return "<a style= 'color: black' >待审批</a>";
          }
     else if(value=="1"){
         return "<a style= 'color: black' >审批中</a>";
          }
     else if(value=="2"){
         return "<a style= 'color: green'>审批通过</a>";
          }
     else if(value=="3"){
         return "<a style= 'color: red'>拒审</a>";
          }
}

function EBSTypeFommater(value, json){
    if (value==null || value=="")
        return "<a style= 'color: black' >待同步</a>";
    else if(value=="0"){
        return "<a style= 'color: black' >待同步</a>";
    }
    else if(value=="1"){
        return "<a style= 'color: green' >已同步</a>";
    }
}
