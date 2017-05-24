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
   <oz:toolbar action="ems/scrapAction" defaultTB="readForm">
    </oz:toolbar>
</div>
<div id="page-center" class="oz-page-form">
    <html:form action="ems/scrapAction" styleId="ozForm" styleClass="oz-form">
        <div class="ems-form-main">
            <div class="ems-form-content">
                <div class="ems-form-head">
                    <img src="./common/res/suntakhead.jpg" alt="崇达"/>
                </div>
                <div class="ems-form-title">
                                                固定资产报废报告表
                </div>
                <div class="ems-form-body">
                    <table class="ems-table-head" >
                        <tr>
                            <td width="70%">编号：<bean:write  name="scrapForm" property="number"  format="0"/></td>
                            <td width="30%">合同编号：<bean:write  name="scrapForm" property="contractNumber" /></td>
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
                              <bean:write  name="scrapForm" property="fixedAssetsName" />
                            </td>
                            <td>规格型号</td>
                            <td>
                            <bean:write  name="scrapForm" property="specificationModel" />
                            </td>
                        </tr>
                        <tr>
                            <td>固定资产类别</td>
                            <td>
                            <bean:write  name="scrapForm" property="fixedAssetsType" />
                            </td>
                            <td>固定资产编号</td>
                            <td>
                            <bean:write  name="scrapForm" property="fixedAssetsNo" />
                            </td>
                        </tr>
                        <tr>
                            <td>数    量</td>
                            <td>
                            <bean:write  name="scrapForm" property="assetsNumber" format="0" />
                            </td>
                            <td>代  理  商</td>
                            <td>
                            <bean:write  name="scrapForm" property="agent" />
                            </td>
                        </tr>
                        <tr>
                            <td>原  产  地</td>
                            <td>
                            <bean:write  name="scrapForm" property="origin" />
                            </td>
                            <td>制  造  商</td>
                            <td>
                            <bean:write  name="scrapForm" property="manufacturer" />
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
                                        <td>是<html:radio property="isImported" value="1" disabled="true"/>  </td>
                                        <td>否<html:radio property="isImported" value="0" disabled="true"/></td>
                                    </tr>
                                    <tr>
                                        <td>报关单号：</td>
                                        <td>
                                        <bean:write  name="scrapForm" property="customsNo" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>行政部-关务负责人：</td>
                                        <td>
                                        <bean:write  name="scrapForm" property="customsPerson" />
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
                                        <td><html:radio property="isDevelop" value="1" disabled="true"/></td>
                                    </tr>
                                    <tr>
                                        <td>否</td>
                                        <td><html:radio property="isDevelop" value="0" disabled="true"/></td>
                                    </tr>
                                    <tr>
                                        <td>研发部负责人：</td>
                                        <td>
                                         <bean:write  name="scrapForm" property="RDPerson" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="line-height: 60px">固定资产工作原理<br>及主要技术指标</td>
                            <td colspan="3">
                            <bean:write  name="scrapForm" property="faTechnicalIndex" />
                            </td>
                        </tr>
                        <tr>
                            <td>开始使用时间</td>
                            <td>
                             <bean:write name="scrapForm" property="startTimeStr" format="yyyy-MM-dd"/>
                            </td>
                            <td>归口管理部门</td>
                            <td>
                            <bean:write  name="scrapForm" property="ascriptionMDname" />
                            </td>
                        </tr>
                        <tr>
                            <td>安装地点</td>
                            <td>
                            <bean:write  name="scrapForm" property="installationLocation" />
                            </td>
                            <td>使用 部门</td>
                            <td>
                            <bean:write  name="scrapForm" property="useDname" />
                            </td>
                        </tr>
                        <tr>
                            <td>已使用期限</td>
                            <td>
                            <bean:write  name="scrapForm" property="usefulLife" />
                            </td>
                            <td>尚可使用年限</td>
                            <td>
                            <bean:write  name="scrapForm" property="canUseLife" />
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
                                        <bean:write  name="scrapForm" property="faDescription" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>部门主管：</td>
                                        <td>
                                        <bean:write  name="scrapForm" property="putUnderCharge" />
                                        </td>
                                        <td>部门负责人：</td>
                                        <td>
                                        <bean:write  name="scrapForm" property="putUnderDMH" />
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
                                        <bean:write  name="scrapForm" property="sectorOpinion" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>部门主管：</td>
                                        <td>
                                        <bean:write  name="scrapForm" property="useDCharge" />
                                        </td>
                                        <td>部门负责人：</td>
                                        <td>
                                        <bean:write  name="scrapForm" property="useDMH" />
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
                                        <bean:write  name="scrapForm" property="originalValue" format="0.00" />
                                        </td>
                                        <td>填写人：</td>
                                        <td>
                                        <bean:write  name="scrapForm" property="financeFillPerson" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>净值</td>
                                        <td>
                                        <bean:write  name="scrapForm" property="netWorth" format="0.00" />
                                        </td>
                                        <td>部门负责人</td>
                                        <td>
                                        <bean:write  name="scrapForm" property="financeDMH" />
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
                                        <bean:write  name="scrapForm" property="faApprovalOpinion" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 70px">总经理：</td>
                                        <td>
                                        <bean:write  name="scrapForm" property="GM" />
                                        </td>
                                        <td>董事长：</td>
                                        <td>
                                        <bean:write  name="scrapForm" property="chairman" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                             <td>固定资产报废/<br>后存放地点</td>
                             <td colspan="3" height="50px">
                             <bean:write  name="scrapForm" property="faPlaceOfStorage" />
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