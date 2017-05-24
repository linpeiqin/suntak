/** 
 * select列表框通用工具方法
 * 版本: 1.0 
 * 作者：dragon 2010-08-06
 * 修改：shilu 2012-02-16
 * 依赖 无
 */
 
OZ.SELECT={
	/**
	 * 将指定源列表选中的选项添加到指定的目标列表中
	 * @param origId 源列表id
	 * @param destId 源列表id
	 * @param clear [可选]是否删除源列表中选中的项，默认为false
	 */
	appendSelected:function(origId,destId,clear){
		// 首先取得指定的列表选项
		var sourceObj = document.getElementById(origId);
		var destObj = document.getElementById(destId);
		if (sourceObj==null || destObj==null){
			return;
		}
		// 循环用户选定的每一个项目，将该项添加到指定列表中
		for (var i = 0; i < sourceObj.length; i++){
			if (sourceObj.options[i].selected){
				var selValue = sourceObj.options[i].value;
				
				// 判断是否已经添加
				if(!OZ.SELECT.isExist(destId, selValue)){
					destObj.options[destObj.length] = new Option(sourceObj.options[i].text, sourceObj.options[i].value);
				}
			}
		}
		
	     // 删除源列表中选中的项
		 if(clear){ OZ.SELECT.removeSelected(origId);}
	},
	/** */
	appendAll:function(origId,destId,clear){
		// 首先取得指定的列表选项
		var sourceObj = document.getElementById(origId);
		var destObj = document.getElementById(destId);
		if (sourceObj==null || destObj==null){
			return;
		}
		// 循环用户选定的每一个项目，将该项添加到指定列表中
		for (var i = 0; i < sourceObj.length; i++){
			var selValue = sourceObj.options[i].value;
			
			// 判断是否已经添加
			if(!OZ.SELECT.isExist(destId, selValue)){
				destObj.options[destObj.length] = new Option(sourceObj.options[i].text, sourceObj.options[i].value);
			}
		}
		
		// 删除源列表中选中的项
		if(clear) {OZ.SELECT.removeAll(origId);}
	},
	/**
	 * 删除列表中选中的项
	 * @param selectId 列表id
	 */
	removeSelected:function(selectId){
		var selectObj = document.getElementById(selectId);
		if (selectObj==null){ return;}
	
		var len = selectObj.length;
		for(var i=len-1; i>=0; i--){
			if(selectObj.options[i].selected){
				selectObj.options[i] = null;//删掉该选项
			}
		}
	},
	/**
	 * 删除列表中的所有项
	 * @param selectId 列表id
	 */
	removeAll:function(selectId){
		var selectObj = document.getElementById(selectId);
		if (selectObj==null){ return;}
		selectObj.length = 0;
	},
	/**
	 * 判断指定的列表中是否存在指定的值
	 * @param selectId 列表id
	 * @param value 要判断的值
	 */
	isExist:function(selectId, value){
		var selectObj = document.getElementById(selectId);
		if(null == selectObj){ return false;}
		
		for(var j = 0; j < selectObj.length; j++){
			if(selectObj.options[j].value == value){
				return true;
			}
		}
		return false;
	},
	/**
	 * 选中指定列表中的所有选项
	 * @param selectIds 列表id数组
	 * @param value 要判断的值
	 */
	selectAll:function(selectIds){
		if(!selectIds){
			return;
		}
		var selectObj;
		for(var i=0; i<selectIds.length; i++){
			selectObj = document.getElementById(selectIds[i]);
			for(var j = 0; j < selectObj.length; j++){
				selectObj.options[j].selected = true;
			}
		}
	},
	/**
	 * 清除选中指定列表中的所有选项
	 * @param selectIds 列表id数组
	 */
	clearAll:function(selectIds){
		if(!selectIds){
			return;
		}
		var selectObj;
		for(var i=0; i<selectIds.length; i++){
			selectObj = document.getElementById(selectIds[i]);
			for(var j = 0; j < selectObj.length; j++){
				selectObj.options[j].selected = false;
			}
		}
	},
	
	/**
	 * 添加选项到指定的Select
	 * @param selectIds 列表id数组
	 * @param name 名称
	 * @param value 值
	 */
	addOption:function(selectId,name,value){
		if(this.isExist(selectId,value)) return;
		var selectObj = document.getElementById(selectId);
		if(null == selectObj){ return false;}
		selectObj.options[selectObj.length] = new Option(name, value);
	},
	
	/**
	 * 把指定的Select中的选中项上移
	 * @param selectId Select的ID
	 */
	moveUp:function(selectId){
		this.move(selectId,'up');
	},
	
	/**
	 * 把指定的Select中的选中项下移
	 * @param selectId Select的ID
	 */
	moveDown:function(selectId){
		this.move(selectId,'down');
	},
	
	/**
	 * 移动指定的Select中的选中项
	 * @param selectId Select的ID
	 * @param type('up':上移 , 'down':下移)
	 */
	move:function(selectId,type){
		var selectObj = document.getElementById(selectId);
		if(selectObj==null)
			return;
		if(selectObj.selectedIndex == -1)
			alert('请选择要移动的项！');
		
		var oldOption = selectObj.options[selectObj.selectedIndex];
		var testOption;
		if(type == 'up' && selectObj.selectedIndex != 0)
			testOption = selectObj.options[selectObj.selectedIndex-1];
		else if(type == 'down')
			testOption = selectObj.options[selectObj.selectedIndex+1];
		else
			return;
		
		if(testOption != null){
			var oldText = testOption.text;
			var oldValue = testOption.value;
			testOption.text = oldOption.text;
			testOption.value = oldOption.value;
			oldOption.text = oldText;
			oldOption.value = oldValue;
			oldOption.selected = false;					
			testOption.selected = true;
		}
	},
	
	/**
	 * 清空指定的Select
	 * @param selectId select的id
	 */
	clearOption:function(selectId){
		if($("#" + selectId).length == 0)
			return;
		$("#" + selectId).empty();
	},
	
	/**
	 * 重新渲染Select中的选项
	 * @param selectId select的id
	 * @param options 选项数组，name/value
	 */
	rerenderOption:function(selectId, options){
		if($("#" + selectId).length == 0)
			return;
		var selectObj = $("#" + selectId);
		selectObj.empty();
		if(options.length > 0){
			for(var i = 0; i < options.length; i++){
				selectObj.append("<option value='" + options[i].value + "'>" + options[i].name + "</option>");				
			}
		}		
	}
};