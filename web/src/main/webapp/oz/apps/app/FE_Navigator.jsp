<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" easyui="true"/>
<head>
	<title><oz:messageSource code="oz.web.navigator"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
	<oz:css cssId="oz-app-icon"/>
	<oz:css cssId="oz-page401"/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.web.navigator"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="app/navigatorAction" defaultTB="editForm">
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="app/navigatorAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.web.navigator"/></div>
			<div class="oz-form-fields">
				<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:98%;table-layout:fixed;border-top-width:0px">
					<tr class="oz-form-locate-tr">
						<td width="10%" style="border-left:1px solid white;"></td>
						<td width="74%"></td>
						<td width="16%" style="border-right:1px solid white;"></td>
					</tr>
					<tr class="oz-form-tr"> 
						<td class="oz-form-label-r"><oz:messageSource code="oz.web.navigator.fields.name"/>：</td>
						<td class="oz-property">
							<html:text property="name" styleId="name" styleClass="oz-form-btField"/>
						</td>
						<td></td>
					</tr>
					<tr class="oz-form-tr"> 
						<td class="oz-form-label-r"><oz:messageSource code="oz.web.navigator.fields.enable"/>：</td>
						<td>
							<html:radio property="enable" styleId="enable" value="true"/><oz:messageSource code="oz.enable"/> 
							<html:radio property="enable" styleId="enable" value="false"/><oz:messageSource code="oz.disable"/>
						</td>
						<td></td>
					</tr>
					<tr class="oz-form-tr"> 
						<td class="oz-form-label-r"><oz:messageSource code="oz.web.navigator.fields.priority"/>：</td>
						<td class="oz-property">
							<html:text property="priority" styleId="priority" styleClass="oz-form-btField" style="width:90px"/>							
						</td>
						<td>
							<span class="oz-form-fields-span" style="color:gray;font-weight:normal;">
								<oz:messageSource code="oz.web.navigator.fields.priority.memo"/>
							</span>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.web.navigator.fields.used.acl"/>：</td>
						<td class="oz-property">
							<oz:acl entityClazz="cn.oz.web.navigator.domain.Navigator" permissionMask="2" style="width:492px;float:left;" styleClass="oz-form-field"></oz:acl>
						</td>
						<td>
							<span class="oz-form-fields-span" style="color:gray;font-weight:normal;">
								<oz:messageSource code="oz.web.navigator.fields.used.acl.memo"/>
							</span>
						</td>
					</tr>
					<tr class="oz-form-tr"> 
						<td class="oz-form-label-r"><oz:messageSource code="oz.web.navigator.fields.description"/>：</td>
						<td class="oz-property">
							<html:text property="description" styleId="description" styleClass="oz-form-field"/>
						</td>
						<td></td>
					</tr>
					<tr class="oz-form-tr"> 
						<td class="oz-form-label-r"><oz:messageSource code="oz.web.navigator.fields.navigator"/>：</td>
						<td colspan="2">
							<div class="oz-form-separator" style="width:350px;height:24px;;float:left">
								<h2 class="oz-form-separator-title">
									导航栏目
								</h2>								
							</div>
							<div style="width:16px;float:left">&nbsp;</div>
							<div class="oz-form-separator" style="width:350px;height:24px;float:left">
								<h2 class="oz-form-separator-title">
									可选栏目
								</h2>
							</div>
						</td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-topLabel"></td>
						<td colspan="2">
							<div style="border:1px solid #76ABD3;width:350px;height:360px;float:left;overflow:auto;">
								<ul id="navigator"></ul>
							</div>
							<div style="width:16px;float:left">&nbsp;</div>
							<div style="border:1px solid #76ABD3;width:350px;height:360px;float:left;overflow:auto;">
								<ul id="appNavigator"></ul>
							</div>
						</td>
					</tr>
				</table>
			</div>
			<html:hidden property="id" styleId="id"/><html:hidden property="unitId" styleId="unitId"/>
			<html:hidden property="naviData" styleId="naviData"/>
		</html:form>
	</div>
	<div id="mm" class="easyui-menu" style="width:120px;">
		<div onclick="editNaviNode()" iconCls="icon-edit">编辑</div>
		<div onclick="removeNaviNode()" iconCls="icon-cancel">删除</div>
		<div class="menu-sep"></div>
		<div onclick="appendNaviNode()" iconCls="icon-add">添加</div>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function beforeSave(){
	var roots = $('#navigator').tree('getRoots');
	if(null != roots && roots.length > 0){
		var naviData = [];
		for(var i = 0; i < roots.length; i++){
			var rootData = getData(roots[i]);
			if(null != rootData){
				naviData.push(rootData);
			}
		}
		$("#naviData").val($.toJSON(naviData));
	}
}

