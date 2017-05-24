/*
 *	
 *	作者：CD826
 *	日期：2009-07-03
 *	功能：toolbar的处理 
 */

//渲染按钮的样式
$(function(){
	OZ.toolbar.init();
})

OZ.toolbar = {
	/**
	 * 初始按钮的Hover操作
	 * 切换样式
	 */
	init:function(){
		$(".oz-tb ul.oz-btn,.oz-tb .oz-btn-search").bind({
			mouseout:function(){
				$(this).removeClass("mousedown mouseover");
			},
			mouseover:function(){
				$(this).removeClass("mousedown mouseout").addClass("mouseover");
			},
			mousedown:function(){
				$(this).removeClass("mouseout mouseover").addClass("mousedown");
			},
			mouseup:function(){
				$(this).removeClass("mousedown mouseover");
			}
		})
	},
	/**
	 * 获取操作工具栏的操作地址
	 * @param btn 按钮
	 */
	getAction:function(btn){
		return $(btn).closest(".oz-tb").data("action");
	}
}

//获取按钮的toolbar中的Action
function getTbAction(btn){
	return $(btn).closest(".oz-tb").data("action");
}

//---------------- Toolbar中缺省处理及缺省按钮的事件响应处理 ----------------
/**
 * 默认的返回操作
 */
function ozTB_BtnBack_Clicked(){
	if((typeof onBtnBack_Clicked) == "function"){
		onBtnBack_Clicked.call(this);
	}else{
		ozTB_DefaultBtnBack_Clicked();
	}
}
function ozTB_DefaultBtnBack_Clicked(){
	OZ.closeWindow();
}

/**
 * 默认刷新操作
 */
function ozTB_BtnRefresh_Clicked(){
	if((typeof onBtnRefresh_Clicked) == "function"){
		onBtnRefresh_Clicked.call(this);
	}else{
		ozTB_DefaultBtnRefresh_Clicked();
	}
}
function ozTB_DefaultBtnRefresh_Clicked(){
	if(typeof(oz_grid_config) != 'undefined'){
		$("#" + oz_grid_config.id).grid("reload");
	}
	
	if(typeof(oz_tree_config) != 'undefined'){
		$("#" + oz_tree_config.id).tree("reload");
	}
	
	if($("#naviTree").length > 0){
		$("#naviTree").tree("reload");	
	}
}

/**
 * 新建按钮默认操作
 * 
 * @param btn 当前操作的按钮
 */
function ozTB_BtnNew_Clicked(btn){
	var action = getTbAction(btn);
	if((typeof onBtnNew_Clicked) == "function"){
		onBtnNew_Clicked.call(btn,action);
	}else{
		ozTB_DefaultBtnNew_Clicked(action);		
	}
}
function ozTB_DefaultBtnNew_Clicked(action){
	if(oz_grid_config.editable){	//视图中出现新建按钮(可编辑表格)
		ozEditGridTB_BtnAddInner(oz_grid_config);
	}else{			//表单中的新建按钮
		var strUrl = OZ.addParamToUrl(action, "action=create");
		ozlog.info("strUrl=" + strUrl);
		OZ.openWindow({
			id: oz_grid_config.id + "_create" + (new Date().getTime()),
			title:"新建" + ($("body").data("name") || "文档"),
			url: strUrl, 
			refresh: true,
			beforeCloseFnName: "oz_Win_BeforeClose"
		});
	}
}

/**
 * 默认的删除操作
 * 
 * @param btn
 */
