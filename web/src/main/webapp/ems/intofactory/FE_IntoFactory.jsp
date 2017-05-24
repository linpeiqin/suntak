<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true" />
<head>
    <title>固定资产入厂报告表</title>
    <%@ include file="/oz/includes/meta.jsp"%>
    <oz:css/>
    <oz:css cssHref="/ems/common/css/ems-util.css"/>
</head>
<body class="oz-body" data-name="固定资产入厂报告表">
<div id="page-top" class="oz-page-top">
    <oz:toolbar action="ems/intoFactoryAction">
        <oz:tbSeperator/>
        <oz:tbButton id="btnSave"/>
        <oz:tbSeperator/>
        <oz:tbButton id="btnSubmitEBS" icon="oz-icon oz-icon-0121" onclick="onSubmitEBS(this,'intoFactory')" text="同步EBS"/>
  		<oz:tbSeperator/>
  		<oz:tbButton id="btnSubmitOA" icon="oz-icon oz-icon-0121" onclick="onSubmitOA('EIntoFactory_99','intoFactory','formmain_0169')" text="同步OA"/>
        <oz:tbSeperator/>
        <oz:tbButton id="btnSelectEQ"  icon="oz-icon oz-icon-0121" onclick="onSelectEQ(this,0)" text="选择入厂设备" />
  		<oz:tbSeperator/>
    </oz:toolbar>
