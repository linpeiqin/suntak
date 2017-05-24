(function() {
	window.oz = window.oz || {};
	oz.config = oz.config || {};

	var doctype = oz.config.doctype = {};

	$.extend(doctype, {
		open:function(title,docType,fileId){
			OZ.openWindow({
				id: docType+fileId,
				title: title,
				url: OZ.addParamToUrl(contextPath+"/config/doctypeAction.do","action=openByDocType&doctype="+docType+"&fileId=" + fileId),
				refresh: false
			});
		}
	});
})();
