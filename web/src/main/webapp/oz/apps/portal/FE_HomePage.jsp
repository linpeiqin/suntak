<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<%@page import="java.util.List"%>
<%@page import="cn.oz.module.portalmgm.domain.Layout"%>
<%@page import="cn.oz.util.Constants"%>
<%@page import="cn.oz.module.portalmgm.domain.Portlet"%>
<oz:ui templete="portalForm"  ex="oz-linkbutton"/>
<html style="overflow:hidden;">
<head>
	<title><oz:messageSource code="oz.portalmgm.homepage"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<meta http-equiv="X-UA-Compatible" content="IE=8"/>
	<oz:css/>
	<oz:css cssHref="/oz/apps/portal/css/e_portal.css"/>
</head>
<body class="oz-body"> 
<div id="page" class="oz-page designer" >
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="module/portalAction">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnSave"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnEditProperty" text="oz.portalmgm.buttons.editproperty" icon="oz-icon-0434" onclick="onBtnEditFields_Clicked()"></oz:tbButton>
			<oz:tbButton id="btnEditLayout" text="oz.portalmgm.buttons.editlayout" icon="oz-icon-0602" onclick="onBtnEditLayout_Clicked()"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="formDiv" style="z-index: 10000;position: absolute;width: 100%;height: 100%;display: none;text-align: center;">
		<div class="divMask"></div>
		<div class="divMain">
			<div class="divMain-title">
				<span style="margin:10px;font-weight:bolder;line-height:42px;color:#0050ab;font-size:14px">
					<oz:messageSource code="oz.portalmgm.fields.editproperty"/>
				</span>
			</div>
			<div style="padding:10px;text-align: left;border: 1px solid #a6cbee;margin: 2px;margin-top:0px">
				<div style="padding: 5px;">
					<html:form action="/module/portalAction.do" styleId="ozForm"  styleClass="oz-form">
						<table cellpadding="4px" cellspacing="4px">
							<tr class="oz-form-emptyTR"> 
								<td width="80"></td>
								<td></td>
							</tr>
							<tr height="28px">
								<td class="oz-form-label"><oz:messageSource code="oz.portalmgm.fields.name"/>：</td>
								<td>
									<html:text property="name" styleId="name" styleClass="oz-form-btField" style="width:400px"></html:text>
								</td>
							</tr>
							<tr height="28px">
								<td class="oz-form-label"><oz:messageSource code="oz.portalmgm.fields.status"/>：</td>
								<td >
									<html:radio property="status" styleId="status" value="0"/><oz:messageSource code="oz.enable"/>&nbsp;&nbsp;
									<html:radio property="status" styleId="status" value="1"/><oz:messageSource code="oz.disable"/>&nbsp;&nbsp;
								</td>
							</tr>
							<tr height="28px">
								<td class="oz-form-label"><oz:messageSource code="oz.portalmgm.fields.acl"/>：</td>
								<td>
									<oz:acl idid="id" entityClazz="cn.oz.module.portalmgm.domain.HomePage" style="width:330px"></oz:acl>
								</td>
							</tr>
							<tr height="28px">
								<td class="oz-form-topLabel"><oz:messageSource code="oz.portalmgm.fields.memos"/>：</td>
								<td>
									<html:textarea property="memos" styleId="memos" styleClass="oz-form-field" style="width:400px" rows="5"></html:textarea>
								</td>
							</tr>
						</table>
						<html:hidden property="id" styleId="id"/><html:hidden property="uuid" styleId="uuid"/>
						<html:hidden property="author.name" styleId="author_name"/><html:hidden property="author.id" styleId="author_id"/>
						<html:hidden property="createdDateTime" styleId="createdDateTime"/><html:hidden property="cfgType" styleId="cfgType"/>
						<html:hidden property="configData" styleId="configData"/><html:hidden property="layoutId" styleId="layoutId"/>
					</html:form>
				</div>				
			</div>
			<div style="text-align: right;padding-bottom: 6px;padding-right:1px;padding-top:3px;">
				<a class="linkbutton" onclick="$('#formDiv').hide()" style="color:black;">&nbsp;<oz:messageSource code="oz.ok"/>&nbsp;</a>
			</div>
		</div>
	</div>
	<div id="designDiv" style="z-index: 10000;position: absolute;width: 100%;height: 100%;display: none;text-align: center;">
		<div class="divMask"></div>
		<div class="divMain">
			<div class="divMain-title">
				<span style="margin:10px;font-weight:bolder;line-height:42px;color:#0050ab;font-size:14px">
					<oz:messageSource code="oz.portalmgm.fields.editlayout"/>
				</span>
			</div>
			<div id="desginPanel" style="padding:10px;display: none;text-align: left;border: 1px solid #a6cbee;margin: 2px;margin-top:0px">
				<!-- 板式 -->
				<div style="padding: 5px;">
					<h3><b><oz:messageSource code="oz.portalmgm.constants.format"/>:</b></h3>
					<div class="radioGroup" id="modeConfigButtons" style="padding-left:30px;padding-top:6px">
						<input type="radio" id="full_mode" name="mode" value="full"/><label for="full_mode"><oz:messageSource code="oz.portalmgm.constants.format.fullscreen"/></label>&nbsp;
						<input type="radio" id="wide_mode" name="mode" value="wide" checked="checked"/><label for="wide_mode"><oz:messageSource code="oz.portalmgm.constants.format.widescreen"/></label>&nbsp;
						<input type="radio" id="petty_mode" name="mode" value="petty"/><label for="petty_mode"><oz:messageSource code="oz.portalmgm.constants.format.narrowscreen"/></label>
					</div>
				</div>
				<!-- 位置 -->
				<div style="padding: 5px;">
					<h3><b><oz:messageSource code="oz.portalmgm.constants.align"/>:</b></h3>
					<div class="radioGroup" id="alignConfigButtons" style="padding-left:30px;padding-top:6px">
						<input type="radio" id="left_align" name="align" value="left"/><label for="left_align"><oz:messageSource code="oz.portalmgm.constants.align.left"/></label>&nbsp;
						<input type="radio" id="center_align" name="align" value="center" checked="checked"/><label for="center_align"><oz:messageSource code="oz.portalmgm.constants.align.center"/></label>&nbsp;
						<input type="radio" id="right_align" name="align" value="right"/><label for="right_align"><oz:messageSource code="oz.portalmgm.constants.align.right"/></label>
					</div>
				</div>
				<!-- 布局 -->
				<div style="padding: 5px;">
					<h3><b><oz:messageSource code="oz.portalmgm.constants.layout"/>:</b></h3>
					<div class="radioGroup" id="layoutsButtons" style="padding-left:30px;padding-top:6px">
						<logic:iterate id="layout" name="layouts">
							<input type="radio" id="layout_<bean:write name="layout" property="id" format="#" />" name="layout" value="<bean:write name="layout" property="id" format="#" />"/>
							<label for="layout_<bean:write name="layout" property="id" format="#" />" class="layoutIcon ui-corner-all ui-state-default">
								<span class='oz-icon-layout <bean:write name="layout" property="iconClazz"/>'></span>
							</label>&nbsp;
						</logic:iterate>
					</div>
				</div>				
			</div>
			<div style="text-align: right;padding-bottom: 6px;padding-right:1px;padding-top:3px;">
				<a class="linkbutton" onclick="$('#designDiv').hide()" style="color:black;">&nbsp;<oz:messageSource code="oz.ok"/>&nbsp;</a>
			</div>
		</div>
	</div>
	<div id="portletDiv" style="z-index: 10000;position: absolute;width: 100%;height: 100%;display: none;text-align: center;">
		<div class="divMask"></div>
		<div class="divMain" style="width:360px">
			<div class="divMain-title">
				<span style="margin:10px;font-weight:bolder;line-height:42px;color:#0050ab;font-size:14px">
					<oz:messageSource code="oz.portalmgm.fields.selectportlet"/>
				</span>
			</div>
			<div style="padding:2px;text-align: left;border: 1px solid #a6cbee;margin: 2px;margin-top:0px">
				<oz:select value="value" property="selPortlet" options="portletOptions" multiple="true" size="12" style="width:100%;"></oz:select>
			</div>
			<div style="text-align: right;padding-bottom: 6px;padding-right:1px;padding-top:3px;">
				<a class="linkbutton" onclick="onSelectPortlet()" style="color:black;">&nbsp;<oz:messageSource code="oz.ok"/>&nbsp;</a>&nbsp;
				<a class="linkbutton" onclick="$('#portletDiv').hide()" style="color:black;">&nbsp;<oz:messageSource code="oz.cancel"/>&nbsp;</a>
			</div>
		</div>
	</div>
	<div id="page-center" style="overflow: auto;position: relative;">
			<div id="mainContainer" class="oz-portlet-container"></div>
	</div>
