var curDate = new Date();
var pagedata;
var logRowClick = false;
var canShowRow = 0;
var logMoreClick = false;

/*
 * 单击一行记录调用的事件
 */
function onRowClick(row) {
	logRowClick = true;
	isShowDivMsg = false;
	showScheduleDetails(row);
	_isCanShow = true;
}


/**
 * 追加html方法
 */
var htmlUtil = {
	appendPageData : function() {
		// 此方法循环把所有数据填充到表格
		for (var item in pagedata) {
			htmlUtil.appendRowData(item);
		}
	},
	
	appendRowData : function(tdId) {
		var data = pagedata[tdId].schedules;
		if(null == data)
			return;
		tdId = pagedata[tdId].date;
		if (null != $("#" + tdId) && $("#" + tdId).length > 0) {
			var pageContent = "";
			if (undefined != data) {
				for (var i = 0; i < data.length; i++) {
					var cm = data[i];
					var styleClass = "oz-calendar-double";
					if (i % 2 != 0) {
						styleClass = "oz-calendar-single";
					}
					pageContent += "<div class='" + styleClass + "' id='" + tdId + "|" + i + "' onclick = 'onRowClick(this)'>";
					pageContent += "    <div class='oz-calendar-content'>";
					pageContent += "        <div style='padding-left:4px'>";
					pageContent += cm.equipmentName+":("+cm.level+")";
					pageContent += "        </div>";
					pageContent += "    </div>";
					pageContent += "</div>";
				}
			}else {
				pageContent += "<div>&nbsp;</div>";
			}
			$("#" + tdId + " .oz-calendar-contentMainDiv").append(pageContent);
		}
	},
	
	removeRowData : function(tdId) {
		// 此方法清空一天（一个TD)的数据
		if (null != $("#" + tdId) && $("#" + tdId).length > 0) {
			var len = $("#" + tdId + " > span > div").length;
			// 第一个DIV是显示当前TD对应的日期数，不用清空
			for (var i = 1; i <= len; i++) {
				$("#" + tdId + " > span > div:nth-child(2) ").remove();
			}
		}
	},
	showAllTDData : function(tdId) {
		logMoreClick = true;
		// 此方法把所有数据显示到弹出的DIV中
		// 加上新的内容
		var list = pagedata[tdId];
		if (undefined != list && list.length > 0) {
			var content = "";
			for (var i = 0; i < list.length; i++) {
				content += "<div class='oz-calendar-listTitle'>&#8226; <span id='" + tdId + "|" + i + "' href='#' onclick='javascript:htmlUtil.showDetail(this)'>" + list[i].content + "</span></div>";
			}
		}else {
			content = "<br/>无记录";
		}
		// 重新追加
		$("#msgDivContent").html(content);
		$("#divMsgButton").html("");
	},
	showDetail : function(tdId_row) {
		showObject(tdId_row);
	},
	showCreateNew : function(td) {
		createNewObject(td);
	},
	appendStart : function() {
		return "<tr><td valign='top' class='oz-calendar-monthMain'>" +
			"<table width='100%' height='100%' border='0' cellspacing='0' cellpadding='0'>" +
				"<tr><td valign='top' id='calendarMain'><div style='overflow-y:auto; height:100%;'>" +
				"<table id='erectTable' width='100%' height='100%' border='0' cellspacing='0'" +
				" cellpadding='0' class='oz-calendar-month' onClick='msgUtil.showDivMsg(event);'>";
	},
	appendEnd : function() {
		return "</table></div></td></tr></table></td></tr>";
	},
	appendMiddleTD : function(date, curDate) {
		var dayStr = date.getDate();
		// 如果是当月第一天，需要显示月份
		if (dayStr == 1) {
			dayStr = (date.getMonth() + 1) + "月" + date.getDate() + "日"
		}
		
		dayStr += " " + getLunarDay(date);
		
		// td的id
		var tdId = "d" + date.format("Ymd");

		var tdContent = "";
		// 是否是当月（样式不同）	
		if (curDate.getMonth() != date.getMonth()) { // 其它月
			 tdContent = "<td valign='top' id='" + tdId + "'><div class='oz-calendar-titleDiv'><span class='oz-calendar-monthTopNonego'>" + dayStr + "</span> </div><div class='oz-calendar-contentMainDiv'></div></td>";
		}else if (dateUtil.isToday(date)) {	// 今天			
			tdContent = "<td valign='top' id='" + tdId + "' class='oz-calendar-daybg'><div class='oz-calendar-titleDiv'><span class='oz-calendar-monthTop'>" + dayStr + "</span></div><div class='oz-calendar-contentMainDiv'></div></td>";
		}else {
			tdContent = "<td valign='top' id='" + tdId + "'><div class='oz-calendar-titleDiv'><span class='oz-calendar-monthTop'>" + dayStr + "</span> </div><div class='oz-calendar-contentMainDiv'></div></td>";
		}
		return tdContent;
	},
	appendTR : function() {
		return "<tr>";
	},
	appendTREnd : function() {
		return "</tr>";
	},
	removeHtml : function() {
		$("#monthTb > tbody > tr:nth-child(3)").remove();
	}
}

