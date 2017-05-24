/**
 * 该函数库已经废弃,请使用oz.office.js来代替
 * 对Office控件支持的辅助函数
 * 
 * CD826 2012-06-21
 * 
 * @since 5.2.0
 */
(function() {

	oz.ocx = oz.ocx || {};

	oz.ocx.create = function(attributes, params, containerId) {
		attributes = attributes || {}
		params = params || {};

		// 组合控件属性
		var ocxAttribute = "";
		for ( var attr in attributes)
			ocxAttribute += ' ' + attr + '="' + attributes[attr] + '"';

		// 组合控件参数
		var ocxParam = "";
		for ( var param in params)
			ocxParam += '<param name="' + param + '" value="' + params[param] + '" />';

		var errMsg = '<span>对不起，系统不能加载文档控件，可能的原因是：';
		errMsg += '<li>当前浏览器不是IE浏览器，不支持该插件，请使用IE浏览器来访问本系统;</li>';
		errMsg += '<li>浏览器安全设置，请检查浏览器安全设置中是否勾选了：运行ActiveX控件和插件。</li>';
		errMsg += '</ol></span>';

		// 构建控件
		var _containerId = containerId || "officeContainer";
		$("#" + _containerId).append('<object ' + ocxAttribute + '>' + ocxParam + errMsg + '</object>');

		var officeOcx = document.getElementById(attributes.id);
		if (officeOcx && officeOcx.attachEvent) {
			return officeOcx;
		} else {
			return null;
		}
	};

	oz.ocx = $.extend(true, oz.ocx, {
		fman : {
			attributes : {
				id : "OFFICE_OCX",
				classid : "clsid:E8FD8E76-203A-48ed-9C39-481479080C34",
				codebase : contextPath + "/oz/apps/3rd/ntko/ntkofman.cab#version=4,0,0,3",
				width : "100%",
				height : "100%"
			},
			params : {
				MakerCaption : "广州嘉瑶软件有限公司",
				MakerKey : "73AF5FD2C90702EDBFBC1E1DD4FDAD68F54D3216",
				ProductCaption : "中国海洋石油总公司节能减排监测中心",
				ProductKey : "341D862CD524C4C178E26501837A34463E77083D",
				MaxUploadSize : 100000000,
				IsUseUTF8URL : true,
				IsUseUTF8Data : true,
				ViewType : 1,
				IsPermitAddDelFiles : true
			},
			create : function(containerId, attributes, params) {
				attributes = $.extend({}, this.attributes, attributes);
				params = $.extend({}, this.params, params);
				return oz.ocx.create(attributes, params, containerId)
			}
		}
	});

	oz.ocx = $.extend(true, oz.ocx, {
		office : {
			attributes : {
				id : "OFFICE_OCX",
				classid : "clsid:6AA93B0B-D450-4a80-876E-3909055B0640",
				codebase : contextPath + "/oz/apps/3rd/ntko/ofctnewclsid5.0.2.7.cab#version=5,0,2,7",
				width : "100%",
				height : "100%"
			},
			params : {
				MakerCaption : "广州嘉瑶软件有限公司",
				MakerKey : "73AF5FD2C90702EDBFBC1E1DD4FDAD68F54D3216",
				ProductCaption : "中国海洋石油总公司节能减排监测中心",
				ProductKey : "341D862CD524C4C178E26501837A34463E77083D",
				Titlebar : false,
				Toolbars : false,
				Menubar : false,
				FileNew : false,
				FileOpen : false,
				FileClose : false,
				FileSave : false,
				FileSaveAs : false,
				FilePrint : false,
				FilePrintPreview : false,
				IsUseUTF8URL : true,
				IsUseUTF8Data : true,
				IsResetToolbarsOnOpen : false,
				MenuButtonStyle : 3,
				MenuBarStyle : 3,
				MenuButtonColor : "15658734",
				MenuButtonFrameColor : "15658734",
				BorderStyle : 1
			},
			create : function(containerId, attributes, params) {
				attributes = $.extend({}, this.attributes, attributes);
				params = $.extend({}, this.params, params);
				return oz.ocx.create(attributes, params, containerId)
			},
			createOfficeOcx : function(params, containerId, objectId) {
				var officeAttributes = $.extend({}, oz.office.attributes);
				var officeParams = $.extend({}, oz.office.params, params);
				if (objectId) {
					officeAttributes.id = objectId;
				}
				return oz.ocx.create(officeAttributes, officeParams, containerId)
			},
			print : function(officeOcx) {
				try {
					if (null != officeOcx) {
						officeOcx.Activate(true);
						officeOcx.FilePrint = true;
						officeOcx.PrintOut(true);
						officeOcx.FilePrint = false;
					}
				} catch (err) {
					// alert("请确认是否安装有打印机。");
				}
			},
			updateBookmark : function(officeOcx, variables) {
				variables = variables || {};
				for ( var key in variables) {
					if (!officeOcx.ActiveDocument.BookMarks.Exists(key)) {
						continue;
					}
					var bkmkObj = officeOcx.ActiveDocument.BookMarks(key);
					var bookmarkRange = officeOcx.ActiveDocument.BookMarks(key).Range;
					bookmarkRange.Text = variables[key] || "";
					officeOcx.ActiveDocument.Bookmarks.Add(key, bookmarkRange);
				}
				officeOcx.ActiveDocument.Fields.Update();
			},
			showMsg : function(msg) {
				msg = msg || "文件加载失败";
				_containerId = _containerId || "officeContainer";
				$("#" + _containerId).html("<strong>" + msg + "</strong>");
			}
		}
	});

	oz.office = oz.office || {};
	//委托到oz.office
	$.extend(oz.office, oz.ocx.office);

})();