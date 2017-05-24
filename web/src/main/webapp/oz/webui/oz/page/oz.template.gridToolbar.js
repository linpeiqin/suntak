/**
 * grid控件内嵌工具条的默认处理函数
 * 
 * 版本: 1.0.0
 * 作者：dragon 2010-10-19
 */

function ozEditGrid_BeforeEdit(index,row){
	row.editing = true;
}
function ozEditGrid_AfterEdit(index,row){
	row.editing = false;
	if(ozlog.infoEnable){
		ozlog.info("ozEditGrid_AfterEdit:gridId=" + this.id);
	}
	ozGrid_SummaryAll(this.id);//更新汇总信息
}
function ozEditGrid_CancelEdit(index,row){
	row.editing = false;
	//$('#ozGrid').datagrid('refreshRow', index);
}
function ozEditGrid_ClickRow(rowIndex){
	var gridCfg = window[$(this).attr("var")];
	if (gridCfg.lastEditIndex != rowIndex){
		$(this).datagrid('endEdit', gridCfg.lastEditIndex);
		$(this).datagrid('beginEdit', rowIndex);
	}
	gridCfg.lastEditIndex = rowIndex;
}
function ozEditGrid_DblClickRow(rowIndex){
	return;
}

//按钮：增加
function ozEditGridTB_BtnAddInner(gridCfg){
	var gridId = "#" + gridCfg.id;
	var url4create = gridCfg.ex.toolbar.url4create;//远程新建的初始化
	var createFn = window[gridCfg.ex.toolbar.createFn];//本地新建函数
	if(url4create){//优先采用远程初始化
		var data = {};
		if(gridCfg.pidField){
			data.pid = $("#" + gridCfg.pidField).val();
		}
		$.ajax({
			type: "POST",dataType: "json",
			url: url4create,
			data: data,
			success: function(json, _status){
				if (typeof(json) != "object"){
					alert("远程初始化返回的数据格式不正确!");
					return;
				}
				
				//处理回调
				var showMsg;
				var callback = gridCfg.ex.toolbar.callback4create;
				if(callback && typeof(window[callback]) == "function"){
					window[callback].apply(this,arguments);
				}
				//添加到表格
				$(gridId).datagrid('endEdit', gridCfg.lastEditIndex);
				$(gridId).datagrid('appendRow',json);
				$(gridId).datagrid('beginEdit', $(gridId).datagrid('getRows').length-1);
			},
			error: function(xhr, errorMsg, errorThrown){
				OZ.Msg.error("远程初始化出现异常！");
			}
		});
	}else{//本地初始化
		var defaultObj = {id:"-1"};
		if(typeof(createFn) == "function"){
			defaultObj = $.extend(defaultObj,createFn.call());
		}
		if(ozlog.debugEnable){ozlog.debug($.toJSON(defaultObj));}
		$(gridId).datagrid('endEdit', gridCfg.lastEditIndex);
		$(gridId).datagrid('appendRow',defaultObj);
		$(gridId).datagrid('beginEdit', $(gridId).datagrid('getRows').length-1);
	}
}
function ozEditGridTB_BtnAdd(){//linkbutton的事件函数
	var gridCfg = window[this.pvar];
	ozEditGridTB_BtnAddInner(gridCfg);
}

//表单保存前要调用的：可编辑表格的全局保存处理
function ozAllEditGrid_BeforeSave(){
	var gridCfg;
	for(var i=0;i<OZAllGridConfigVarName.length;i++){
		gridCfg = window[OZAllGridConfigVarName[i]];
		if(gridCfg.editable){//仅处理可编辑表格
			$("#" + gridCfg.id).datagrid('endEdit',gridCfg.lastEditIndex);//退出编辑状态
			ozEditGridTB_BtnSaveInner(gridCfg);//序列化数据或远程保存
		}
	}	
}
//表单保存后要调用的：可编辑表格的全局接收修改
function ozAllEditGrid_AfterSave(json){
	var gridCfg;
	for(var i=0;i<OZAllGridConfigVarName.length;i++){
		gridCfg = window[OZAllGridConfigVarName[i]];
		if(gridCfg.editable){//仅处理可编辑表格
			$("#" + gridCfg.id).datagrid('acceptChanges');
		}
	}	
}

