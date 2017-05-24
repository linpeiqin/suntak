<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<%@ page import="java.util.*,org.springframework.web.bind.ServletRequestUtils" %>
<%
	String widgetId = ServletRequestUtils.getStringParameter(request, "widgetId", "widget"  +  String.valueOf(new Date().getTime()));
%>
<logic:present name="items">
	<div class="widget-app-list">
		<div class="app-list-container">
			<logic:iterate id="item" name="items" indexId="index">
				<div class="app-list-item" style="height:24px;padding-bottom:2px;">
					<div class="avatar" style="height:21px"></div>
					<div class="title" style="margin-left:9px">
						<span style="display:inline-block;text-overflow:ellipsis; overflow:hidden;white-space: nowrap;float:left">
							&nbsp;
							<a href="<oz:contextPath/>/module/systemMessageAction.do?action=open&id=<bean:write name="item" property="id" format="#"/>" target="_page" title="<bean:write name="item" property="subject"/>">
							 	<bean:write name="item" property="subject"/>
							</a>
						</span>
						<span style="display:inline-block;text-overflow:ellipsis; overflow:hidden;white-space: nowrap;float:right">
							<bean:write name="item" property="authorName"/>&nbsp;<bean:write name="item" property="createdDateTime2Minute"/>
						</span>
					</div>
				</div>
			</logic:iterate>
		</div>
	</div>
</logic:present>
<logic:notPresent name="items">
	<div style="font-weight:bold; text-align:center; padding:3px;">	
		<oz:messageSource code="oz.data.isempty"/>
	</div>
</logic:notPresent>
<script type="text/javascript">
(function(){
	var root = this, widgetId = "<%=widgetId%>";
	var count = '<%=request.getAttribute("count")%>'; 
	var totalCount = '<%=request.getAttribute("totalCount")%>';
	var countInfo = "("+(count != "0" ? ("1-" + count + "/" + totalCount + "") : "0")+")";
	
	var moduleObject = {
		widgetId : widgetId,
		more : function(title, arg) {
			
		},
		
		initialize: function(){
			
		},
		
		onload : function() {
			this.widget.subtitle(countInfo);
		}
	};
	root[widgetId] = moduleObject;
})();
</script>