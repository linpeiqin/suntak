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
<% } else {%>
<%} %>
<ul style="margin:4px;list-style:none;">
	<logic:iterate id="item" name="items">
		<li style="margin:4px 0 2px 0;border-bottom:1px solid #ccc;line-height: 25px;">
			<span style="float: left;"> <b>·</b>&nbsp;</span>
			<bean:write name="item" property="releaseDate" format="yyyy-MM-dd"/>&nbsp;
			<a href="javascript:void(0);" data-href="<oz:contextPath/>/module/bulletinAction.do?action=open&id=<bean:write name="item" property="id" format="#"/>"  
			class="opentab"  title="<bean:write name="item" property="subject"/>"><bean:write name="item" property="subject"/></a>
		</li>
	</logic:iterate>
</ul>
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
			more : function (){
				OZ.openWindow({
					id:"viewBulletin",
					title:'<oz:messageSource code="oz.mdu.bulletin"/>',
					url:contextPath+"/module/bulletinAction.do?action=display",
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