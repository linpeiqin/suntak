/**
 * 平台对easyui扩展的集合
 * 
 * 版本: 1.0.0
 * 作者：dragon 2010-10-20
 */

//文本输入+按钮的html模板
var TPL_DLG_SELECT = '<span class="ozselectbox">'+
	'<input type="text" class="ozselectbox-text">'+
	'<span><span class="ozselectbox-icon" title="点击选择"></span></span>'+
	'</span>';

//计算映射配置的值
function ozMappingValue(result,config,defaultKey){
	if(typeof(result) == "string"){
		return result;
	}
	
	if(!$.isArray(config)){//没有配置的情况
		defaultKey = (defaultKey ? defaultKey : "value");
		if($.isPlainObject(result)){
			return result[defaultKey] ? result[defaultKey] : $.toJSON(result);
		}else{
			return result;
		}
	}else{
		var args = [];
		var keys = config[0].split(",");
		var value;
		for(var i=0;i<keys.length;i++){
			value = result[keys[i]];
			args.push(value ? ""+value : "");
		}
		return OZ.String.format(config[1],args);
	}
}

//处理链接型输入框的函数：返回false代表失败，true代表成功
function dealEditorLink(target,options){
	if(!options.link2Column){
		return true;
	}
	
	var link2Value = null;
	var preField,preName,pre = options.link2Column.split("|");
	preField = pre[0];
	preName = (pre.length >1 ? pre[1]:pre[0]);
	
	//获取前导列单元格的值
	var $grid = $("#"+window[options.pvar].id);//获取grid对象
	var rowIndex = target.parents("tr[datagrid-row-index]").attr("datagrid-row-index");//当前编辑行的索引号
	ozlog.info("rowIndex=" + rowIndex);
	var $link2Cell = target.parents("div.datagrid-view").find(".datagrid-body tr[datagrid-row-index='"+rowIndex+"'] td[field='" + preField + "']");
	link2Value = $link2Cell.find(":text,textarea").val();
	ozlog.info("link2Cell=" + $link2Cell.length);
	ozlog.info("before link2Value=" + link2Value);
	if(options.link2Fn && typeof(window[options.link2Fn]) == "function"){
		var go = window[options.link2Fn].call($grid,link2Value,rowIndex,$link2Cell);
		if(typeof(go) == "object") {
			OZ.Msg.info(go.msg || "请先设置\"" + preName + "\"的值");
			return false;
		}else if(go === false) {	//返回false则退出
			OZ.Msg.info("请先设置\"" + preName + "\"的值");
			return false;
		}else if(go){
			link2Value = go;//修改为用户修改后的值
		}
	}
	ozlog.info("after link2Value=" + link2Value);
	
	//必填检查
	if(options.link2Required && (!link2Value || link2Value=="" || link2Value=="-1")){
		OZ.Msg.info("请先设置\"" + preName + "\"的值");
		return false;
	}
	
	options.link2Value = link2Value;
	return true;
}
//默认的对话框编辑器
var ozDialogSelectBox = {
	init: function(container, options){
		if(ozlog.debugEnable){
			ozlog.debug("options="+$.toJSON(options));
		}
		
		var target = $(TPL_DLG_SELECT).appendTo(container);
		//绑定按钮的事件：弹出对话框选择
		target.find(".ozselectbox-icon").click(function(event){
			//检测联动
			if(!dealEditorLink(target,options)){
				return;
			}
			var link2Value = options.link2Value;
			
			//创建对话框
			ozlog.info("link2Value=" + link2Value);
			var dlfConfig = $.extend({},options);
			if(link2Value === false || link2Value=="" || link2Value){
				dlfConfig.url = OZ.addParamToUrl(dlfConfig.url,options.link2Param + "=" + link2Value);
			}
			if(typeof(options.onSelect) == "function"){
				dlfConfig.onOk = function(result){
					target.find("input[type='text']").val(ozMappingValue(result,options.valueMapping,"value"));
					options.onSelect(result);
				};
			}
			var dlg = new OZ.Dlg.create(dlfConfig);
		}).hover(
			function(){$(this).addClass("ozselectbox-icon-hover");},
			function(){$(this).removeClass("ozselectbox-icon-hover");}
		);
		
		//返回editor对象
		return target;
	},
	getValue: function(target){
		return $(target).find("input[type='text']").val();
	},
	setValue: function(target, value){
	   $(target).find("input[type='text']").val(value);
	},
	resize: function(target, width){
		//ozlog.info("resize：width="+width);
		var input = $(target).find("input[type='text']");
		var w;
		if ($.boxModel === true){
			w = (width - (input.outerWidth() - input.width()) - $(target).find(".ozselectbox-icon").parent().width() - 2);
		} else {
			w = (width - $(target).find(".ozselectbox-icon").width());
		}
		//ozlog.info("resize：input width="+w);
		input.width(w);
	}
};