function ozTB_BtnDelete_Clicked(btn){
	var action = getTbAction(btn);
	if((typeof onBtnDelete_Clicked) == "function"){
		onBtnDelete_Clicked.call(btn, action);
	}else{
		ozTB_DefaultBtnDelete_Clicked(action);
	}
}
function ozTB_DefaultBtnDelete_Clicked(action){
	ozTB_DefaultBtnDelete_ClickedEx(OZ.addParamToUrl(action, "action=delete"));
}
function ozTB_DefaultBtnDelete_ClickedEx(strUrl){
	var rows = $("#" + oz_grid_config.id).grid("getSelections");
	if (null == rows || rows.length === 0) {
		OZ.Msg.info("请先选择要删除的项！");
		return;
	}
	
	var ids=[];
	for(var i=0;i<rows.length;i++){
		ids.push(rows[i].id);
	}
	if(ozlog.infoEnable){
		ozlog.info("ids=" + ids);
	}
	strUrl += "&timeStamp=" + new Date().getTime();
	OZ.Msg.confirm(
		"确定要删除选中的" + ids.length + "项吗？",
		function(){
			$.ajax({
				type: "GET",
				dataType: "json",
				url: strUrl,
				data:{ids:ids.join(";")},
				success: function(response, textStatus){
					if (response.result === true){   // Ajax请求处理成功
						OZ.Msg.slide(response.msg);
						if (typeof refresh == 'function'){
							refresh();
						}else{
							$("#" + oz_grid_config.id).grid("reload");
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
		}
	);
}

/**
 * 查询条件的回车
 * @param _event
 */
function ozTB_Query_KeyDown(_event){
	var event = event || _event;
	if(event.keyCode == 13){
		if((typeof onOZQuery_KeyDown) == "function"){
			onOZQuery_KeyDown.call(this);
		}else{
			ozTB_DefaultQuery_KeyDown_Clicked();
		}
	}
}
function ozTB_DefaultQuery_KeyDown_Clicked(){
	ozTB_BtnSearch_Clicked();
}

/**
 * 查询操作
 */
function ozTB_BtnSearch_Clicked(){
	var searchCondition = $("#ozQuery").val();
	if((typeof onBtnSearch_Clicked) == "function"){
		onBtnSearch_Clicked.call(this, searchCondition);
	}else{
		ozTB_DefaultBtnSearch_Clicked(searchCondition);
	}
}
function ozTB_DefaultBtnSearch_Clicked(searchCondition){
	var store = $('#' + oz_grid_config.id).data("widget-grid").store;
	store.params = [{
		name: 'dbftsParams',
		value: searchCondition
	}];
	store.load();
}

/**
 *  高级查询操作
 * @param value
 */
function ozTB_BtnAdvanceSearch_Clicked(value){
	if((typeof onBtnAdvanceSearch_Clicked) == "function"){
		onBtnAdvanceSearch_Clicked.call();
	}else{
		toggleExtendContainer();
	}
}

/**
 * 查询重置操作
 */
function ozTB_BtnReset_Clicked(){
	$("#ozQuery").val("");
	if((typeof onBtnReset_Clicked) == "function"){
		onBtnReset_Clicked.call();
	}else{
		ozTB_DefaultBtnReset_Clicked();
	}
}
function ozTB_DefaultBtnReset_Clicked(){	
	var store = $('#' + oz_grid_config.id).data("widget-grid").store;
	store.params = [];
	store.load();
}

/**
 * 编辑操作
 * @param btn
 */
function ozTB_BtnEdit_Clicked(btn){
	var action = getTbAction(btn);
	if((typeof onBtnEdit_Clicked) == "function"){
		onBtnEdit_Clicked.call(btn,action);
	}else{
		ozTB_DefaultBtnEdit_Clicked(action);	
	}
}
function ozTB_DefaultBtnEdit_Clicked(action){
	document.location.replace(OZ.addParamToUrl(action, "action=edit&id=" + $("#id").val()));
}

/**
 * 保存操作
 * @param btn
 */
function ozTB_BtnSave_Clicked(btn){
	var action = getTbAction(btn);
	if((typeof onBtnSave_Clicked) == "function"){
		onBtnSave_Clicked.call(btn,action);
	}else{
		ozTB_DefaultBtnSave_Clicked(action);
	}
}
function ozTB_BtnSaveByAjax_Clicked(btn){
	var action = getTbAction(btn);
	if((typeof onBtnSave_Clicked) == "function"){
		onBtnSave_Clicked.call(this, action);
	}else{
		ozTB_DefaultBtnSaveByAjax_Clicked(action);
	}
}
// 默认保存按钮处理函数，使用ajax保存文档
function ozTB_DefaultBtnSave_Clicked(action){
	ozTB_DefaultBtnSave_ClickedEx(OZ.addParamToUrl(action, "action=save"));
}
function ozTB_DefaultBtnSaveByAjax_Clicked(action){
	ozTB_DefaultBtnSaveByAjax_ClickedEx(OZ.addParamToUrl(action, "action=saveByAjax"));
}
function ozTB_DefaultBtnSave_ClickedEx(saveUrl){
	if(!OZ.Form.validate()){
		return;
	}
	// 提交表单
	document.forms[0].action = saveUrl;
	document.forms[0].target = "_self";
	document.forms[0].submit();
}
function ozTB_DefaultBtnSaveByAjax_ClickedEx(saveUrl){
	if(OZ.View){	//视图中出现保存按钮(可编辑表格)
		ozEditGridTB_BtnSaveInner(oz_grid_config);
	}else{			//表单中的保存按钮
		OZ.Form.save(saveUrl);
	}
}