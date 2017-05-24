<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<style>
.oz-home-icons li{
	float:left;
	height:45px;
	width: 50px;
	margin-right: 20px;
}

.oz-home-icons li>div{
	margin-left:1px;
	margin-top:1px;
	text-align:center;
	cursor: pointer;
}

.oz-home-icons li>div:hover{
	margin-left:0px;
	margin-top:0px;
	font-weight: bold;
}

</style>
<div style="">
	<div style="padding:2px;text-align: center;margin-bottom:4px;height: 80px">
		<ul class="oz-home-icons" >
			<oz:permissionAuthorize ifAnyGranted="EMS_DM_REPAIR_RECORD">
					<li style="margin-right: 20px;">
						<div onclick="openRepairRecord('REPAIR')" style="margin-bottom: 10px;">
							<div>
								<img src="<oz:contextPath/>/oz/apps/portal/images/settings.png">
							</div>
							<div>
								维修记录
							</div>
						</div>
						<oz:permissionAuthorize ifAnyGranted="EMS_DM_MAINTENANCE_OPERATION" >
						<div onclick="newRepairRecord('REPAIR')">
							<div style="color:red">
								新建
							</div>
						</div>
						</oz:permissionAuthorize>
						<oz:permissionAuthorize ifAnyGranted="EMS_DM_REPAIRED_OPERATION" >
							<div onclick="newRepairRecord('REPAIR')">
								<div style="color:red">
									新建
								</div>
							</div>
						</oz:permissionAuthorize>
					</li>
			</oz:permissionAuthorize>
			<oz:permissionAuthorize ifAnyGranted="EMS_DM_MAINTAIN">
			<li style="margin-right: 20px;">
				<div onclick="openMaintainRecord('MAINTAIN')" style="margin-bottom: 10px;">
					<div>
						<img src="<oz:contextPath/>/oz/apps/portal/images/app.png">
					</div>
					<div>
						保养记录
					</div>
				</div>
			</li>
			</oz:permissionAuthorize>
			<oz:permissionAuthorize ifAnyGranted="EMS_DM_REPAIR_PLAN">
			<li style="margin-right: 20px;">
				<div onclick="openRepairPlan('MAINTAIN')" style="margin-bottom: 10px;">
					<div>
						<img src="<oz:contextPath/>/oz/apps/portal/images/copy_doc.png">
					</div>
					<div>
						保养计划
					</div>
				</div>
				<div onclick="newRepairPlan('MAINTAIN')">
					<div style="color:red">
						新建
					</div>
				</div>
			</li>
			</oz:permissionAuthorize>
			<oz:permissionAuthorize ifAnyGranted="EMS_DM_MONTH_PLAN">
			<li style="margin-right: 20px;">
				<div onclick="openPlanByMonth()" style="margin-bottom: 10px;">
					<div>
						<img src="<oz:contextPath/>/oz/apps/portal/images/date.png">
					</div>
					<div>
						月保养计划
					</div>
				</div>
			</li>
			</oz:permissionAuthorize>
			<oz:permissionAuthorize ifAnyGranted="EMS_DM_YEAR_PLAN">
			<li style="margin-right: 20px;">
				<div onclick="openPlanByYear()" style="margin-bottom: 10px;">
					<div>
						<img src="<oz:contextPath/>/oz/apps/portal/images/date.png">
					</div>
					<div>
						年保养计划
					</div>
				</div>
			</li>
			</oz:permissionAuthorize>
			<oz:permissionAuthorize ifAnyGranted="EMS_DM_FAULT_DESC">
			<li style="margin-right: 20px;">
				<div onclick="openFaultDesc()" style="margin-bottom: 10px;">
					<div>
						<img src="<oz:contextPath/>/oz/apps/portal/images/applications.png">
					</div>
					<div>
						故障字典
					</div>
				</div>
				<div onclick="newFaultDesc()">
					<div style="color:red">
						新建
					</div>
				</div>
			</li>
			</oz:permissionAuthorize>
			<oz:permissionAuthorize ifAnyGranted="EMS_DM_SCHEDULE">
			<li style="margin-right: 20px;">
				<div onclick="openDateTable()" >
					<div>
						<img src="<oz:contextPath/>/oz/apps/portal/images/date.png">
					</div>
					<div>
						日程表
					</div>
				</div>
			</li>
			</oz:permissionAuthorize>
		</ul>
		<div style="clear: both;"></div>	
	</div>
