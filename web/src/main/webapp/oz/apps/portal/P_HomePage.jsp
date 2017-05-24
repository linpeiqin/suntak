<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<%@ page import="java.util.*,org.springframework.web.bind.ServletRequestUtils" %>
<%
	int width = ServletRequestUtils.getIntParameter(request, "width", 0);
	boolean simple = width < 500 || ServletRequestUtils.getBooleanParameter(request, "simple", false);
	String moduleId = ServletRequestUtils.getStringParameter(request, "moduleId", "module"  +  String.valueOf(new Date().getTime()));
%>
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
	<div style="padding:4px;text-align: center;margin-bottom:4px">
		<ul class="oz-home-icons">
			<li>
				<div onclick="<%=moduleId%>.editPersonal()">
					<div>
						<img src="<oz:contextPath/>/oz/apps/portal/images/user_profile.png">
					</div>
					<div>
						个人信息
					</div>
				</div>
			</li>
			<li>
				<div onclick="<%=moduleId%>.onBtnChangePassword_Clicked()">
					<div>
						<img src="<oz:contextPath/>/oz/apps/portal/images/user_password.png">
					</div>
					<div>
						修改密码
					</div>
				</div>
			</li>
		<%--	<li>
				<div onclick="<%=moduleId%>.onHomePage_Customize()">
					<div>
						<img src="<oz:contextPath/>/oz/apps/portal/images/create_homepage.png">
					</div>
					<div>
						首页定制
					</div>
				</div>
			</li>--%>
			<li>
				<div onclick="<%=moduleId%>.logout();">
					<div>
						<img src="<oz:contextPath/>/oz/apps/portal/images/exit.png">
					</div>
					<div>
						退出系统
					</div>
				</div>
			</li>
		</ul>
		<div style="clear: both;"></div>	
	</div>
<%--	<logic:present name="homePages">
	<div style="padding:4px;background-color: #EFF8FD;">
		<b>可选主页：</b>
		<select class="ozHomePageSelect" onchange="<%=moduleId%>.onHomePage_Changed()">
			<logic:iterate id="homePage" name="homePages" indexId="index">
			<option value='<bean:write name="homePage" property="id" format="#"/>'><bean:write name="homePage" property="name"/></option>
			</logic:iterate>
		</select>
	</div>
	</logic:present>
	<logic:notPresent name="homePages">
		<div style="height:6px">&nbsp;</div>
	</logic:notPresent>--%>
</div>

<script type="text/javascript">
(function(){
	var root = this,moduleId = "<%=moduleId%>";
	
	var moduleObject = {
			editPersonal : function (){
				OZ.openWindow({
					id:"editPersonal",
					title:'<oz:messageSource code="oz.mdu.organize.personal"/>',
					url:contextPath+"/organize/userInfoAction.do?action=editPersonal",
					refresh:false
				});
			},
			onBtnChangePassword_Clicked : function (){
				var strUrl = contextPath + "/security/userAction.do?action=dlgChangePassword";
				strUrl += "&timeStamp=" + new Date().getTime();
				
				new OZ.Dlg.create({ 
					id: "dlg_ChangePassword", 
					width:260, height:230,
					title:'<oz:messageSource code="oz.mdu.organize.userinfo.dlg.changpassword.title"/>',
					url: strUrl,
					onOk:function(result){
						$.getJSON(
							contextPath + "/security/userAction.do?action=changePersonalPassword&timeStamp=" + new Date().getTime(),
							{newPassword:result.newPassword, oldPassword:result.oldPassword},
							function(json){
								if(json.result == true){
									OZ.Msg.info('<oz:messageSource code="oz.mdu.organize.userinfo.dlg.changpassword.success"/>');
								}else{
									OZ.Msg.info(json.msg, null, onBtnChangePassword_Clicked);
								}
							}
						);
					},
					onCancel:function(result){
						// do nothing...
					}
				});
			},
			onHomePage_Customize : function (){
				var strUrl = contextPath + "/module/portalAction.do?action=customize&homePageId=" + _homePageId + "&timeStamp=" + new Date().getTime();
				OZ.openWindow({
					id:"HomePageCustomize",
					title:'<oz:messageSource code="oz.portalmgm.constants.homepage.customize"/>',
					url:strUrl,
					refresh:false
				});
			},
			onHomePage_Changed : function(){
				var homePageId = $("#"+moduleId + "Div").find(".ozHomePageSelect").val();
				if(_homePageId == homePageId)
					return;
				var homePageUrl = contextPath + "/module/portalAction.do?action=homePage&homePageId=" + homePageId + "&timeStamp=" + new Date().getTime();
				window.open(homePageUrl, "_self");
			},
			onload : function(){
				$("#"+moduleId + "Div").find(".ozHomePageSelect").val(_homePageId);
			},
			logout : function(){
				var logoutClosePage = false;
				if (logoutClosePage) {
					window.opener = null;
					window.open("", "_self");
					window.close();
				} else {
					var strUrl = contextPath + "/logoutAction.do";
					top.location.href = strUrl;
				}
			}
	};
	root[moduleId] = moduleObject;
})();
</script>