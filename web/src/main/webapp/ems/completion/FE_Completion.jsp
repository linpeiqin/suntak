<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true"/>
<head>
    <title>工程完工报告表</title>
    <%@ include file="/oz/includes/meta.jsp"%>
    <oz:css/>
    <oz:css cssHref="/ems/common/css/ems-util.css"/>
</head>
<body class="oz-body" data-name="工程完工报告表">
<div id="page-top" class="oz-page-top">
    <oz:toolbar action="ems/completionAction">
        <oz:tbSeperator/>
        <oz:tbButton id="btnBack"/>
        <oz:tbSeperator/>
        <oz:tbButton id="btnSave"/>
        <oz:tbSeperator/>
        <oz:tbButton id="btnSubmitEBS" icon="oz-icon oz-icon-0121" onclick="onSubmitEBS(this,'completion')" text="同步EBS"/>
        <oz:tbSeperator/>
  		<oz:tbButton id="btnSubmitOA" icon="oz-icon oz-icon-0121" onclick="onSubmitOA('EProjectFinish_99','completion','formmain_0153')" text="同步OA"/>
  		<oz:tbSeperator/>
    </oz:toolbar>
</div>
<div id="page-center" class="oz-page-form">
    <html:form action="ems/completionAction" styleId="ozForm" styleClass="oz-form">
        <div class="ems-form-main">
            <div class="ems-form-content">
                <div class="ems-form-head">
                    <img src="./common/res/suntakhead.jpg" alt="崇达"/>
                </div>
                <div class="ems-form-title">
                    工程完工报告表
                </div>
                <div class="ems-form-body">
                    <table class="ems-table-head" >
                        <tr>
                            <td width="70%">编号：<span id="numberSpan"><bean:write  name="completionForm" property="number" ></bean:write></span></td>
                            <td width="30%">合同编号： <html:text styleClass="oz-form-field" property="contractNumber" styleId="contractNumber"></html:text></td>
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
                            <td>工程项目名称</td>
                            <td colspan="3">
                                <html:text styleClass="oz-form-btfield" property="projectName" styleId="projectName" style="width:100%"></html:text>
                            </td>
                        </tr>
                        <tr>
                            <td>数    量</td>
                            <td>
                                <html:text styleClass="oz-form-field formatToInt" property="assetsNumber" styleId="assetsNumber" style="width:100%"></html:text>
                            </td>
                            <td>归口管理部门</td>
                            <td>
                                <html:select styleId="ascriptionMD" property="ascriptionMD" styleClass="oz-form-btField" style="width:100%">
                                    <html:optionsCollection name="departmentSelect" label="name" value="value" />
                                </html:select>
                            </td>
                        </tr>
                        <tr>
                            <td>承 包 单 位</td>
                            <td>
                                <html:text styleClass="oz-form-field" property="contractingUnit" styleId="contractingUnit" style="width:100%"></html:text>
                            </td>
                            <td>施 工 单 位</td>
                            <td>
                                <html:text styleClass="oz-form-field" property="constructionUnit" styleId="constructionUnit" style="width:100%"></html:text>
                            </td>
                        </tr>
                        <tr style="line-height: 60px">
                            <td >工作原理及主要<br>技术指标</td>
                            <td colspan="3">
                                <html:textarea styleClass="oz-form-field" property="WPT" styleId="WPT"></html:textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>开始施工时间</td>
                            <td>
                                <html:text styleClass="oz-dateTimeField oz-form-btfield" property="constructionStartTimeTime" styleId="constructionStartTimeTime" style="width:100%"></html:text>
                            </td>
                            <td>完 工 时 间</td>
                            <td>
                                <html:text styleClass="oz-dateTimeField" property="makespanTime" styleId="makespanTime" style="width:100%"></html:text>
                            </td>
                        </tr>
                        <tr>
                            <td>安 装 地 点</td>
                            <td>
                                <html:text styleClass="oz-form-btfield" property="installationLocation" styleId="installationLocation" style="width:100%"></html:text>
                            </td>
                            <td>使 用 部 门</td>
                            <td>
                                <html:select styleId="useD" property="useD" styleClass="oz-form-btField" style="width:100%">
                                    <html:optionsCollection name="departmentSelect" label="name" value="value" />
                                </html:select>
                            </td>
                        </tr>
                        <tr>
                            <td>安装调试人员</td>
                            <td>
                                <html:text styleClass="oz-form-field" property="installationPersonnel" styleId="installationPersonnel" style="width:100%"></html:text>
                            </td>
                            <td>预计使用年限</td>
                            <td>
                                <html:text styleClass="oz-form-field" property="estimateUsefulLife" styleId="estimateUsefulLife" style="width:100%"></html:text>
                            </td>
                        </tr>
                        <tr>
                            <td>工程效果<br>检查/验收情况<br>（技术部门填）<br>
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
                                        <td colspan="3">
                                            <html:textarea styleClass="oz-form-field" property="mainRecordIndex" styleId="mainRecordIndex" style="width:100%"></html:textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>测试记录：</td>
                                        <td colspan="3">
                                            <html:textarea styleClass="oz-form-field" property="testRecord" styleId="testRecord" style="width:100%"></html:textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>结论：</td>
                                        <td colspan="3">
                                            <html:textarea styleClass="oz-form-field" property="conclusion" styleId="conclusion" style="width:100%"></html:textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>检查/验收人：</td>
                                        <td>
                                            <html:text styleClass="oz-form-field" property="acceptancePersonT" styleId="acceptancePersonT" style="width:100%"></html:text>
                                        </td>
                                        <td>部门负责人：</td>
                                        <td>
                                            <html:text styleClass="oz-form-field" property="technicalMH" styleId="technicalMH" style="width:100%"></html:text>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>工程效果<br>检查/验收情况<br>（归口管理部门填）</td>
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
                                            <html:textarea styleClass="oz-form-field" property="engineeringInspection" styleId="engineeringInspection" style="width:100%"></html:textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>检查/验收人：</td>
                                        <td>
                                            <html:text styleClass="oz-form-field" property="acceptancePersonM" styleId="acceptancePersonM" style="width:100%"></html:text>
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
                                        <td colspan="4" height="100px">
                                            <html:textarea styleClass="oz-form-field" property="useDOpinion" styleId="useDOpinion" style="width:100%"></html:textarea>
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
                            <td>工程价值<br>
                                （财务部填）
                            </td>
                            <td colspan="3" style="padding: 0;border: 0">
                                <table class="ems-table-sub1">
                                    <tr class="ems-table-sub1-head">
                                        <td width="20%" ></td>
                                        <td width="30%"></td>
                                        <td width="20%"></td>
                                        <td width="30%"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" rowspan="2" height="100px">
                                            <html:textarea styleClass="oz-form-field" property="engineeringValue" styleId="engineeringValue" ></html:textarea>
                                        </td>
                                        <td style="text-align: center">填写人：</td>
                                        <td>
                                            <html:text styleClass="oz-form-field" property="financeFillPerson" styleId="financeFillPerson" style="width:100%"></html:text>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>部门负责人：</td>
                                        <td>
                                            <html:text styleClass="oz-form-field" property="financeDMH" styleId="financeDMH" style="width:100%"></html:text>
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
                                        <td  style="height: 70px">总经理：</td>
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
                            <td>工程项目资料</td>
                            <td>
                                <html:text styleClass="oz-form-field" property="projectInformation" styleId="projectInformation" style="width:100%"></html:text>
                            </td>
                            <td>接收人：</td>
                            <td>
                                <html:text styleClass="oz-form-field" property="recipient" styleId="recipient" style="width:100%"></html:text>
                            </td>
                        </tr>
                    </table>
                    <div style="height: 100px"></div>
                </div>
            </div>
        </div>
        <html:hidden property="id" styleId="id"/>
        <html:hidden property="type" styleId="type"/>
        <html:hidden property="equipmentId" styleId="equipmentId" value="${equipmentId}"/>
   </html:form>
</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<script type="text/javascript">
    function onBtnSave_Success(json){
        $('#numberSpan').html(json.number);
    }
</script>
</html>