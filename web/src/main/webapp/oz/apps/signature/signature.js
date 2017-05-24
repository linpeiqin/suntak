(function() {
	
	var getCurrentDate = function(){
		var date = new Date();
		return date.getFullYear()+ "-" + (OZ.String.leftPad(date.getMonth() + 1, 2, '0') ) + "-" + OZ.String.leftPad(date.getDate(), 2, '0');
	}
	oz.form.signature = function(fieldId){
		var plugin = this, fieldId = fieldId,signatureObj = null;
		var init = function() {
			var sikey = "Signature_" + fieldId;
			if (sikey in document) {
				signatureObj = document[sikey];
				if (signatureObj && signatureObj.attachEvent) {
					signatureObj.UserName = _formInfo.curuser;
					signatureObj.RecordID = _formInfo.fiId;
				}else{
					signatureObj = null;
				}
			}
		}
		var execMenuCmd = function(menuCaption) {
			if(signatureObj){
				switch (menuCaption) {
				case "签名":
					signatureObj.WriteName(_formInfo.curuser + "  " + getCurrentDate());
					break;
				case "签章验证":
					signatureObj.ShowSignature();
					break;
				case "取消修改":
					 if (!(signatureObj.Enabled)) {
					    alert('该签章已被锁定，无权编辑！');
					  }
					  else{
						signatureObj.Clear();
					  }
					break;
				}
			}
		}
		var methods = {
			load:function(){
				if(signatureObj){
					signatureObj.LoadSignature();//调用“签发”签章数据信息
				}
			},
			/**
			 * 页面是否加载完成
			 */
			save : function(callback) {
				if (signatureObj && signatureObj.Modify) {// 判断签章数据信息是否有改动
					if (!signatureObj.SaveSignature()) { 	// 保存签章数据信息
						alert("保存会签签批内容失败！");
					}
				}
				if((typeof callback) == "function"){
					callback.call(this);
				}
			},
			getObj:function(){
				return signatureObj;
			},
			execute:function(text,btn){
				execMenuCmd(text);
			}
		}
		$.extend(plugin, methods);
		init();
		return plugin;
	}
})();