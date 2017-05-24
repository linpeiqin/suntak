<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true" tabs="true" richinput="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.organize.userInfo"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.cmpn.ldap.sync.userinfo"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ldap/userInfoSyncAction" defaultTB="editForm">
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="ldap/userInfoSyncAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.cmpn.ldap.sync.userinfo"/></div>
			<div class="oz-form-fields">
				<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:800px;table-layout:fixed;border-top-width:0px">
					<tr class="oz-form-locate-tr">
						<td width="11%" style="border-left:1px solid white;border-right:0px solid white"></td>
						<td width="35%" style="border-right:0px solid white"></td>
						<td width="11%" style="border-right:0px solid white"></td>
						<td width="" style="border-right:1px solid white;"></td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.cmpn.ldap.sync.userinfo.fields.username"/>：</td>
						<td class="oz-property" colspan="3">
						    <a href="javascript:openuserInfo(<bean:write name="userInfoSyncForm" property="userInfo.id" format="#"/>,'<bean:write name="userInfoSyncForm" property="userInfo.name"/>')"><bean:write name="userInfoSyncForm" property="userInfo.name"/></a>
						</td>
                    </tr>
                    <tr class="oz-form-tr">
                        <td class="oz-form-label-r"><oz:messageSource code="oz.cmpn.ldap.sync.fields.mode"/>：</td>
						<td class="">
                            <html:radio property="mode" value="0" /> 不同步
                            <html:radio property="mode" value="1" /> 自动
                            <html:radio property="mode" value="2" /> 手动
						</td>
                        <td class="oz-form-label-r"></td>
                        <td class="">

                        </td>
                    </tr>
                    <tr class="oz-form-tr">
                        <td class="oz-form-label-r"><oz:messageSource code="oz.cmpn.ldap.sync.fields.lastupdate"/>：</td>
                        <td>
                            <bean:write name="userInfoSyncForm" property="lastUpdate" format="yyyy-MM-dd HH:mm:ss"/>
                        </td>
                        <td class="oz-form-label-r"><oz:messageSource code="oz.cmpn.ldap.sync.fields.objectguid"/>：</td>
                        <td>
                            <bean:write name="userInfoSyncForm" property="objectDashedString"/>
                        </td>
                    </tr>
				</table>			
			</div>
			<html:hidden property="id" styleId="id"/>
		</html:form>
	</div>
</body>
<oz:organizeJs></oz:organizeJs>
<oz:js/>
<script type="text/javascript">
function onSelectUser(result){
    $("#recipientId").val(result.id);
    $("#recipientName").val(result.name);
    return true;
}
function onBtnClearParent_Clicked(){
	$("#parentId").val("");
	$("#parentName").val("");
	$("#parentFullName").val("");
}
function openuserInfo(id,title){
    OZ.openWindow({
        id:"userInfo"+id,
        title:title,
        url:contextPath+"/organize/userInfoAction.do?action=open&id="+id
    });
}
$(function(){

});
</script>
</html>