<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true"/>
<head>
    <title>固定资产入厂验收报告表</title>
    <%@ include file="/oz/includes/meta.jsp"%>
    <oz:css/>
    <oz:css cssHref="/ems/common/css/ems-util.css"/>
</head>
<body class="oz-body" data-name="固定资产入厂验收报告表">
<div id="page-top" class="oz-page-top">
    <oz:toolbar action="ems/intoFactoryCheckAction">
        <oz:tbSeperator/>
        <oz:tbButton id="btnSave"/>
        <oz:tbSeperator/>
        <oz:tbSeperator/>
        <oz:tbButton id="btnSubmitEBS" icon="oz-icon oz-icon-0121" onclick="onSubmitEBS(this,'intoFactoryCheck')" text="同步EBS"/>
   		<oz:tbSeperator/>
  		<oz:tbButton id="btnSubmitOA" icon="oz-icon oz-icon-0121" onclick="onSubmitOA('EIntoFactory_99','intoFactoryCheck','formmain_0169')" text="同步OA"/>
        <oz:tbSeperator/>
        <oz:tbButton id="btnSelectEQ" icon="oz-icon oz-icon-0121" onclick="onSelectEQ(this,1)" text="确认验收设备"/>
    </oz:toolbar>
</div>
<div id="page-center" class="oz-page-form">
    <html:form action="ems/intoFactoryCheckAction" styleId="ozForm" styleClass="oz-form">
        <div class="ems-form-main">
            <div class="ems-form-content">

                <div class="ems-form-title">
                    固定资产验收报告表
                </div>
                <div class="ems-form-body">
                    <table class="ems-table-head" >
                        <tr>
                            <td width="50%">编号：<span id="numberSpan"><bean:write  name="intoFactoryCheckForm" property="number" ></bean:write></span></td>
                            <td width="50%">合同编号：<bean:write name="intoFactoryForm" property="contractNumber" /> <html:hidden property="contractNumber" styleId="contractNumber"  /></td>
                        </tr>
                    </table>
                    <table class="ems-form-table" >
                        <tr class="ems-form-table-headtr" >
                            <td width="20%"></td>
                            <td width="30%"></td>
                            <td width="20%"></td>
                            <td width="30%"></td>
                        </tr>
                        <tr>
                            <td>固定资产名称</td>
                            <td>
                                <bean:write name="intoFactoryForm" property="fixedAssetsName" />
                                <html:hidden property="fixedAssetsName" styleId="fixedAssetsName"  />
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
                                <bean:write name="intoFactoryForm" property="fixedAssetsType" />
                                <html:hidden property="fixedAssetsType" styleId="fixedAssetsType"  />
                            </td>
                            <td>设备编号</td>
                            <td>
                                <span id="serialNumberSpan">
                                    <bean:write name="intoFactoryForm" property="serialNumber" />
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
                                <bean:write name="intoFactoryForm" property="agent" />
                                <html:hidden property="agent" styleId="agent"  />
                            </td>
                        </tr>
                        <tr>
                            <td>原 产 地</td>
                            <td>
                                <bean:write name="intoFactoryForm" property="origin" />
                                <html:hidden property="origin" styleId="origin"  />
                            </td>
                            <td>制 造 商</td>
                            <td>
                                <bean:write name="intoFactoryForm" property="manufacturer" />
                                <html:hidden property="manufacturer" styleId="manufacturer"  />
                            </td>
                        </tr>
                        <tr>
                            <td rowspan="3">是否进口资产</td>
                            <td>是<html:radio property="isImported" value="1" disabled="true"/> 报关单号：
                                <bean:write name="intoFactoryForm" property="customsNo" />
                                <html:hidden property="isImported" styleId="isImported"  />
                                <html:hidden property="customsNo" styleId="customsNo"  />
                            </td>
                            <td rowspan="3">是否研发资产</td>
                            <td>是<html:radio property="isDevelop" value="1" disabled="true"/>
                                <html:hidden property="isDevelop" styleId="isDevelop"  />
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: left">否<html:radio property="isImported" value="0" disabled="true"/> </td>
                            <td>否<html:radio property="isDevelop" value="0" disabled="true"/></td>
                        </tr>
                        <tr>
                            <td style="text-align: left">行政部-关务负责人： <bean:write name="intoFactoryForm" property="customsPerson" /><html:hidden property="customsPerson" styleId="customsPerson"  /></td>
                            <td>研发部负责人：<bean:write name="intoFactoryForm" property="RDPerson" /><html:hidden property="RDPerson" styleId="RDPerson"  /></td>
                        </tr>
                        <tr style="line-height: 60px">
                            <td>固定资产工作原理<br>及主要技术指标</td>
                            <td colspan="3"><html:textarea styleClass="oz-form-zdField" property="WPATI" styleId="WPATI" readonly="true" ></html:textarea></td>
                        </tr>
                        <tr>
                            <td>入 厂 时 间</td>
                            <td>
                                <bean:write name="intoFactoryForm" property="intoFactoryTimeTime" format="yyyy-MM-dd"/>
                                <html:hidden property="intoFactoryTimeTime" styleId="intoFactoryTimeTime"  />
                            </td>
                            <td>归口管理部门</td>
                            <td>
                                    <bean:write name="intoFactoryForm" property="ascriptionMDname"></bean:write>
                                    <%--<html:text property="ascriptionMDname" onclick="OZ.Organize.selectOUInfo(onSelectMD)" styleClass="ascriptionMDname oz-form-btField" styleId="ascriptionMDname" style="width:100%"></html:text>--%>
                                    <html:hidden property="ascriptionMD" styleId="ascriptionMD"></html:hidden>
                                    <html:hidden property="ascriptionMDname" styleId="ascriptionMDname"></html:hidden>
                                    <html:hidden property="ascriptionMDebs" styleId="ascriptionMDebs"></html:hidden>
                            </td>
                        </tr>
                        <tr>
                            <td>安 装 地 点</td>
                            <td>
                                <bean:write name="intoFactoryForm" property="installationLocation" />
                                <html:hidden property="installationLocation" styleId="installationLocation"  />
                            </td>
                            <td>使 用 部 门</td>
                            <td>
                                <bean:write name="intoFactoryForm" property="useDname"></bean:write>
                                <html:hidden property="useD" styleId="useD"></html:hidden>
                                <html:hidden property="useDname" styleId="useDname"></html:hidden>
                                <html:hidden property="useDebs" styleId="useDebs"></html:hidden>
                            </td>
                        </tr>
                        <tr>
                            <td>安装调试人员</td>
                            <td>
                                <bean:write name="intoFactoryForm" property="installationPersonnel" />
                                <html:hidden property="installationPersonnel" styleId="installationPersonnel"  />
                            </td>
                            <td>预计使用年限</td>
                            <td>
                                <bean:write name="intoFactoryForm" property="estimateUsefulLife" />
                                <html:hidden property="estimateUsefulLife" styleId="estimateUsefulLife"  />
                            </td>
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
                                        <td colspan="3"><html:textarea styleClass="oz-form-zdField" property="mainRecordIndex" styleId="mainRecordIndex"  readonly="true"></html:textarea></td>
                                    </tr>
                                    <tr>
                                        <td>测试记录：</td>
                                        <td colspan="3"><html:textarea styleClass="oz-form-zdField" property="testRecord" styleId="testRecord"  readonly="true"></html:textarea></td>
                                    </tr>
                                    <tr>
                                        <td>结论：</td>
                                        <td colspan="3"><html:textarea styleClass="oz-form-zdField" property="conclusion" styleId="conclusion"  readonly="true"></html:textarea></td>
                                    </tr>
                                    <tr>
                                        <td>检查/验收人：</td>
                                        <td><html:text styleClass="oz-form-zdField" property="acceptancePersonT" styleId="acceptancePersonT"  style="width:100%" readonly="true"></html:text></td>
                                        <td>部门负责人：</td>
                                        <td><html:text styleClass="oz-form-zdField" property="technicalMH" styleId="technicalMH"  style="width:100%"  readonly="true"></html:text></td>
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
                                            <html:textarea styleClass="oz-form-zdField" property="putUnderD" styleId="putUnderD"  style="width:100%;line-height: 2.0;" readonly="true"></html:textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>检查/验收人：</td>
                                        <td><html:text styleClass="oz-form-zdField" property="acceptancePersonM" styleId="acceptancePersonM"  style="width:100%" readonly="true" ></html:text></td>
                                        <td>部门负责人：</td>
                                        <td><html:text styleClass="oz-form-zdField" property="putUnderDMH" styleId="putUnderDMH"  style="width:100%" readonly="true"></html:text></td>
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
                                            <html:textarea styleClass="oz-form-zdField" property="useDOpinion" styleId="useDOpinion" readonly="true"></html:textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>部门主管：</td>
                                        <td><html:text styleClass="oz-form-zdField" property="useDCharge" styleId="useDCharge"  style="width:100%" readonly="true"></html:text></td>
                                        <td>部门负责人：</td>
                                        <td><html:text styleClass="oz-form-zdField" property="useDMH" styleId="useDMH"  style="width:100%" readonly="true"></html:text></td>
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
                                        <td>原 值</td>
                                        <td>
                                            <bean:write name="intoFactoryForm" property="originalValue"  format="0.0000"/>
                                            <html:hidden property="originalValue" styleId="originalValue"  />
                                        </td>
                                        <td rowspan="2">填写人：</td>
                                        <td rowspan="2"><html:text styleClass="oz-form-zdField" property="financeFillPerson" styleId="financeFillPerson"  style="width:100%" readonly="true"></html:text></td>
                                    </tr>
                                    <tr>
                                        <td>安装费用</td>
                                        <td>
                                            <bean:write name="intoFactoryForm" property="installationCost"  format="0.0000"/>
                                            <html:hidden property="installationCost" styleId="installationCost" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>关 税</td>
                                        <td>
                                            <bean:write name="intoFactoryForm" property="tariff" format="0.0000"/>
                                            <html:hidden property="tariff" styleId="tariff" />
                                        </td>
                                        <td  rowspan="3">部门负责人：</td>
                                        <td  rowspan="3"><html:text styleClass="oz-form-zdField" property="financeDMH" styleId="financeDMH"  style="width:100%" readonly="true" ></html:text></td>
                                    </tr>
                                    <tr>
                                        <td>其 他</td>
                                        <td>
                                            <bean:write name="intoFactoryForm" property="other" format="0.0000"/>
                                            <html:hidden property="other" styleId="other" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>价值合计</td>
                                        <td>
                                            <bean:write name="intoFactoryForm" property="totalValue" format="0.0000"/>
                                            <html:hidden property="totalValue" styleId="totalValue" />
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
                                        <td><html:text styleClass="oz-form-zdField" property="GM" styleId="GM"  style="width:100%" readonly="true"></html:text></td>
                                        <td>董事长：</td>
                                        <td><html:text styleClass="oz-form-zdField" property="chairman" styleId="chairman"  style="width:100%" readonly="true"></html:text></td>
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
<oz:js jsSrc="/ems/intofactorycheck/js/ems.intofactorycheck.FE.js"/>
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