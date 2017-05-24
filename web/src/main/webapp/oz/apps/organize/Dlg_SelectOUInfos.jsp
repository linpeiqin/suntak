<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="dialog" tree="true" messager="true" select="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.organize.ouinfo"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" style="background-color: #F4FEFF;height:100%;width:100%;overflow:hidden;border:none;margin: 0px;padding: 0px;">
	<table width="500"  style="background-color:#FFFFFF;margin: 5px  auto;">
		<tr>
			<td width="215px" valign="top">
				<div style="width:100%;height:260px;overflow:auto;border:1px solid #7F9DB9">
					<ul id="ouTree"></ul>
				</div>
			</td>
			<td width="70px" style="text-align: center;vertical-align: middle;">
				<input id="btnAdd" type="button" class="oz-form-button" value=" <oz:messageSource code="oz.add"/> > " onclick="appendSelected()"/><br /><br /><br />
				<input id="btnDelete" type="button" class="oz-form-button" value=" < <oz:messageSource code="oz.delete"/> " onclick="removeSelected(false)"/><br /><br /><br />
				<input id="btnClear" type="button" class="oz-form-button" value=" << <oz:messageSource code="oz.clearall"/> " onclick="removeSelected(true)"/>
			</td>
			<td width="215px" valign="top">
				<oz:select value="ouInfos" property="ouInfos" options="ouInfoOptions" multiple="true" style="width:100%;height:263px;overflow:auto;"></oz:select>
			</td>
		</tr>
	</table>
</body>
<oz:js/>
<script type="text/javascript">
var _ouId = "<%= request.getAttribute("ouId") %>";
var _ouType = "<%= request.getAttribute("ouType") %>";
var nodes = <%= request.getAttribute("nodes") %>;
nodes = nodes||[];

$(function(){
	var strUrl = contextPath + '/organize/ouTreeAction.do?action=getTree&timeStamp=' + new Date().getTime()
	strUrl += "&ouId=" + _ouId + "&ouType=" + _ouType;
	$('#ouTree').tree({url:strUrl});
});

function appendSelected(){
	var node = $('#ouTree').tree('getSelected');
	if(null == node){
		OZ.Msg.alert('<oz:messageSource code="oz.mdu.organize.ouinfo.msg.select.isnone"/>');
        return null;
    }
	
	// 判断选择的信息是否符合
	if(null != _ouType && _ouType.length > 0){
		if(node.type != _ouType){
			if(_ouType == "DW" || _ouType == "dw")
				OZ.Msg.alert('<oz:messageSource code="oz.mdu.organize.ouinfo.msg.select.not.unit"/>');
			else
				OZ.Msg.alert('<oz:messageSource code="oz.mdu.organize.ouinfo.msg.select.not.department"/>');
			return null;
		}
	}else{
		if(node.type != "DW" && node.type != "dw" && node.type != "BM" && node.type != "bm"){
			OZ.Msg.alert('<oz:messageSource code="oz.mdu.organize.ouinfo.msg.select.not.ouinfo"/>');
			return null;
		}
	}

	var ouId = node.id;
	var destObj = document.getElementById("ouInfos");
	if(null == destObj)
		return;

	// 判断是否已经存在
	var isExist = false;
	for(var i = 0; i < destObj.length; i++){
		if(destObj.options[i].value == ouId){
			isExist = true;
			break;
		}
	}
	if(!isExist){
		var len = destObj.length;
		destObj.options[len] = new Option(node.shortFullName, ouId);

		// 添加到数组中
		nodes.push(node);
	}
}

function removeSelected(isAll){
	var selectObj = document.getElementById("ouInfos");
	if (selectObj==null) 
		return;

	if(isAll){
		selectObj.length = 0;
		nodes = [];
	}else{		
		var selectedCount = 0;
		var len = selectObj.length;
		for(var i = len-1; i >= 0; i--){
			if(selectObj.options[i].selected){
				selectedCount++;
				var ouId = selectObj.options[i].value;
				selectObj.options[i] = null;

				// 从数组中移除
				for(var j = 0; j < nodes.length; j++){
					if(nodes[j].id == ouId){
						nodes.splice(j--,1);
						break;
					}
				}
			}
		}
		
		if(selectedCount == 0)
			OZ.Msg.alert('<oz:messageSource code="oz.mdu.organize.ouinfo.msg.select.isnone"/>');
	}
}		

function ozDlgOkFn(){
	if(null == nodes || nodes.length == 0){
		OZ.Msg.alert('<oz:messageSource code="oz.mdu.organize.ouinfo.msg.select.isnone"/>');
		return false;
	}
	return nodes;
}
</script>
</html>