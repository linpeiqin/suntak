<!DOCTYPE HTML>
<%@page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="dialog" tree="true" messager="true" datePicker="true"/>
<head>
	<title>日期和时间 </title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body style="background-color: #FFFFFF;height:100%;width:100%;overflow:auto;border:none;margin:0px;padding: 0px;overflow: hidden;">
	<div style="padding:3px 6px;">
		<b>可选格式:</b>
	</div>
	<div style="text-align:center;padding:0px 6px;">
		<select id="dateList" size="15" style="width:100%" ondblclick="selected();"></select>
	</div>
	<div style="text-align:right;padding:5px;">
		<button onclick="selected();" class="oz-form-button">确定</button>&nbsp;
		<button onclick="cancel();" class="oz-form-button">取消</button>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function selected(){
	window.returnValue = $("#dateList").val();	
	window.close();
}

function cancel(){
	window.close();
}

function ozDlgOkFn(){	
	return $("#dateList").val();
}

Number.prototype.toCHS = function (b) {
    var arr = ["〇", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十"];
	var r = b? ((this > 19 ? Math.floor(this / 10) : "") + (this > 9 ? ("十") : "") + (this % 10 == 0 ? "" : this % 10) ): this;
    return ("" + r).replace(/(\d)/g, function (w) {
    	return arr[w];
    });
}

Date.prototype.format = function(format) {
    var o = {
   		"N": this.getFullYear().toCHS(false),
   		"Y":  (this.getMonth() + 1).toCHS(true),
   		"R":  this.getDate().toCHS(true),
		"W": this.getDay().toCHS(true),
        "y+": this.getFullYear(),
		"M+": this.getMonth() + 1,
        "d+": this.getDate(),
		"h+": (this.getHours() % 12) ? this.getHours() % 12 : 12,
        "H+": this.getHours(),
        "m+": this.getMinutes(),
        "s+": this.getSeconds(),
        "q+": Math.floor((this.getMonth() + 3) / 3),
        "S+": this.getMilliseconds(), //millisecond
		"a": (this.getHours() < 12 ? 'am' : 'pm'),
        "A": (this.getHours() < 12 ? '上午' : '下午')
	}
    
    for (var k in o)
    	if (new RegExp("(" + k + ")").test(format)) format = format.replace(RegExp.$1, oz.String.leftPad(o[k],RegExp.$1.length, '0'));
    return format;
}

var formats = ["y年M月d日",
               "N年Y月R日",
               "y年M月d日星期W",
               "N年Y月R日星期W",
               "y年M月",
               "N年Y月",
               "y/M/d",
               "y.M.d",
               "HH:mm:ss",
               "h时m分s秒",
               "H时m分",
               "Ah时m分"];
               
function initList(d){
	$("#dateList").empty();
	var s = "";
	$.each(formats,function(){
		var v = d.format(this);
		s +="<option value='"+v+"'>"+v+"</option>";
	})
	$("#dateList").html(s);
}

function init(){
	initList(new Date());
}

init();
</script>
</html>