//选择单位部门控件的扩展
$.extend($.fn.datagrid.defaults.editors, {
	ozDialogSelectBox: ozDialogSelectBox,
	ozSelectOUBox: $.extend({},ozDialogSelectBox,{
		init: function(container, options){
			if(ozlog.infoEnable){
				ozlog.info("options="+$.toJSON(options));
			}
			
			var target = $(TPL_DLG_SELECT).appendTo(container);
			//绑定按钮的事件：弹出对话框选择
			target.find(".ozselectbox-icon").click(function(event){
				if(!dealEditorLink(target,options)){
					return;//检测联动
				}
				if(options.link2Column || options.pid){
					var ouId = options.pid || options.link2Value;
					var ouType = options.ouType;
					OZ.Organize.selectOUInfoWithUnitID(ouId,ouType || null,function(result){
						target.find("input[type='text']").val(ozMappingValue(result,options.valueMapping,"text"));
						if(typeof(options.onSelect) == "function"){
							options.onSelect(result);
						}
					});
				}else{
					OZ.Organize.selectOUInfo(function(result){
						target.find("input[type='text']").val(ozMappingValue(result,options.valueMapping,"text"));
						if(typeof(options.onSelect) == "function"){
							options.onSelect(result);
						}
					});
				}
			}).hover(
				function(){$(this).addClass("ozselectbox-icon-hover");},
				function(){$(this).removeClass("ozselectbox-icon-hover");}
			);
			
			//返回editor对象
			return target;
		}
	}),
	ozSelectUnitBox: $.extend({},ozDialogSelectBox,{
		init: function(container, options){
			if(ozlog.infoEnable){
				ozlog.info("options="+$.toJSON(options));
			}
			
			var target = $(TPL_DLG_SELECT).appendTo(container);
			//绑定按钮的事件：弹出对话框选择
			target.find(".ozselectbox-icon").click(function(event){
				if(!dealEditorLink(target,options)) {
					return;//检测联动
				}
				if(options.link2Column || options.pid){
					var ouId = options.pid || options.link2Value;
					OZ.Organize.selectOUInfoWithUnitID(ouId,"DW" || null,function(result){
						target.find("input[type='text']").val(ozMappingValue(result,options.valueMapping,"text"));
						if(typeof(options.onSelect) == "function"){
							options.onSelect(result);
						}
					});
				}else{
					OZ.Organize.selectUnit(function(result){
						target.find("input[type='text']").val(ozMappingValue(result,options.valueMapping,"text"));
						if(typeof(options.onSelect) == "function"){
							options.onSelect(result);
						}
					});
				}
			}).hover(
				function(){$(this).addClass("ozselectbox-icon-hover");},
				function(){$(this).removeClass("ozselectbox-icon-hover");}
			);
			
			//返回editor对象
			return target;
		}
	}),
	ozSelectDepartmentBox: $.extend({},ozDialogSelectBox,{
		init: function(container, options){
			if(ozlog.infoEnable){
				ozlog.info("options="+$.toJSON(options));
			}
			
			var target = $(TPL_DLG_SELECT).appendTo(container);
			//绑定按钮的事件：弹出对话框选择
			target.find(".ozselectbox-icon").click(function(event){
				if(!dealEditorLink(target,options)) {
					return;//检测联动
				}
				if(options.link2Column || options.pid){
					var ouId = options.pid || options.link2Value;
					OZ.Organize.selectOUInfoWithUnitID(ouId,"BM" || null,function(result){
						target.find("input[type='text']").val(ozMappingValue(result,options.valueMapping,"text"));
						if(typeof(options.onSelect) == "function"){
							options.onSelect(result);
						}
					});
				}else{
					OZ.Organize.selectDepartment(function(result){
						target.find("input[type='text']").val(ozMappingValue(result,options.valueMapping,"text"));
						if(typeof(options.onSelect) == "function"){
							options.onSelect(result);
						}
					});
				}
			}).hover(
				function(){$(this).addClass("ozselectbox-icon-hover");},
				function(){$(this).removeClass("ozselectbox-icon-hover");}
			);
			
			//返回editor对象
			return target;
		}
	}),
	ozSelectGroupBox: $.extend({},ozDialogSelectBox,{
		init: function(container, options){
			if(ozlog.infoEnable){
				ozlog.info("options="+$.toJSON(options));
			}
			
			var target = $(TPL_DLG_SELECT).appendTo(container);
			//绑定按钮的事件：弹出对话框选择
			target.find(".ozselectbox-icon").click(function(event){
				OZ.Organize.selectGroup(function(result){
					target.find("input[type='text']").val(ozMappingValue(result,options.valueMapping,"name"));
					if(typeof(options.onSelect) == "function"){
						options.onSelect(result);
					}
				});
			}).hover(
				function(){$(this).addClass("ozselectbox-icon-hover");},
				function(){$(this).removeClass("ozselectbox-icon-hover");}
			);
			
			//返回editor对象
			return target;
		}
	}),
	ozSelectUserBox: $.extend({},ozDialogSelectBox,{
		init: function(container, options){
			if(ozlog.infoEnable){
				ozlog.info("options="+$.toJSON(options));
			}
			
			var target = $(TPL_DLG_SELECT).appendTo(container);
			//绑定按钮的事件：弹出对话框选择
			target.find(".ozselectbox-icon").click(function(event){
				OZ.Organize.selectUser(function(result){
					target.find("input[type='text']").val(ozMappingValue(result,options.valueMapping,"text"));
					if(typeof(options.onSelect) == "function"){
						options.onSelect(result);
					}
				});
			}).hover(
				function(){$(this).addClass("ozselectbox-icon-hover");},
				function(){$(this).removeClass("ozselectbox-icon-hover");}
			);
			
			//返回editor对象
			return target;
		}
	}),
	ozCombotree:{
		init:function(container, options){
			var target = $("<input type=\"text\">").appendTo(container);
			target.combotree(options);
			return target;
		},
		destroy:function(target){
			$(target).combotree("destroy");
		},
		getValue:function(target){
			var value = $(target).combotree("getValue");
			return value.replace("-", "/");
		},
		setValue:function(target, value){
			if(null != value)
				value = value.replace("/", "-");
			$(target).combotree("setValue", value);
		},
		resize:function(target, width){
			$(target).combotree("resize", width);
		}
	}
});

