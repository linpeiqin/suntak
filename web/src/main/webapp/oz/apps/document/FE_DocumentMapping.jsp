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
<body class="oz-body" data-name="文种映射配置">
<div id="page" class="oz-page">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="document/documentMappingAction">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack" text="返回"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnSave" text="保存"></oz:tbButton>
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
							<html:text property="name" styleId="name" styleClass="oz-form-btField"/>
						</td>
					</tr>
					<tr>
						<td class="oz-form-topLabel">源文种：</td>
						<td class="oz-property" >
							<html:text property="source.name" styleId="sourceName" styleClass="oz-form-zdField" readonly="true"/>
						</td>
						<td class="oz-form-topLabel">目标文种：</td>
						<td class="oz-property" >
							<html:text property="target.name" styleId="targetName" styleClass="oz-form-zdField" readonly="true"/>
						</td>
					</tr>
					<tr>
						<td class="oz-form-topLabel">映射设置：</td>
						<td colspan="3">
							<div style="overflow: hidden;border: 1px solid #76ABD3">
							<table height="100%" cellpadding="0" cellspacing="0" style="width:100%;border-width: 0px;padding: 0px;margin: 0px;">
								<tr>
									<td width="150" height="23px" style='line-height:23px;border-bottom:1px solid #76ABD3;background-color:#E8F3F9;'>
										<span style='font-weight: bold;margin-left:3px;'>&nbsp;源字段</span>
									</td>
									<td width="150" height="23px" style='line-height:23px;border-bottom:1px solid #76ABD3;border-left:1px solid #76ABD3;background-color:#E8F3F9;'>
											<span style='font-weight: bold;margin-left:3px;'>&nbsp;目标字段</span>
									</td>
									<td width="80" height="23px" style='line-height:23px;border-bottom:1px solid #76ABD3;border-left:1px solid #76ABD3;background-color:#E8F3F9;'>
											<span style='font-weight: bold;margin-left:3px;'>&nbsp;操作</span>
									</td>
									<td style='line-height:23px;border-bottom:1px solid #76ABD3;border-left:1px solid #76ABD3;background-color:#E8F3F9;'>
										<span style='font-weight: bold;margin-right:80px;'>&nbsp;对应关系</span>
										<input id="btnDelete" type="button" class="oz-form-button" value="删除" onclick="doDelete()" />
										<input id="btnDelete" type="button" class="oz-form-button" value="清空" onclick="doClean()" />
									</td>
								</tr>
								<tr>
									<td height="30">
										<html:select property="sourceFields" styleId="sourceFields" style="width:100%;height:100%;margin: 0;padding: 0;">
											<logic:present  name="sourceFields" >
											<html:optionsCollection name="sourceFields" label="name" value="value"/>
											</logic:present>
										</html:select>
									</td>
									<td style="border-right:1px solid #76ABD3;">
										<html:select property="targetFields" style="width:100%;height:100%;margin: 0;padding: 0;" styleId="targetFields">
											<logic:present  name="targetFields" >
												<html:optionsCollection name="targetFields" label="name" value="value"/>
											</logic:present>
										</html:select>
									</td>
									<td style="text-align: center;vertical-align: middle;">
										<input type="button" class="oz-form-button" value="添 加 >" onclick="doMapping()" />
									</td>
									<td rowspan="5" style="border-left:1px solid #76ABD3;">
										<html:select property="mapping" style="width:100%;height:100%;margin: 0;padding: 0;" styleId="mappings" multiple="multiple">
											<logic:present  name="mappings" >
											<html:optionsCollection name="mappings" label="name" value="value"/>
											</logic:present>
										</html:select>
									</td>
								</tr>
								<tr>
									<td width="150" height="23px" style='line-height:23px;border-bottom:1px solid #76ABD3;border-top:1px solid #76ABD3;background-color:#E8F3F9;'>
										<span style='font-weight: bold;margin-left:3px;'>&nbsp;源控件</span>
									</td>
									<td width="150" height="23px" style='line-height:23px;border:1px solid #76ABD3;background-color:#E8F3F9;'>
											<span style='font-weight: bold;margin-left:3px;'>&nbsp;目标控件</span>
									</td>
									<td style="text-align: center;border-bottom:1px solid #76ABD3;border-top:1px solid #76ABD3;background-color:#E8F3F9;">&nbsp;
									</td>
								</tr>
								<tr>
									<td height="30">
										<html:select property="sourceElements" styleId="sourceElements" style="width:100%;height:100%;margin: 0;padding: 0;" >
											<logic:present  name="sourceElements" >
											<html:optionsCollection name="sourceElements" label="name" value="value"/>
											</logic:present>
										</html:select>
									</td>
									<td style="border-right:1px solid #76ABD3;">
										<html:select property="targetElements" style="width:100%;height:100%;margin: 0;padding: 0;" styleId="targetElements">
											<logic:present  name="targetElements" >
												<html:optionsCollection name="targetElements" label="name" value="value"/>
											</logic:present>
										</html:select>
									</td>
									<td style="text-align: center;vertical-align: middle;">
										转换器:	<br>	
										<html:select property="converter" style="width:100%;" styleId="converter">
											<logic:present  name="converters" >
												<html:optionsCollection name="converters" label="name" value="value"/>
											</logic:present>
										</html:select>
										<br>	
										<input type="button" class="oz-form-button" value="添 加 >" onclick="doMappingElement()" />
									</td>
								</tr>
								<tr>
									<td width="150" height="23px" style='line-height:23px;border-bottom:1px solid #76ABD3;border-top:1px solid #76ABD3;background-color:#E8F3F9;'>
										<span style='font-weight: bold;margin-left:3px;'>&nbsp;源文件</span>
									</td>
									<td width="150" height="23px" style='line-height:23px;border:1px solid #76ABD3;background-color:#E8F3F9;'>
											<span style='font-weight: bold;margin-left:3px;'>&nbsp;目标文件</span>
									</td>
									<td style="text-align: center;border-bottom:1px solid #76ABD3;border-top:1px solid #76ABD3;background-color:#E8F3F9;">&nbsp;
									</td>
								</tr>
								<tr>
									<td height="30">
										<html:select property="sourceFiles" styleId="sourceFiles" style="width:100%;height:100%;margin: 0;padding: 0;">
											<logic:present  name="sourceFiles" >
											<html:optionsCollection name="sourceFiles" label="name" value="value"/>
											</logic:present>
										</html:select>
									</td>
									<td style="border-right:1px solid #76ABD3;">
										<html:select property="targetFiles" style="width:100%;height:100%;margin: 0;padding: 0;"  styleId="targetFiles">
											<logic:present  name="targetFiles" >
												<html:optionsCollection name="targetFiles" label="name" value="value"/>
											</logic:present>
										</html:select>
									</td>
									<td style="text-align: center;vertical-align: middle;">
										<input type="button" class="oz-form-button" value="添 加 >" onclick="doMappingFile()" />
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
function onBtnSave_Clicked(action){
	// 选中列表框的所有值
	OZ.SELECT.selectAll(["mappings"]);
	
	ozTB_DefaultBtnSaveByAjax_Clicked(action);
}
function doMapping(){
	if($("#sourceFields").val() && $("#targetFields").val()){
		var text = $("#sourceFields").find("option:selected").text()+" ===>> " +$("#targetFields").find("option:selected").text();
		var value = $("#sourceFields").val()+"||" +$("#targetFields").val()+"||field";
		var s = $("#mappings")[0];
		var opts = s.options
		for(var i=0;i<opts.length;i++){
			if(opts[i].value == value){
				return;
			}
		}
		s.options[s.length] = new Option(text,value);
	}
}
function doMappingElement(){
	if($("#sourceElements").val() && $("#targetElements").val()){
		var text = "[element]"+$("#sourceElements").find("option:selected").text()+" ===>> " +$("#targetElements").find("option:selected").text();
		var value = $("#sourceElements").val()+"||" +$("#targetElements").val()+"||element||"+$("#converter").val();
		var s = $("#mappings")[0];
		var opts = s.options
		for(var i=0;i<opts.length;i++){
			if(opts[i].value == value){
				return;
			}
		}
		s.options[s.length] = new Option(text,value);
	}
}
function doMappingFile(){
	if($("#sourceFiles").val() && $("#targetFiles").val()){
		var text = "[file]"+$("#sourceFiles").find("option:selected").text()+" ===>> " +$("#targetFiles").find("option:selected").text();
		var value = $("#sourceFiles").val()+"||" +$("#targetFiles").val()+"||file";
		var s = $("#mappings")[0];
		var opts = s.options
		for(var i=0;i<opts.length;i++){
			if(opts[i].value == value){
				return;
			}
		}
		s.options[s.length] = new Option(text,value);
	}
}
function doDelete(){
	var s = $("#mappings")[0];
	var opts = s.options
	for(var i=opts.length-1;i>=0;i--){
		if(opts[i].selected){
			opts[i]=null;
		}
	}
}
function doClean(){
	var s = $("#mappings")[0];
	s.options.length = 0;
}
$(function(){
	
})
</script>
</html>