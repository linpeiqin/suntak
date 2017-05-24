<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<%@ page import="java.util.*,org.springframework.web.bind.ServletRequestUtils" %>
<%
	int width = ServletRequestUtils.getIntParameter(request, "width", 0);
	boolean simple = width < 500 || ServletRequestUtils.getBooleanParameter(request, "simple", false);
	String moduleId = ServletRequestUtils.getStringParameter(request, "moduleId", "module"  +  String.valueOf(new Date().getTime()));
%>
<logic:present name="items">
<% if(simple){ %>
<ul class="oz-portlet-list">
	<logic:iterate id="item" name="items">
		<li>
			<span style="float: left;"> <b>·</b>&nbsp;</span>
			<a href="javascript:void(0);" data-href="<oz:contextPath/>/module/systemMessageAction.do?action=open&id=<bean:write name="item" property="id" format="#"/>"  
			class="opentab"  title="<bean:write name="item" property="subject"/>"><bean:write name="item" property="subject"/></a>
		</li>
	</logic:iterate>
</ul>
<% } else {%>
<ul class="oz-portlet-list">
	<logic:iterate id="item" name="items">
		<li>
			<span style="float: left;"> <b>·</b>&nbsp;</span>
			<bean:write name="item" property="createdDate" format="yyyy-MM-dd"/>&nbsp;
			<a href="javascript:void(0);" data-href="<oz:contextPath/>/module/systemMessageAction.do?action=open&id=<bean:write name="item" property="id" format="#"/>"  
			class="opentab"  title="<bean:write name="item" property="subject"/>"><bean:write name="item" property="subject"/></a>
		</li>
	</logic:iterate>
</ul>
<%} %>
</logic:present>

<logic:notPresent name="items">
<div style="font-weight:bold;text-align:center;padding: 3px;">	
		<oz:messageSource code="oz.mdu.systemmessage.no.message"/>
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
			more : function (title){
				OZ.openWindow({
					id:"viewSystemMessage",
					title: title ||'<oz:messageSource code="oz.mdu.systemmessage"/>',
					url:contextPath+"/module/systemMessageAction.do?action=display",
					refresh:true,
					moduleId:moduleId
				});
			},
			onload : function(){
				OZ.Portlet.setSubtitle(moduleId,countInfo);
			}
	};
	
	root[moduleId] = moduleObject;

})();
</script>