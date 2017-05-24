<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"  tree="true" datePicker="true" tabs="true" attachment="true" easyui="true"/>
<html>
<head>
	<title>
		资产详细信息
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssHref="/ems/common/css/ems-view.css"/>
</head>
<body class="oz-body" data-name="资产详细信息">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/equipmentDetailsAction" ><!--searchButton="nomal"-->
			<oz:tbButton id="btnBack"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnCreateEquip" icon="oz-icon oz-icon-0102"  text="添加设备" onclick="ozTB_BtnNew_Clicked(this)"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnDoCanel" icon="oz-icon oz-icon-0903"  onclick="disableEquip()" text="停用"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnDoCanel" icon="oz-icon oz-icon-0901"  onclick="enableEquip()" text="启用"/>
			<oz:tbSeperator/>
			<oz:tbSelect id="useDText" text="使用部门: " style="width :80;" options="useDSelect" blankOption="true" />
			<oz:tbSeperator/>
			<oz:tbSelect id="procedureText" text="工序: " style="width :80;" options="procedureSelect" blankOption="true" />
			<oz:tbSeperator/>
			<oz:tbSeperator/>
		</oz:toolbar>
	</div>

	<div id="page-center" class="oz-page-center">
		<div id="page-center-tree" class="oz-page-center-tree">
			<ul id="naviTree">
			</ul>
		</div>
		<div id="page-center-seperator" class="oz-page-center-seperator"></div>
		<div id="page-center-grid" class="oz-page-center-grid">
		<oz:grid action="ems/equipmentDetailsAction" sortName="equipmentName" fit="true"  excel="true" id="eqNo" pageSize="10">
			<oz:column field="id" checkbox="false"  title="" width="27"  />
			<oz:column field="equipmentName" title="资产名称" width="180" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="equipmentAlias" title="资产别名" width="100" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="serialNo" title="机身编号" width="100" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="equipmentNo" title="设备编号" width="100" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="specificationModel" title="规格型号" width="110" sortable="true" formatter="oz_DefaultFormatter"/>
			<oz:column field="manufacturer" title="生产厂商" width="180" sortable="true" />
			<oz:column field="installationLocation" title="安装地点" width="100" sortable="true"/>
			<oz:column field="procedure" title="使用工序" width="100" sortable="true"/>
			<oz:column field="ebsEntity.managerD" title="管理部门" width="80" sortable="true" />
			<oz:column field="ebsEntity.userD" title="使用部门" width="80" sortable="true" />
			<oz:column field="suppliers" title="供应商" width="80" sortable="true"  />
			<oz:column field="ebsEntity.originalValue" title="资产原值" width="80" sortable="true" />
			<oz:column field="ebsEntity.netWorth" title="资产净值" width="80" sortable="true" />
			<oz:column field="ebsEntity.deprectationMethod" title="折旧方式" width="80" sortable="true" />
			<oz:column field="ebsEntity.canUseLife" title="折旧年限" width="80" sortable="true" />
			<oz:column field="assetId" title="资产编号" width="80" sortable="true" />
			<oz:column field="startTime" title="购置时间" width="80" sortable="true" formatter="renderpublisherDate2" />
			<oz:column field="type" title="资产状态" width="60" sortable="true" formatter="type_formatter"/>
			<oz:column field="contractNo" title="合同编号" width="100" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="equipmentType" title="资产类别" width="120" sortable="true" formatter="oz_DefaultFormatter"/>
			<oz:column field="instructions" title="是否有说明书"  width="30" sortable="true"   formatter="fommaterForInstructions" />
			<oz:column field="remark" title="备注" width="80" sortable="true" formatter="oz_DefaultFormatter"/>
		</oz:grid>
		</div>
        <div id="moveLine"class="oz-layout-split-north" style="position: absolute">
            <div class="oz-layout-mini-north">&nbsp;</div>
        </div>
        <div id="tabCt" class="border" style="position: absolute">
            <div data-tab-panel='{"id":"tab_01","title":"生命周期","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
                <iframe id="IFRAME_01" class="oz-tab-iframe" height="100%" width="100%" frameborder="0">
                </iframe>
            </div>
            <div data-tab-panel='{"id":"tab_02","title":"扩展参数","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
                <iframe id="IFRAME_02" class="oz-tab-iframe" height="100%" width="100%" frameborder="0">
                </iframe>
            </div>
            <div data-tab-panel='{"id":"tab_03","title":"维修记录","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
                <iframe id="IFRAME_03" class="oz-tab-iframe" height="100%" width="100%" frameborder="0">
                </iframe>
            </div>
			<div data-tab-panel='{"id":"tab_09","title":"保养记录","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
				<iframe id="IFRAME_09" class="oz-tab-iframe" height="100%" width="100%" frameborder="0">
				</iframe>
			</div>
            <div data-tab-panel='{"id":"tab_04","title":"保养计划","border":false,"fit":false,"iconCls":"oz-icon-tab"}'>
                <iframe id="IFRAME_04" class="oz-tab-iframe" height="100%" width="100%" frameborder="0">
                </iframe>
            </div>
            <div data-tab-panel='{"id":"tab_05","title":"附件(说明书等)","border":false,"fit":false,"iconCls":"oz-icon-tab"}'>
                <iframe id="IFRAME_05" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" >
                </iframe>
            </div>
            <div data-tab-panel='{"id":"tab_06","title":"配件更换记录","border":false,"fit":false,"iconCls":"oz-icon-tab"}'>
                <iframe id="IFRAME_06" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" >
                </iframe>
            </div>
            <div data-tab-panel='{"id":"tab_07","title":"辅机设备","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
                <iframe id="IFRAME_07" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" >
                </iframe>
            </div>
            <div data-tab-panel='{"id":"tab_08","title":"关联配件","border":false,"fit":true,"iconCls":"oz-icon-tab"}'>
                <iframe id="IFRAME_08" class="oz-tab-iframe" height="100%" width="100%" frameborder="0" >
                </iframe>
            </div>
        </div>
    </div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/equipmentdetails/js/ems.equipmentdetails.V.js"/>
<script type="text/javascript">

	function type_formatter(value, json){
		if (value==null || value=="")
			return "待入厂";
		else if (value==0){
			return "待入厂";
		}
		else if (value==1){
			return "待验收";
		}
		else if (value==2){
			return "使用中";
		}else if (value==3){
			return "报废";
		}
		else if (value==4){
			return "出售";
		}
		else if (value==5){
			return "待更新";
		}
		else if (value==6){
			return "更新验收";
		}else if (value==9){
			return "停用";
		}
	}
</script>
</html>