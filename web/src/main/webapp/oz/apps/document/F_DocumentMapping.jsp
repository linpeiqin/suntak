<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" tabs="true" select="true"/>
<head>
	<title>文种映射配置</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css />
</head>
<body class="oz-body" name="文种映射配置">
<div id="page" class="oz-page">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="document/documentMappingAction" defaultTB="readForm">
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="document/documentMappingAction.do" styleId="ozForm" styleClass="oz-form">
			<!-- 标题  -->
			<div class="oz-form-title">文种映射配置</div>
			<!-- 表单域  -->
			<div class="oz-form-fields">
				<table cellpadding="0" cellspacing="4">
					<tr class="oz-form-emptyTR"> 
						<td width="80"></td>
						<td width="300"></td>
						<td width="80"></td>
						<td width="300"></td>
					</tr>
					<tr>
						<td class="oz-form-label">映射名称：</td>
						<td class="oz-property" colspan="3">
							<html:text property="name" styleId="name" styleClass="oz-form-zdField" readonly=""/>
						</td>
					</tr>
					<tr>
						<td class="oz-form-topLabel">源文种：</td>
						<td class="oz-property" colspan="3">
							<html:text property="source.name" styleId="sourceName" styleClass="oz-form-zdField" readonly="true"/>
						</td>
					</tr>
					<tr>
						<td class="oz-form-topLabel">目标文种：</td>
						<td class="oz-property" colspan="3">
							<html:text property="target.name" styleId="targetName" styleClass="oz-form-zdField" readonly="true"/>
						</td>
					</tr>
					<tr>
						<td class="oz-form-topLabel">映射设置：</td>
						<td colspan="3">
							<div style="overflow: hidden;border: 1px solid #76ABD3">
								<table height="100%" cellpadding="0" cellspacing="0" style="width:100%;border-width: 0px;padding: 0px;margin: 0px;">
									<tr>
										<td>
											<html:select property="mapping" style="width:100%;height:100%;margin: 0;padding: 0;" size="20" styleId="mappings">
												<html:optionsCollection name="mappings" label="name" value="value"/>
											</html:select>
										</td>
									</tr>
								</table>
							</div>
						</td>
					</tr>
				</table>			
			</div>
			<html:hidden property="target.id" styleId="targetId"/>
			<html:hidden property="source.id" styleId="sourceId"/>
			<html:hidden property="id" styleId="id"/>
			<html:hidden property="uuid" styleId="uuid"/>
			<html:hidden property="author.id" styleId="author.id"/>
			<html:hidden property="author.name" styleId="author.name"/>
		</html:form>
	</div>
</div>
</body>
<oz:js/>
<script type="text/javascript">
function onBtnSave_Clicked(callback, bShowMsg){
	if(null == bShowMsg)
		_bShowMsg = true;
	else
		_bShowMsg = bShowMsg;

	var id = $("#id").val();
	if(id == -1){
		if(!OZ.Form.validate()) 
			return false;
		
		// 提交表单
		var saveUrl = contextPath + "/documentMappingAction.do?action=save&timeStamp=" + new Date().getTime();
		document.forms[0].action = saveUrl;
		document.forms[0].target = "_self";
		document.forms[0].submit();
	}else{
		OZ.Form.save({
			url:contextPath + "/documentMappingAction.do?action=saveByAjax",
			callback:function(){
				onAfterSave();
				if((typeof callback) == "function"){
					callback.call(this);
				}
				return _bShowMsg;
			}
		});
	}
}
function selectDD(target){
	var dlgUrl = contextPath + "/documentMappingAction.do?action=dlgSelectDefinition&timeStamp=" + new Date().getTime();
	new OZ.Dlg.create({ id:"d1", width:360, height:244,
		  title:"选择流程",
		  url: dlgUrl,
		  onOk:function(value){
			 loadDatas(value.id,target)
			 $("#"+target+"Id").val(value.id);
			 $("#"+target+"Name").val(value.name);
		  }
    });
}

function loadDatas(id,target){
	var strUrl = contextPath + "/documentMappingAction.do?action=loadDatas&timeStamp=" + new Date().getTime();
	OZ.SELECT.removeAll(target+"Fields");
	$.getJSON(strUrl,{id:id},function(json){
		var dstatus = document.getElementById(target+"Fields");
		$.each(json,function(index,d){
			dstatus.options[index] = new Option(d.name,d.key);
		})
	});
}
function doMapping(){
	$("#sourceFields").val();
	$("#targetFields").val();
	var text = $("#sourceFields").val()+"<===>" +$("#targetFields").val();
	var value = $("#sourceFields").val()+"||" +$("#targetFields").val();
	var s = $("#mappings")[0];
	var opts = s.options
	for(var i=0;i<opts.length;i++){
		if(opts[i].value == value){
			return;
		}
	}
	s.options[s.length] = new Option(text,value);
}
$(function(){
	
})
</script>
</html>