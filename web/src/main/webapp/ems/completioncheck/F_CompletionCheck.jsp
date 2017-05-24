<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true"/>
<head>
    <title>工程完工验收报告表</title>
    <%@ include file="/oz/includes/meta.jsp"%>
    <oz:css/>
    <oz:css cssHref="/ems/common/css/ems-util.css"/>
</head>
<body class="oz-body" data-name="工程完工验收报告表">
<div id="page-top" class="oz-page-top" >
    <oz:toolbar action="ems/completionCheckAction" defaultTB="readForm">
    </oz:toolbar>
</div>
<div id="page-center" class="oz-page-form">
    <html:form action="ems/completionCheckAction" styleId="ozForm" styleClass="oz-form">
        <div class="ems-form-main">
            <div class="ems-form-content">
                <div class="ems-form-head">
                    <img src="./common/res/suntakhead.jpg" alt="崇达"/>
                </div>
                <div class="ems-form-title">
                    工程完工验收报告表
                </div>
                <div class="ems-form-body">
                    <table class="ems-table-head" >
                        <tr>
                            <td width="70%">编号：<bean:write name="completionCheckForm" property="number" /></td>
                            <td width="30%">合同编号： <bean:write name="completionCheckForm" property="contractNumber" /></td>
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
                                <bean:write name="completionCheckForm" property="projectName" />
                            </td>
                        </tr>
                        <tr>
                            <td>数    量</td>
                            <td>
                                <bean:write name="completionCheckForm" property="assetsNumber" format="#"/>
                            </td>
                            <td>归口管理部门</td>
                            <td>
                                <bean:write name="completionCheckForm" property="ascriptionMD" />
                            </td>
                        </tr>
                        <tr>
                            <td>承 包 单 位</td>
                            <td>
                                <bean:write name="completionCheckForm" property="contractingUnit" />
                            </td>
                            <td>施 工 单 位</td>
                            <td>
                                <bean:write name="completionCheckForm" property="constructionUnit" /><bean:write name="completionCheckForm" property="contractNumber" />
                            </td>
                        </tr>
                        <tr>
                            <td>工作原理及主要<br>技术指标</td>
                            <td colspan="3">
                                <bean:write name="completionCheckForm" property="WPT" />
                            </td>
                        </tr>
                        <tr>
                            <td>开始施工时间</td>
                            <td>
                                <bean:write name="completionCheckForm" property="constructionStartTime" format="yyyy-MM-dd"/>
                            </td>
                            <td>完 工 时 间</td>
                            <td>
                                <bean:write name="completionCheckForm" property="makespan"  format="yyyy-MM-dd"/>
                            </td>
                        </tr>
                        <tr>
                            <td>安 装 地 点</td>
                            <td>
                                <bean:write name="completionCheckForm" property="installationLocation" />
                            </td>
                            <td>使 用 部 门</td>
                            <td>
                                <bean:write name="completionCheckForm" property="useD" />
                            </td>
                        </tr>
                        <tr>
                            <td>安装调试人员</td>
                            <td>
                                <bean:write name="completionCheckForm" property="installationPersonnel" />
                            </td>
                            <td>预计使用年限</td>
                            <td>
                                <bean:write name="completionCheckForm" property="estimateUsefulLife" />
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
                                            <bean:write name="completionCheckForm" property="mainRecordIndex" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>测试记录：</td>
                                        <td colspan="3">
                                            <bean:write name="completionCheckForm" property="testRecord" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>结论：</td>
                                        <td colspan="3">
                                            <bean:write name="completionCheckForm" property="conclusion" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>检查/验收人：</td>
                                        <td>
                                            <bean:write name="completionCheckForm" property="acceptancePersonT" />
                                        </td>
                                        <td>部门负责人：</td>
                                        <td>
                                            <bean:write name="completionCheckForm" property="technicalMH" />
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
                                        <td colspan="4" height="50px">
                                            <bean:write name="completionCheckForm" property="engineeringInspection" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>检查/验收人：</td>
                                        <td>
                                            <bean:write name="completionCheckForm" property="acceptancePersonM" />
                                        </td>
                                        <td>部门负责人：</td>
                                        <td>
                                            <bean:write name="completionCheckForm" property="putUnderDMH" />
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
                                            <bean:write name="completionCheckForm" property="useDOpinion" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>部门主管：</td>
                                        <td>
                                            <bean:write name="completionCheckForm" property="useDCharge" />
                                        </td>
                                        <td>部门负责人：</td>
                                        <td>
                                            <bean:write name="completionCheckForm" property="useDMH" />
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
                                        <td colspan="2" rowspan="2">
                                            <bean:write name="completionCheckForm" property="engineeringValue" />
                                        </td>
                                        <td style="text-align: center">填写人：</td>
                                        <td>
                                            <bean:write name="completionCheckForm" property="financeFillPerson" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>部门负责人：</td>
                                        <td>
                                            <bean:write name="completionCheckForm" property="financeDMH" />
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
                                        <td>
                                            <bean:write name="completionCheckForm" property="GM" />
                                        </td>
                                        <td>董事长：</td>
                                        <td>
                                            <bean:write name="completionCheckForm" property="chairman" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>工程项目资料</td>
                            <td>
                                <bean:write name="completionCheckForm" property="projectInformation" />
                            </td>
                            <td>接收人：</td>
                            <td>
                                <bean:write name="completionCheckForm" property="recipient" />
                            </td>
                        </tr>
                    </table>
                    <div style="height: 100px"></div>
                </div>
            </div>
        </div>
        <html:hidden property="id" styleId="id"/>
    </html:form>
</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
</html>