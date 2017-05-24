<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true"/>
<head>
    <title>固定资产更新改造验收报告表</title>
    <%@ include file="/oz/includes/meta.jsp"%>
    <oz:css/>
    <oz:css cssHref="/ems/common/css/ems-util.css"/>
</head>
<body class="oz-body" data-name="固定资产更新改造验收报告表">
<div id="page-top" class="oz-page-top">
    <oz:toolbar action="ems/renewalCheckAction">
        <oz:tbSeperator/>
        <oz:tbButton id="btnSave"/>
        <oz:tbSeperator/>
       <%-- <oz:tbButton id="btnSubmitEBS" icon="oz-icon oz-icon-0121" onclick="onSubmitEBS(this,'renewalCheck')" text="同步EBS"/>
    	<oz:tbSeperator/>--%>
  		<oz:tbButton id="btnSubmitOA" icon="oz-icon oz-icon-0121" onclick="onSubmitOA('EUpdate_99','renewalCheck','formmain_0158')" text="同步OA"/>
  		<oz:tbSeperator/>
        <oz:tbButton id="btnSelectEQ" icon="oz-icon oz-icon-0121" onclick="onSelectEQ(this,5)" text="选择待更新、改造设备"/>
        <oz:tbSeperator/>
    </oz:toolbar>