//====表格添加汇总功能====开始
/** 处理指定列的汇总计算
 * @param col 列的配置信息
 * @param rows 当前表格所有行的json数据
 */
function ozGrid_SummaryColumn(col,rows){
	//求值函数
	function _getValue(col,row){
		if(col.summaryFormula){		//使用计算公式计算出相应的值
			var formula = col.summaryFormula;
			//ozlog.info("formula1=" + formula);
			var cellvalue;
			for(var key in row){
				if(formula.indexOf(key) != -1){
					cellvalue = row[key];
					cellvalue = parseFloat(cellvalue);
					if (isNaN(cellvalue)){
						cellvalue = 0;
					}
					formula=formula.replace(key,cellvalue);
				}
			}
			//ozlog.info("formula2=" + formula);
			return (new Function("return " + formula))();
		}else{						//当前单元格的值
			var value = parseFloat(row[col.field],10);
			if (isNaN(value)){
				value = 0;
			}
			return value;
		}
	}
	
	var summary = 0,value,i;
	if(col.summaryType == "sum"){//求和
		for(i=0;i<rows.length;i++){
			value = _getValue(col,rows[i]);
			summary += value;
		}
	}else if(col.summaryType == "avg"){//求平均值
		for(i=0;i<rows.length;i++){
			value = _getValue(col,rows[i]);
			summary += value;
		}
		summary = summary/rows.length;
	}else if(col.summaryType == "max"){//求最大值
		summary = (rows.length > 0 ? _getValue(col,rows[0]) : 0);
		for(i=1;i<rows.length;i++){
			summary = Math.max(summary,_getValue(col,rows[i]));
		}
	}else if(col.summaryType == "min"){//求最小值
		summary = (rows.length > 0 ? _getValue(col,rows[0]) : 0);
		for(i=1;i<rows.length;i++){
			summary = Math.min(summary,_getValue(col,rows[i]));
		}
	}else{
		summary="undefined summaryType:" + col.summaryType;
	}

	//显示汇总值
	if(col.summary2Field){
		if(col.summaryFormatter){
			var fn = window[col.summaryFormatter];
			if(typeof(fn) == "function"){
				summary = fn.call(this,summary);//格式化汇总的值
			}
		}
		var s2Field = document.getElementById(col.summary2Field);
		if(s2Field){
			if(/input|textarea/.test(s2Field.tagName)){
				//文本框的处理
				s2Field.value = summary;
			}else{
				//dom的处理
				s2Field.innerHTML = ""+summary;
			}
		}
	}
	//ozlog.info(col.field + " summary=" + summary);
}
/** 更新指定id的grid的汇总信息 */
function ozGrid_SummaryAll(gridId){
	var grid = $("#" + gridId);
	var options = grid.datagrid("options");
	var rows = grid.datagrid("getRows");

	//获取要汇总的列
	var columns = options.columns[0];
	var summaryColumns = [];
	for(var i=0;i<columns.length;i++){
		if(columns[i].summaryType){//要汇总的列
			ozGrid_SummaryColumn(columns[i],rows);
		}
	}
}
//====表格添加汇总功能====结束
