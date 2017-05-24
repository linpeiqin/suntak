<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true"/>
<head>
    <title>固定资产报废报告表</title>
    <%@ include file="/oz/includes/meta.jsp"%>
    <oz:css/>
    <oz:css cssHref="/ems/common/css/ems-util.css"/>
</head>
<body class="oz-body" data-name="固定资产报废报告表">
<div id="page-top" class="oz-page-top">
    <oz:toolbar action="ems/scrapAction">
        <oz:tbSeperator/>
        <oz:tbButton id="btnSave"/>
        <oz:tbSeperator/>
        <oz:tbButton id="btnSubmitEBS" icon="oz-icon oz-icon-0121" onclick="onSubmitEBS(this,'scrap')" text="同步EBS"/>
  		<oz:tbSeperator/>
  		<oz:tbButton id="btnSubmitOA" icon="oz-icon oz-icon-0121" onclick="onSubmitOA('ESell_99','scrap','formmain_0154')" text="同步OA"/>
        <oz:tbSeperator/>
        <oz:tbButton id="btnSelectEQ" icon="oz-icon oz-icon-0121" onclick="onSelectEQ(this,2)" text="选择报废设备"/>
        <oz:tbSeperator/>
    </oz:toolbar>
</div>
<div id="page-center" class="oz-page-form">
    <html:form action="ems/scrapAction" styleId="ozForm" styleClass="oz-form">
        <div class="ems-form-main">
            <div class="ems-form-content">
                <div class="ems-form-title">
                                                固定资产报废报告表
                </div>
                <div class="ems-form-body">
                    <table class="ems-table-head" >
                        <tr>
                            <td width="70%">编号：<span id="numberSpan"><bean:write  name="scrapForm" property="number" ></bean:write></span></td>
                            <td width="50%">合同编号：<bean:write name="scrapForm" property="contractNumber" /> <html:hidden property="contractNumber" styleId="contractNumber"  /></td>
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
                                <bean:write name="scrapForm" property="fixedAssetsName" />
                                <html:hidden property="fixedAssetsName" styleId="fixedAssetsName"  />
                            </td>
                            <td>规 格 型 号</td>
                            <td>
                                <bean:write name="scrapForm" property="specificationModel" />
                                <html:hidden property="specificationModel" styleId="specificationModel"  />
                            </td>
                        </tr>
                        <tr>
                            <td>固定资产类别</td>
                            <td>
                                <bean:write name="scrapForm" property="fixedAssetsType" />
                                <html:hidden property="fixedAssetsType" styleId="fixedAssetsType"  />
                            </td>
                            <td>设备编号</td>
                            <td>
                                <span id="serialNumberSpan">
                                    <bean:write name="scrapForm" property="serialNumber" />
                                </span>
                                <html:hidden property="serialNumber" styleId="serialNumber"  />
                            </td>
                        </tr>
                        <tr>
                            <td>数量</td>
                            <td>
                                <html:text styleClass="oz-form-field formatToInt oz-form-zdField" property="assetsNumber" styleId="assetsNumber"  style="width:100%" readonly="true"></html:text>
                            </td>
                            <td>代 理 商</td>
                            <td>
                                <html:text styleClass="oz-form-field oz-form-btField" property="agent" readonly="true" styleId="agent"  style="width:100%" onclick="selectAgent(this,afterAgentChange)" ></html:text>
                            </td>
                        </tr>
                        <tr>
                            <td>原 产 地</td>
                            <td>
                                <html:text styleClass="oz-form-field oz-form-btField" property="origin" styleId="origin"  style="width:100%" ></html:text>
                            </td>
                            <td>制 造 商</td>
                            <td>
                                <bean:write name="scrapForm" property="manufacturer" />
                                <html:hidden property="manufacturer" styleId="manufacturer"  />
                            </td>
                        </tr>
                        <tr>
                            <td rowspan="3">是否进口资产</td>
                            <td>是<html:radio property="isImported" value="1" /> 报关单号：
                                <html:text readonly="true" styleClass="oz-form-zdField" property="customsNo" styleId="customsNo" ></html:text>
                            </td>
                            <td rowspan="3">是否研发资产</td>
                            <td>是<html:radio property="isDevelop" value="1" />
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: left">否<html:radio property="isImported" value="0" /> </td>
                            <td>否<html:radio property="isDevelop" value="0" /></td>
                        </tr>
                        <tr>
                            <td style="text-align: left">行政部-关务负责人： <bean:write name="scrapForm" property="customsPerson" /><html:hidden property="customsPerson" styleId="customsPerson"  /></td>
                            <td>研发部负责人：<bean:write name="scrapForm" property="RDPerson" /><html:hidden property="RDPerson" styleId="RDPerson"  /></td>
                        </tr>

                        <tr>
                            <td style="line-height: 60px">固定资产工作原理<br>及主要技术指标</td>
                            <td colspan="3">
                                <html:textarea property="faTechnicalIndex" styleId="faTechnicalIndex" styleClass="oz-form-field oz-form-btField"></html:textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>开始使用时间</td>
                            <td>
                                    <bean:write name="scrapForm" property="startTime" format="yyy-MM-dd"/>
                                    <html:hidden property="startTimeStr" styleId="startTimeStr"/>
                            </td>
                            <td>归口管理部门</td>
                            <td>
                                <html:text property="ascriptionMDname" onclick="OZ.Organize.selectOUInfo(onSelectMD)" styleClass="ascriptionMDname oz-form-btField" styleId="ascriptionMDname" style="width:100%"></html:text>
                                <html:hidden property="ascriptionMD" styleId="ascriptionMD"></html:hidden>
                                <html:select styleId="ascriptionMDebs" property="ascriptionMDebs" styleClass="oz-form-btField" style="width:100%">
                                    <html:optionsCollection name="manageDSelect" label="name" value="value" />
                                </html:select>
                            </td>
                        </tr>
                        <tr>
                            <td>安装地点</td>
                            <td>
                                <bean:write name="scrapForm" property="installationLocation"></bean:write>
                                <html:hidden property="installationLocation" styleId="installationLocation"></html:hidden>
                            </td>
                            <td>使用 部门</td>
                            <td>
                                <html:text property="useDname" onclick="OZ.Organize.selectOUInfo(onSelectUseD)" styleClass="useDname oz-form-btField" styleId="useDname" style="width:100%"></html:text>
                                <html:hidden property="useD" styleId="useD"></html:hidden>
                                <html:select styleId="useDebs" property="useDebs" styleClass="oz-form-btField" style="width:100%">
                                    <html:optionsCollection name="useDSelect" label="name" value="value" />
                                </html:select>
                            </td>
                        </tr>
                        <tr>
                            <td>已使用期限</td>
                            <td>
                                    <%--<html:text styleClass="oz-form-field" property="usefulLife" styleId="usefulLife" style="width:100%"></html:text>--%>
                                <bean:write name="scrapForm" property="usefulLife"></bean:write>
                                <html:hidden property="usefulLife" styleId="usefulLife"></html:hidden>
                            </td>
                            <td>尚可使用期限</td>
                            <td>
                                    <%--<html:text styleClass="oz-form-field" property="canUseLife" styleId="canUseLife" style="width:100%"></html:text>--%>
                                <bean:write name="scrapForm" property="canUseLife"></bean:write>
                                <html:hidden property="canUseLife" styleId="canUseLife"></html:hidden>
                            </td>
                        </tr>
                       <tr>
                            <td>固定资产出售<br>/报废情况说明<br>（归口管理部门填）</td>
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
                                        <html:textarea styleClass="oz-form-field oz-form-zdField" readonly="true" property="faDescription" styleId="faDescription" style="width:100%"></html:textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>部门主管：</td>
                                        <td>
                                        <html:text styleClass="oz-form-field oz-form-zdField" readonly="true" property="putUnderCharge" styleId="putUnderCharge" style="width:100%"></html:text>
                                        </td>
                                        <td>部门负责人：</td>
                                        <td>
                                        <html:text styleClass="oz-form-field oz-form-zdField" readonly="true" property="putUnderDMH" styleId="putUnderDMH" style="width:100%"></html:text>
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
                                        <html:textarea styleClass="oz-form-field oz-form-zdField" readonly="true" property="sectorOpinion" styleId="sectorOpinion" style="width:100%"></html:textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>部门主管：</td>
                                        <td>
                                        <html:text styleClass="oz-form-field oz-form-zdField" readonly="true" property="useDCharge" styleId="useDCharge" style="width:100%"></html:text>
                                        </td>
                                        <td>部门负责人：</td>
                                        <td>
                                        <html:text styleClass="oz-form-field oz-form-zdField" readonly="true" property="useDMH" styleId="useDMH" style="width:100%"></html:text>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                          <tr>
                            <td>固定资产价值<br>（财务部填） </td>
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
                                        <html:text styleClass="oz-form-field oz-form-zdField" readonly="true" property="originalValue" styleId="originalValue" style="width:100%"></html:text>
                                        </td>
                                        <td>填写人：</td>
                                        <td>
                                        <html:text styleClass="oz-form-field oz-form-zdField" readonly="true" property="financeFillPerson" styleId="financeFillPerson" style="width:100%"></html:text>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>净值</td>
                                        <td>
                                        <html:text styleClass="oz-form-field oz-form-zdField" readonly="true" property="netWorth" styleId="netWorth" style="width:100%"></html:text>
                                        </td>
                                        <td>部门负责人</td>
                                        <td>
                                        <html:text styleClass="oz-form-field oz-form-zdField" readonly="true" property="financeDMH" styleId="financeDMH" style="width:100%"></html:text>
                                        </td>
                                    </tr>                                   
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>固定资产出售/<br>报废批准意见</td>
                            <td colspan="3" style="padding: 0px;border: 0px">
                                <table class="ems-table-sub1">
                                    <tr class="ems-table-sub1-head">
                                        <td width="20%" ></td>
                                        <td width="30%"></td>
                                        <td width="20%"></td>
                                        <td width="30%"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" height="50px">
                                        <html:textarea styleClass="oz-form-field oz-form-zdField" readonly="true" property="faApprovalOpinion" styleId="faApprovalOpinion" style="width:100%"></html:textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 70px">总经理：</td>
                                        <td>
                                        <html:textarea styleClass="oz-form-field oz-form-zdField" readonly="true" property="GM" styleId="GM" style="width:100%"></html:textarea>
                                        </td>
                                        <td>董事长：</td>
                                        <td>
                                        <html:textarea styleClass="oz-form-field oz-form-zdField" readonly="true" property="chairman" styleId="chairman" style="width:100%"></html:textarea>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                             <td>固定资产报废/<br>后存放地点</td>
                             <td colspan="3" height="50px">
                             <html:textarea styleClass="oz-form-field oz-form-zdField" readonly="true" property="faPlaceOfStorage" styleId="faPlaceOfStorage" style="width:100%"></html:textarea>
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
        <html:hidden property="oaType" value="${oaType}" styleId="oaType" />
        <html:hidden property="lifeCycleId" value="${lifeCycleId}" styleId="lifeCycleId"/>
   </html:form>
</div>
</body>
<oz:organizeJs></oz:organizeJs>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<oz:js jsSrc="/ems/scrap/js/ems.scrap.FE.js"/>
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