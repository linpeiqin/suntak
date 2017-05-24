<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" tree="true" messager="true"/>
<head>
	<title></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssId="oz-app-icon"/>
</head>
<body class="oz-body oz-form" style="background-color: #F4FEFF;height:100%;width:100%;overflow:hidden;border:none;margin: 0px;padding: 0px;background-color: white;">
	<table width="100%" class="oz-form-bordertable" style="border-top:0px solid #99BBE8;">
		<tr height="28px"> 
			<td class="oz-form-label" width="70px">
				<oz:messageSource code="oz.web.navigation.node.fields.name"/>：
			</td>
			<td class="oz-property" width="260px">
				<input type="text" id="name" class="oz-form-btField" value="<%= request.getAttribute("name") %>">
			</td>	
		</tr>
		<tr height="32px">
			<td class="oz-form-label">
				<oz:messageSource code="oz.web.navigation.node.fields.icon"/>：
			</td>
			<td class="oz-property">
				<div id="naviIcon" class="app-icon" style="top:0px;margin-top:0px;margin-left:0px;position: relative; width:16px;cursor:pointer;" onclick="onBtnSelectNaviIcon_Clicked()">
				</div>
			</td>	
		</tr>
		<tr height="28px">
			<td class="oz-form-label" width="70px">
				<oz:messageSource code="oz.web.navigation.node.fields.url"/>：
			</td>
			<td class="oz-property" width="260px">
				<input type="text" id="url" class="oz-form-field" value="<%= request.getAttribute("url") %>">
			</td>	
		</tr>
	</table>
	<div id="naviIcons" style="position:absolute; left:79px; top:27px; width:260px; height:140px; border:1px solid #E3E3E3; background-color:white; overflow:auto; display:none">
		<%
			String iconRow = "";
			String iconCol = "";
			for(int row = 1; row < 16; row++){
				if(row < 10)
					iconRow = "0";
				else
					iconRow = "";
				iconRow += String.valueOf(row);
				for(int col = 1; col < 21; col++){
					if(col < 10)
						iconCol = "0";
					else
						iconCol = "";
					iconCol += String.valueOf(col);
		%>
			<a href="javascript:onNaviIcon_Clicked('app-icon-<%= iconRow %><%= iconCol %>')" style="width:24px;height:24px;cursor:pointer;">
				<span class="app-icon app-icon-<%= iconRow %><%= iconCol %>"></span>
			</a>
		<%		
				}
			}
		%>
	</div>
	<input type="hidden" id="icon" name="icon" value="<%= request.getAttribute("icon") %>">
</body>
<oz:js/>
<script type="text/javascript">
function onBtnSelectNaviIcon_Clicked(){
	$("#naviIcons").show();
}

function onNaviIcon_Clicked(icon){
	var oldIcon = $("#icon").val();
	if(null != oldIcon && oldIcon.length > 0)
		$("#naviIcon").removeClass(oldIcon);
	$("#naviIcon").addClass(icon);
	$("#icon").val(icon);
	$("#naviIcons").hide();
}

$(function(){
	var icon = $("#icon").val();
	if(null != icon && icon.length > 0)
		$("#naviIcon").addClass(icon);
	
	var canEditUrl = '<%= request.getAttribute("canEditUrl") %>';
	if("n" == canEditUrl){
		$("#url").addClass("oz-form-zdField");
		$("#url").attr("readOnly", "readOnly");
	}
});

function ozDlgOkFn(){
	var name = $("#name").val();
	if(null == name || name.length == 0){
		OZ.Msg.alert("请填写导航的名称");
        return false;	
	}
	
    return { 
    	name:name,
    	icon:$("#icon").val(),
    	url:$("#url").val()
    };
}
</script>
</html>