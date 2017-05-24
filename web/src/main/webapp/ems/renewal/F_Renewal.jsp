<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" datePicker="true"/>
<head>
    <title>固定资产更新改造报告表</title>
    <%@ include file="/oz/includes/meta.jsp"%>
    <oz:css/>
    <oz:css cssHref="/ems/common/css/ems-util.css"/>
</head>
<body class="oz-body" data-name="固定资产更新改造报告表">
<div id="page-top" class="oz-page-top">
     <oz:toolbar action="ems/renewalAction" defaultTB="readForm">
    </oz:toolbar>
</div>
<div id="page-center" class="oz-page-form">
    <html:form action="ems/renewalAction" styleId="ozForm" styleClass="oz-form">
        <div class="ems-form-main">
            <div class="ems-form-content">
                <div class="ems-form-head">
                    <img src="./common/res/suntakhead.jpg" alt="崇达"/>
                </div>
                <div class="ems-form-title">
                                                固定资产更新改造报告表
                </div>
                <div class="ems-form-body">
                    <table class="ems-table-head" >
                        <tr>
                            <td width="70%">编号：<bean:write  name="renewalForm" property="number" /></td>
                            <td width="30%">合同编号：<bean:write  name="renewalForm" property="contractNumber" /> </td>
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
                            <bean:write  name="renewalForm" property="fixedAssetsName" />
                            </td>
                            <td>规格型号</td>
                            <td>
                            <bean:write  name="renewalForm" property="specificationModel" />
                            </td>
                        </tr>
                        <tr>
                            <td>固定资产类别</td>
                            <td>
                            <bean:write  name="renewalForm" property="fixedAssetsType" />
                            </td>
                            <td>设备编号</td>
                            <td>
                            <bean:write  name="renewalForm" property="serialNumber" />
                            </td>
                        </tr>
                        <tr>
                            <td>数    量</td>
                            <td>
                            <bean:write  name="renewalForm" property="assetsNumber" format="#"/>
                            </td>
                            <td>供应商</td>
                            <td>
                            <bean:write  name="renewalForm" property="agent" />
                            </td>
                        </tr>
                        <tr>
                            <td>更新改造项目</td>
                            <td>
                             <bean:write  name="renewalForm" property="origin" />
                            </td>
                            <td>改造商</td>
                            <td>
                            <bean:write  name="renewalForm" property="manufacturer" />
                            </td>
                        </tr>
                        <tr>
                            <td style="line-height: 60px">固定资产更新改<br>造工作内容</td>
                            <td colspan="3">
                            <bean:write  name="renewalForm" property="faUpdateContent" />
                            </td>
                        </tr>
                        <tr>
                            <td>改造完成时间</td>
                            <td>
                            <bean:write name="renewalForm" property="startTimeTime" format="yyyy-MM-dd"/>
                            </td>
                            <td>归口管理部门</td>
                            <td>
                            <bean:write  name="renewalForm" property="ascriptionMDname" />
                            </td>
                        </tr>
                        <tr>
                            <td>安装地点</td>
                            <td>
                            <bean:write  name="renewalForm" property="installationLocation" />
                            </td>
                            <td>使用 部门</td>
                            <td>
                            <bean:write  name="renewalForm" property="useDname" />
                            </td>
                        </tr>
                        <tr>
                            <td>已使用期限</td>
                            <td>
                            <bean:write  name="renewalForm" property="usefulLife" />
                            </td>
                            <td>尚可使用年限</td>
                            <td>
                            <bean:write  name="renewalForm" property="canUseLife" />
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
                                        <bean:write  name="renewalForm" property="mainRecordIndex" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>测试记录：</td>
                                        <td colspan = "3">
                                        <bean:write  name="renewalForm" property="testRecord" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>结论：</td>
                                        <td colspan = "3">
                                        <bean:write  name="renewalForm" property="conclusion" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>检查/验收人：</td>
                                        <td>
                                        <bean:write  name="renewalForm" property="acceptancePersonT" />
                                        </td>
                                        <td>部门负责人：</td>
                                        <td>
                                        <bean:write  name="renewalForm" property="technicalMH" />
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
                                        <bean:write  name="renewalForm" property="sectorOpinion" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>检查/验收人：</td>
                                        <td>
                                        <bean:write  name="renewalForm" property="acceptancePersonM" />
                                        </td>
                                        <td>部门负责人：</td>
                                        <td>
                                        <bean:write  name="renewalForm" property="putUnderDMH" />
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
                                        <bean:write  name="renewalForm" property="useDOpinion" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>部门主管：</td>
                                        <td>
                                        <bean:write  name="renewalForm" property="useDCharge" />
                                        </td>
                                        <td>部门负责人：</td>
                                        <td>
                                        <bean:write  name="renewalForm" property="useDMH" />
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
                                        <bean:write  name="renewalForm" property="originalValue" format="0.00" />
                                        </td>
                                        <td>填写人：</td>
                                        <td>
                                        <bean:write  name="renewalForm" property="financeFillPerson"  />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>净值</td>
                                        <td>
                                        <bean:write  name="renewalForm" property="netWorth" format="0.00" />
                                        </td>
                                        <td>部门负责人</td>
                                        <td>
                                        <bean:write  name="renewalForm" property="financeDMH"  />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>新增价值</td>
                                        <td colspan = "3">
                                        <bean:write  name="renewalForm" property="addedValue" format="0.00" />
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
                                        <bean:write  name="renewalForm" property="GM" />
                                        </td>
                                        <td>董事长：</td>
                                        <td style="height: 70px">
                                         <bean:write  name="renewalForm" property="chairman" />
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