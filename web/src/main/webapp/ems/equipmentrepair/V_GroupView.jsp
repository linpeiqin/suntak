<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"  tree="true" datePicker="true"/>
<html>
<head>
	<title>
		岗位人员选择
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssHref="/ems/common/css/ems-view.css"/>
</head>
<body class="oz-body" data-name="岗位人员选择">
	<div id="page-center" class="oz-page-center">
		<oz:grid action="ems/repairRecordAction" sortName="id" fit="true"  excel="true" singleSelect="true">
			<oz:column field="id" checkbox="true" title="" width="27" />
			<oz:column field="name" title="姓名" width="300" sortable="true" />
		</oz:grid>
	</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.util.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<script type="text/javascript">
    oz_grid_config.url = "<oz:contextPath/>/ems/repairRecordAction.do?action=page4User&groupCode=WXG";
    function ozDlgOkFn(){
        var rows = OZ.View.getGridSelection();
        if (rows.length==0){
            oz.Msg.info("请维修人员！");
            return false;
        }
        return {name:rows[0].name,id:rows[0].id};
    }
    function oz_Row_DBLClicked(rowIndex,rowData){
        ozDlgOkFn();
    }
</script>
</html>