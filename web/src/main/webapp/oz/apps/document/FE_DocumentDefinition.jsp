<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true" tabs="true" select="true" attachment="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.document.documentdefinition"/></title>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.document.documentdefinition"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="document/documentDefAction" defaultTB="editForm">
			<oz:tbButton id="btnEditRight" text="编辑权限" icon="oz-icon-1131" onclick="onEditRgith()"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="document/documentDefAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.mdu.document.documentdefinition"/></div>
			<div class="oz-form-fields">
				<table cellpadding="0">
					<tr class="oz-form-emptyTR"> 
						<td width="120"></td>
						<td width="380"></td>
						<td width="120"></td>
						<td width="180"></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.dd.fields.classified"/>：</td>
						<td class="oz-property">
                            <html:select property="classified" styleClass="oz-form-btField">
                                <html:optionsCollection name="DocumentClassified" label="name" value="value"/>
                            </html:select>
						</td>
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.dd.fields.filetype"/>：</td>
						<td class="oz-property">
							<html:text property="fileType" styleClass="oz-form-field"/>
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.dd.fields.name"/>：</td>
						<td class="oz-property">
							<html:text property="name" styleClass="oz-form-btField"/>
						</td>
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.dd.fields.code"/>：</td>
						<td class="oz-property">
							<html:text property="code" styleClass="oz-form-btField"/>
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.dd.fields.orderno"/>：</td>
						<td class="oz-property">
							<html:text property="orderNo" styleClass="oz-form-btField"/>
						</td>
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.dd.fields.status"/>：</td>
						<td>
							<html:radio property="enable" styleId="enable" value="true"/><oz:messageSource code="oz.enable"/>
							<html:radio property="enable" styleId="enable" value="false"/><oz:messageSource code="oz.disable"/>
						</td>
					</tr>
					<tr id="TR_PROCESSNEW" style="display:none"> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.dd.fields.process"/>：</td>
						<td class="oz-property" colspan="3">
							<html:select property="processCfgId" styleId="processCfgId" styleClass="oz-form-btField" style="width:612px;float:left" onchange="onProcessCfgSelect_Changed()">
								<html:option value="-1"><oz:messageSource code="oz.select.blank.text"/></html:option>
								<html:optionsCollection name="processOptions" label="name" value="value" />
							</html:select>
							<button id="btnCreateProcess" type="button" class="oz-form-button" style="width:62px;height:21px;float:right" onclick="onBtnEditProcess_Clicked()" ><oz:messageSource code="oz.mdu.document.dd.buttons.editprocess"/></button>
						</td>
					</tr>
					<tr id="TR_PROCESSEDIT">
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.dd.fields.process"/>：</td>
						<td colspan="3">
							<html:text property="processName" styleClass="oz-form-zdField" readonly="true" style="width:612px;float:left"/>
							<button id="btnEditProcess" type="button" class="oz-form-button" style="width:62px;height:21px;float:right;" onclick="onBtnEditProcess_Clicked()" ><oz:messageSource code="oz.mdu.document.dd.buttons.editprocess"/></button>
						</td>
					</tr>
					<tr id="TR_FORMNEW" style="display:none">
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.dd.fields.form"/>：</td>
						<td class="oz-property" colspan="3">
							<html:select property="formCfgId" styleId="formCfgId" styleClass="oz-form-btField" style="width:612px;float:left" onchange="onProcessFormSelect_Changed()">
								<html:option value="-1"><oz:messageSource code="oz.select.blank.text"/></html:option>
								<html:optionsCollection name="formOptions" label="name" value="value" />
							</html:select>
							<button id="btnCreateForm" type="button" class="oz-form-button" style="width:62px;height:21px;float:right" onclick="onBtnEditForm_Clicked()" ><oz:messageSource code="oz.mdu.document.dd.buttons.editform"/></button>
						</td>
					</tr>
					<tr id="TR_FORMEDIT">
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.dd.fields.form"/>：</td>
						<td colspan="3">
							<html:text property="formName" styleClass="oz-form-zdField" readonly="true" style="width:612px;float:left"/>
							<button id="btnEditForm" type="button" class="oz-form-button" style="width:62px;height:21px;float:right;" onclick="onBtnEditForm_Clicked()" ><oz:messageSource code="oz.mdu.document.dd.buttons.editform"/></button>
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.dd.fields.used.acl"/>：</td>
						<td class="oz-property" colspan="3">
							<oz:acl id="aclUsed" entityClazz="cn.oz.module.document.def.domain.DocumentDefinition" permissionMask="2" rows="3" style="width:612px;float:left;"></oz:acl>
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.dd.fields.view.acl"/>：</td>
						<td class="oz-property" colspan="3">
							<oz:acl id="aclView" entityClazz="cn.oz.module.document.def.domain.DocumentDefinition" permissionMask="4" rows="3" style="width:612px;float:left;"></oz:acl>
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.dd.fields.admin.acl"/>：</td>
						<td class="oz-property" colspan="3">
							<oz:acl id="aclAdmin" entityClazz="cn.oz.module.document.def.domain.DocumentDefinition" permissionMask="1" rows="3" style="width:612px;float:left;"></oz:acl>
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.mdu.document.dd.fields.description"/>：</td>
						<td class="oz-property" colspan="3">
							<html:text property="description" styleClass="oz-form-field"/>
						</td>
					</tr>
				</table>			
			</div>
			<html:hidden property="id" styleId="id"/><html:hidden property="uuid" styleId="uuid"/>
			<html:hidden property="author.id" styleId="author.id"/><html:hidden property="author.name" styleId="author.name"/>
			<html:hidden property="createdDateTime" styleId="createdDateTime"/><html:hidden property="IS_ENABLE" styleId="IS_ENABLE"/>
			<html:hidden property="processCfg.id" styleId="processCfg_id"/><html:hidden property="formCfg.id" styleId="formCfg_id"/>
			<html:hidden property="adminAclFlag" styleId="adminAclFlag"/><html:hidden property="usedAclFlag" styleId="usedAclFlag"/>
			<html:hidden property="viewAclFlag" styleId="viewAclFlag"/><html:hidden property="unitId" styleId="unitId"/>
			<html:hidden property="hideRights" styleId="hideRights"/>
		</html:form>
		<div class="oz-form-tabs">
				<div id="tabCt" class="border" data-tabs='{"height":470}' style="border-width:0px;background-color: transparent;">
					<div data-tab-panel='{"id":"tab_02","title":"<oz:messageSource code="oz.mdu.document.dd.tabs.relateds"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<iframe id="IFRAME_02" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" src="">
						</iframe>
					</div>
					<div data-tab-panel='{"id":"tab_03","title":"<oz:messageSource code="oz.mdu.document.dd.tabs.mapping"/>","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
						<iframe id="IFRAME_03" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" src="">
						</iframe>
					</div>
				</div>	
			</div>
			<div>
		</div>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
