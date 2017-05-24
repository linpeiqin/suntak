<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form"/>
<head>
	<title><oz:messageSource code="oz.cmpn.ldap.config"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.cmpn.ldap.config"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ldap/ldapConfigAction">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnSave"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnTest" text="oz.cmpn.ldap.config.buttons.test" icon="oz-icon-0740" onclick="onBtnTest_Clicked()"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-form">
		<html:form action="ldap/ldapConfigAction.do" styleId="ozForm" styleClass="oz-form">
			<div class="oz-form-title"><oz:messageSource code="oz.cmpn.ldap.config"/></div>
			<div class="oz-form-fields">
				<table cellpadding="0">
					<tr class="oz-form-emptyTR"> 
						<td width="25%"></td>
						<td width="40%"></td>
						<td width="35%"></td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.ldap.config.fields.enableflag"/>：</td>
						<td>
							<html:radio property="enabledFlag" styleId="enabledFlag" value="Y"/><oz:messageSource code="oz.enable"/>
							<html:radio property="enabledFlag" styleId="enabledFlag" value="N"/><oz:messageSource code="oz.disable"/>
						</td>
						<td class="oz-guideline">
						</td>
					</tr>				
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.ldap.config.fields.domaincontroller"/>：</td>
						<td class="oz-property">
							<html:text property="domainController" styleId="domainController" styleClass="oz-form-btField"/>
						</td>
						<td class="oz-guideline">
							例如：ldap://192.168.0.1:389
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.ldap.config.fields.namesuffix"/>：</td>
						<td class="oz-property">
							<html:text property="nameSuffix" styleId="nameSuffix" styleClass="oz-form-btField"/>
						</td>
						<td class="oz-guideline">
							例如：@oz.cn
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.ldap.config.fields.username"/>：</td>
						<td class="oz-property">
							<html:text property="userName" styleId="userName" styleClass="oz-form-field"/>
						</td>
						<td class="oz-guideline">
							例如：CN=john,CN=Users,DC=domainname,DC=com
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.ldap.config.fields.userpwd"/>：</td>
						<td class="oz-property">
							<html:text property="userPwd" styleId="userPwd" styleClass="oz-form-field"/>
						</td>
						<td class="oz-guideline">
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.ldap.config.fields.basedn"/>：</td>
						<td class="oz-property">
							<html:text property="baseDn" styleId="baseDn" styleClass="oz-form-field"/>
						</td>
						<td class="oz-guideline">
							例如：CN=Users,DC=domainname,DC=com
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.ldap.config.fields.searchfilter"/>：</td>
						<td class="oz-property">
							<html:text property="searchFilter" styleId="searchFilter" styleClass="oz-form-field"/>
						</td>
						<td class="oz-guideline">
							例如：(objectClass=*)
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.ldap.config.fields.ldaptype"/>：</td>
						<td class="oz-property">
							<html:select property="ldapType" styleId="ldapType" styleClass="egd-form-btField" onchange="onLdapType_Changed(false)">
								<html:optionsCollection name="ldapTypes" label="name" value="value" />
							</html:select>
						</td>
						<td class="oz-guideline">
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.ldap.config.fields.loginattribute"/>：</td>
						<td class="oz-property">
							<html:text property="loginAttribute" styleId="loginAttribute" styleClass="oz-form-zdField" readonly="true"/>
						</td>
						<td class="oz-guideline">
							例如：AD的'sAMAccountName'/OpenLDAP的'uid'
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.ldap.config.fields.mailattribute"/>：</td>
						<td class="oz-property">
							<html:text property="mailAttribute" styleId="mailAttribute" styleClass="oz-form-zdField" readonly="true"/>
						</td>
						<td class="oz-guideline">
							例如：AD的'mail'
						</td>
					</tr>
					<tr> 
						<td class="oz-form-label"><oz:messageSource code="oz.cmpn.ldap.config.fields.dnattribute"/>：</td>
						<td class="oz-property">
							<html:text property="dnAttribute" styleId="dnAttribute" styleClass="oz-form-zdField" readonly="true"/>
						</td>
						<td class="oz-guideline">
							例如：AD的'distinguishedName'
						</td>
					</tr>
				</table>			
			</div>
			<html:hidden property="id" styleId="id"/>
		</html:form>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
function onBtnTest_Clicked(){
	var strUrl = contextPath + "/ldap/ldapConfigAction.do?action=dlgTest&timeStamp=" + new Date().getTime();
	new OZ.Dlg.create({
		id:"Dlg_LdapTester", 
		width:320, height:200,
		title:'<oz:messageSource code="oz.cmpn.ldap.dlg.title.test"/>',
		url: strUrl,
		onOk:function(result){
			strUrl = contextPath + "/ldap/ldapConfigAction.do?action=testLdap&timeStamp=" + new Date().getTime();
			$.getJSON(
				strUrl, 
				{loginName:result.loginName, loginPwd:result.loginPwd},
				function(json){
					if(json.result == true){
						OZ.Msg.info(json.msg);
					}else{
						OZ.Msg.info(json.msg);
					}
				}
			);
		},
		onCancel:function(result){}
	});
}

function onLdapType_Changed(isPageInit){
	var ldapType = $("#ldapType").val();
	if(ldapType == "Others"){
		$("#loginAttribute").attr("class", "oz-form-field");
		$("#loginAttribute").attr("readOnly", false);
		$("#mailAttribute").attr("class", "oz-form-field");
		$("#mailAttribute").attr("readOnly", false);
		$("#dnAttribute").attr("class", "oz-form-field");
		$("#dnAttribute").attr("readOnly", false);
		if(!isPageInit){
			$("#loginAttribute").val("");			
			$("#mailAttribute").val("");
			$("#dnAttribute").val("");
		}
	}else{
		$("#loginAttribute").css("oz-form-zdField");
		$("#loginAttribute").attr("readOnly", true);
		$("#mailAttribute").css("oz-form-zdField");
		$("#mailAttribute").attr("readOnly", true);
		$("#dnAttribute").css("oz-form-zdField");
		$("#dnAttribute").attr("readOnly", true);
		if(ldapType == "AD"){
			$("#loginAttribute").val("sAMAccountName");			
			$("#mailAttribute").val("mail");
			$("#dnAttribute").val("distinguishedName");
		}else if(ldapType == "eDirectory"){
			$("#loginAttribute").val("uid");			
			$("#mailAttribute").val("mail");
			$("#dnAttribute").val("-");
		}else if(ldapType == "OpenLDAP"){
			$("#loginAttribute").val("uid");			
			$("#mailAttribute").val("mail");
			$("#dnAttribute").val("-");
		}
	}
}

$(function(){
	onLdapType_Changed(true);
});
</script>
</html>