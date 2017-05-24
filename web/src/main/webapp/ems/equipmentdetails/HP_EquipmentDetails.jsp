<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<style>
.oz-home-icons li{
	float:left;
	height:45px;
	width: 50px;
	margin: 2px;
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
	<div style="padding:4px;text-align: center;margin-bottom:4px;height: 60px">
		<ul class="oz-home-icons">
			<li>
				<div onclick="openEquipmentDetails()" style="margin-bottom: 10px;">
					<div>
						<img src="<oz:contextPath/>/oz/apps/portal/images/computer_on.png">
					</div>
					<div>
						设备详情
					</div>
				</div>
			</li>
		</ul>
		<div style="clear: both;"></div>	
	</div>
</div>
<oz:js/>
<script type="text/javascript">
	function openEquipmentDetails(){
		OZ.openWindow({
			id: 'equipmentDetails',
			title: '设备详细信息',
			url: contextPath+'/ems/equipmentDetailsAction.do?action=display',
			refresh: true,
			beforeCloseFnName:"oz_Win_BeforeClose"
		});
	}
</script>