//按钮：保存
function ozEditGridTB_BtnSave(){//linkbutton的事件函数
	var gridCfg = window[this.pvar];
	ozEditGridTB_BtnSaveInner(gridCfg);
}
function ozEditGridTB_BtnSaveInner(gridCfg){
	var gridId = "#" + gridCfg.id;
	var $grid = $(gridId);
	$grid.datagrid('endEdit',gridCfg.lastEditIndex);
	var rows = $grid.datagrid('getChanges');
	if(rows.length){
		//将修改的信息序列化
		var data = {
			inserted:$grid.datagrid('getChanges','inserted'),
			deleted:$grid.datagrid('getChanges','deleted'),
			updated:$grid.datagrid('getChanges','updated')
		};	//changes
		if(gridCfg.pidField){
			var pid = document.getElementById(gridCfg.pidField);
			if(pid){ data.pid = pid.value;}				//pid
		}
		if(ozlog.infoEnable){ozlog.info($.toJSON(data));}
		
		//保存序列化的信息
		if(gridCfg.dataField){	//保存数据到指定的域
			var p = document.getElementById(gridCfg.dataField);
			if(p){ p.value = $.toJSON(data);}
			
			//调用回调函数
			if(typeof(gridCfg.ex.toolbar.callback4save) == "function"){
				gridCfg.ex.toolbar.callback4save.call(this);
			}
		}else{					//直接保存到服务器
			$.ajax({
				type: "POST",dataType: "json",
				url: gridCfg.ex.toolbar.url4save,
				data: {gridData: $.toJSON(data)},
				success: function(json, _status){
					if(json.result === true){// 保存成功
						$grid.datagrid('acceptChanges');
						
						//调用回调函数
						var showMsg;
						var callback = window[gridCfg.ex.toolbar.callback4save];
						if(typeof(callback) == "function"){
							showMsg = callback.apply(this,arguments);
						}
						if(showMsg !== false){OZ.Msg.slide(rows.length + '行信息已保存！');}
					}else{						  // 保存失败
						OZ.Msg.warn(json.msg || "信息保存失败！");
					}
				},
				error: function(xhr, errorMsg, errorThrown){
					OZ.Msg.error("保存操作出现未处理异常！");
				}
			});
		}
	}else{
		OZ.Msg.slide("当前还没有任何修改！");
	}
}
//按钮：取消--撤销所有当前表格的修改
function ozEditGridTB_BtnCancel(){
	var gridId = "#" + window[this.pvar].id;
	var rows = $(gridId).datagrid('getChanges');
	if(rows.length){
		OZ.Msg.confirm("当前有" + rows.length + '行信息已被修改，确认撤销这些修改吗？',function(){
			$(gridId).datagrid('rejectChanges');
		});
	}else{
		OZ.Msg.slide("当前还没有任何修改！");
	}
}
//按钮：删除
function ozEditGridTB_BtnDelete(){
	var gridCfg = window[this.pvar];
	var gridId = "#" + gridCfg.id;
	var rows = $(gridId).datagrid('getSelections');
	if (rows.length){
		OZ.Msg.confirm(
			"确定要删除选中的" + rows.length + "项吗？",
			function(){
				if(gridCfg.ex.toolbar.url4delete){//远程删除
					var ids=[];
					for(var i=0;i<rows.length;i++){
						if(rows[i].id && rows[i].id != "-1" && rows[i].id != ""){
							ids.push(rows[i].id);
						}
					}
					$.ajax({
						type: "GET",dataType: "json",
						url: gridCfg.ex.toolbar.url4delete,
						data:{ids:ids.join(";")},
						success: function(response, textStatus){
							if (response.result === true){   // Ajax请求处理成功
								for(var i=0;i<rows.length;i++){
									var index = $(gridId).datagrid('getRowIndex', rows[i]);
									$(gridId).datagrid('deleteRow', index);
								}
								//$(gridId).datagrid('rejectChanges');//TODO 这里先拒绝之前的修改
								
								//调用回调函数
								var showMsg;
								var callback = window[gridCfg.ex.toolbar.callback4delete];
								if(typeof(callback) == "function"){
									showMsg = callback.apply(this,arguments);
								}
								if(showMsg !== false) {
									OZ.Msg.slide(rows.length + '行信息已删除！');
								}
							}else{						  // Ajax请求处理失败
								OZ.Msg.warn(response.msg);
							}
						},
						error: function(xhr, errorMsg, errorThrown){
							var e = $.httpData(xhr, "json");
							alert("删除操作出现异常：message=" + e.message + ";messageCode=" + e.messageCode);
						}
					});
				}else{
					//本地删除
					for(var j=0;j<rows.length;j++){
						var index = $(gridId).datagrid('getRowIndex', rows[j]);
						$(gridId).datagrid('deleteRow', index);
					}
				}
			}
		);
	}else{
		OZ.Msg.slide("当前还没有选定要删除的行！");
	}
}
//按钮：刷新
function ozEditGridTB_BtnRefresh(){
	var gridId = "#" + window[this.pvar].id;
	var rows = $(gridId).datagrid('getChanges');
	if(rows.length){
		OZ.Msg.info("当前有" + rows.length + '行信息已被修改，请先对修改的信息做处理！');
		return;
	}else{
		$(gridId).datagrid('rejectChanges');
		$(gridId).datagrid('reload');
		OZ.Msg.slide("表格信息重新加载完毕！");
	}
}
//按钮：测试--获取修改的行数
function ozEditGridTB_BtnTest(){
	var gridCfg = window[this.pvar];
	var gridId = "#" + gridCfg.id;
	$(gridId).datagrid('endEdit',gridCfg.lastEditIndex);
	var rows = $(gridId).datagrid('getChanges');
	OZ.Msg.slide('changed rows: ' + rows.length + ' lines');
}
//初始化EditGrid
function ozEditGrid_Init(gridConfig){
	if(typeof(gridConfig) == "undefined"){ return;}
	if(ozlog.debugEnable){ozlog.debug("url=" + gridConfig.url);}
	if(gridConfig.excel){//添加导出Excel按钮
		$.extend($.fn.pagination.defaults,{buttons:[
			{iconCls:"oz-icon oz-icon-1011",handler:function(e){
				OZ.View.export2Excel(e,"bottom");
			}}
		]});
	}
	if(gridConfig.pidField){
		var p = document.getElementById(gridConfig.pidField);
		if(p){
			gridConfig.queryParams={pid:p.value};	//pid
		}
		//alert("--" + $.toJSON(gridConfig.queryParams));
	}
	$("#" + gridConfig.id).datagrid($.extend({
		idField: 'id',
		fit: true,
		width:500,height:300,
		border: true,
		nowrap: false,
		striped: true,
		remoteSort: true,
		pagination: false,
		rownumbers: true,
		//onDblClickRow: oz_Row_DBLClicked,
		pageSize: 25,
		pageList: [10,25,50,100]
	},gridConfig));
}