/**
 * 日期常用方法
 */
var dateUtil = {
	getLastMonthStart : function(curDate) {	// 找出当月视图中上个月的开始日期
		var lastDateOfMonth = curDate.getLastDateOfMonth();
		var firstDateOfMonth = curDate.getFirstDateOfMonth();
		var lastMonth = firstDateOfMonth.clone();
		lastMonth.setDate(firstDateOfMonth.getDate() - firstDateOfMonth.getDay());
		return lastMonth;
	},
	getMonthEnd : function(curDate) {
		 var endDateOfCurMonth = curDate.getLastDateOfMonth().clone();
		 var week = endDateOfCurMonth.getDay();
		 endDateOfCurMonth.setDate(endDateOfCurMonth.getDate() + (6 - week));
		 return endDateOfCurMonth;
	},
	getWeekStratDate : function(curDate) {	// 得到
		var tempDate = curDate.clone();
		var curWeek = tempDate.getDay();
		if (curWeek != 0) {
			tempDate.setDate(tempDate.getDate() - curWeek + 1);
		}else {
			tempDate.setDate(tempDate.getDate() - 6);
		}
		return tempDate;
	},
	getWeekEnd : function(curDate) {
		// 得到周的开始日期
		var tempDate = this.getWeekStratDate(curDate).clone();
		// 加６得到周的最后一天
		tempDate.setDate(tempDate.getDate() + 6);
		return tempDate;
	},
	getRow : function() {
		// 这个月最后一天　加上　这个月是星期几　得出总天数
		var countDate = curDate.getLastDateOfMonth().getDate() + curDate.getFirstDateOfMonth().getDay();
		var row = 5;	// 默认５行
		if (countDate <= 28) {
			row = 4;			// 如２００９年２月
		}else if (countDate > 28 && countDate <= 35) {
			row = 5;
		}else if (countDate > 35) {
			row = 6;
		}
		return row;
	},
	tdIdToDate : function(input, format) {
		// 此方法把原TDID转换为原来的日期，按format格式化
		var s = input.substring(1);
		return (Date.parseDate(s, "Ymd")).format(format);
	},
	isToday : function(date) {
		// 是否是今天
		var today =  new Date();
		var isToday = false;
		if (today.getYear() ==  date.getYear()) {
			if (today.getMonth() == date.getMonth()) {
				if (today.getDate() ==  date.getDate()) {
					isToday = true;
				}
			}
		}
		return isToday;
	},
	/**
	 * url路径添加时间差，防止页面缓存
	 */	
	addTimeStamp:function(url){
		var strUrl = url || "";
		if(strUrl.indexOf("timeStamp") == -1){
			if(strUrl.indexOf("?") != -1)
				strUrl += "&timeStamp=" + new Date().getTime();
			else
				strUrl += "?timeStamp=" + new Date().getTime();
		}
		return strUrl;
	},
	onTextChange : function(obj) {
		if ("" != obj.value) {
			setTimeout("dateUtil.setTextValue('" + obj.value + "')", 10);	
		}	
	},	
	setTextValue : function(value) {
		document.getElementById("dateElect").value = "";
		curDate = Date.parseDate(value, "Y-m-d");
		refresh();	
	},
	weeks : ['周日', '周一', '周二', '周三', '周四', '周五', '周六']
};