</div>
<div id="tpl_AddPortlet" style="display:none">
	<div align="center" class="oz-add-portlet">
		<div class="oz-add-portlet-icon"></div>
	</div>
</div>
<div id="module_temp" style="display: none;" class="oz-portlet-box">
	<div class="oz-portlet-outerbox oz-portlet">
  		<div class="oz-portlet-innerbox">
  			<div class="oz-portlet-box-content">
	   			<div class="oz-portlet-titleBar dragdrop-handle">
	    			<div class="oz-portlet-buttonBar"> 
	  					<a class="oz-portlet-btn close-btn" id="home_close9" onclick="OZ.Portlet.removeModule(this)"></a>
	  				</div>
	  				<div class="oz-portlet-title">
	    				<span class="oz-portlet-icon"><b class="oz-icon">&nbsp;</b></span><span class="title" ></span>
	    			</div>
	   			</div>
	    		<div class="oz-portlet-body-outer">
			   		<div class="oz-portlet-body"></div>
		    	</div>
	    	</div>
		</div>
	</div>
</div>
</body>
<oz:js/>
<oz:js jsSrc="/oz/apps/portal/js/portal.js"/>
<script type="text/javascript">
var _curContainerId = "";
var _addPortletBtnObj = null;

var _modules={};
<logic:iterate id="portlet" name="portlets">
	<logic:equal name="portlet" property="status" value="0">
		_modules.m<bean:write name="portlet" property="id" format="#" /> = {
			portletId : <bean:write name="portlet" property="id" format="#" />,
			title:"<bean:write name="portlet" property="name"/>", 
			url:"<bean:write name="portlet" property="urlPath" filter="false"/>",
			icon:"<bean:write name="portlet" property="icon"/>",
			hrefMore:"<bean:write name="portlet" property="hrefMore" filter="false"/>",
			showHead:"<bean:write name="portlet" property="minWindow"/>"
		};
	</logic:equal>
