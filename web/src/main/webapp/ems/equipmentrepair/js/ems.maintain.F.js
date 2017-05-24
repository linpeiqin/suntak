function onSeePlan(){
    var mtId = $("#repairPlanId").val();
    new OZ.Dlg.create({
        id:mtId + "open" ,
        width:550, height:400,
        title:"保养计划",
        url: contextPath+"/ems/repairPlanAction.do?action=open&id="+mtId,
        buttons:[{text:'关闭', handler:$.noop}]
    });
}