</div>
<div id="page-center" class="oz-page-form">
    <html:form action="ems/intoFactoryAction" styleId="ozForm" styleClass="oz-form">
        <div class="ems-form-main">
            <div class="ems-form-content">
                <div class="ems-form-title">
                    固定资产入厂报告表
                </div>
                <div class="ems-form-body">
                    <table class="ems-table-head" >
                        <tr>
                            <td width="50%">编号：<span id="numberSpan"><bean:write  name="intoFactoryForm" property="number" ></bean:write></span></td>
                            <td width="50%">合同编号：<bean:write name="intoFactoryForm" property="contractNumber" /> <html:hidden property="contractNumber" styleId="contractNumber"  /></td>
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
                                <%--<bean:write name="intoFactoryForm" property="fixedAssetsName" />--%>
                                <%--<html:hidden property="fixedAssetsName" styleId="fixedAssetsName"  />--%>
                                <html:text property="fixedAssetsName" styleId="fixedAssetsName"  styleClass="oz-form-btField" style="width:100%"/>
                            </td>
                            <td>规 格 型 号</td>
                            <td>
                                <bean:write name="intoFactoryForm" property="specificationModel" />
                                <html:hidden property="specificationModel" styleId="specificationModel"  />
                            </td>
                        </tr>
                        <tr>
                            <td>固定资产类别</td>
                            <td>
                                <html:select styleId="fixedAssetsType" property="fixedAssetsType" styleClass="oz-form-btField" style="width:100%">
                                    <html:optionsCollection name="fixedAssetsTypeSelect" label="name" value="value" />
                                </html:select>
                            </td>
                            <td>设备编号</td>
                            <td>
                                <span id="serialNumberSpan" style="overflow: scroll" >
                                    <bean:write name="intoFactoryForm" property="serialNumber" />
                                </span>
                                <html:hidden property="serialNumber" styleId="serialNumber"/>
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
                                    <%--<input type="button" onclick="btnAgSelect(this,afterAgentChange)"  value="选择" style="width: 15%">--%>
                            </td>
                        </tr>
                        <tr>
                            <td>原 产 地</td>
                            <td>
                                <html:text styleClass="oz-form-field oz-form-btField" property="origin" styleId="origin"  style="width:100%" ></html:text>
                            </td>
                            <td>制 造 商</td>
                            <td>
                                <html:text styleClass="oz-form-field oz-form-btField" property="manufacturer" styleId="manufacturer"  style="width:85%" onclick="selectAgent(this,afterManufacturerChange)"></html:text><input type="button" onclick="btnMaSelect(this,afterManufacturerChange)" value="选择" style="width: 15%">
                            </td>
                        </tr>
                        <tr>
                            <td rowspan="3">是否进口资产</td>
                            <td>是<html:radio property="isImported" value="1" /> 报关单号：<html:text readonly="true" styleClass="oz-form-zdField formatToInt" property="customsNo" styleId="customsNo" ></html:text></td>
                            <td rowspan="3">是否研发资产</td>
                            <td>是<html:radio property="isDevelop" value="1"/></td>
                        </tr>
                        <tr>
                            <td style="text-align: left">否<html:radio property="isImported" value="0"/> </td>
                            <td>否<html:radio property="isDevelop" value="0"/></td>
                        </tr>
                        <tr>
                            <td style="text-align: left">行政部-关务负责人：<html:text styleClass="oz-form-zdfield" readonly="true" property="customsPerson" styleId="customsPerson"></html:text></td>
                            <td>研发部负责人：<html:text styleClass="oz-form-zdfield" readonly="true" property="RDPerson" styleId="RDPerson"></html:text></td>
                        </tr>
                        <tr style="line-height: 60px">
                            <td>固定资产工作原理<br>及主要技术指标</td>
                            <td colspan="3"><html:textarea styleClass="oz-form-field oz-form-btField" property="WPATI" styleId="WPATI" ></html:textarea></td>
                        </tr>
                        <tr>
                            <td>入 厂 时 间</td>
                            <td><html:text styleClass="oz-dateTimeField oz-form-btField" property="intoFactoryTimeTime" styleId="intoFactoryTimeTime"  style="width:100%" ></html:text></td>
                            <td>安 装 地 点</td>
                            <td><html:text styleClass="oz-form-btfield" property="installationLocation" styleId="installationLocation"  style="width:100%" ></html:text></td>
                        </tr>

                        <tr>
                            <td>归口管理部门</td>
                            <td>
                                    <html:text property="ascriptionMDname" onclick="OZ.Organize.selectOUInfo(onSelectMD)" styleClass="ascriptionMDname oz-form-btField" styleId="ascriptionMDname" style="width:100%"></html:text>
                                    <html:hidden property="ascriptionMD" styleId="ascriptionMD"></html:hidden>
                                    <html:select styleId="ascriptionMDebs" property="ascriptionMDebs" styleClass="oz-form-btField" style="width:100%">
                                        <html:optionsCollection name="manageDSelect" label="name" value="value" />
                                    </html:select>
                            <td>使 用 部 门</td>
                            <td>
                                    <html:text property="useDname" onclick="OZ.Organize.selectOUInfo(onSelectUseD)" styleClass="useDname oz-form-btField" styleId="useDname" style="width:100%"></html:text>
                                    <html:hidden property="useD" styleId="useD"></html:hidden>
                                    <html:select styleId="useDebs" property="useDebs" styleClass="oz-form-btField" style="width:100%">
                                        <html:optionsCollection name="useDSelect" label="name" value="value" />
                                    </html:select>
                            </td>
                        </tr>
                        <tr>
                            <td>安装调试人员</td>
                            <td><html:text styleClass="oz-form-field oz-form-btField" property="installationPersonnel" styleId="installationPersonnel"  style="width:100%" ></html:text></td>
                            <td>预计使用年限</td>
                            <td><html:text styleClass="oz-form-field formatToInt oz-form-zdField" readonly="true"  property="estimateUsefulLife" styleId="estimateUsefulLife"  style="width:100%" ></html:text></td>
                        </tr>
                        <tr>
                            <td>固定资产入厂<br>检查/验收情况<br>（技术部门填）<br>
                                （可另附页）
                            </td>
                            <td colspan="3" style="padding: 0;border: 0">
                                <table class="ems-table-sub1">
                                    <tr class="ems-table-sub1-head">
                                        <td width="20%"></td>
                                        <td width="30%"></td>
                                        <td width="20%"></td>
                                        <td width="30%"></td>
                                    </tr>
                                    <tr>
                                        <td>主要技术指标：</td>
                                        <td colspan="3"><html:textarea styleClass="oz-form-field oz-form-btField" property="mainRecordIndex" styleId="mainRecordIndex" ></html:textarea></td>
                                    </tr>
                                    <tr>
                                        <td>测试记录：</td>
                                        <td colspan="3"><html:textarea styleClass="oz-form-field oz-form-zdField" readonly="true" property="testRecord" styleId="testRecord" ></html:textarea></td>
                                    </tr>
                                    <tr>
                                        <td>结论：</td>
                                        <td colspan="3"><html:textarea styleClass="oz-form-field oz-form-zdField" readonly="true" property="conclusion" styleId="conclusion"  ></html:textarea></td>
                                    </tr>
                                    <tr>
                                        <td>检查/验收人：</td>
                                        <td><html:text styleClass="oz-form-field oz-form-zdField" readonly="true" property="acceptancePersonT" styleId="acceptancePersonT"  style="width:100%"></html:text></td>
                                        <td>部门负责人：</td>
                                        <td><html:text styleClass="oz-form-field oz-form-zdField" readonly="true" property="technicalMH" styleId="technicalMH"  style="width:100%" ></html:text></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>固定资产入厂<br>检查/验收情况<br>（归口管理部门填）</td>
                            <td colspan="3" style="padding: 0px;border: 0px">
                                <table class="ems-table-sub1">
                                    <tr class="ems-table-sub1-head">
                                        <td width="20%"></td>
                                        <td width="30%"></td>
                                        <td width="20%"></td>
                                        <td width="30%"></td>
                                    </tr>
                                    <tr >
                                        <td colspan="4" height="100px">
                                            <html:textarea styleClass="oz-form-field oz-form-btField"  property="putUnderD" styleId="putUnderD"  style="width:100%;line-height: 2.0;" ></html:textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>检查/验收人：</td>
                                        <td><html:text styleClass="oz-form-field oz-form-zdField" readonly="true" property="acceptancePersonM" styleId="acceptancePersonM"  style="width:100%" ></html:text></td>
                                        <td>部门负责人：</td>
                                        <td><html:text styleClass="oz-form-field oz-form-zdField" readonly="true" property="putUnderDMH" styleId="putUnderDMH"  style="width:100%" ></html:text></td>
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
                                        <td colspan="4" height="100px">
                                            <html:textarea styleClass="oz-form-field oz-form-zdField" readonly="true" property="useDOpinion" styleId="useDOpinion" ></html:textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>部门主管：</td>
                                        <td><html:text styleClass="oz-form-field oz-form-zdField" readonly="true" property="useDCharge" styleId="useDCharge"  style="width:100%" ></html:text></td>
                                        <td>部门负责人：</td>
                                        <td><html:text styleClass="oz-form-field oz-form-zdField" readonly="true" property="useDMH" styleId="useDMH"  style="width:100%" ></html:text></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>固定资产价值<br>
                                （财务部填）
                            </td>
                            <td colspan="3" style="padding: 0;border: 0">
                                <table class="ems-table-sub1">
                                    <tr class="ems-table-sub1-head">
                                        <td width="20%"></td>
                                        <td width="30%"></td>
                                        <td width="20%"></td>
                                        <td width="30%"></td>
                                    </tr>
                                    <tr>

                                        <td>原 值<span>(<bean:write name="intoFactoryForm" property="hasTax"></bean:write><bean:write name="intoFactoryForm" property="currency"></bean:write>)</span></td>
                                        <td><html:text styleClass="oz-form-currencyField formatToMoney oz-form-zdField" readonly="true"  property="originalValue" styleId="originalValue"  style="width:100%" ></html:text></td>
                                        <td rowspan="2">填写人：</td>
                                        <td rowspan="2"><html:text styleClass="oz-form-field oz-form-zdField" readonly="true" property="financeFillPerson" styleId="financeFillPerson"  style="width:100%" ></html:text></td>
                                    </tr>
                                    <tr>
                                        <td>安装费用</td>
                                        <td><html:text styleClass="oz-form-currencyField formatToMoney oz-form-zdField" readonly="true" property="installationCost" styleId="installationCost"  style="width:100%" ></html:text></td>
                                    </tr>
                                    <tr>
                                        <td>关 税</td>
                                        <td><html:text styleClass="oz-form-currencyField formatToMoney oz-form-zdField" readonly="true" property="tariff" styleId="tariff"  style="width:100%" ></html:text></td>
                                        <td  rowspan="3">部门负责人：</td>
                                        <td  rowspan="3"><html:text styleClass="oz-form-field oz-form-zdField" readonly="true" property="financeDMH" styleId="financeDMH"  style="width:100%" ></html:text></td>
                                    </tr>
                                    <tr>
                                        <td>其 他</td>
                                        <td><html:text styleClass="oz-form-currencyField formatToMoney oz-form-zdField" readonly="true" property="other" styleId="other"  style="width:100%" ></html:text></td>
                                    </tr>
                                    <tr>
                                        <td>价值合计</td>
                                        <td><html:text styleClass="oz-form-currencyField oz-form-zdField formatToMoney"  property="totalValue" styleId="totalValue"  style="width:100%" readonly="true"></html:text></td>
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
                                        <td><html:text styleClass="oz-form-field oz-form-zdField" readonly="true" property="GM" styleId="GM"  style="width:100%" ></html:text></td>
                                        <td>董事长：</td>
                                        <td><html:text styleClass="oz-form-field oz-form-zdField" readonly="true" property="chairman" styleId="chairman"  style="width:100%" ></html:text></td>
                                    </tr>
                                </table>
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
        <html:hidden property="currency" styleId="currency"/>
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
<oz:js jsSrc="/ems/intofactory/js/ems.intofactory.FE.js"/>
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