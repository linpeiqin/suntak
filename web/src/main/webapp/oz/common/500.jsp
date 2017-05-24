<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"/>
<html>
	<head>
	<title>500 - 系统内部错误</title>
	<oz:css cssId="oz-common"/>
</head>
<body style="padding: 10px;overflow:hidden;">
	<div style="padding-top:24px;padding-left:24px;width:800;border: 0px solid red">
		<div style="width:280px;float:left">
			<img alt="" src="<oz:contextPath/>/oz/common/images/500.jpg">
		</div>
		<div style="padding-top:40px;">
			<p style="color: #C00;font-weight: bold;font-size: 16px;">哎哟，服务器出现500错误了：</p>
			<br/>
			<%
				String errMsg = (String)request.getAttribute("errMsg");
				if(null == errMsg || errMsg.length() == 0){
			%>
			<div class="msgDetail-textBold" style="color:#666;padding-top:6px">&nbsp;&nbsp;&nbsp;&nbsp;系统发生内部错误，可能的原因是:</div>
    		<div class="msgDetail-text" style="color:#666">
        		<ul>
        			<li style="padding-top:4px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1)系统正在进行维护;</li>
        			<li style="padding-top:4px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2)系统有程序错误。</li>
        		</ul>
    		</div>
			<%
				}else{
			%>
			<div class="msgDetail-textBold" style="color:#666;padding-top:6px">
				&nbsp;&nbsp;&nbsp;&nbsp;<%= errMsg %>
			</div>
			<%	
				}
			%>
			<br/>
    		<div class="msgButton-wrap">
    			<div class="msgButton-text" style="padding-top:4px;">
    				&nbsp;&nbsp;&nbsp;
    				<a href="javascript:onBtnBack_Click()" style="color:#0257AE">点击这里返回</a>
    			</div>
    		</div>
		</div>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function onBtnBack_Click(){
	OZ.closeWindow();
}
</script>
</html>