</div>
<div id="page-center" class="oz-page-form">
    <html:form action="ems/renewalCheckAction" styleId="ozForm" styleClass="oz-form">
        <div class="ems-form-main">
            <div class="ems-form-content">
                <div class="ems-form-title">
                                                固定资产更新改造验收报告表
                </div>
                <div class="ems-form-body">
                    <table class="ems-table-head" >
                        <tr>
                            <td width="50%">编号：<span id="numberSpan"><bean:write  name="renewalCheckForm" property="number" ></bean:write></span></td>
                            <td width="50%">合同编号：<bean:write name="renewalCheckForm" property="contractNumber" /> <html:hidden property="contractNumber" styleId="contractNumber"  /></td>
                        </tr>
                    </table>
                    <table class="ems-form-table">
                        <tr class="ems-form-table-headtr" >
                            <td width="20%"></td>
                            <td width="30%"></td>
                            <td width="20%"></td>
                            <td width="30%"></td>
                        </tr>
                        <tr>
                            <td>固定资产名称</td>
                            <td>
                                <bean:write name="renewalCheckForm" property="fixedAssetsName" />
                                <html:hidden property="fixedAssetsName" styleId="fixedAssetsName"  />
                            </td>
                            <td>规格型号</td>
                            <td>
                                <bean:write name="renewalCheckForm" property="specificationModel" />
                                <html:hidden property="specificationModel" styleId="specificationModel"  />
                            </td>
                        </tr>
                        <tr>
                            <td>固定资产类别</td>
                            <td>
                                <bean:write name="renewalCheckForm" property="fixedAssetsType" />
                                <html:hidden property="fixedAssetsType" styleId="fixedAssetsType"  />
                            </td>
                            <td>设备编号</td>
                            <td>
                                <span id="serialNumberSpan">
                                    <bean:write name="renewalCheckForm" property="serialNumber" />
                                </span>
                                <html:hidden property="serialNumber" styleId="serialNumber"  />
                            </td>
                        </tr>
                        <tr>
                            <td>数    量</td>
                            <td>
                                <html:text styleClass="oz-form-field formatToInt oz-form-zdField" property="assetsNumber" styleId="assetsNumber"  style="width:100%" readonly="true"></html:text>
                            </td>
                            <td>供应商</td>
                            <td>
                                <bean:write name="renewalCheckForm" property="agent" />
                                <html:hidden property="agent" styleId="agent"  />
                            </td>
                        </tr>
                        <tr>
                            <td>更新改造项目</td>
                            <td>
                                <bean:write name="renewalCheckForm" property="origin" />
                                <html:hidden property="origin" styleId="origin"  />
                            </td>
                            <td>改造商</td>
                            <td>
                                <bean:write name="renewalCheckForm" property="manufacturer" />
                                <html:hidden property="manufacturer" styleId="manufacturer"  />
                            </td>
                        </tr>
                        <tr>
                            <td style="line-height: 60px">固定资产更新改<br>造工作内容</td>
                            <td colspan="3">
                                <bean:write name="renewalCheckForm" property="faUpdateContent"></bean:write>
                                <html:hidden property="faUpdateContent" styleId="faUpdateContent"/>
                            </td>
                        </tr>
                        <tr>
                            <td>改造完成时间</td>
                            <td>
                                <bean:write name="renewalCheckForm" property="startTimeStr"></bean:write>
                                <html:hidden property="startTimeStr" styleId="startTimeStr"/>
                            </td>
                            <td>归口管理部门</td>
                            <td>
                                <bean:write name="renewalCheckForm" property="ascriptionMDname"></bean:write>
                                    <%--<html:text property="ascriptionMDname" onclick="OZ.Organize.selectOUInfo(onSelectMD)" styleClass="ascriptionMDname oz-form-btField" styleId="ascriptionMDname" style="width:100%"></html:text>--%>
                                <html:hidden property="ascriptionMD" styleId="ascriptionMD"></html:hidden>
                                <html:hidden property="ascriptionMDname" styleId="ascriptionMDname"></html:hidden>
                                <html:hidden property="ascriptionMDebs" styleId="ascriptionMDebs"></html:hidden>
                            </td>
                        </tr>
                        <tr>
                            <td>安装地点</td>
                            <td>
                                    <bean:write name="renewalCheckForm" property="installationLocation" />
                                    <html:hidden property="installationLocation" styleId="installationLocation"  />
                            <td>使用 部门</td>
                            <td>
                                <bean:write name="renewalCheckForm" property="useDname"></bean:write>
                                <html:hidden property="useD" styleId="useD"></html:hidden>
                                <html:hidden property="useDname" styleId="useDname"></html:hidden>
                                <html:hidden property="useDebs" styleId="useDebs"></html:hidden>
                            </td>
                        </tr>
                        <tr>
                            <td>已使用期限</td>
                            <td>
                                    <%--<html:text styleClass="oz-form-field" property="usefulLife" styleId="usefulLife" style="width:100%"></html:text>--%>
                                <bean:write name="renewalCheckForm" property="usefulLife"></bean:write>
                                <html:hidden property="usefulLife" styleId="usefulLife"></html:hidden>
                            </td>
                            <td>尚可使用期限</td>
                            <td>
                                    <%--<html:text styleClass="oz-form-field" property="canUseLife" styleId="canUseLife" style="width:100%"></html:text>--%>
                                <bean:write name="renewalCheckForm" property="canUseLife"></bean:write>
                                <html:hidden property="canUseLife" styleId="canUseLife"></html:hidden>
                            </td>
                        </tr>
                       <tr>
                            <td>固定资产更新<br>完工情况<br>（技术部门填）<br>（可另附页）</td>
                            <td colspan="3" style="padding: 0px;border: 0px">
                                <table class="ems-table-sub1">
                                    <tr class="ems-table-sub1-head">
                                        <td width="20%"></td>
                                        <td width="30%"></td>
                                        <td width="20%"></td>
                                        <td width="30%"></td>
                                    </tr>
                                    <tr>
                                        <td>主要技术指标：</td>
                                        <td colspan = "3">
                                         <html:text styleClass="oz-form-field oz-form-zdField" readonly="true" property="mainRecordIndex" styleId="mainRecordIndex" style="width:100%"></html:text>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>测试记录：</td>
                                        <td colspan = "3">
                                        <html:text styleClass="oz-form-field oz-form-zdField" readonly="true"  property="testRecord" styleId="testRecord" style="width:100%"></html:text>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>结论：</td>
                                        <td colspan = "3">
                                        <html:text styleClass="oz-form-field oz-form-zdField" readonly="true"  property="conclusion" styleId="conclusion" style="width:100%"></html:text>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>检查/验收人：</td>
                                        <td>
                                        <html:text styleClass="oz-form-field oz-form-zdField" readonly="true"  property="acceptancePersonT" styleId="acceptancePersonT" style="width:100%"></html:text>
                                        </td>
                                        <td>部门负责人：</td>
                                        <td>
                                        <html:text styleClass="oz-form-field oz-form-zdField" readonly="true"  property="technicalMH" styleId="technicalMH" style="width:100%"></html:text>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                       <tr>
                            <td>归口管理部门<br>意见</td>
                            <td colspan="3" style="padding: 0px;border: 0px">
                                <table class="ems-table-sub1">
                                    <tr class="ems-table-sub1-head">
                                        <td width="20%"></td>
                                        <td width="30%"></td>
                                        <td width="20%"></td>
                                        <td width="30%"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" height="50px">
                                        <html:textarea styleClass="oz-form-field oz-form-zdField" readonly="true"  property="sectorOpinion" styleId="sectorOpinion" style="width:100%"></html:textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>检查/验收人：</td>
                                        <td>
                                        <html:text styleClass="oz-form-field oz-form-zdField" readonly="true"  property="acceptancePersonM" styleId="acceptancePersonM" style="width:100%"></html:text>
                                        </td>
                                        <td>部门负责人：</td>
                                        <td>
                                        <html:text styleClass="oz-form-field oz-form-zdField" readonly="true"  property="putUnderDMH" styleId="putUnderDMH" style="width:100%"></html:text>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>使用部门意见</td>
                            <td colspan="3" style="padding: 0px;border: 0px">
                                <table class="ems-table-sub1">
                                    <tr class="ems-table-sub1-head">
                                        <td width="20%"></td>
                                        <td width="30%"></td>
                                        <td width="20%"></td>
                                        <td width="30%"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" height="50px">
                                        <html:textarea styleClass="oz-form-field oz-form-zdField" readonly="true"  property="useDOpinion" styleId="useDOpinion" style="width:100%"></html:textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>部门主管：</td>
                                        <td>
                                        <html:text styleClass="oz-form-field oz-form-zdField" readonly="true"  property="useDCharge" styleId="useDCharge" style="width:100%"></html:text>
                                        </td>
                                        <td>部门负责人：</td>
                                        <td>
                                        <html:text styleClass="oz-form-field oz-form-zdField" readonly="true"  property="useDMH" styleId="useDMH" style="width:100%"></html:text>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                         <tr>
                          <tr>
                            <td>固定资产原价 </td>
                            <td colspan="3" style="padding: 0;border: 0">
                                <table class="ems-table-sub1">
                                    <tr class="ems-table-sub1-head">
                                        <td width="20%"></td>
                                        <td width="30%"></td>
                                        <td width="20%"></td>
                                        <td width="30%"></td>
                                    </tr>
                                    <tr>
                                        <td>原 值</td>
                                        <td>
                                        <html:text styleClass="oz-form-field oz-form-zdField" readonly="true"  property="originalValue" styleId="originalValue"  style="width:100%"></html:text>
                                        </td>
                                        <td>填写人：</td>
                                        <td>
                                        <html:text styleClass="oz-form-field oz-form-zdField" readonly="true"  property="financeFillPerson" styleId="financeFillPerson" style="width:100%"></html:text>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>净  值</td>
                                        <td>
                                        <html:text styleClass="oz-form-field  oz-form-zdField" readonly="true"  property="netWorth" styleId="netWorth" style="width:100%"></html:text>
                                        </td>
                                        <td>部门负责人</td>
                                        <td>
                                        <html:text styleClass="oz-form-field oz-form-zdField" readonly="true"  property="financeDMH" styleId="financeDMH" style="width:100%"></html:text>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>新增价值</td>
                                        <td colspan = "3">
                                        <html:text styleClass="oz-form-field  oz-form-zdField" readonly="true"  property="addedValue" styleId="addedValue" style="width:100%"></html:text>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>验收结果<br>
                                批准意见
                            </td>
                            <td colspan="3" style="padding: 0px;border: 0px">
                                <table class="ems-table-sub1">
                                    <tr class="ems-table-sub1-head">
                                        <td width="20%" ></td>
                                        <td width="30%"></td>
                                        <td width="20%"></td>
                                        <td width="30%"></td>
                                    </tr>
                                    <tr>
                                        <td style="height: 70px">总经理：</td>
                                        <td style="height: 70px">
                                        <html:textarea styleClass="oz-form-field oz-form-zdField" readonly="true"  property="GM" styleId="GM" style="width:100%"></html:textarea>
                                        </td>
                                        <td>董事长：</td>
                                        <td style="height: 70px">
                                        <html:textarea styleClass="oz-form-field oz-form-zdField" readonly="true"  property="chairman" styleId="chairman" style="width:100%"></html:textarea>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                             <td colspan = "4" style="padding: 0;border: 0">
                                                                                         备注：固定资产类别指房屋建筑物、机器设备、办公设备等。
                             </td>
                        </tr>
                    </table>
                    <div style="height: 100px"></div>
                </div>
            </div>
        </div>
        <html:hidden property="id" styleId="id"/>
        <html:hidden property="type" styleId="type"/>
         <html:hidden property="fixedAssetsTypeId" styleId="fixedAssetsTypeId"/>
        <html:hidden property="agentId" styleId="agentId"/>
        <html:hidden property="manufacturerId" styleId="manufacturerId"/>
        <html:hidden property="equipmentId" styleId="equipmentId" value="${equipmentId}"/>
        <html:hidden property="equipmentNos" styleId="equipmentNos" value="${equipmentNos}"/>
        <html:hidden property="oaType" styleId="oaType" value="${oaType}" />
        <html:hidden property="lifeCycleId" styleId="lifeCycleId" value="${lifeCycleId}"/>
   </html:form>
</div>
</body>
<oz:js/>
<oz:organizeJs></oz:organizeJs>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<oz:js jsSrc="/ems/renewalcheck/js/ems.renewalcheck.FE.js"/>
<script type="text/javascript">
    function onSelectMD(result){
        $('#ascriptionMDname').val(result.name);
        $('#ascriptionMD').val(result.id);
    }
    function onSelectUseD(result){
        $('#useDname').val(result.name);
        $('#useD').val(result.id);
    }
</script>
</html>