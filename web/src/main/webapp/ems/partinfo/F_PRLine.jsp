<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" easyui="true"/>
<head>
<title>添加配件</title>
<%@ include file="/oz/includes/meta.jsp"%>
<oz:css />
<oz:css cssHref="/ems/common/css/ems-util.css" />
<oz:css cssHref="/ems/common/css/ems-view.css" />
</head>
<body  data-name="添加配件"  class="oz-body" class="oz-form-tabs"  style="margin-left: 0px;width:100%;height: 320px;border: 0px solid #99BBE8" >
<table  id="partsGrid"></table>
</body>
<oz:js />
<oz:js jsSrc="/ems/common/js/common.util.js" />
<oz:js jsSrc="/ems/partinfo/js/ems.prline.F.js" />
<oz:js jsSrc="/ems/common/js/common.V.js"/>
<oz:js jsSrc="/ems/common/js/common.view.js"/>
<script type="text/javascript">

</script>
</html>