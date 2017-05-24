<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"  tree="true" datePicker="true" tabs="true" attachment="true"/>
<html>
<head>
	<title>
		申购单
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssHref="/ems/common/css/ems-view.css"/>
</head>
<body class="oz-body" data-name="申购单">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/pRLineAction" searchButton="nomal">
		    <oz:tbButton id="btnBack"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnDelete"/>
			<oz:tbSeperator/>
			<oz:tbButton id="btnNewPr" icon="oz-icon oz-icon-0102" onclick="onBtnNewClick()" text="新建" />
			<oz:tbSeperator/>
			<oz:tbButton id="btnRefresh"/>
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="ems/pRLineAction" sortName="id" fit="true"  excel="true" >
			<oz:column field="id" checkbox="true" title="" width="27" />
			<oz:column field="pRHead.id" hidden="true" />
			<oz:column field="pRHead.ebsState" title="ebs同步状态" width="130" sortable="true" formatter="formatEbsStatus" />
		<%-- 	<oz:column field="pRHead.approveStatus" title="审核状态" width="100" sortable="true" formatter="oz_DefaultFormatter" /> --%>
			<oz:column field="itemName" title="配件名称" width="350" sortable="true" formatter="oz_DefaultFormatter" />
		 	<oz:column field="itemNo" title="配件编号" width="140" sortable="true" formatter="oz_DefaultFormatter"  />
			<oz:column field="qty" title="数量" width="100" sortable="true" formatter="oz_DefaultFormatter"  />
<%-- 			<oz:column field="pRHead.vendorName" title="供应商名称" width="100" sortable="true" formatter="oz_DefaultFormatter" /> --%>
<%-- 			<oz:column field="pRHead.prNo" title="单据编号" width="100" sortable="true"  formatter="oz_DefaultFormatter" /> --%>
			<oz:column field="pRHead.deptName" title="申购部门" width="100" sortable="true"  formatter="oz_DefaultFormatter" />
			<oz:column field="pRHead.applByName" title="申请人" width="100" sortable="true" formatter="oz_DefaultFormatter" />
			<oz:column field="pRHead.prDate" title="申购日期" width="160" sortable="true" formatter="renderpublisherDate2"  />
<%-- 			<oz:column field="promisedDate" title="需要日期" width="100" sortable="true"  formatter="renderpublisherDate"  /> --%>
<%-- 			<oz:column field="pRHead.remark" title="摘要" width="100" sortable="true" formatter="oz_DefaultFormatter" /> --%>
		</oz:grid>
	</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/partinfo/js/ems.prline.V.js"/>
<script type="text/javascript">
</script>
</html>