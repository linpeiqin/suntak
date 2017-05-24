<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view" />
<html>
<head>
	<title>
		<oz:messageSource code="oz.comment.relationship"/>
	</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.comment.relationship"/>">
	<div id="page-center" class="oz-page-center">
		<oz:grid action="relationShipAction" sortName="createdDate" sortOrder="desc" fit="true">
			<oz:column field="id" checkbox="true" title=""/>
			<oz:column field="docType" title="oz.comment.relationship.associate.fields.doctype" width="100" sortable="true"  formatter="docIdFormatter"/>
			<oz:column field="subject" title="oz.comment.relationship.associate.fields.subject" width="300" sortable="false"  formatter="subjectFormatter"/>
			<oz:column field="author.id" title="oz.comment.relationship.associate.fields.author" width="100" sortable="true" formatter="authorFormatter"/>
			<oz:column field="createdDate" title="oz.comment.relationship.associate.fields.createddate" width="150" sortable="true"/>
		</oz:grid>
	</div>
</body>
<oz:js/>
<script type="text/javascript">
var docId = '<%=request.getAttribute("docId")%>';
var docType = '<%=request.getAttribute("docType")%>';
oz_grid_config.url = "<oz:contextPath/>/relationShipAction.do?action=page&docId="+docId+"&docType="+docType;

function docIdFormatter(value, rowData){
	return rowData.docTypeName || "";
}

function authorFormatter(value, rowData){
	return rowData.author.name || "";
}

function subjectFormatter(value, rowData, rowIndex, data){
	if(typeof value == "undefined")
		value = '(<oz:messageSource code="oz.comment.relationship.associate.no.subject"/>)';
	
	if(typeof rowData.openUrl == "undefined" || rowData.openUrl == "")
		return value;
	
	data = data || "";
	var title = value;
	var _href = "<a href='";
	_href += "javascript:OZ.openWindow({";
	_href += "url:\""+contextPath+rowData.openUrl + "\",";
	_href += "title:\""+oz_GetTabTitle(rowData) +"\",";
	_href += "id:\""+rowData.docType+"_"+rowData.docId + "\",";
	_href += "tabTip:\"" + title + "\",";
	_href += "refresh:true,";
	_href += "beforeCloseFnName:\"oz_Win_BeforeClose\",";
	_href += "data:\"" + data + "\"";
	_href += "})";
	_href += "'>" + value + "</a>";
    return _href;
}

function onRow_DBLClicked(rowIndex,rowData,data){
	data = data || "";
	OZ.openWindow({
		id: rowData.docType+"_"+rowData.docId,
		title: oz_GetTabTitle(rowData),
		url: contextPath+rowData.openUrl ,
		refresh: true,
		beforeCloseFnName:"oz_Win_BeforeClose",
		data:data
	});
}
</script>
</html>