var _rights4Activity = [];
var _curActivity = "";

function onExportExecute(){
	if($("#id").val() == -1){
		OZ.Msg.info("文档未保存，不能执行导出。");
		return false;
	}else{
		window.open(contextPath+"/document/documentXmlAction.do?action=exportDefine&id="+$("#id").val());
	}	
	return false;
}

function onBtnSave_Clicked(){
	var id = $("#id").val();
	if(id == -1){
		ozTB_DefaultBtnSave_Clicked(contextPath + "/document/documentDefAction.do");
	}else{
		ozTB_DefaultBtnSaveByAjax_Clicked(contextPath + "/document/documentDefAction.do");
	}
}

// 保存前将用户设置的权限进行序列化
function beforeSave(){
	return true
}

/**
 * Acl使用到的函数，获取表单的对象ID
 */
function getOzEntityId(){
	var entityId = $("#id").val();
	if(null == entityId || entityId.length == 0 || entityId == "-1"){
		entityId = $("#uuid").val(); 
	}
	return entityId;
}

var _mappingLoadFlag = -1;	
var _relatedLoadFlag = -1;
function onPageActive(data, editFlag){
	var idVal = $("#id").val();
	var pageId = data.tab.tabPanel("option","id");
	if(pageId == "tab_02"){				// 关联文种
		strUrl = contextPath + "/document/documentDefAction.do?action=display&viewType=related&editFlag=y&&ddId=" + idVal;
		_relatedLoadFlag = loadSubPanel("IFRAME_02", _relatedLoadFlag, strUrl);
	}else if(pageId == "tab_03"){		// 文种映射
		 strUrl = contextPath + "/document/documentMappingAction.do?action=display&editFlag=true&sourceId=" + idVal;
		 _mappingLoadFlag = loadSubPanel("IFRAME_03", _mappingLoadFlag, strUrl);
	}
}

