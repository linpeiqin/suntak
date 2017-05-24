var isShowDivMsg = true;
var _isCanShow = true;

var msgUtil = {
	divMsgClose : function() {
		var calendarMsg = document.getElementById("calendarMsg");
		calendarMsg.style.display="none";
	},
	showDivMsg : function(e) {
		var _event = e || event;
		if (isShowDivMsg || !_isCanShow) {
			return;
		}
		
		var calendarMsg = document.getElementById("calendarMsg");
		var calendarBody = document.getElementById("calendarBody");
		calendarMsg.style.display="";
		var msgTop = document.getElementById("msgTop");
		var msgLeft = document.getElementById("msgLeft");
		var msgRight = document.getElementById("msgRight");
		var msgBottom = document.getElementById("msgBottom");
		msgTop.style.display="none";
		msgLeft.style.display="none";
		msgRight.style.display="none";
		msgBottom.style.display="none";
		
		x = _event.clientX
		y = _event.clientY
		var msg_x;
		var msg_y;
		
		if (x > (calendarBody.clientWidth-330)){
			msg_x=x-380;
			if (y > (calendarBody.clientHeight -240)){
				msg_y=y-265;
				msg_x=x-325;
				msgBottom.style.display="";
			}else{
				msg_y=y-58;	
				msgRight.style.display="";
			}
		}else{
			msg_x=x-58;
			if (y > (calendarBody.clientHeight -240)){
				msg_y=y-208;
				msg_x=x;
				msgLeft.style.display="";
			}else{
				msg_y=y;
				msgTop.style.display="";
			}
			//////msg_y=y;
		}
		
		calendarMsg.style.left=msg_x;
		calendarMsg.style.top=msg_y;
		isShowDivMsg = true;
	}
}