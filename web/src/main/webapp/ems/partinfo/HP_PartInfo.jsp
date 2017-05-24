<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<style>
.oz-home-icons li{
	float:left;
	height:45px;
	width: 50px;
	margin-right: 40px;
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
	<div style="padding:4px;text-align: center;margin-bottom:4px;height: 80px">
		<ul class="oz-home-icons" >
			<oz:permissionAuthorize ifAnyGranted="EMS_DM_PART_INFO">
			<li>
				<div onclick="openPartInfo()" style="margin-bottom: 10px;">
					<div>
						<img src="<oz:contextPath/>/oz/apps/portal/images/advanced.png">
					</div>
					<div>
						配件详情
					</div>
				</div>
			</li>
			</oz:permissionAuthorize>
			<oz:permissionAuthorize ifAnyGranted="EMS_DM_PART_TREE">
			<li>
				<div onclick="openPartInfoTree()" style="margin-bottom: 10px;">
					<div>
						<img src="<oz:contextPath/>/oz/apps/portal/images/usb.png">
					</div>
					<div>
						配件关系树
					</div>
				</div>
			</li>
			</oz:permissionAuthorize>
			<oz:permissionAuthorize ifAnyGranted="EMS_DM_PART_PR">
			<li>
				<div onclick="openPartInfoPR()" style="margin-bottom: 10px;">
					<div>
						<img src="<oz:contextPath/>/oz/apps/portal/images/cash.png">
					</div>
					<div>
						采购申请
					</div>
				</div>
				<div onclick="newPartInfoPR()">
					<div style="color:red">
						新建
					</div>
				</div>
			</li>
			</oz:permissionAuthorize>
			<oz:permissionAuthorize ifAnyGranted="EMS_DM_PART_LYCK">
			<li>
				<div onclick="openOrderHeadTemp()" style="margin-bottom: 10px;">
					<div>
						<img src="<oz:contextPath/>/oz/apps/portal/images/install.png">
					</div>
					<div>
						领用出库
					</div>
				</div>
				<div onclick="newOrderHeadTemp()">
					<div style="color:red">
						新建
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

	function openPartInfo(){
		OZ.openWindow({
			id: 'openPartInfo',
			title: '配件详情',
			url: contextPath+'/ems/partInfoAction.do?action=display',
			refresh: true,
			beforeCloseFnName:"oz_Win_BeforeClose"
		});
	}
	function openPartInfoTree(){
		OZ.openWindow({
			id: 'openPartInfoTree',
			title: '配件关系树',
			url: contextPath+'/ems/partInfoTreeAction.do?action=display',
			refresh: true,
			beforeCloseFnName:"oz_Win_BeforeClose"
		});
	}
	function openPartInfoPR(){
		OZ.openWindow({
			id: 'openPartInfoPR',
			title: '采购申请',
			url: contextPath+'/ems/pRLineAction.do?action=display',
			refresh: true,
			beforeCloseFnName:"oz_Win_BeforeClose"
		});
	}

	function newPartInfoPR(){
		var url = contextPath+'/ems/pRHeadAction.do?action=create';
		new OZ.Dlg.create({
			id:'newPartInfoPR' + '_create' + (new Date().getTime()),
			width:1000, height:650,
			title:"新建采购申请",
			url: url,
			buttons:[{text:'关闭', handler:$.noop}],
			maximizable:true
		});
	}

	function openOrderHeadTemp(){
		OZ.openWindow({
			id: 'openOrderHeadTemp',
			title: '领用出库',
			url: contextPath+'/ems/orderHeadTempAction.do?action=display',
			refresh: true,
			beforeCloseFnName:"oz_Win_BeforeClose"
		});
	}

	function newOrderHeadTemp(){
		var url = contextPath+'/ems/orderHeadTempAction.do?action=create';
		new OZ.Dlg.create({
			id:'newOrderHeadTemp' + '_create' + (new Date().getTime()),
			width:1000, height:650,
			title:"新建领用出库",
			url: url,
			buttons:[{text:'关闭', handler:$.noop}],
			maximizable:true
		});
	}
</script>