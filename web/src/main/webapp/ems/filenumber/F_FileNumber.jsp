<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="java.util.Calendar"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"  datePicker="true"   />
<head>
	<title>文件编号管理</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<style type="text/css">
		.titleBar {
			padding: 4px 0px 4px 12px;
			font-weight:bold;
		}
		.titleBar b{
			cursor:hand;
			float:left;
			width:16px;
		}
		.titleBar b{
			background:url('<oz:contextPath/>/oa/taskSupervision/css/Expand.png');
		}
		.titleBar.collapse b{
			background:url('<oz:contextPath/>/oa/taskSupervision/css/Collapse.png');
		}
	</style> 
</head>
<body class="oz-body">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/fileNumberAction">
			<oz:tbButton id="btnBack"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnEdit"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnDelete"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
			<html:form action="ems/fileNumberAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title" >文件编号管理</div>
				<div class="oz-form-fields">
					<table cellpadding="0" cellspacing="0">
						<tr class="oz-form-emptyTR"> 
							<td width="20%"></td>
							<td width="80%"></td>
						</tr>
					
						<tr>
							<td class="oz-form-label">排序号：</td>
							<td >
								<span class="oz-form-fields-span"><bean:write name="fileNumberForm" property="numberOrder" format="#"/></span>
							</td>
						</tr>
						<tr>
							<td class="oz-form-label">编号名称：</td>
							<td >
								<span class="oz-form-fields-span"><bean:write name="fileNumberForm" property="numberName" format="#"/></span>
							</td>
						</tr>
						<tr>
							<td class="oz-form-label">编号代码：</td>
							<td >
								<span class="oz-form-fields-span"><bean:write name="fileNumberForm" property="numberCode" format="#"/></span>
							</td>
						</tr>
						<tr>
							<td class="oz-form-label">断号方式：</td>
							<td >
								<html:select property="numberRule" styleId="numberRule" styleClass="oz-form-zdField" style="width:205px;float:left" disabled="true">
									<html:option value="0">按年编号</html:option> 
									<html:option value="1">按月编号</html:option>
									<html:option value="2">按天编号</html:option>
									<html:option value="1">按月编号</html:option>									
								</html:select>
							</td>
						</tr>
						<tr>
							<td class="oz-form-label">编号前缀：</td>
							<td >
								<span class="oz-form-fields-span"><bean:write name="fileNumberForm" property="numberPrefix" format="#"/></span>
							</td>
						</tr>
						<tr>
							<td class="oz-form-label">编号后缀：</td>
							<td >
								<span class="oz-form-fields-span"><bean:write name="fileNumberForm" property="numberPostfix" format="#"/></span>
							</td>
						</tr>
						<tr>
							<td class="oz-form-label">当前序号：</td>
							<td >
								<span class="oz-form-fields-span"><bean:write name="fileNumberForm" property="serial" format="#"/></span>
							</td>
						</tr>
						<tr>
							<td class="oz-form-label">序号长度：</td>
							<td >
								<span class="oz-form-fields-span"><bean:write name="fileNumberForm" property="numberLength" format="#"/></span>
							</td>
						</tr>
						
					</table>
					<span class="oz-form-fields-span">说明：</span>
					<P>1、编号 = 编号前缀 + 当前序号（不够长度的前面补0） + 编号后缀 ；</P>
					<P>2、编号前缀、编号后缀可以使用{OUName}表示部门名称，{OUCode}表示部门代码；</P>
                    <P>3、编号前缀、编号后缀可以使用{UnitName}表示单位名称，{UnitCode}表示单位代码；</P>
					<P>4、编号前缀、编号后缀中如果需要取时间，可以用{yyyy-MM-dd}表示，其中{}中的格式请具体参见SimpleDateFormat类的格式定义；</P>
					<P>5、编号前缀、编号后缀中如果要输出{或}，请使用\{或\}。</P>
				</div>
					<html:hidden property="id" styleId="id" />
					<html:hidden property="uuid" styleId="uuid" />


			</html:form>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function onBtnDelete_Clicked(){
	OZ.Msg.confirm(
		'确认要删除吗?',
		function(){
			$.getJSON(
				contextPath + "/ems/fileNumberAction.do?action=delete&timeStamp=" + new Date().getTime(),
				{id:$("#id").val()},
				function(json){
					if(json.result == true){
						OZ.Msg.info('<oz:messageSource code="oz.core.msg.delete.success"/>', null, function(){
							ozTB_BtnBack_Clicked();
						});
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			);
		}
	);
}

</script>
</html>