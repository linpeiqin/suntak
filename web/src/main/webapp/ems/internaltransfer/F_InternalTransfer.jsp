<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true"/>
<head>
    <title>固定资产内部转移报告表</title>
    <%@ include file="/oz/includes/meta.jsp"%>
    <oz:css/>
    <oz:css cssHref="/ems/common/css/ems-util.css"/>
</head>
<body class="oz-body" data-name="固定资产内部转移报告表">
<div id="page-top" class="oz-page-top">
     <oz:toolbar action="ems/internalTransferAction" defaultTB="readForm">
    </oz:toolbar>
</div>
<div id="page-center" class="oz-page-form">
    <html:form action="ems/internalTransferAction" styleId="ozForm" styleClass="oz-form">
        <div class="ems-form-main">
            <div class="ems-form-content">
                <div class="ems-form-head">
                    <img src="./common/res/suntakhead.jpg" alt="崇达"/>
                </div>
                <div class="ems-form-title">
                                                  固定资产内部转移报告表
                </div>
                <div class="ems-form-body">
                    <table class="ems-table-head" >
                        <tr>
                            <td width="70%">编号：<bean:write name="internalTransferForm" property="number" format="0"/></td>
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
                            <bean:write name="internalTransferForm" property="fixedAssetsName" />
                            </td>
                            <td>规格型号</td>
                            <td>
                            <bean:write name="internalTransferForm" property="specificationModel" />
                            </td>
                        </tr>
                        <tr>
                            <td>固定资产类别</td>
                            <td>
                            <bean:write name="internalTransferForm" property="fixedAssetsType" />
                            </td>
                            <td>固定资产编号</td>
                            <td>
                            <bean:write name="internalTransferForm" property="fixedAssetsNo" />
                            </td>
                        </tr>
                        <tr>
                            <td>数    量</td>
                            <td>
                             <bean:write name="internalTransferForm" property="assetsNumber" format="0" />
                            </td>
                            <td>代  理  商</td>
                            <td>
                            <bean:write name="internalTransferForm" property="agent" />
                            </td>
                        </tr>
                        <tr>
                            <td>原  产  地</td>
                            <td>
                            <bean:write name="internalTransferForm" property="origin" />
                            </td>
                            <td>制  造  商</td>
                            <td>
                            <bean:write name="internalTransferForm" property="manufacturer" />
                            </td>
                        </tr>
                        <tr>
                            <td style="line-height: 60px">固定资产工作原理<br>及主要技术指标</td>
                            <td colspan="3">
                            <bean:write name="internalTransferForm" property="faPrincipleTechnology" />
                            </td>
                        </tr>
                        <tr>
                            <td>开始使用时间</td>
                            <td>
                            <bean:write name="internalTransferForm" property="startTimeStr" format="yyyy-MM-dd"/>
                            </td>
                            <td>归口管理部门</td>
                            <td>
                            <bean:write name="internalTransferForm" property="ascriptionMDname" />
                            </td>
                        </tr>
                        <tr>
                            <td>原安装地点</td>
                            <td>
                            <bean:write name="internalTransferForm" property="installationLocation" />
                            </td>
                            <td>原使用 部门</td>
                            <td>
                            <bean:write name="internalTransferForm" property="useDname" />
                            </td>
                        </tr>
                        <tr>
                            <td>新安装地点</td>
                            <td>
                            <bean:write name="internalTransferForm" property="newInstallationLocation" />
                            </td>
                            <td>新使用部门</td>
                            <td>
                            <bean:write name="internalTransferForm" property="newUseDname" />
                            </td>
                        </tr>
                        <tr>
                            <td>已使用期限</td>
                            <td>
                            <bean:write name="internalTransferForm" property="usefulLife" />
                            </td>
                            <td>尚可使用期限</td>
                            <td>
                            <bean:write name="internalTransferForm" property="canUseLife" />
                            </td>
                        </tr>
                       <tr>
                            <td>固定资产<br>内部转移情况说明<br>（归口管理部门填）</td>
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
                                        <bean:write name="internalTransferForm" property="faTransferExplain" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>部门主管：</td>
                                        <td>
                                        <bean:write name="internalTransferForm" property="putUnderCharge" />
                                        </td>
                                        <td>部门负责人：</td>
                                        <td>
                                        <bean:write name="internalTransferForm" property="putUnderDMH" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>原使用部门意见</td>
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
                                        <bean:write name="internalTransferForm" property="useDOpinion" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>部门主管：</td>
                                        <td>
                                        <bean:write name="internalTransferForm" property="useDCharge" />
                                        </td>
                                        <td>部门负责人：</td>
                                        <td>
                                        <bean:write name="internalTransferForm" property="useDMH" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>新使用部门意见</td>
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
                                        <bean:write name="internalTransferForm" property="newUseDOpinion" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>部门主管：</td>
                                        <td>
                                        <bean:write name="internalTransferForm" property="newUseDCharge" />
                                        </td>
                                        <td>部门负责人：</td>
                                        <td>
                                        <bean:write name="internalTransferForm" property="newUseDMH" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                         <tr>
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
                                        <bean:write name="internalTransferForm" property="originalValue" format="0.00"/>
                                        </td>
                                        <td>填写人：</td>
                                        <td>
                                        <bean:write name="internalTransferForm" property="financeFillPerson" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>净值</td>
                                        <td>
                                        <bean:write name="internalTransferForm" property="netWorth" format="0.00"/>
                                        </td>
                                        <td>部门负责人</td>
                                        <td>
                                        <bean:write name="internalTransferForm" property="financeDMH" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>固定资产内部转移<br>
                                批准意见
                            </td>
                            <td colspan="3" style="padding: 0px;border: 0px">
                                <table class="ems-table-sub1">
                                    <tr class="ems-table-sub1-head">
                                        <td width="20%" ></td>
                                        <td width="20%"></td>
                                        <td width="10%"></td>
                                        <td width="20%"></td>
                                        <td width="10%"></td>
                                        <td width="20%"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                        <bean:write name="internalTransferForm" property="faTransferOpinion" />
                                        </td>
                                        <td style="width: 10%">总经理：</td>
                                        <td style="width: 20%">
                                        <bean:write name="internalTransferForm" property="GM" />
                                        </td>
                                        <td style="width: 10%">董事长：</td>
                                        <td style="width: 20%">
                                        <bean:write name="internalTransferForm" property="chairman" />
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
   </html:form>
</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
</html>