/*
 * syncWindow 同步窗体大小
 * 
 * divClose 关闭浮动的DIV
 * 
 * showDivMsg 定位 浮动的DIV
 */
var divUtils = {
	syncWindow : function(firstTime){
		msgUtil.divMsgClose();
		divUtils.showScroll();
		var calendarMainHeight = document.getElementById("calendarMain").clientHeight;
		var erectTableHeight = document.getElementById("erectTable").clientHeight;
		var topOverflow = document.getElementById("topOverflow");
		var erectTable = document.getElementById("erectTable");
	
		var calendarTd=erectTable.getElementsByTagName("td"); 
		var tdHeight = calendarMainHeight / dateUtil.getRow();
		for (var i=0,j=0;i<calendarTd.length;i++){			
			if (tdHeight < 60)
				tdHeight = 60;
			calendarTd[i].style.height = tdHeight;
			$(".oz-calendar-contentMainDiv", calendarTd[i]).height(tdHeight - 20);
			j++;
		}
		tdHeigthOfDate = tdHeight;
		// 每一行记录高度为20
		var allrow = (tdHeigthOfDate / 20) + "";
		canShowRow =  allrow.substring(0, 1) - 2;	 // 去小数点，去第一位
		
		if (firstTime == true) {

		}else {
			htmlUtil.removeHtml();
 			thisPage.initTab(false);
		}
	},
	showScroll : function() {
		//calendarMain.clientWidth Height
		var calendarMainHeight = document.getElementById("calendarMain").clientHeight;
		var erectTableHeight = document.getElementById("erectTable").clientHeight;
		var topOverflow = document.getElementById("topOverflow");
		
		if (calendarMainHeight < erectTableHeight){
			topOverflow.style.display = "";
		}else{
			topOverflow.style.display = "none";	
		}
	},
	displayMore : function() {
		// 超过行数的去年多余数据显示更多，不够的加上数据
		// 实现方法：判断符合条件的天数（TD）重新加载数据
		for (var item in pagedata) {
			var array = pagedata[item];
			// 如果多于则删除，如果不够则补上
			var len = array.length;
			var curLen = $("#" + item + " > span > div").length;
			
			// 删除原有数据
			htmlUtil.removeRowData(item);
			// 重新加载数据
			htmlUtil.appendRowData(item, pagedata);
		}
	}
}

var thisPage = {
	preButton : function() {
		var tempDate = curDate.getFirstDateOfMonth().clone();
		tempDate.setDate(tempDate.getDate() - 1);
		curDate = tempDate;
		htmlUtil.removeHtml();
		thisPage.initTab();
	},
	nextButton : function() {
		var tempDate = curDate.getLastDateOfMonth().clone();
		tempDate.setDate(tempDate.getDate() + 1);
		curDate = tempDate;
		htmlUtil.removeHtml();
		thisPage.initTab();
	},
	todayButton : function() {
		curDate = new Date();
		htmlUtil.removeHtml();
		thisPage.initTab();
	},
	initTab : function (flag) {
		$("#curDate").text(curDate.format("Y年m月"));
		var lastMonthStart = dateUtil.getLastMonthStart(curDate);
	
		var str = "";
		str += htmlUtil.appendStart();
		
		for (var i = 0; i < dateUtil.getRow(); i++) {
			str += htmlUtil.appendTR();
	
			for (var j = 0; j < 7; j++) {			
				str += htmlUtil.appendMiddleTD(lastMonthStart, curDate);
				lastMonthStart.setDate(lastMonthStart.getDate() + 1);
			}
			str += htmlUtil.appendTREnd();
		}
		
		str += htmlUtil.appendEnd();
		
		$("#monthTb > tbody").append(str);

		// 追加数据
		var startDate = dateUtil.getLastMonthStart(curDate).format('Y-m-d');
		var endDate = dateUtil.getMonthEnd(curDate).format('Y-m-d');
		getDataByAjax(startDate, endDate, renderData)

		// 同步窗体大小
		divUtils.syncWindow(true);
	}
};

function getLunarDay(date){
	var _lunarYear = date.getFullYear();  
	var _lunarMonth = date.getMonth();;
	var _lunarDay = date.getDate();
	
	var sDObj = new Date(_lunarYear, _lunarMonth, _lunarDay);
	var lDObj = new Lunar(sDObj);
	var day = cDay(lDObj.day);
	if("初一" == day){
		day = cMonthy(lDObj.month) + day;
	}
	return day;
}

// 渲染数据
function renderData(json){
	pagedata = json;
	htmlUtil.appendPageData();
}

// 重新加载本页面视图
function refresh(){
	msgUtil.divMsgClose();
 	htmlUtil.removeHtml();
 	thisPage.initTab();
}

//初始化
jQuery(function($){
	$(window).bind("resize", divUtils.syncWindow);
	
	// 绑定日期域
	$("#dateElect").datepicker({
		showAnim:'',
		showButtonPanel: false,
		changeMonth: true,
		changeYear: true,
		showTime: false,
		onSelect: function(dateText, inst) {
			curDate = Date.parseDate(dateText, "Y-m-d");
			$("#curDate").html($.datepicker.formatDate("yy年m月",curDate));
			refresh();
		}
	});
	
	thisPage.initTab();
});

