package com.seeyon.www.action;

import java.util.Date;

import cn.oz.util.DateTimeUtils;
import cn.suntak.ems.completion.domain.Completion;

import com.seeyon.www.util.AxHelper;

public class test {

	/**
	 * @param args
	 */
	public static void main(String[] args) {

//        AxHelper.callOaInterface("EIntoFactory_01",getIntoFactory());

      /*  Completion c = new Completion();
		java.util.Date date = new Date();
//		System.out.println(date.toString());
		java.sql.Date dates = new java.sql.Date(date.getTime());
//		System.out.println(dates);
		c.setMakespan(date);
		System.out.println("11");
		System.out.println(c.getMakespan());
		System.out.println("22");
		System.out.println(c.getMakespanTime());*/
//		System.out.println(DateTimeUtils.formatDateTime(date));

	}

	//基础数据同步--工厂类别、供应商名称、供应商代码、固定资产类别
	//执行简报--没有表单
	//工程完工验收--工程-完工、验收-报告表
	//设备退货验收--固定资产-设备退货验收单--未发布
	//设备更新改造完工报告--固定资产更新改造-完工、验收-报告表
	//设备更新改造验收报告--固定资产更新改造-完工、验收-报告表
	//固定资产内部转移报告表--固定资产内部转移报告表
	//设备出售/报废申请单--固定资产-出售、报废报告表
	//设备入厂--固定资产-入厂、验收-报告表
	//设备验收--固定资产-入厂、验收-报告表
	private static String getIntoFactory(){
		StringBuffer sb = new StringBuffer();
		sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		sb.append("<formExport version=\"2.0\">");
		sb.append("<summary id=\"\" name=\"formmain_0169\"/>");
		sb.append("<values>");
		sb.append("<column name=\"入厂\">");
        sb.append("<value><![CDATA[0]]></value>");
        sb.append("</column>");
        sb.append("<column name=\"验收报告表\">");
        sb.append("<value><![CDATA[0]]></value>");
        sb.append("</column>");
        sb.append("<column name=\"编号\">");
        sb.append("<value><![CDATA[test11]]></value>");
        sb.append("</column>");
        sb.append("<column name=\"合同编号\">");
        sb.append("<value><![CDATA[010101]]></value>");
        sb.append("</column>");
        sb.append("<column name=\"固定资产名称\">");
        sb.append("<value><![CDATA[test]]></value>");
        sb.append("</column>");
        sb.append("<column name=\"规格型号\">");
        sb.append("<value><![CDATA[M-c01]]></value>");
        sb.append("</column>");
        sb.append("<column name=\"固定资产类别\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"固定资产编号\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"数量\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"代理商\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"原产地\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"制造商\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"入厂时间\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"归口管理部门\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"安装地点\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"使用部门\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"安装调试人员\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"预计使用年限\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"主要技术指标\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"测试记录\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"结论\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"检查验收人1\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"部门负责人1\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"检查验收人2\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"部门负责人2\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"部门主管\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"部门负责人3\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"原值\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"安装费用\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"填写人\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"部门负责人4\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"价值合计\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"分管副总子公司总经理\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"财务分管副总\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"董事长\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"关税\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"其他\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"是1\">");
        sb.append("<value><![CDATA[0]]></value>");
        sb.append("</column>");
        sb.append("<column name=\"报关单号\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"是2\">");
        sb.append("<value><![CDATA[0]]></value>");
        sb.append("</column>");
        sb.append("<column name=\"否1\">");
        sb.append("<value><![CDATA[0]]></value>");
        sb.append("</column>");
        sb.append("<column name=\"行政部-关务负责人\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"研发部负责人\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"否2\">");
        sb.append("<value><![CDATA[0]]></value>");
        sb.append("</column>");
        sb.append("<column name=\"固定资产工作原理及主要技术指标\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"技术部门验收人选择\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"需求报告\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"固定资产照片\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"验收报告\">");
        sb.append("<value/>");
        sb.append("</column>");
        sb.append("<column name=\"管理部门验收人选择\">");
        sb.append("<value><![CDATA[2136278285717815805]]></value>");
        sb.append("</column>");
        sb.append("</values>");
        sb.append("</formExport>");

    
    return sb.toString();
	}
}