function getData(node){
	var nodeData = {};
	nodeData.id = node.id;
	nodeData.text = node.text;
	if(null != node.attributes){
		if(node.attributes['naviType'])
			nodeData.naviType = node.attributes['naviType'];
		if(node.attributes['label'])
			nodeData.label = node.attributes['label'];
		if(node.attributes['url'])
			nodeData.url = node.attributes['url'];
		if(node.attributes['icon'])
			nodeData.icon = node.attributes['icon'];
	}
		
	var childs = $('#navigator').tree('getChildren', node.target);
	if(null != childs && childs.length > 0){
		var childData = [];
		for(var ci = 0; ci < childs.length; ci++){
			var pnode = $('#navigator').tree('getParent', childs[ci].target);
			if(null == pnode)
				continue;
			if(pnode.text != node.text)
				continue;
			
			var child = getData(childs[ci]);
			if(null != child)
				childData.push(child);
		}
		nodeData.children = childData;
	}	
	return nodeData;
}

function removeNaviNode(){
	var node = $('#navigator').tree('getSelected');
	$('#navigator').tree('remove', node.target);
}

function editNaviNode(){
	var curNode = $('#navigator').tree('getSelected');
	if(null == curNode)
		return;
	
	var naviType = "";
	var strUrl = contextPath + "/app/navigatorAction.do?action=dlgNode";
	strUrl += "&timeStamp=" + new Date().getTime();
	strUrl += "&name=" + encodeURIComponent(curNode.text);
	if(null != curNode.attributes){
		if(curNode.attributes['url'])
			strUrl += "&url=" + encodeURIComponent(curNode.attributes['url']);
		if(curNode.attributes['icon'])
			strUrl += "&icon=" + encodeURIComponent(curNode.attributes['icon']);
		
		if(curNode.attributes['naviType'])
			naviType = curNode.attributes['naviType'];
		if("nav" == naviType || "app" == naviType)
			strUrl += "&canEditUrl=n";
	}
	new OZ.Dlg.create({ 
		id:"Dlg_NavigationNode",
		width:360, 
		height:240,
		title:'<oz:messageSource code="oz.web.navigator.dlg.title.navigation.node"/>',
		url: strUrl,
		onOk:function(newNode){
			$('#navigator').tree('update', {
				target: curNode.target,
				id: curNode.id,
				text: newNode.name,
				iconCls: 'app-icon ' + newNode.icon,
				attributes:{
					url: newNode.url,
					icon: newNode.icon,
					naviType: naviType
				}
			});
		},onCancel:function(result){
			
		}
	});
}

function appendNaviNode(){
	var strUrl = contextPath + "/app/navigatorAction.do?action=dlgNode";
	strUrl += "&timeStamp=" + new Date().getTime();
	new OZ.Dlg.create({ 
		id:"Dlg_NavigationNode",
		width:360, 
		height:240,
		title:'<oz:messageSource code="oz.web.navigator.dlg.title.navigation.node"/>',
		url: strUrl,
		onOk:function(newNode){
			var curNode = $('#navigator').tree('getSelected');
			$('#navigator').tree('append',{
				parent: (curNode ? curNode.target : null),
				data:[{
					text:newNode.name,
					iconCls: 'app-icon ' + newNode.icon,
					attributes:{
						url: newNode.url,
						icon: newNode.icon
					}
				}]
			});
		},onCancel:function(result){
			
		}
	});
}

$(function(){
	var strUrl = contextPath + "/app/navigatorAction.do?action=loadAppNaviTree&id=" + $("#id").val();
	strUrl += "&timeStamp=" + new Date().getTime();
	$('#appNavigator').tree({
		checkbox: false,
		animate: true, 
		dnd: true,
		url: strUrl
	});
	
	strUrl = contextPath + "/app/navigatorAction.do?action=loadNaviTree&id=" + $("#id").val();
	strUrl += "&timeStamp=" + new Date().getTime();
	$('#navigator').tree({
		checkbox: false,
		animate: true, 
		dnd: true,
		url: strUrl,
		onClick:function(node){
			$('#navigator').tree('beginEdit', node.target);
		},
		onContextMenu: function(e, node){
			e.preventDefault();
			$('#navigator').tree('select', node.target);
			$('#mm').menu('show', {
				left: e.pageX,
				top: e.pageY
			});
		}
	});
});
</script>
</html>