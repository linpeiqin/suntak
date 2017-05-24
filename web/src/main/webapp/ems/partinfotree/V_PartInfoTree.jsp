<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view" tree="true"/>
<html>
<head>
	<title>
		配件关联树
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="配件关联树">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/partInfoTreeAction" searchButton="normal">
			<oz:tbSeperator/>
			<oz:tbButton id="btnBack"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnAddEquipment"  icon="oz-icon oz-icon-0322" text="加入设备" onclick="onAddEPClick('0')"/>
			<oz:tbButton id="btnAddPart" icon="oz-icon oz-icon-1207" text="加入配件" onclick="onAddEPClick('1')"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnDelete"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnRefresh"/>
			<oz:tbSeperator/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<div id="page-center-tree" class="oz-page-center-tree">
			<ul id="naviTree">
			</ul>
		</div>
		<div id="page-center-seperator" class="oz-page-center-seperator"></div>
		<div id="page-center-grid" class="oz-page-center-grid">
			<oz:grid action="ems/partInfoTreeAction" sortName="qty" sortOrder="asc" fit="true" >
				<oz:column field="id" checkbox="true" title=""/>
				<oz:column field="type" title="类型" sortable="true" width="60" formatter="render4Type"/>
				<oz:column field="name" title="名称" sortable="true" width="360" formatter="oz_DefaultFormatter"/>
				<oz:column field="qty" title="数量" sortable="true" width="60" formatter="oz_DefaultFormatter"/>
				<oz:column field="section" title="分段" sortable="true" width="60" formatter="oz_DefaultFormatter"/>
				<oz:column field="usePeriod" title="使用周期" sortable="true" width="60" formatter="oz_DefaultFormatter"/>
				<oz:column field="replaceDateTime" title="上次更换日期" sortable="true" width="80"/>
				<oz:column field="nextReDateTime" title="下次更换日期" sortable="true" width="80"/>
				<oz:column field="isExclusive" title="是否专属" sortable="true" width="120" formatter="render4Exclusive"/>
			</oz:grid>
		</div>
	</div>
</body>
<oz:js />
<script type="text/javascript">
var _parentId = '<%= request.getAttribute("parentId") %>';
oz_grid_config.url = "<oz:contextPath/>/ems/partInfoTreeAction.do?action=page";
oz_grid_config.params = [{parentId:_parentId}];

</script>
<oz:js />
<script type="text/javascript">
$(function(){
	doPartOrEquipment(-1);
})
function onAddEPClick(type){
	var url = contextPath + "/ems/partInfoTreeAction.do?action=create";
	if (_parentId == null){
		oz.Msg.info("请选择上级设备或备件！");
		return false;
	}
	url += "&parentId=" + _parentId;
	url += "&timeStamp=" + new Date().getTime();
	url += "&type="+type;
	var url = url|| OZ.addParamToUrl(action, "action=create");
	new OZ.Dlg.create({
		id:oz_grid_config.id + "_create" + (new Date().getTime()),
		width:400, height:300,
		title:"新建" + ($("body").data("name") || "文档"),
		url: url,
		buttons:[{text:'关闭', handler:$.noop}]
	});
}
function render4Type(value, json){
	if(value == 0)
		return '设备';
	else
		return '配件';
}
function render4Exclusive(value, json){
	if(value == "0")
		return '否';
	else
		return '是';
}

function oz_Default_Open_Row(rowIndex,rowData,data){
	 new OZ.Dlg.create({
	        id:oz_grid_config.id+rowData.id,
	        width:400, height:300,
	        title:"编辑",
	        url: OZ.addParamToUrl(contextPath + "/ems/partInfoTreeAction.do?action=edit&id=" + rowData.id),
	        buttons:[{text:'关闭', handler:$.noop}]
	    });
}

function doPartOrEquipment(type){
	if (type==0){
		$("#btnAddEquipment").hide();
		$("#btnAddPart").show();
	}
	if (type==1){
		$("#btnAddEquipment").hide();
		$("#btnAddPart").show();
	}
	if (type==-1){
		$("#btnAddEquipment").show();
		$("#btnAddPart").hide();
	}
}
$(function(){
	$('#naviTree').tree({
		children:[{text:"配件关联树",id:"-1",type:-1,children:true}],
		url: contextPath + '/ems/partInfoTreeAction.do?action=getParentTree&parentId=' + _parentId + '&timeStamp=' + new Date().getTime(),
		click:function(e, data){
			doPartOrEquipment(data.type);
			_parentId = data.id;
			OZ.View.reloadGrid({parentId:_parentId, dbftsParams:""});
		},
		onLoadSuccess:function(node, data){
			if(_parentId != -1){
				doPartOrEquipment(1);
			}else{
				doPartOrEquipment(-1);
			}
            OZ.View.reloadGrid({parentId:_parentId, dbftsParams:""})
		}
	});
});

</script>
</html>