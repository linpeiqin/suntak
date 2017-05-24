<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true" tabs="true" richinput="true"/>
<head>
	<title><oz:messageSource code="oz.mdu.organize.ouinfo"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.cmpn.ldap.sync.ouinfo"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ldap/ouInfoSyncAction" defaultTB="editForm">
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="ldap/ouInfoSyncAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.cmpn.ldap.sync.ouinfo"/></div>
			<div class="oz-form-fields">
				<table cellpadding="2" cellspacing="0" class="oz-form-bordertable" style="width:800px;table-layout:fixed;border-top-width:0px">
					<tr class="oz-form-locate-tr">
						<td width="11%" style="border-left:1px solid white;border-right:0px solid white"></td>
						<td width="35%" style="border-right:0px solid white"></td>
						<td width="11%" style="border-right:0px solid white"></td>
						<td width="" style="border-right:1px solid white;"></td>
					</tr>
					<tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.cmpn.ldap.sync.ouinfo.fields.ouname"/>：</td>
						<td class="oz-property" colspan="3">
						    <a href="javascript:openOUInfo(<bean:write name="ouInfoSyncForm" property="ouInfo.id" format="#"/>,'<bean:write name="ouInfoSyncForm" property="ouInfo.name"/>')"><bean:write name="ouInfoSyncForm" property="ouInfo.name"/></a>
						</td>
                    </tr>
                    <tr class="oz-form-tr">
                        <td class="oz-form-label-r"><oz:messageSource code="oz.cmpn.ldap.sync.fields.mode"/>：</td>
						<td class="">
                            <html:radio property="mode" value="0" /> 不同步
                            <html:radio property="mode" value="1" /> 自动
                            <html:radio property="mode" value="2" /> 手动
						</td>
                        <td class="oz-form-label-r"><oz:messageSource code="oz.cmpn.ldap.sync.ouinfo.fields.includesub"/>：</td>
                        <td class="">
                            <html:radio property="includeSub" value="false" /> 不包含
                            <html:radio property="includeSub" value="true" /> 包含
                        </td>
                    </tr>
                    <tr class="oz-form-tr">
                        <td class="oz-form-label-r"><oz:messageSource code="oz.cmpn.ldap.sync.ouinfo.fields.adname"/>：</td>
						<td class="oz-property" colspan="3">
							<html:text property="adName" styleClass="oz-form-field"/>
						</td>
                    </tr>
                    <tr class="oz-form-tr">
						<td class="oz-form-label-r"><oz:messageSource code="oz.cmpn.ldap.sync.ouinfo.fields.notification"/>：</td>
						<td class="">
                          <label><html:multibox property="notifications" value="1" /> 邮件</label>
                            <label> <html:multibox property="notifications" value="2" /> 系统消息 </label>
						</td>
                        <td class="oz-form-label-r"><oz:messageSource code="oz.cmpn.ldap.sync.ouinfo.fields.recipient"/>：</td>
                        <td class="oz-property">
                            <html:text property="recipient.name"  styleId="recipientName" styleClass="oz-form-field" style="width:200px;"/>
                            <button type="button" class="oz-form-button" style="width:62px;height:21px;float:right" onclick="onSelectUser({})" >清除</button>
                            <button type="button" class="oz-form-button" style="width:62px;height:21px;float:right" onclick="OZ.Organize.selectUserInfoLocal(onSelectUser, '')" >选择</button>
                        </td>
                    </tr>
                    <tr class="oz-form-tr">
                        <td class="oz-form-label-r"><oz:messageSource code="oz.cmpn.ldap.sync.fields.lastupdate"/>：</td>
                        <td>
                            <bean:write name="ouInfoSyncForm" property="lastUpdate" format="yyyy-MM-dd HH:mm:ss"/>
                        </td>
                        <td class="oz-form-label-r"><oz:messageSource code="oz.cmpn.ldap.sync.fields.objectguid"/>：</td>
                        <td>
                            <bean:write name="ouInfoSyncForm" property="objectDashedString"/>
                        </td>
                    </tr>
				</table>			
			</div>
			<html:hidden property="id" styleId="id"/>
            <html:hidden property="recipient.id" styleId="recipientId"/>
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
function openOUInfo(id,title){
    OZ.openWindow({
        id:"ouInfo"+id,
        title:title,
        url:contextPath+"/organize/ouInfoAction.do?action=open&id="+id
    });
}
$(function(){

});
</script>
</html>