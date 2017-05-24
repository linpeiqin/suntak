<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true" attachment="true"/>
<head>
<title>配件附件</title>
<%@ include file="/oz/includes/meta.jsp"%>
<oz:css />
</head>
<body class="oz-body">
<html:form action="ems/partInfoAction" styleId="ozForm" styleClass="oz-form">
<oz:attachment id="ATTACHMENT" style="border:1px solid #ccc;margin:0;height:100%;width:100%;" group="partInfo" theme="simple" />
<html:hidden property="id" styleId="id" />
</html:form>
</body>
<oz:js />
</html>