</logic:iterate>

function getOzEntityId(){
	var entityId = $("#id").val();
	if(null == entityId || entityId.length == 0 || entityId == "-1"){
		entityId = $("#uuid").val(); 
	}
	return entityId;
}

function beforeSave(){
	var name = $("#name").val();
	if(null == name || name.length == 0){
		OZ.Msg.alert('<oz:messageSource code="oz.portalmgm.msg.name.isnull"/>', null, function(){
			onBtnEditFields_Clicked();
		});
		return false;
	}
	
	var config = {};
	config.mode = $(":radio[name='mode'][checked]").val();
	config.align = $(":radio[name='align'][checked]").val();
	config.layoutId = $(":radio[name='layout'][checked]").val();
	config.modules = $.map($("#mainContainer .moduleItem"), function(item){
		var module = $(item).data("module");
		delete module.portlet;
		return module;
	});
	
	if(config.modules.length == 0){
		OZ.Msg.alert('<oz:messageSource code="oz.portalmgm.msg.config.isempty"/>');
		return false;
	}
	$("#configData").val($.toJSON(config));
	$("#layoutId").val($(":radio[name='layout'][checked]").val());
}
	
function onBtnSave_Success(){
	if(!($("#formDiv").is(":hidden"))){
		$("#formDiv").hide();
	}
}
	
function onBtnEditFields_Clicked(){
	$("#designDiv").hide();
	$("#portletDiv").hide();
	$("#formDiv").show();
}
	
function onBtnEditLayout_Clicked(){
	$("#formDiv").hide();
	$("#portletDiv").hide();
	$("#designDiv").show();
}

function onSelectPortlet(){
	var selPortletObj = document.getElementById("selPortlet");
	if(null == selPortletObj || selPortletObj.length == 0){
		$("#portletDiv").hide();
		return;
	}
		
	for (var i = 0; i < selPortletObj.length; i++){
		if (selPortletObj.options[i].selected){
			OZ.Portlet.addPortlet(_curContainerId, selPortletObj.options[i].value , true);
			selPortletObj.options[i].selected = false;
		}
	}		
	$("#portletDiv").hide();
}
function ozRefresh(data){
}


var _homePageId = null;

$(function(){
	var _configData = <%= request.getAttribute("configData") %>;
	_configData.layoutId =  '<%= request.getAttribute("layoutId") %>';
	
	$(".linkbutton").linkbutton();
		
	// 打开设计模式
	OZ.Portlet.setDesginMode(true);
			
	if(_configData._layoutId=="-1"){
		// 显示页面配置让用户进行配置
		$("#designDiv").toggle();
		OZ.Portlet.setMode("full");
		OZ.Portlet.setAlign("center");
		OZ.Portlet.setLayout();
	}else{
		// 初始配置	
		OZ.Portlet.loadPage(_configData);
	}
	
	$(".oz-add-portlet").live({
		"hover":function(ev){
			if(ev.type == 'mouseenter'){  
				$(this).addClass("oz-add-portlet-hover"); 
			}
			if(ev.type == 'mouseleave'){  
				$(this).removeClass("oz-add-portlet-hover");
			}
		},
		"click":function(ev){
			$("#formDiv").hide();
			$("#designDiv").hide();
			_curContainerId = $(this).parent().attr("id");
			_addPortletBtnObj = this;
			$("#portletDiv").show();
		}
	});
	
	$(".oz-portlet-box").live({
		"hover":function(ev){
			if(ev.type == 'mouseenter'){  
				$(this).addClass("oz-portlet-box-hover"); 
			}
			if(ev.type == 'mouseleave'){  
				$(this).removeClass("oz-portlet-box-hover");
			}
		}
	});
})
</script>
</html>