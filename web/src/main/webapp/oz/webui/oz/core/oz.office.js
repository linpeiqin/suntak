/** 
 * 对Office控件支持的辅助函数
 * 
 * CD826 2012-06-21
 * @since 5.2.0
 */

window.oz = window.oz || {};

(function(){
	var officeOcx = function(id, params){
		this.id = id;
		this.params = params;
		this.trackRevisions = false;
		this.officeOcx = null;
		this.create();
	}
	
	officeOcx.prototype.create = function (){
		$("#" + this.id).data("officeOcx", this);
		
		var officeAttributes = {
			id : "OFFICE_OCX",
			classid : "clsid:6AA93B0B-D450-4a80-876E-3909055B0640",
			codebase : contextPath + "/oz/apps/3rd/ntko/ofctnewclsid5.0.2.7.cab#version=5,0,2,7",
			width : "100%",
			height : "100%"
		};
			
		var officeParams = {
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
		};
		officeParams = $.extend(officeParams, this.params);
		
		// 组合控件属性
		var ocxAttribute = "";
		for (var attr in officeAttributes)
			ocxAttribute += ' ' + attr + '="' + officeAttributes[attr] + '"';
		
		// 组合控件参数
		var ocxParam = "";
		for (var param in officeParams)
			ocxParam += '<param name="' + param + '" value="' + officeParams[param] + '" />';
		
		var errMsg = '';
		errMsg += '<span>对不起，系统不能加载文档控件，可能的原因是：';
		errMsg += '    <ul>';
		errMsg += '        <li>当前浏览器不是IE浏览器，不支持该插件，请使用IE浏览器来访问本系统;</li>';
		errMsg += '        <li>浏览器安全设置，请检查浏览器安全设置中是否勾选了：运行ActiveX控件和插件。</li>';
		errMsg += '    </ul>';
		errMsg += '</span>';
		
		// 构建控件
		$("#" + this.id).append('<object ' + ocxAttribute + '>' + ocxParam + errMsg + '</object>');
		var officeOcx = document.getElementById(officeAttributes.id);
		if(officeOcx && officeOcx.attachEvent){
			this.officeOcx = officeOcx;
			return this;
		}else{
			this.officeOcx = null;
			return null;
		}
	}
	
	officeOcx.prototype.getOcx = function (){
		return this.officeOcx;
	}
	
	/**
	 * 创建
	 */
	officeOcx.prototype.createNew = function (fileType){
		if(null == this.officeOcx){
			alert("对不起，当前Office控件尚未初始化。")
			return;
		}
		
		fileType = fileType.toLowerCase();
		if(fileType == "word" || fileType == "doc"){
			this.officeOcx.CreateNew("Word.Document");	
		}else if(fileType == "excel" || fileType == "xls"){
			this.officeOcx.CreateNew("Excel.Sheet");
		}else if(fileType == "powerpoint" || fileType == "ppt"){
			this.officeOcx.CreateNew("PowerPoint.Show");
		}else{
			alert("未知文件类型(可用文件类型有:doc、xls、ppt)")
		}
	}
	
	/**
	 * 打开指定的文档
	 */
	officeOcx.prototype.open = function(url, readonly){
		if(null == this.officeOcx){
			alert("对不起，当前Office控件尚未初始化，不能够加载文件。")
			return;
		}
		
		var isReadonly = "true";
		if(!readonly)
			isReadonly = "false";
		this.officeOcx.OpenFromURL(url, isReadonly);
		if (0 != this.officeOcx.StatusCode) {
			this.showMsg("");
		}
		if(readonly){
			this.officeOcx.ActiveDocument.ShowRevisions = false;
			this.officeOcx.SetReadOnly(true, "");
		}
	}

	/**
	 * 保存
	 */
	officeOcx.prototype.save = function(saveUrl, formData, fileName, callback){
		if(!this.isValidate())
			return;
		
		try {
			var officeOcx = this.officeOcx;
			var result = officeOcx.SaveToURL(saveUrl, "EDITFILE", formData, fileName);
			if (0 == officeOcx.StatusCode) {
				eval("var json=" + result);
				if((typeof callback) == "function"){
					callback.call(this, json);
				}
			}
		} catch (err) {
			alert("文件保存失败，错误原因：" + err.number + "，" + err.description);
		}
	}
	
	/**
	 * 另存为
	 */
	officeOcx.prototype.saveAs = function(){
		if(!this.isValidate())
			return;
		
		try {
			var officeOcx = this.officeOcx;
			officeOcx.CancelLastCommand = true;
			officeOcx.FileSaveAs = true;
			var doctype = officeOcx.DocType;
			if (doctype == 1) {
				officeOcx.ShowDialog(3);// “另存为”对话框--这个在excel2007试过不行
			} else if (doctype == 2) {
				officeOcx.ActiveDocument.Application.Dialogs(5).Show();
			} else {
				try{
					officeOcx.SaveAsOtherFormatFile()
				}catch (err) {
					alert("该文档类型不支持另存为操作！");
				}
			}
		} catch (err) {
			//  alert("另存为操作出现错误:" + err.number + "(" + err.description + ")");
		}finally{
			officeOcx.FileSaveAs = false;
		}
	}
	
	/**
	 * 插入文件
	 */
	officeOcx.prototype.insertFile = function(){
		if(!this.isValidate())
			return;
		if(this.isProtection()){
			alert("对不起，当前文档处于保护模式,不能够执行该项操作。")
			return;
		}
		this.officeOcx.AddTemplateFromLocal("", true);
	}
	
	/**
	 * 插入时间
	 */
	officeOcx.prototype.insertDateTime = function() {
		if(!this.isValidate())
			return;
		if(this.isProtection()){
			alert("对不起，当前文档处于保护模式,不能够执行该项操作。")
			return;
		}
		
		var officeOcx = this.officeOcx;
		var cb = function(dateTime) {
			if (dateTime) {
				officeOcx.ActiveDocument.Application.Selection.InsertAfter(dateTime);
			}
		};
		
		var str = window.showModalDialog(contextPath + "/oz/common/dlg_SelectDateTime.jsp", "", "dialogWidth=270px;dialogHeight=310px;status=no;scroll=no");
		cb(str);
	}
	
	/**
	 * 显示文件属性对话框
	 */
	officeOcx.prototype.openFilePropertiesDlg = function() {
		if(!this.isValidate())
			return;
		
		// DocType: 1=word; 2=Excel.Sheet; 3=PowerPoint.Show; 4= Visio.Drawing; 5=MSProject.Project; 6= WPS Doc; 7=Kingsoft Sheet
		var officeOcx = this.officeOcx;
		var doctype = officeOcx.DocType;
		if (doctype == 1) {
			officeOcx.ActiveDocument.Application.Dialogs(750).Show();
		} else if (doctype == 2) {
			officeOcx.ShowDialog(6);
		}
	}
	
	/**
	 * 显示页面设置对话框
	 */
	officeOcx.prototype.openPageSetupDlg = function() {
		if(!this.isValidate())
			return;
		
		// DocType: 1=word; 2=Excel.Sheet; 3=PowerPoint.Show; 4= Visio.Drawing; 5=MSProject.Project; 6= WPS Doc; 7=Kingsoft Sheet
		var officeOcx = this.officeOcx;
		officeOcx.Activate(true);
		var doctype = officeOcx.DocType;
		if (doctype == 1) {
			officeOcx.ActiveDocument.Application.Dialogs(178).Show();
		} else if (doctype == 2) {
			officeOcx.ShowDialog(5);
		}
	}
	
	/**
	 * 打印
	 */
	officeOcx.prototype.print = function() {
		if(!this.isValidate())
			return;
		
		try {
			var officeOcx = this.officeOcx;
			officeOcx.FilePrint = true;
			officeOcx.PrintOut(true);
			officeOcx.FilePrint = false;
		} catch (err) {
			//alert("请确认是否安装有打印机。");
		}
	}

	/**
	 * 打印预览
	 */
	officeOcx.prototype.printPreview = function() {
		if(!this.isValidate())
			return;
		
		try {
			this.officeOcx.PrintPreview();
		} catch (err) {
			//alert("请确认是否安装有打印机。");
		}
	}
	
	/**
	 * 设置书签的值
	 */
	officeOcx.prototype.updateBookmark = function(bookMarkName, bookMarkValue) {
		if(!this.isValidate())
			return;
		
		var officeOcx = this.officeOcx;
		if (!officeOcx.ActiveDocument.BookMarks.Exists(bookMarkName))
			return;
		
		this.setTrackRevisions(false);
		var bookMarkObj = ocx.ActiveDocument.BookMarks(bookMarkName);
		var saveRange = bookMarkObj.Range;
		saveRange.Text = bookMarkValue;
		ocx.ActiveDocument.Bookmarks.Add(bookMarkName, saveRange);
		this.setTrackRevisions(this.trackRevisions);
	}
	
	officeOcx.prototype.updateBookmarks = function(variables) {
		if(!this.isValidate())
			return;
		
		var officeOcx = this.officeOcx;
		variables = variables || {};
		for ( var key in variables) {
			if (!officeOcx.ActiveDocument.BookMarks.Exists(key))
				continue;
			var bookMarkObj = officeOcx.ActiveDocument.BookMarks(key);
			var bookmarkRange = officeOcx.ActiveDocument.BookMarks(key).Range;
			bookmarkRange.Text = variables[key] || "";
			officeOcx.ActiveDocument.Bookmarks.Add(key, bookmarkRange);
		}
		officeOcx.ActiveDocument.Fields.Update();
	},
	
	/**
	 * 设置Word工具栏显示与隐藏
	 */
	officeOcx.prototype.setWordToolbarStatus = function(isShow) {
		if(!this.isValidate())
			return;
		var officeOcx = this.officeOcx;
		officeOcx.Toolbars = isShow;
	}
	
	/**
	 * 显示/不显示修订文字
	 */
	officeOcx.prototype.setRevisionsStatus = function(showRevision) {
		if(!this.isValidate())
			return;
		this.officeOcx.ActiveDocument.ShowRevisions = showRevision;
	}
	
	/**
	 * 规范全文
	 */
	officeOcx.prototype.formatContent = function(isFormat) {
		if(!this.isValidate())
			return;
		if(this.isProtection()){
			alert("对不起，当前文档处于保护模式,不能够执行该项操作。")
			return;
		}
		
		if(isFormat){
			try {
				var format = $.extend({
					fontName : "仿宋_GB2312",
					fontSize : 16,
					firstLineIndent : 2,
					lineSpacing : 29
				}, window.wordFormat);
				
				this.setTrackRevisions(false);
				var officeOcx = this.officeOcx;
				with(officeOcx.ActiveDocument.Content){
					Font.Name = format.fontName;
					Font.Size = format.fontSize;
					ParagraphFormat.CharacterUnitFirstLineIndent = format.firstLineIndent;
					ParagraphFormat.LineSpacingRule = 4;
					ParagraphFormat.LineSpacing = format.lineSpacing;
				}
				this.setTrackRevisions(this.trackRevisions);
			} catch (err) {
				alert("规范全文时出错,错误信息如下:" + err.number + "(" + err.description + ")");
			}
		}else{
			var officeOcx = this.officeOcx;
			officeOcx.ActiveDocument.Undo();
			officeOcx.ActiveDocument.Undo();
			officeOcx.ActiveDocument.Undo();
			officeOcx.ActiveDocument.Undo();
			officeOcx.ActiveDocument.Undo();
		}
	}
	
	/**
	 * 设置痕迹保留的状态
	 */
	officeOcx.prototype.setTrackRevisions = function(isTrack, curUserName) {
		if(!this.isValidate())
			return;
		if(this.isProtection()){
			alert("对不起，当前文档处于保护模式,不能够执行该项操作。")
			return;
		}
		
		this.officeOcx.ActiveDocument.TrackRevisions = isTrack;
		if(isTrack){
			if(null != curUserName && curUserName.length > 0)
				this.setDocUser(curUserName);
		}
	}
	
	/**
	 * 设置当前Office的用户名（痕迹的用户名）
	 */
	officeOcx.prototype.setDocUser = function(curUserName) {
		if(!this.isValidate())
			return;
		if(this.isProtection()){
			alert("对不起，当前文档处于保护模式,不能够执行该项操作。")
			return;
		}
		
		var officeOcx = this.officeOcx;
		with (officeOcx.ActiveDocument.Application) {
			UserName = curUserName;
		}
	}
	
	officeOcx.prototype.isValidate = function(){
		if(null == this.officeOcx){
			alert("对不起，当前Office控件尚未初始化，不能够执行该项操作。")
			return false;
		}
			
		if ((typeof (this.officeOcx.ActiveDocument) == "undefined")) {
			alert("对不起，当前Office控件尚未初始化，不能够执行该项操作。")
			return false;
		}		
		return true;
	}
	
	officeOcx.prototype.isProtection = function() {
		try {
			return this.officeOcx.ActiveDocument.ProtectionType != -1;
		} catch (err) {
			return true;
		}
	}
	
	officeOcx.prototype.showMsg = function (msg){
		msg = msg || "文件加载失败";
		$("#" + this.id).html("<strong>" + msg + "</strong>");
	}
	
	oz.officeOcx = officeOcx;
})();