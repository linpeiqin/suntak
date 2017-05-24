

// 获取数据
function getDataByAjax(startDate, endDate, callBack){
	var strUrl = contextPath + "/ems/repairPlanAction.do?action=getScheduleDatas&timeStamp=" + new Date().getTime();
	$.getJSON(
		strUrl,
		{startDate:startDate, endDate:endDate},
		function(json){
			callBack.call(this, json);
		}
	);
}


/**
 * 简要信息
 */
function showScheduleDetails(tdId_row) {
	var tdIdRowId = tdId_row.id;
	var clickId = tdIdRowId;							// 用于记录原参数，事件处理
	var rowData = getRowData(tdIdRowId);
	if(null == rowData)
		return;
	var content = "";
	content += "<table width='100%'>";
	content += "    <col width='95'/><col width='205'/>";
	content += "    <tr>";
	if (rowData.planDate){
		content += "        <td style='align:right'>系统计划时间：</td><td class='oz-calendar-dateTime'>" + rowData.planDate.substring(0, 10) +"</td>";
	} else {
		content += "        <td style='align:right'>系统计划时间：</td><td class='oz-calendar-dateTime'></td>";
	}
	content += "    </tr>";
	content += "    <tr>";
	content += "        <td style='align:right'>人工调整时间：</td><td class='oz-calendar-dateTime'>" + rowData.actualDate.substring(0, 10)  + "</td>";
	content += "    </tr>";
	content += "    <tr>";
	content += "        <td style='align:right' valign=top>保养级别：</td><td class='oz-calendar-hh'>" + rowData.level + "</td>";
	content += "    </tr>";
	content += "</table>";
	
	// 重新追加html
	$("#msgDivContent").html("<span style='width: 300px; float: left; '>" + content + "</span>");
	
	var btnHtml = "";

	btnHtml += "<span onclick=onBtnDeleteSchedule('" + clickId + "')>删&nbsp;除</span>&nbsp;&nbsp;&nbsp;";
	btnHtml += "<span onclick=onBtnViewSchedule('" + clickId + "');>查看详细信息</span>&nbsp;&nbsp;";
	
	$("#divMsgButton").html(btnHtml);
}

function onBtnNew_Click(obj){
	new OZ.Dlg.create({
		id:"repairPlan",
        width:550, height:600,
		title:"新建日程计划文档",
		url: contextPath + "/ems/repairPlanAction.do?action=create",
		buttons:[{text:'关闭', handler:$.noop}]
	});
}


function onBtnViewSchedule(tdIdRowId){
	var rowData = getRowData(tdIdRowId);
	if(null == rowData)
		return;

	new OZ.Dlg.create({
		id:"repairPlan",
        width:550, height:600,
		title:"查看日程安排",
		url: contextPath + "/ems/repairPlanAction.do?action=open&id=" + rowData.id+"&barShow=false",
		buttons:[{text:'关闭', handler:$.noop}]
	});
}

function onBtnDeleteSchedule(tdIdRowId){
	var rowData = getRowData(tdIdRowId);
	if(null == rowData)
		return;
	
	OZ.Msg.confirm(
		"确定要删除本日程吗？",
		function(){
			$.getJSON(
				contextPath + "/ems/repairPlanAction.do?action=delete&timeStamp=" + new Date().getTime(),
				{id:rowData.id},
				function(json){
					if(json.result == true){
						OZ.Msg.info("删除成功。", null, function(){
							refresh();
						});
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			);
		}
	);
}

function getRowData(tdIdRowId){
	var s_index = tdIdRowId.indexOf("|");
	var tdId = tdIdRowId.substring(0, s_index);
	var rowIndex = tdIdRowId.substring(s_index + 1);
	
	var data = null;
	for(var i = 0; i < pagedata.length; i++){
		if(pagedata[i].date == tdId){
			data = pagedata[i].schedules;
			break;
		}
	}
	if(null == data)
		return null;
	return data[rowIndex];
}
