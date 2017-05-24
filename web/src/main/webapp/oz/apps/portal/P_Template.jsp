<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<%@ page import="java.util.*,org.springframework.web.bind.ServletRequestUtils" %>
<%
	int width = ServletRequestUtils.getIntParameter(request, "width", 0);
	boolean simple = width < 500 || ServletRequestUtils.getBooleanParameter(request, "simple", false);
	boolean isDesgin = ServletRequestUtils.getBooleanParameter(request, "isDesgin", false);
	String moduleId = ServletRequestUtils.getStringParameter(request, "moduleId", "module"  +  String.valueOf(new Date().getTime()));
%>
<logic:present name="items">
<style>
<!--
/*[]重写使用在改模块的样式*/
.<%=moduleId%>Class .oz-portlet-titleBar {
	background-image: url('<oz:contextPath/>/oa/portlet/images/oa_portlet_title_bg_3.png');
	background-repeat: repeat-x;
	height: 33px;
}
.<%=moduleId%>Class .oz-portlet-title {
	line-height: 33px;
	color: #006BB4;
	font-size: 14px;
}
.<%=moduleId%>Class .title{
	background-image: url('<oz:contextPath/>/oa/portlet/images/oa_portlet_title_bg_4.png');
	background-repeat: no-repeat;
	background-position:right;
	padding-right:10px;
	display: inline-block;
}
.oz-portlet-grid .isNewArrive{
	font-weight: bold;
}
-->
</style>
<% if(simple){ %>
<!-- 窄版 -->
<table class="oz-portlet-grid" cellpadding="0" cellspacing="0">
	<tr class="oz-grid-head">
		<td width="18px"></td>
		<td>标题</td>
	</tr>
<logic:iterate id="item" name="items" indexId="index">
	<tr class="<%=(index % 2 == 0)? "oz-grid-content":"oz-grid-content-even"%>">		
		<td>	<div class="oz-icon oz-icon-1340"></div></td>
		<td>
			<a href="javascript:void(0);" data-href="<oz:contextPath/>/work/demoAction.do?action=open&id=<bean:write name="item" property="id" format="#"/>"  
				class="opentab"  title="<bean:write name="item" property="subject"/>"><bean:write name="item" property="subject"/></a>
		</td>
	</tr>	
</logic:iterate>
</table>
<% } else {%>
<!-- 宽版 -->
<table class="oz-portlet-grid" cellpadding="0" cellspacing="0">
	<tr class="oz-grid-head">
		<td width="18px"></td>
		<td width="110px">分类</td>
		<td>标题</td>
		<td width="100px">发送人</td>
		<td width="110px">日期</td>			
	</tr>
<logic:iterate id="item" name="items" indexId="index">
	<tr class="<%=(index % 2 == 0)? "oz-grid-content":"oz-grid-content-even"%> ">				
		<td>	<div class="oz-icon oz-icon-1340"></div></td>
		<td>	<bean:write name="item" property="workEntity.classified"/></td>
		<td>
			<a href="javascript:void(0);" data-href="<oz:contextPath/>/work/demoAction.do?action=open&id=<bean:write name="item" property="id" format="#"/>"  
				class="opentab"  title="<bean:write name="item" property="subject"/>"><bean:write name="item" property="subject"/></a>
		</td>
		<td>	<bean:write name="item" property="firstSender.name"/>	</td>
		<td><bean:write name="item" property="firstArrivedDate" format="yyyy-MM-dd HH:mm"/></td>
	</tr>	
</logic:iterate>
</table>
<%} %>
</logic:present>
<logic:notPresent name="items">
<div style="font-weight:bold;text-align:center;padding: 3px;">	
		<oz:messageSource code="oz.data.isempty"/>
</div>
</logic:notPresent>
<script type="text/javascript">
(function(){
	var root = this,moduleId = "<%=moduleId%>";
	//条目信息
	var count = '<%=request.getAttribute("count")%>'; 
	var totalCount = '<%=request.getAttribute("totalCount")%>';
	var countInfo = "("+(count != "0" ? ("1-" + count + "/" + totalCount + "") : "0")+")";
	
	var moduleObject = {
			moduleId : moduleId,
			//如果更多定义的不是url，则会将url作为arg传入该方法
			more : function(title, arg) {
				var url = contextPath + "/work/demoAction.do?action=display&viewType=todo";
				if (arg) {
					url += "&arg=" + arg;
				}
				title = title || '缺省标题';
				OZ.Portlet.openTab(moduleId, "viewToDoWork_"+ arg, title , url);
			},
			//[]第一次加载触发的动作
			initialize: function(){
				
			},
			//[]每次加载触发的动作
			onload : function() {
				//更新副标题
				OZ.Portlet.setSubtitle(moduleId, countInfo);
			}
		};
	root[moduleId] = moduleObject;
})();
</script>