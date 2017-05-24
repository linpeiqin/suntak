jQuery(function($){
	var $loginForm = $("#loginForm");
	var modalLogin = false;

	//登录按钮
	$("#submit").hover(
		function () {
			if(!$(this).hasClass("login-icon-submit-mouseover"))
				$(this).addClass("login-icon-submit-mouseover");
		},
		function () {
			$(this).removeClass("login-icon-submit-mouseover");
		}
	).mousedown(function(){
	    if(!$(this).hasClass("login-icon-submit-mousedown")){
	    	$(this).addClass("login-icon-submit-mousedown");
	    }
	}).mouseup(function(){
		$(this).removeClass("login-icon-submit-mousedown");
	}).click(function(){
		onBtnLogin_Clicked();
	});

	//输入框处理
	if(!$.browser.safari){
		$(".textInput").focus(function () {
			if(!$(this).hasClass("login-icon-input-active"))$(this).addClass("login-icon-input-active");
		}).blur(function(){
			$(this).removeClass("login-icon-input-active");
		});
	}else{
		$(".textInput").removeClass("login-icon-input-default").addClass("login-icon-input-safari");
	}
	$("#loginName").focus();
	
	var selecting = false;
	//表单提交事件处理
	$loginForm.submit(function(){
		return submitForm();
	});
	
	//登录处理
	function onBtnLogin_Clicked(){
		$("#msg").hide();
		if(!validate()) 
			return false;
		selecting = false;
		
		var data = {loginName:$("#loginName").val(), loginPassword:$("#loginPassword").val(), isSavePwd:$("#isSavePwd:checked").val()};
		var strUrl = contextPath + "/loginAction.do?action=login&timeStamp=" + new Date().getTime();
		$.get(strUrl, data, function(json){
			  if(json.result){
				  submitForm();
			  }else{
				  showMsg("" + json.errMsg);
				  selecting = false;
			  }
		  }, "json");
	}

	function submitForm(){
		$("#debug").html($("#debug").html() + "<br/>selecting=" + selecting);
		if(selecting) 
			return false;
		
		// 提交表单
		var strUrl = contextPath + "/loginAction.do?action=logon&timeStamp=" + new Date().getTime();
		var loginForm = $loginForm.get(0);
		loginForm.action = strUrl;
		loginForm.target = "_self";
		$loginForm.unbind();
		loginForm.submit();
		return false;
	}

	//基本验证
	function validate(){ 
		if(!$("#loginName").val().length){
			showMsg("帐号不能为空！");
			$("#loginName").focus();
			return false;
		}
		if(!$("#loginPassword").val().length){
			showMsg("密码不能为空！");
			$("#loginPassword").focus();
			return false;
		}
		return true; 
	}

	//显示登录角色选择窗口:roles=[{name:"",ouId:"",ouName:"",ouFullName:""},...]
	function showUserRoles(roles){ 
		//$("#main").hide();//隐藏登录页面
		var t=[];
		for(var i=0;i<roles.length;i++){
			t.push('<li ouid="' + roles[i].ouId + '"><span></span>' + roles[i].ouFullName + '</li>');
		}
		var $userRolesBox = $("#userRolesBox");
		var $userRoles = $("#userRoles");
		$userRoles.unbind().empty().html(t.join(""));
		//if($userRolesBox.width() < 350) 
		//	$userRolesBox.css("width",350);
		//var _css = {top:($("body").height()-$userRolesBox.height())/2,left:($("body").width()-$userRolesBox.width())/2};//定位到屏幕的中间
		$userRolesBox.slideDown("fast",function(){
			$userRoles.find(">li").hover(
				function () {
					if(!$(this).hasClass("role-mouseover"))$(this).addClass("role-mouseover");
				},
				function () {
					$(this).removeClass("role-mouseover");
				}
			).mousedown(function(){
			    if(!$(this).hasClass("role-mousedown")) $(this).addClass("role-mousedown");
			}).mouseup(function(){
				$(this).removeClass("role-mousedown");
			}).click(function(){
				//log("ouId="+$(this).attr("ouId"));
				$("#ouId").val($(this).attr("ouId"));
				//$userRolesBox.hide();
				$(document).unbind();
				selecting = false;
				submitForm();
			});
		});
		$("#cancelRoleSelect").one("click",function(){
			selecting = false;
			$userRoles.unbind().empty();
			$userRolesBox.unbind().hide();
		});
		
		//选择默认的角色
		var selectedIndex = selectDefaultRole();
		
		//允许键盘导航:which for click: 1 === left; 2 === middle; 3 === right
		$(document).keydown(function(e){
			//log("keyCode="+e.keyCode+";si=" + selectedIndex);
			if(e.keyCode == 38 || e.keyCode == 40){//导航选择：38-向上,40-向下
				var step = (e.keyCode == 38 ? -1 : 1);
				var i = selectedIndex + step;
				var $li = $("#userRoles").find(">li:eq(" + i + ")");
				if($li.length){
					$("#userRoles").find(">li:eq(" + selectedIndex + ")").removeClass("role-mousedown");
					$li.addClass("role-mousedown");
					selectedIndex = i;
				}else{
					i = (e.keyCode == 38 ? $("#userRoles").find(">li").length-1 : 0);
					if(i!=selectedIndex){
						$("#userRoles").find(">li:eq(" + selectedIndex + ")").removeClass("role-mousedown");
						$li = $("#userRoles").find(">li:eq(" + i + ")");
						$li.addClass("role-mousedown");
						selectedIndex = i;
					}
				}
			}else if(e.keyCode == 13){//回车键：提交表单
				var ouId = $("#userRoles").find(">li:eq(" + selectedIndex + ")").attr("ouId");
				//log("ouId="+ouId);//return;
				$("#ouId").val(ouId);
				$(document).unbind();
				submitForm();
				selecting = false;
				//$("#userRolesBox").hide();
			}
		});
	}
	
	function selectDefaultRole(){ 
		$("#userRoles").find(">li:first-child").addClass("role-mousedown");
		return 0;
	}

	//显示提示信息
	function showMsg(msg){
		if(msg){
			if(msg.indexOf("口令") != -1 || msg.indexOf("password") != -1){
				$("#loginPassword").focus().select();
			}else if(msg.indexOf("帐号") != -1 || msg.indexOf("用户名") != -1 || msg.indexOf("user") != -1){
				$("#loginName").focus().select();
			}
			return $("#msg").html('<div class="icon-info"></div>'+msg).show("fast");
		}else{
			return $("#msg");
		}
	}

	//显示调试信息
	function log(msg){ 
		return $("#debug").html($("#debug").html() + '<br/>'+msg);
	}

	function getCookie(name){ 
		var strCookie = document.cookie; 
		var arrCookie = strCookie.split("; "); 
		for(var i = 0; i < arrCookie.length; i++){ 
			var arr = arrCookie[i].split("="); 
			if(arr[0] == name)
				return arr[1]; 
		} 
		return ""; 
	}

	function onSavePwd_clicked(){
		var chkSavePwdObj = $("#chkSavePwd");
		if(chkSavePwdObj.attr("class") != "login-checkbox-checked"){
			chkSavePwdObj.attr("class", "login-checkbox-checked");
			egdCookie.isSavePwd = "true";
		}else{
			chkSavePwdObj.attr("class", "login-checkbox");
			egdCookie.isSavePwd = "false";
		}
	}

	function setSavePwdStatus(checked){
		var chkSavePwdObj = $("#chkSavePwd");
		if(checked){
			chkSavePwdObj.attr("class", "login-checkbox-checked");
		}else{
			chkSavePwdObj.attr("class", "login-checkbox");
		}
	}

	//debug
	if(debug == "true" || window.location.href.indexOf("debug=true") != -1){
		//定义要显示的测试用户
		var users = "admin|超级管理员,chengang|陈刚,chenhao|陈浩,chenkeai|陈可爱,chenyili|陈毅力,chenzhongqun|陈忠群,cifu|慈赟,diqian|狄浅,dongzong|董总,fangboping|方波平,fangli|方立,fanyong|樊勇,fugangfeng|付刚峰,hechenxi|贺晨曦,heping|何萍,huangcheng|黄诚,huangjin|黄进,huangjinyan|黄金燕,huangwei|黄伟,laiqiaozhen|赖巧贞,lihao|李晟,lijingchang|李京长,liliping|李丽萍,linxiaojing|林晓静,liqi|李琦,liuzuogen|刘卓根,liyadong|李亚东,lizong|李总,luozhiqi|罗志奇,panbeichuan|潘北川,songming|宋明,sunchengming|孙承铭,suzong|苏总,tangjian|唐健,taomuming|陶慕明,taowu|陶武,wangchaoye|王晓野,wangchunge|王春阁,wangfeimilan|王菲米兰,wangjian|王健,wangshaoyun|王少云,wuxin|吴沂,wuxinxin|吴心心,xubaomin|徐保民,xuguotong|徐国统,xujianqing|徐建清,xurui|涂瑞,xuxiaoping|涂晓平,yangbinbin|杨彬彬,yewei|叶卫,yudiyun|余迪云,yuhong|于红,yuyong|于勇,yuyu|王珏,zhangdayong|张大勇,zhangxin|张鑫,zhaoyurong|赵玉荣,zhenghua|郑华,zhengyiping|郑一平,zhengyuhua|郑钰华,zhongtao|钟涛,zuoyanyun|左燕云";
		
		//默认自动填写超级管理员的帐号和密码
		$("#loginName").val("admin");
		$("#loginPassword").val("");

		//鼠标指到图标上就自动显示用户列表
		function buildDebugUsersUI(){
			if($("#debugUsers").length) {
				$("#debugUsers").show();
				return;
			}
			
			//创建可选用户列表
			var dir = "top";
			var html = '<div id="debugUsers" style="display:none;position:absolute;border:1px solid #B7AC94;background-color:#FFFEDE;width:200px;height:360px;overflow:auto">';
			if(dir == "top")html += '<div style="position:relative;"><span class="oz-icon oz-icon-1102" style="position:absolute;margin-top:-15px;right:0px;"></span></div>';
			html += '<form name="exporter" method="post" style="margin:2px;">'
				+'<div style="margin:8px 8px 0;height:22px;line-height:22px;font-size:14px;font-weight:bold;color:#333;">选择测试用户</div>'
				+'<ul>{0}</ul></form>';
			if(dir == "bottom")html += '<div style="position:relative;"><span class="oz-icon oz-icon-1103" style="position:absolute;margin-top:-1px;left:0px;"></span></div>'
			html += '</div>';
			var fields = [],field,name,keyName;
			users = users.split(",");
			for(var i=0;i<users.length;i++){
				keyName = users[i].split("|");
				if(keyName.length == 1) keyName[1] = keyName[0];
				fields.push('<li style="margin:4px;_margin:4;cursor:pointer;border:1px solid #E58433;font-size:14px;height:22px;line-height:22px;" account="'+keyName[0]+'"><span style="margin:0 4px;_margin:0 2px;">'+users[i]+'</span></li>');
			}
			var _css = $("#debug").offset();//{bottom:25,left:2}
			_css.right = $("body").width() - _css.left - 18;
			_css.top = _css.top + $("#debug").height() + 8;
			delete _css.left;
			var exporter = $(html.format(fields.join(""))).appendTo("body").css(_css).show();
			exporter.find("li").hover(
				function () {
					if(!$(this).hasClass("role-mouseover"))$(this).addClass("role-mouseover");
				},
				function () {
					$(this).removeClass("role-mouseover");
				}
			).click(function(e){
				var account = $(this).attr("account");
				$("#loginName").val(account);
				$("#loginPassword").val("password");
				onBtnLogin_Clicked();
			});
		};
		$('<div id="debug"></div>').appendTo("#box").mouseenter(buildDebugUsersUI).show();
		$('body').click(function(e) {
			if($("#debugUsers:visible"))$("#debugUsers").hide();
		});
	}
		
	$("input").keypress(function(e) {
		var keyCode = e.keyCode ? e.keyCode : e.which ? e.which : e.charCode;
		if(keyCode == 13){
			onBtnLogin_Clicked();
			return false;	// 取消默认的提交行为
		}
	});
});