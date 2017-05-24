<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<%@ page import="java.util.*,org.springframework.web.bind.ServletRequestUtils" %>
<%
	String widgetId = ServletRequestUtils.getStringParameter(request, "widgetId", "widget"  +  String.valueOf(new Date().getTime()));
%>
<c:if test="${!empty items}" >
	<div class="widget-app-list">
		<div class="app-list-container">
			<c:forEach var="item" items="${items}">
				<div class="app-list-item" style="height:24px;padding-bottom:2px;">
					<div class="avatar" style="height:21px"></div>
					<div class="title" style="margin-left:9px;overflow:hidden;display:block;white-space:nowrap;text-overflow: ellipsis;">
						<a href="<oz:contextPath/>/module/bulletinAction.do?action=open&id=${item.id}"  target="_page" title="${item.subject}">
						   [${item.releaseDateTime}]&nbsp;${item.subject}
						</a>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</c:if>
<c:if test="${empty items}" >
	<div style="font-weight:bold;text-align:center;padding: 3px;">	
		暂无公告
	</div>
</c:if>
<script type="text/javascript">
(function(){
	var root = this, widgetId = "<%=widgetId%>";
	var moduleObject = {
		widgetId : widgetId,
		onload : function() {
		}
	};
	root[widgetId] = moduleObject;
})();
</script>