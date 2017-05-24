<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"  datePicker="true"  />
<head>
	<title>文件编号管理</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<style type="text/css">
		.numText1,.numText2 ,.numText3 {
			width: 50px
		}
		.numTotalText1,.numTotalText2,.numTotalText3 {
			width: 50px
		}
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
			<oz:tbButton id="btnSave"></oz:tbButton>
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
								<html:text property="numberOrder"  styleClass="oz-form-field numValidate"  style="width:205px;float:left" />
							</td>
						</tr>
						<tr>
							<td class="oz-form-label">编号名称：</td>
							<td >
								<html:text property="numberName"  styleId="numberName" styleClass="oz-form-btField"  style="width:205px;float:left"/>
							</td>
						</tr>
						<tr>
							<td class="oz-form-label">编号代码：</td>
							<td >
								<html:text property="numberCode"  styleId="numberCode" styleClass="oz-form-btField"  style="width:205px;float:left"/>
							</td>
						</tr>
						<tr>
							<td class="oz-form-label">断号方式：</td>
							<td >
								
								<html:select property="numberRule" styleId="numberRule" styleClass="oz-form-btField" style="width:205px;float:left">
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
								<html:text property="numberPrefix"  styleId="numberPrefix" styleClass="oz-form-field"  style="width:205px;float:left"/>
							</td>
						</tr>
						<tr>
							<td class="oz-form-label">编号后缀：</td>
							<td >
								<html:text property="numberPostfix"  styleId="numberPostfix" styleClass="oz-form-field"  style="width:205px;float:left"/>
							</td>
						</tr>
						<tr>
							<td class="oz-form-label">当前序号：</td>
							<td >
								<html:text property="serial"  styleId="serial" styleClass="oz-form-btField"  style="width:205px;float:left"/>
							</td>
						</tr>
						<tr>
							<td class="oz-form-label">序号长度：</td>
							<td >
								<html:text property="numberLength"  styleId="numberLength" styleClass="oz-form-btField"  style="width:205px;float:left"/>
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

					<html:hidden property="author.name"   styleId="author.name"/>
					<html:hidden property="author.id" styleId="author.id"/>
					<html:hidden property="author.ouId" styleId="author.ouId"/>
					<html:hidden property="author.ouName" styleId="author.ouName"/>
	
					<html:hidden property="unitId" styleId="unitId"/>
				
					

			</html:form>
	</div>
</body>
<oz:js/>
<script type="text/javascript">


/*
function onBtnSave_Clicked(){	
	var id = $("#id").val();
	if(id == -1){
		ozTB_DefaultBtnSave_Clicked(contextPath + "/standard/fileNumberAction.do");
	}else{
		ozTB_DefaultBtnSaveByAjax_Clicked(contextPath + "/standard/fileNumberAction.do");
	}
}
*/


</script>
</html>