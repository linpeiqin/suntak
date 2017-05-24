<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"  tree="true" datePicker="true" tabs="true" attachment="true"/>
<html>
<head>
    <title>
        备件采购申请
    </title>
    <%@ include file="/oz/includes/meta.jsp"%>
    <oz:css/>
    <oz:css cssHref="/ems/common/css/ems-view.css"/>
</head>
<body class="oz-body" data-name="备件采购申请">
<div id="page-top" class="oz-page-top">
    <oz:toolbar action="ems/pRHeadAction" searchButton="nomal">
        <oz:tbButton id="btnBack"/>
        <oz:tbSeperator/>
        <oz:tbButton id="btnDelete"/>
        <oz:tbSeperator/>
        <oz:tbButton id="btnNew"/>
        <oz:tbSeperator/>
        <oz:tbButton id="btnRefresh"/>
    </oz:toolbar>
</div>
<div id="page-center" class="oz-page-center">
    <oz:grid action="ems/pRHeadAction" sortName="id" fit="true"  excel="true">
        <oz:column field="id" checkbox="true" title="" width="27" />
        <oz:column field="ebsState" title="ebs同步状态" width="130" sortable="true" formatter="formatEbsStatus" />
        <oz:column field="prNo" title="申购单号" width="150" sortable="true"  formatter="oz_DefaultFormatter" />
        <oz:column field="deptName" title="申购部门" width="100" sortable="true"  formatter="oz_DefaultFormatter" />
        <oz:column field="applByName" title="申请人" width="100" sortable="true" formatter="oz_DefaultFormatter" />
        <oz:column field="prDate" title="申购日期" width="160" sortable="true" formatter="renderpublisherDate2"  />
        <oz:column field="needReason" title="用处说明" width="500" sortable="true" formatter="oz_DefaultFormatter"  />
    </oz:grid>
</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/partinfo/js/ems.prhead.V.js"/>
<script type="text/javascript">
</script>
</html>