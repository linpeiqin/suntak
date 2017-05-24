<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true"/>
<head>
    <title>固定资产出售报告表</title>
    <%@ include file="/oz/includes/meta.jsp"%>
    <oz:css/>
    <oz:css cssHref="/ems/common/css/ems-util.css"/>
</head>
<body class="oz-body" data-name="固定资产出售报告表">
<div id="page-top" class="oz-page-top">
    <oz:toolbar action="ems/sellAction">
        <oz:tbSeperator/>
        <oz:tbButton id="btnBack"/>
        <oz:tbSeperator/>
        <oz:tbButton id="btnSave"/>
        <oz:tbSeperator/>
        <oz:tbButton id="btnSubmitEBS" icon="oz-icon oz-icon-0121" onclick="onSubmitEBS(this,'sell')" text="同步EBS"/>
   		<oz:tbSeperator/>
  		<oz:tbButton id="btnSubmitOA" icon="oz-icon oz-icon-0121" onclick="onSubmitOA('ESell_99','sell','formmain_0154')" text="同步OA"/>
  		<oz:tbSeperator/>
    </oz:toolbar>
</div>
<div id="page-center" class="oz-page-form">
    <html:form action="ems/sellAction" styleId="ozForm" styleClass="oz-form">
        <div class="ems-form-main">
            <div class="ems-form-content">
                <div class="ems-form-title">
                                                固定资产出售报告表
                </div>
                <div class="ems-form-body">
                    <table class="ems-table-head" >
                        <tr>
                            <td width="70%">编号：<span id="numberSpan"><bean:write  name="sellForm" property="number" ></bean:write></span></td>
                            <td width="30%">合同编号： <html:text styleClass="oz-form-field" property="contractNumber" styleId="contractNumber"></html:text> </td>
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
                              <html:text styleClass="oz-form-btField" property="fixedAssetsName" styleId="fixedAssetsName" style="width:100%"></html:text>
                            </td>
                            <td>规格型号</td>
                            <td>
                            <html:text styleClass="oz-form-btField" property="specificationModel" styleId="specificationModel" style="width:100%"></html:text>
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
                                <span id="serialNumberSpan"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>数    量</td>
                            <td>
                             <html:text styleClass="oz-form-field formatToInt" property="assetsNumber" styleId="assetsNumber" style="width:100%"></html:text>
                            </td>
                            <td>代  理  商</td>
                            <td>
                             <html:text styleClass="oz-form-field" property="agent" styleId="agent" style="width:100%" onclick="selectAgent(this)"></html:text>
                            </td>
                        </tr>
                        <tr>
                            <td>原  产  地</td>
                            <td>
                            <html:text styleClass="oz-form-field" property="origin" styleId="origin" style="width:100%"></html:text>
                            </td>
                            <td>制  造  商</td>
                            <td>
                            <html:text styleClass="oz-form-field" property="manufacturer" styleId="manufacturer" style="width:100%" onclick="selectAgent(this)"></html:text>
                            </td>
                        </tr>
                        
                         <tr>
                            <td>是否进口资产</td>
                            <td style="padding: 0;border: 0">
                                <table class="ems-table-sub1">
                                    <tr class="ems-table-sub1-head">
                                        <td width="20%"></td>
                                        <td width="30%"></td>

                                    </tr>
                                    <tr>
                                        <td>是<html:radio property="isImported" value="1"/>  </td>
                                        <td>否<html:radio property="isImported" value="0"/></td>
                                    </tr>
                                    <tr>
                                        <td>报关单号：</td>
                                        <td>
                                        <html:text styleClass="oz-form-zdField" property="customsNo" styleId="customsNo" style="width:100%"></html:text>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>行政部-关务负责人：</td>
                                        <td>
                                        <html:text styleClass="oz-form-field" property="customsPerson" styleId="customsPerson" style="width:100%"></html:text>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>是否研发资产</td>
                            <td style="padding: 0;border: 0">
                                <table class="ems-table-sub1">
                                    <tr class="ems-table-sub1-head">
                                        <td width="20%"></td>
                                        <td width="30%"></td>
                                    </tr>
                                    <tr>
                                        <td>是</td>
                                        <td><html:radio property="isDevelop" value="1"/></td>
                                    </tr>
                                    <tr>
                                        <td>否</td>
                                        <td><html:radio property="isDevelop" value="0"/></td>
                                    </tr>
                                    <tr>
                                        <td>研发部负责人：</td>
                                        <td>
                                        <html:text styleClass="oz-form-field" property="RDPerson" styleId="RDPerson" style="width:100%"></html:text>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="line-height: 60px">固定资产工作原理<br>及主要技术指标</td>
                            <td colspan="3">
                            <html:textarea styleClass="oz-form-field" property="faTechnicalIndex" styleId="faTechnicalIndex"></html:textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>开始使用时间</td>
                            <td>
                            <html:text styleClass="oz-dateTimeField oz-form-btField" property="startTimeStr" styleId="startTimeStr" style="width:100%"></html:text>
                            </td>
                            <td>归口管理部门</td>
                            <td>
                                <html:text property="ascriptionMDname" onclick="OZ.Organize.selectOUInfo(onSelectMD)" styleClass="ascriptionMDname oz-form-btField" styleId="ascriptionMDname" style="width:100%"></html:text>
                                <html:hidden property="ascriptionMD" styleId="ascriptionMD"></html:hidden>
                            </td>
                        </tr>
                        <tr>
                            <td>安装地点</td>
                            <td>
                            <html:text styleClass="oz-form-btfield" property="installationLocation" styleId="installationLocation" style="width:100%"></html:text>
                            </td>
                            <td>使用 部门</td>
                            <td>
                                <html:text property="useDname" onclick="OZ.Organize.selectOUInfo(onSelectUseD)" styleClass="useDname oz-form-btField" styleId="useDname" style="width:100%"></html:text>
                                <html:hidden property="useD" styleId="useD"></html:hidden>
                            </td>
                        </tr>
                        <tr>
                            <td>已使用期限</td>
                            <td>
                            <html:text styleClass="oz-form-field" property="usefulLife" styleId="usefulLife" style="width:100%"></html:text>
                            </td>
                            <td>尚可使用年限</td>
                            <td>
                            <html:text styleClass="oz-form-field" property="canUseLife" styleId="canUseLife" style="width:100%"></html:text>
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
                                        <html:textarea styleClass="oz-form-field" property="faDescription" styleId="faDescription" style="width:100%"></html:textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>部门主管：</td>
                                        <td>
                                        <html:text styleClass="oz-form-field" property="putUnderCharge" styleId="putUnderCharge" style="width:100%"></html:text>
                                        </td>
                                        <td>部门负责人：</td>
                                        <td>
                                        <html:text styleClass="oz-form-field" property="putUnderDMH" styleId="putUnderDMH" style="width:100%"></html:text>
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
                                        <html:textarea styleClass="oz-form-field" property="sectorOpinion" styleId="sectorOpinion" style="width:100%"></html:textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>部门主管：</td>
                                        <td>
                                        <html:text styleClass="oz-form-field" property="useDCharge" styleId="useDCharge" style="width:100%"></html:text>
                                        </td>
                                        <td>部门负责人：</td>
                                        <td>
                                        <html:text styleClass="oz-form-field" property="useDMH" styleId="useDMH" style="width:100%"></html:text>
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
                                        <html:text styleClass="oz-form-field" property="originalValue" styleId="originalValue" style="width:100%"></html:text>
                                        </td>
                                        <td>填写人：</td>
                                        <td>
                                        <html:text styleClass="oz-form-field" property="financeFillPerson" styleId="financeFillPerson" style="width:100%"></html:text>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>净值</td>
                                        <td>
                                        <html:text styleClass="oz-form-field" property="netWorth" styleId="netWorth" style="width:100%"></html:text>
                                        </td>
                                        <td>部门负责人</td>
                                        <td>
                                        <html:text styleClass="oz-form-field" property="financeDMH" styleId="financeDMH" style="width:100%"></html:text>
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
                                        <html:textarea styleClass="oz-form-field" property="faApprovalOpinion" styleId="faApprovalOpinion" style="width:100%"></html:textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 70px">总经理：</td>
                                        <td>
                                        <html:textarea styleClass="oz-form-field" property="GM" styleId="GM" style="width:100%"></html:textarea>
                                        </td>
                                        <td>董事长：</td>
                                        <td>
                                        <html:textarea styleClass="oz-form-field" property="chairman" styleId="chairman" style="width:100%"></html:textarea>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                             <td>固定资产报废/<br>后存放地点</td>
                             <td colspan="3" height="50px">
                             <html:textarea styleClass="oz-form-field" property="faPlaceOfStorage" styleId="faPlaceOfStorage" style="width:100%"></html:textarea>
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
   </html:form>
</div>
</body>
<oz:organizeJs></oz:organizeJs>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<oz:js jsSrc="/ems/sell/js/ems.sell.FE.js"/>
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