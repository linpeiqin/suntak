<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view"  tree="true" datePicker="true" tabs="true" attachment="true"/>
<html>
<head>
	<title>
		配件详细信息
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
	<oz:css cssHref="/ems/common/css/ems-view.css"/>
</head>
<body class="oz-body" data-name="配件详细信息">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/partInfoAction" searchButton="nomal">
		</oz:toolbar>
	</div>
	<div id="page-center" class="oz-page-center">
		<oz:grid action="ems/partInfoAction" sortName="partNo" fit="true"  excel="true" >
			<oz:column field="id" checkbox="${checkboxBln }" title="" width="27" />
			<oz:column field="itemId" title="ebs物料ID" width="80" hidden="true"  />
			<oz:column field="partNo" title="配件编号" width="80" sortable="true"  />
			<oz:column field="partName" title="配件名称" width="410" sortable="true" />
			<oz:column field="UOMCode" title="单位" width="80" hidden="true"  />
			<oz:column field="organizationId" title="组织id" width="80" hidden="true"  />
            <oz:column field="price" title="单价" width="120" sortable="true" />
			<oz:column field="onhandQty" title="本地现有量" width="80" sortable="true" />
			<oz:column field="onroadQty" title="本地在途量" width="80" sortable="true" />
			<oz:column field="totalOnhandQty" title="集团总现有量" width="80" sortable="true" />
		</oz:grid>
	</div>
</body>
<oz:js/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<script type="text/javascript">
	function ozDlgOkFn() {
		var rows = OZ.View.getGridSelection();
		if (rows.length == 0) {
			oz.Msg.info("请选择备件！");
			return false;
		}
		var res = [];
		for (var i=0;i< rows.length;i++){
            var re = {};
            re.partNo = rows[i].partNo;
            re.partName = rows[i].partName;
            re.price = rows[i].price;
            re.UOMCode = rows[i].UOMCode;
			re.partId =  rows[i].id;
			re.itemId = rows[i].itemId;
            re.organizationId = rows[i].organizationId;
            res.push(re);
        }
		return res;
	}
	function oz_Row_DBLClicked(rowIndex,rowData){
		ozDlgOkFn();
	}
</script>
</html>