function loadSubPanel(iframeId, loadFlag, strUrl){
	if(loadFlag == 0)
		($("#" + iframeId).get(0)).src = strUrl + "&timeStamp=" + new Date().getTime();
	return loadFlag + 1;
}

function onProcessCfgSelect_Changed(){
	$("#processCfg_id").val($("#processCfgId").val());
}

function onBtnEditProcess_Clicked(){
	var processCfgId = $("#processCfg_id").val();
	if(null == processCfgId || processCfgId.length == 0 || processCfgId == -1){
		OZ.Msg.info('<oz:messageSource code="oz.mdu.document.dd.msg.documentprocess.isnull"/>');
		return;
	}

	var strUrl = contextPath + "/document/documentDefAction.do?action=getProcessCfgKey&timeStamp=" + new Date().getTime();
	$.getJSON(
		strUrl, 
		{processCfgId:processCfgId},
		function(json){
			if(json.result){
				if(json.supporter != "documentProcessSupporter4BPM"){
					OZ.Msg.info('<oz:messageSource code="oz.mdu.document.dd.msg.documentprocess.type.cant.support"/>');
					return;
				}else{
					strUrl = contextPath + "/ozbpm/processModeler?key=" + json.pdKey + "&timeStamp=" + new Date().getTime();
					var newwindow = window.open(strUrl, "_blank");
					if (document.all){
						newwindow.moveTo(0,0);
						newwindow.resizeTo(screen.width, screen.height);
					}
				}
			}else{
				OZ.Msg.info(json.msg);
			}
		}
	);
}

function onProcessFormSelect_Changed(){
	$("#formCfg_id").val($("#formCfgId").val());
}

function onBtnEditForm_Clicked(){
	var formCfgId = $("#formCfg_id").val();
	if(null == formCfgId || formCfgId.length == 0 || formCfgId == -1){
		OZ.Msg.info('<oz:messageSource code="oz.mdu.document.dd.msg.documentform.isnull"/>');
		return;
	}

	var strUrl = contextPath + "/document/documentDefAction.do?action=getFormCfgKey&timeStamp=" + new Date().getTime();
	$.getJSON(
		strUrl, 
		{formCfgId:formCfgId},
		function(json){
			if(json.result){
				if(json.supporter != "documentFormSupporter4FormEngine"){
					OZ.Msg.info('<oz:messageSource code="oz.mdu.document.dd.msg.documentform.type.cant.support"/>');
					return;
				}else{
					strUrl = contextPath + "/form/designerAction.do?key=" + json.formKey + "&timeStamp=" + new Date().getTime();
					var newwindow = window.open(strUrl, "_blank");
					if (document.all){
						newwindow.moveTo(0,0);
						newwindow.resizeTo(screen.width, screen.height);
					}
				}
			}else{
				OZ.Msg.info(json.msg);
			}
		}
	);
}

function changeElementDisplay(){
	if($("#id").val() == -1){
		$("#TR_PROCESSNEW").show();
		$("#TR_PROCESSEDIT").hide();
		$("#TR_FORMNEW").show();
		$("#TR_FORMEDIT").hide();
	}else{
		$("#TR_PROCESSNEW").hide();
		$("#TR_PROCESSEDIT").show();
		$("#TR_FORMNEW").hide();
		$("#TR_FORMEDIT").show();		
	}	
}

function refresh(data){
	var tabType = data.data;
	if(tabType == "documentMapping"){
		_mappingLoadFlag = false;
		$("#tabCt").tabs("activeTab","tab_03");
	}
}

$(function(){
	changeElementDisplay();
	
	$("#tabCt").tabs({
		active:function(e,data){onPageActive(data, true);}
	});
	$("#tabCt").tabs("activeTab","tab_02");
});
</script>
<script type="text/javascript">
function onEditRgith(){
	var id = $("#id").val();
	if(id=="-1"){
		OZ.Msg.alert("请先保存文档。");
		return;
	}
	OZ.openWindow({
		id:"editRight",
		title:"编辑权限",
		url:contextPath+"/document/def/rightAction.do?action=edit&id="+$("#id").val()
	})
}
</script>
</html>