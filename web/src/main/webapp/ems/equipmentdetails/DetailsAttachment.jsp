<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" attachment="true"/>
<head>
<title>设备附件</title>
<%@ include file="/oz/includes/meta.jsp"%>
<oz:css />
</head>
<body class="oz-body">
<html:form action="ems/equipmentDetailsAction" styleId="ozForm" styleClass="oz-form" >
    <logic:equal value="true" property="edit" name="equipmentDetailsForm">
        <oz:attachment id="attachmentInstructions" style="border:1px solid #ccc;margin:0;height:100%;width:100%;" group="equipmentInstructions" theme="simple2" subject="说明书"/>
        <oz:attachment id="attachmentOther" style="border:1px solid #ccc;margin:0;height:100%;width:100%;" group="equipmentOther" theme="simple2" subject="其他"/>
    </logic:equal>
    <logic:equal value="false" property="edit" name="equipmentDetailsForm">
        <oz:attachment id="attachmentInstructions" style="border:1px solid #ccc;margin:0;height:100%;width:100%;" group="equipmentInstructions"  readOnly="true" theme="simple2" subject="说明书"/>
        <oz:attachment id="attachmentOther" style="border:1px solid #ccc;margin:0;height:100%;width:100%;" group="equipmentOther"  readOnly="true" theme="simple2" subject="其他"/>
    </logic:equal>
<html:hidden property="id" styleId="id" />
</html:form>
</body>
<oz:js />
</html>