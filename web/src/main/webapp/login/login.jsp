<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<html>
	<oz:ui/>
	<head>
		<title><oz:systemConfiguration key="system.title"></oz:systemConfiguration>-<oz:systemConfiguration key="system.version.no"></oz:systemConfiguration></title>
		<%@ include file="/oz/includes/meta.jsp"%>
		<oz:css/>
		<oz:css cssHref="/login/login.css"/>
	</head>
<body style="overflow: hidden;background-color: #FFF">
	<div id="main" style="100%;height:100%;overflow: hidden;">
		<div style="margin-left:-450px; margin-top:-250px; top:50%; left:50%; position: absolute;">
			<div id="box">
				<div class="login-icon mainImage"></div>
				<html:form action="/loginAction.do" styleId="loginForm" target="_top">
					<ul class="controls">
						<li class="line first">
							<ul>
								<li class="cell label">帐&nbsp;&nbsp;号：</li>
								<li class="cell value">
									<html:text styleId="loginName" property="loginName" styleClass="textInput login-icon-input-default"/>
								</li>
							</ul>
							<div class="clear"></div>
						</li>
						<li class="line">
							<ul>
								<li class="cell label">密&nbsp;&nbsp;码：</li>
								<li class="cell value">
									<html:password styleId="loginPassword" property="loginPassword" styleClass="textInput login-icon-input-default"/>
								</li>
							</ul>
							<div class="clear"></div>
						</li>
						<li class="line">
							<ul>
								<li class="cell label">&nbsp;</li>
								<li class="cell value"><label for="auto"><input type="checkbox" id="isSavePwd" name="isSavePwd" value="true">下次自动登录</label></li>
							</ul>
							<div class="clear"></div>
						</li>
						<li class="line">
							<ul>
								<li class="cell label">&nbsp;</li>
								<li class="cell value">
									<a id="submit" href="javascript:;" class="login-icon login-icon-submit-default"></a>
									<input style="visibility: visible;" type="submit" id="submitBtn" name="submitBtn" value="">
								</li>
                                                                
							</ul>
							<div class="clear"></div>
						</li>
                        
					</ul>
					<html:hidden property="redirect" styleId="redirect"/>
					<html:hidden property="ouId" styleId="ouId"/>
				</html:form>
				<hr class="imageLine"/>
				<div class="copylight"><oz:systemConfiguration key="system.copyright"></oz:systemConfiguration></div>
				<div id="msg"></div>
				<div id="userRolesBox" style="z-index: 9999">
					<div><div id="selectRoleInfo">选择登录身份</div><div id="cancelRoleSelect" title="返回"></div><div style="font-size:0;clear:both;"></div></div>
					<ul id="userRoles"></ul>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
var debug = '<oz:systemConfiguration key="system.debug"></oz:systemConfiguration>';
</script>
<oz:js/>
<oz:js jsSrc="/login/login.js"/>
<script type="text/javascript">
	$(function(){
		//设置用户名为空
		$("#loginName").val("");
	});
</script> 
</html>