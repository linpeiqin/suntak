<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" timePicker="true"/>
<head>
    <title>固定资产入厂报告表</title>
    <%@ include file="/oz/includes/meta.jsp"%>
    <oz:css/>
    <oz:css cssHref="/ems/common/css/ems-util.css"/>
</head>
<body class="oz-body" data-name="固定资产入厂报告表">
<div id="page-top" class="oz-page-top" >
    <oz:toolbar action="ems/intoFactoryAction" ><!-- defaultTB="readForm" -->
    	<oz:tbSeperator/>
		<oz:tbButton id="btnEdit"/>
    </oz:toolbar>
</div>
<div id="page-center" class="oz-page-form">
    <html:form action="ems/intoFactoryAction" styleId="ozForm" styleClass="oz-form">
        <div class="ems-form-main">
            <div class="ems-form-content">
                <div class="ems-form-head">
                    <img src="./common/res/suntakhead.jpg" alt="崇达"/>
                </div>
                <div class="ems-form-title">
                    固定资产入厂报告表
                </div>
                <div class="ems-form-body">
                    <table class="ems-table-head" >
                        <tr>
                            <td width="70%">编号：<bean:write name="intoFactoryForm" property="number" /></td>
                            <td width="30%">合同编号：<bean:write name="intoFactoryForm" property="contractNumber" /></td>
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
                                <bean:write name="intoFactoryForm" property="fixedAssetsName" />
                            </td>
                            <td>规 格 型 号</td>
                            <td>
                                <bean:write name="intoFactoryForm" property="specificationModel" />
                            </td>
                        </tr>
                        <tr>
                            <td>固定资产类别</td>
                            <td>
                                <bean:write name="intoFactoryForm" property="fixedAssetsType" />
                            </td>
                            <td>设备编号</td>
                            <td>
                                <bean:write name="intoFactoryForm" property="serialNumber" />
                            </td>
                        </tr>
                        <tr>
                            <td>数量</td>
                            <td>
                                <bean:write name="intoFactoryForm" property="assetsNumber" format="#"/>
                            </td>
                            <td>代 理 商</td>
                            <td>
                                <bean:write name="intoFactoryForm" property="agent" />
                            </td>
                        </tr>
                        <tr>
                            <td>原 产 地</td>
                            <td>
                                <bean:write name="intoFactoryForm" property="origin" />
                            </td>
                            <td>制 造 商</td>
                            <td>
                                <bean:write name="intoFactoryForm" property="manufacturer" />
                            </td>
                        </tr>
                        <tr>
                            <td rowspan="3">是否进口资产</td>
                            <td>是<html:radio property="isImported" value="1" disabled="true"/> 报关单号：
                                <bean:write name="intoFactoryForm" property="customsNo" />
                            </td>
                            <td rowspan="3">是否研发资产</td>
                            <td>是<html:radio property="isDevelop" value="1" disabled="true"/></td>
                        </tr>
                        <tr>
                            <td style="text-align: left">否<html:radio property="isImported" value="0" disabled="true"/>  </td>
                            <td>否<html:radio property="isDevelop" value="0" disabled="true"/></td>
                        </tr>
                        <tr>
                            <td style="text-align: left">行政部-关务负责人：
                                <bean:write name="intoFactoryForm" property="customsPerson" />
                            </td>
                            <td>研发部负责人：<bean:write name="intoFactoryForm" property="RDPerson" />
                            </td>
                        </tr>
                        <tr style="line-height: 60px">
                            <td>固定资产工作原理<br>及主要技术指标</td>
                            <td colspan="3">
                                <bean:write name="intoFactoryForm" property="WPATI" />
                            </td>
                        </tr>
                        <tr>
                            <td>入 厂 时 间</td>
                            <td>
                                <bean:write name="intoFactoryForm" property="intoFactoryTimeTime" format="yyyy-MM-dd"/>
                            </td>
                            <td>归口管理部门</td>
                            <td>
                                <bean:write name="intoFactoryForm" property="ascriptionMDname" />
                            </td>
                        </tr>
                        <tr>
                            <td>安 装 地 点</td>
                            <td>
                                <bean:write name="intoFactoryForm" property="installationLocation" />
                            </td>
                            <td>使 用 部 门</td>
                            <td>
                                <bean:write name="intoFactoryForm" property="useDname" />
                            </td>
                        </tr>
                        <tr>
                            <td>安装调试人员</td>
                            <td>
                                <bean:write name="intoFactoryForm" property="installationPersonnel" />
                            </td>
                            <td>预计使用年限</td>
                            <td>
                                <bean:write name="intoFactoryForm" property="estimateUsefulLife" />
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
                                        <td colspan="3">
                                            <bean:write name="intoFactoryForm" property="mainRecordIndex" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>测试记录：</td>
                                        <td colspan="3">
                                            <bean:write name="intoFactoryForm" property="testRecord" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>结论：</td>
                                        <td colspan="3">
                                            <bean:write name="intoFactoryForm" property="conclusion" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>检查/验收人：</td>
                                        <td>
                                            <bean:write name="intoFactoryForm" property="acceptancePersonT" />
                                        </td>
                                        <td>部门负责人：</td>
                                        <td>
                                            <bean:write name="intoFactoryForm" property="technicalMH" />
                                        </td>
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
                                    <tr>
                                        <td colspan="4" height="50px">
                                            <bean:write name="intoFactoryForm" property="putUnderD" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>检查/验收人：</td>
                                        <td>
                                            <bean:write name="intoFactoryForm" property="acceptancePersonM" />
                                        </td>
                                        <td>部门负责人：</td>
                                        <td>
                                            <bean:write name="intoFactoryForm" property="putUnderDMH" />
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
                                            <bean:write name="intoFactoryForm" property="useDOpinion" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>部门主管：</td>
                                        <td>
                                            <bean:write name="intoFactoryForm" property="useDCharge" />
                                        </td>
                                        <td>部门负责人：</td>
                                        <td>
                                            <bean:write name="intoFactoryForm" property="useDMH" />
                                        </td>
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
                                        <td>原 值<span>(<bean:write name="intoFactoryForm" property="currency"></bean:write>)</span></td>
                                        <td><bean:write name="intoFactoryForm" property="originalValue" format="0.0000"/>
                                        </td>
                                        <td rowspan="2">填写人：</td>
                                        <td rowspan="2">
                                            <bean:write name="intoFactoryForm" property="financeFillPerson" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>安装费用</td>
                                        <td>
                                            <bean:write name="intoFactoryForm" property="installationCost" format="0.0000"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>关 税</td>
                                        <td>
                                            <bean:write name="intoFactoryForm" property="tariff" format="0.0000"/>
                                        </td>
                                        <td  rowspan="3">部门负责人：</td>
                                        <td  rowspan="3">
                                            <bean:write name="intoFactoryForm" property="financeDMH" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>其 他</td>
                                        <td>
                                            <bean:write name="intoFactoryForm" property="other" format="0.0000"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>价值合计</td>
                                        <td>
                                            <bean:write name="intoFactoryForm" property="totalValue" format="0.0000"/>
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
                                            <bean:write name="intoFactoryForm" property="GM" />
                                        </td>
                                        <td>董事长：</td>
                                        <td>
                                            <bean:write name="intoFactoryForm" property="chairman" />
                                        </td>
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
    </html:form>
</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
</html>