</div>
<oz:js/>
<script type="text/javascript">
	function openRepairRecord(){
		OZ.openWindow({
			id: 'openRepairRecord',
			title: '维修记录',
			url: contextPath+'/ems/repairRecordAction.do?action=display',
			refresh: true,
			beforeCloseFnName:"oz_Win_BeforeClose"
		});
	}

	function openMaintainRecord(){
		OZ.openWindow({
		id: 'openMaintainRecord',
		title: '保养记录',
		url: contextPath+'/ems/maintainAction.do?action=display',
		refresh: true,
		beforeCloseFnName:"oz_Win_BeforeClose"
		});
	}

	function newRepairRecord(){
		var url = contextPath+'/ems/repairRecordAction.do?action=create';
		new OZ.Dlg.create({
			id:'newRepairRecord' + '_create' + (new Date().getTime()),
			width:1000, height:650,
			title:"新建维修记录",
			url: url,
			buttons:[{text:'关闭', handler:$.noop}],
			maximizable:true
		});
	}

	function newMaintainRecord(){
		var url = contextPath+'/ems/maintainAction.do?action=create';
		new OZ.Dlg.create({
		id:'newRepairRecord' + '_create' + (new Date().getTime()),
		width:1000, height:650,
		title:"新建维修记录",
		url: url,
		buttons:[{text:'关闭', handler:$.noop}],
		maximizable:true
		});
	}

	function openRepairPlan(RMType){
		OZ.openWindow({
			id: 'openRepairPlan'+RMType,
			title: '保养计划',
			url: contextPath+'/ems/repairPlanAction.do?action=display&RMType='+RMType,
			refresh: true,
			beforeCloseFnName:"oz_Win_BeforeClose"
		});
	}
	function newRepairPlan(RMType){
		var url = contextPath+'/ems/repairPlanAction.do?action=create&RMType='+RMType+"&barShow=false";
		new OZ.Dlg.create({
			id:'newRepairPlan' + '_create' + (new Date().getTime()),
			width:550, height:600,
			title:"新建保养计划",
			url: url,
			buttons:[{text:'关闭', handler:$.noop}],
			maximizable:true
		});
	}
    function openPlanByMonth(){
        OZ.openWindow({
            id: 'openPlanByMonth',
            title: '月保养计划',
            url: contextPath+'/ems/repairMonthPlanAction.do?action=display',
            refresh: true,
            beforeCloseFnName:"oz_Win_BeforeClose"
        });
	}
    function openPlanByYear(){
        OZ.openWindow({
            id: 'openPlanByMonth',
            title: '月保养计划',
            url: contextPath+'/ems/repairYearPlanAction.do?action=display',
            refresh: true,
            beforeCloseFnName:"oz_Win_BeforeClose"
        });
    }
	function openFaultDesc(){
		OZ.openWindow({
			id: 'openFaultDesc',
			title: '故障字典',
			url: contextPath+'/ems/faultDescAction.do?action=display',
			refresh: true,
			beforeCloseFnName:"oz_Win_BeforeClose"
		});
	}
	function newFaultDesc(){
		var url = contextPath+'/ems/faultDescAction.do?action=create';
		new OZ.Dlg.create({
			id:'openFaultDesc' + '_create' + (new Date().getTime()),
			width:600, height:370,
			title:"新建故障字典",
			url: url,
			buttons:[{text:'关闭', handler:$.noop}],
			maximizable:true
		});
	}
	function openDateTable(){
		OZ.openWindow({
			id: 'dateTable',
			title: '日程表',
			url: contextPath+'/ems/repairPlanAction.do?action=display&viewType=Month',
			refresh: true,
			beforeCloseFnName:"oz_Win_BeforeClose"
		});
	}
</script>