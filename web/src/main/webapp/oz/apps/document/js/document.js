/**
 * 文种映射转换操作操作
 * @param targetName
 */

function onFEBtnDocConvert_Clicked(targetName, param, cb) {
	OZ.Document.convert(targetName, param, cb);
}

function inState(state) {
	if (window._ozBpmTaskInfos && window._ozBpmTaskInfos.length > 0) {
		for (var i in _ozBpmTaskInfos) {
			var stateInfo = _ozBpmTaskInfos[i];
			if (stateInfo.name == state) {
				return true;
			}
		}
	}
	return false;
}

function updatePiInfos(callback) {
	$.getJSON(
	contextPath + "/document/documentInstanceAction.do?action=getPiInfoByFi&fiid=" + $("#id").val(), function(json) {
		if (json.result) {
			_ozBpmPiid = json.piId;
			_ozBpmPiStatus = json.piStatus;
			if (json.taskCount > 0) {
				_ozBpmTaskCount = json.taskCount;
				_ozBpmActivityInfos = json.activity;
				_ozBpmTaskInfos = json.ti;
			} else {
				_ozBpmTaskCount = 0;
				_ozBpmActivityInfos = [];
				_ozBpmTaskInfos = [];
			}
		}
		if ((typeof callback) == "function") {
			callback.call(this);
		}
	});
}

/**
 * 文种的核心方法
 */
(function() {
	window.oz = window.oz || {};

	function defaultCreate(classified, data) {
		var strUrl = contextPath + "/document/documentDefAction.do?action=list4Create&classified=" + classified;
		strUrl += "&timeStamp=" + new Date().getTime();
		OZ.openWindow({
			id: "document_create" + (new Date().getTime()),
			title: "新建文档",
			url: strUrl,
			refresh: true,
			beforeCloseFnName: "oz_Win_BeforeClose",
			data: data || {}
		});
	}

	oz.Document = oz.document = {
		/**
		 * 创建文档
		 * @param classified 文种文类编码
		 * @param srcDocType 来源文档类型
		 * @param srcDocId 来源文档Id
		 * @param srcSubject 源文档标题
		 * @param paramData 扩展的参数
		 */
		create: function(classified, srcDocType, srcDocId, srcSubject, relationShip, paramData) {
			var data = {
				srcDocType: srcDocType,
				srcDocId: srcDocId,
				srcSubject: srcSubject,
				relationShip: relationShip,
				paramData: paramData
			};
			defaultCreate(classified, data);
			return;
			if (classified) {
				$.getJSON(
				contextPath + "/document/documentDefAction.do?action=getDefinitionByCategory&classified=" + classified, function(json) {
					if (json.result && json.definitions.length == 1) {
						var dd = json.definitions[0];
						var strUrl = contextPath + "/form/formEngineAction.do?action=create&formKey=" + dd.formKey;
						strUrl += "&inceptionKey=" + dd.dvid + "&inceptionType=DocumentInstance";
						if (paramData) {
							strUrl += "&" + $.param(paramData);
						}
						strUrl += "&timeStamp=" + new Date().getTime();

						OZ.openWindow({
							id: "document_create" + (new Date().getTime()),
							title: "新建" + dd.name,
							url: strUrl,
							refresh: true,
							beforeCloseFnName: "oz_Win_BeforeClose",
							data: {
								srcDocType: srcDocType,
								srcDocId: srcDocId,
								srcSubject: srcSubject,
								relationShip: relationShip
							}
						});
					} else {
						defaultCreate(classified, data);
					}
				});
			} else {
				defaultCreate("", data);
			}
		},
		/**
		 * 通过编码创建文种对象
		 * @param code 编码
		 */
		createByCode: function(code, srcDocType, srcDocId, srcSubject, relationShip, paramData) {
			var data = {
				srcDocType: srcDocType,
				srcDocId: srcDocId,
				srcSubject: srcSubject,
				relationShip: relationShip,
				paramData: paramData
			};
			if (code) {
				$.getJSON(
				contextPath + "/document/documentDefAction.do?action=getDefinitionByCode&code=" + code, function(json) {
					if (json.result) {
						var dd = json;
						var strUrl = contextPath + "/form/formEngineAction.do?action=create&formKey=" + dd.formKey;
						strUrl += "&inceptionKey=" + dd.dvid + "&inceptionType=DocumentInstance";
						if (paramData) {
							strUrl += "&" + $.param(paramData);
						}
						strUrl += "&timeStamp=" + new Date().getTime();
						OZ.openWindow({
							id: "document_create" + (new Date().getTime()),
							title: "新建" + dd.name,
							url: strUrl,
							refresh: true,
							beforeCloseFnName: "oz_Win_BeforeClose",
							data: {
								srcDocType: srcDocType,
								srcDocId: srcDocId,
								srcSubject: srcSubject,
								relationShip: relationShip
							}
						});
					} else {
						defaultCreate("", data);
					}
				});
			} else {
				defaultCreate("", data);
			}
		},
		/**
		 * 通过文种表单示例的ID，使用对应的映射转换到对应的文档
		 * @param targetName 文种映射的名称
		 */
		convert: function(targetName, params, cb) {
			var self = this;
			if (targetName) {
				self.convertTo(targetName, params, cb);
				return;
			}
			var fiid = $("#id").val();
			var strUrl = contextPath + "/document/documentInstanceAction.do?action=dlgSelectTarget&fiid=" + fiid + "&timeStamp=" + new Date().getTime();
			new OZ.Dlg.create({
				id: "dlg_selectConvert",
				width: 200,
				height: 200,
				title: "选择转换目标",
				url: strUrl,
				onOk: function(result) {
					self.convertTo(result, params, cb);
				},
				onCancel: function(result) {
					// do nothing...
				}
			});
		},
		/**
		 * 通过文种表单示例的ID，使用对应的映射转换到对应的文档
		 * @param targetName 文种映射的名称
		 */
		convertTo: function(targetName, params, cb) {
			var callback = function() {
					var fiid = $("#id").val();
					params = params || {};
					$.extend(params, {
						target: targetName || "",
						fiid: fiid
					});
					var postUrl = contextPath + "/document/documentInstanceAction.do?action=transform&timeStamp=" + new Date().getTime();
					$.post(postUrl, params, function(result) {
						if ((typeof cb) == "function") {
							cb.call(null, result);
						} else {
							OZ.Msg.info(result.msg);
						}
					}, "json");
				}
			if (oz.form && oz.form.engine) {
				oz.form.engine.call(callback);
			} else {
				callback();
			}
		},
		inState: function(state) {
			if (window._ozBpmTaskInfos && _ozBpmTaskInfos.length > 0) {
				for (var i in _ozBpmTaskInfos) {
					var stateInfo = _ozBpmTaskInfos[i];
					if (stateInfo.name == state) {
						return true;
					}
				}
			}
			return false;
		}
	};
})();