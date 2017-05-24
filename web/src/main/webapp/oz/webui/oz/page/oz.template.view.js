/**
 * oz视图函数模板
 * 
 * 版本: 1.0.0
 * 作者：dragon 2010-07-21
 */
//---------------- View页面变量的定义 ----------------
var ozOpenActionName = "open";	// 打开文档的action名称

//---------------- View页面的辅助函数 ----------------
//从对象中获取默认的页签标题
function oz_GetTitle(json){
	return json.name || json.subject || json.title || json.summary || null;
}

function oz_GetTabTitle(json){
	if((typeof getTabTitle) == "function"){
		return getTabTitle.call(this, json);
	}else{
		return oz_GetTitle(json) || "未命名文档";
	}
}
//---------------- View页面中事件响应处理 ----------------
// Grid中行的双击事件
function oz_Row_DBLClicked(event, rowData, rowIndex){
	if((typeof onRow_DBLClicked) == "function"){
		onRow_DBLClicked.call(this,rowIndex, rowData);
	}else{
		oz_Default_Row_DBLClicked(rowIndex, rowData, "");
	}
}

function oz_Row_Clicked(event, rowData, rowIndex){
	if((typeof onRow_Clicked) == "function"){
		onRow_Clicked.call(this,rowIndex, rowData);
	}else{
		oz_Row_DBLClicked(event, rowData, rowIndex)
	}
}
// 默认表格中行的双击事件处理函数
function oz_Default_Row_DBLClicked(rowIndex,rowData,data){
	oz_Default_Open_Row(rowIndex,rowData,data);
}

// 默认超链接渲染函数
function oz_DefaultFormatter(value, rowData, rowIndex, colIdx){
	return oz_DefaultFormatterEx(value, rowData, rowIndex, "");
}

function oz_OpenGridRow(rowIndex, data){
	var store = $('#'+oz_grid_config.id).data("widget-grid").store;
	var data = store.getPage();
	return oz_Default_Open_Row(rowIndex, data[rowIndex], data);
}

/**
 * 默认的打开
 * @param rowIndex
 * @param rowData
 * @param data
 */
function oz_Default_Open_Row(rowIndex,rowData,data){
	data = data || "";
	OZ.openWindow({
		id: oz_grid_config.id+rowData.id,
		title: oz_GetTabTitle(rowData),
		url: OZ.addParamToUrl(oz_grid_config.path,"action="+ozOpenActionName+"&id=" + rowData.id),
		refresh: true,
		beforeCloseFnName:"oz_Win_BeforeClose",
		data:data
	});
}

function oz_DefaultFormatterEx(value, rowData, rowIndex, data){
	if(value == null){
		return "";
	}
	data = data || "";
	return "<a href='javascript:oz_OpenGridRow(\""+rowIndex+"\",\"" + data + "\")'>" + value + "</a>";
}
/**
 * @deprecated 使用OZ.View.reloadGrid
 * @param params
 */
function oz_ReloadGrid(params){
	OZ.View.reloadGrid(params);
}

/**
 * @deprecated 使用OZ.View.getGridSelectionIds
 * 获取所选定的条目
 * @return
 */
function oz_GetGridSelectionIds(){
	return OZ.View.getGridSelectionIds();
}

//初始化grid
function oz_DefaultGrid_Init(){
	if(typeof(oz_grid_config) == "undefined"){ return; }
	if(ozlog.debugEnable){ozlog.debug("url=" + oz_grid_config.url);}
	
	if(typeof(ozEditGrid_Init) == "function"){
		ozEditGrid_Init(oz_grid_config);//可编辑表格的默认初始化
		if(ozlog.infoEnable){ozlog.info("init editGrid");}
		return;
	}
	
	if(oz_grid_config.excel){//添加导出Excel按钮
		$.extend(oz_grid_config,{extendBtns:[
			{iconCls:"excel",handler:function(e){
				OZ.View.export2Excel(e,"bottom");
			}}                            
		]});
	}
	if(oz_grid_config.pidField){
		var p = document.getElementById(oz_grid_config.pidField);
		if(p){ oz_grid_config.queryParams={pid:p.value};}//pid
	}
	
	$("#" + oz_grid_config.id).grid($.extend({
		idField: 'id',
		fit: true,
		width:500,height:300,
		border: false,
		nowrap: false,
		striped: true,
		remoteSort: true,
		pagination: true,
		rownumbers: true,
		pageSize: 25,
		pageList: [10,25,50,100],
		rowdblclick: oz_Row_DBLClicked,
		rowclick:oz_Row_Clicked,
	},oz_grid_config));
}

//初始化tree
function oz_DefaultTree_Init(){
	if(typeof(oz_tree_config) == "undefined"){ return;}
	$("#" + oz_tree_config.id).tree(oz_tree_config);
}

//默认页面大小初始化
function oz_DefaultPage_Resize(){
	OZ.View.resize();
	//窗口大小变动后自动调整grid的尺寸
	$(window).resize(OZ.View.resize);
}

// 默认页面初始化处理函数
function oz_DefaultPage_Init(){
	// 页面大小初始化
	if(typeof(onPage_Resize) == "function"){
		onPage_Resize();

	}else{
		oz_DefaultPage_Resize();
	}
	// 初始化grid
	if(typeof(onGrid_Init) == "function"){
		onGrid_Init();
	}else{
		oz_DefaultGrid_Init();
 	}
	
	// 初始化tree
	if(typeof(onTree_Init) == "function"){
		onTree_Init();
	}else{
		oz_DefaultTree_Init();
	}
}

//切换扩展容器的显示隐藏状态(置于工具条容器的下边)
function toggleExtendContainer(){
	var $extendContainer;
	if($("#page-center-tree").length){//带树的处理
		$extendContainer = $("#page-center-grid-top");
		if(!$extendContainer.length){ return;}
		ozlog.info("toggleExtendContainer2");
		if($extendContainer.is(":visible")){
			$extendContainer.hide();
			OZ.View.resize();
		}else{
			$extendContainer.show();
			OZ.View.resize();
		}
	}else{//无树的处理
		$extendContainer = $("#page-top-extendContainer");
		if(!$extendContainer.length){ return;}
		ozlog.info("toggleExtendContainer");
		if($extendContainer.is(":visible")){
			$extendContainer.hide();
			OZ.View.resize();
			if(typeof(callback) == "function"){
				callback.call();
			}
		}else{
			$extendContainer.show();
			OZ.View.resize();
			if(typeof(callback) == "function"){
				callback.call();
			}
		}
	}
}
/** View处理函数 */
OZ.View = {
	/**
	 * 加载表格数据
	 */
	reloadGrid:function(params){
		if(typeof(oz_grid_config) == "undefined"){ return; }
		var store = $('#'+oz_grid_config.id).data("widget-grid").store;	
		if(params){
			var newparams = [];
			for (var key in params){
				newparams.push({name:key,value:params[key]});
			}
			store.params = newparams;
		}
		store.load();
	},
	/*重新加载视图数据*/
	reload: function(){
		OZ.View.reloadGrid();
		if(typeof(oz_tree_config) != 'undefined'){
			$("#" + oz_tree_config.id).tree("reload");
		}
	},
	getGridSelectionIds:function(){
		var rows = OZ.View.getGridSelection();
		if (null == rows || rows.length == 0) {
			return "";
		}
		
		var ids = [];
		for(var i = 0; i < rows.length; i++)
			ids.push(rows[i].id);
		if(ids.length == 0)
			return "";
		return ids.join(";");
	},
	getGridSelection:function(){
		return $("#" + oz_grid_config.id).grid("getSelections");
	},
	/*重新调整视图大小*/
	resize: function(){
		var ch = $(window).height()-$("#page-top").height();
		if($("#page-center-tree").length){
			$("#page-center,#page-center-tree,#page-center-seperator").height(ch);
			$("#page-center-grid,#page-center-grid-top").width($(window).width()-$("#page-center-tree").width()-$("#page-center-seperator").width());
			var gridTop = $("#page-center-grid-top");
			var h2 = gridTop.is(":visible") ? gridTop.outerHeight(true) : 0;//border+padding+content
			$("#page-center-grid").css("top",h2).height(ch - h2);
		}else{
			$extendContainer = $("#page-top-extendContainer");
			var h2 = $extendContainer.is(":visible") ? $extendContainer.outerHeight(true) : 0;//border+padding+content
			$("#page-center").height(ch-h2);
		}
		if(typeof(oz_grid_config) != "undefined"){
			$("#" + oz_grid_config.id).grid("resize");
		}
	},
	/*显示导出视图数据的配置界面-->用户选择-->导出excel*/
	export2Excel: function(_e,dir){
		dir = dir || "top";
		if($("#exporter").length){ $("#exporter").remove();}
		
		var e = $.browser.msie ? jQuery.event.fix(event) : _e;
		if(typeof(oz_grid_config) == 'undefined'){
			return;
		}
		
		var btn = $(e.target);
		var p = btn.offset();
		p.left = p.left + btn.width()/2 - 8 - 10;
		if(dir == "top"){		//指向箭头在上
			p.top = p.top + btn.height() + 4;
		}else if(dir == "bottom"){//指向箭头在下
			p.bottom = ($(document).height() - p.top) + ($.browser.msie ? 6 : 7 );
			delete p.top;
		}
				
		var html = [];
		html.push('<div id="exporter" style="display:none;position:absolute;border:1px solid #B7AC94;background-color:#FFFEDE;width:200px;z-index:999;overflow-y:scroll;max-height: 320px">');
		if(dir == "top"){
			html.push('<div style="position:relative;">');
			html.push('<span id="arrow" class="oz-icon oz-icon-1102" style="position:absolute;margin-top:-15px;left:10px;"></span>');
			html.push('</div>');
		}
		html.push('<form name="exporter" method="post" >');
		
		// 当页数大于1页时让用户确认导出范围
		var store = $('#'+oz_grid_config.id).data("widget-grid").store;	
		var totalPage = Math.ceil(store.getTotalCount() / store.pageSize);
		if(totalPage > 1){
			html.push('<div style="height:22px;line-height:22px;font-size:14px;font-weight:bold;color:#333;">确认导出范围</div>');
			html.push('<ul>');
			html.push('  <li style="margin:2px;_margin:0;">');
			html.push('    <label for="exportScope1">');
			html.push('      <input style="margin:2px 0;_margin:0;" type="radio" id="exportScope1" name="exportScope" value="1" checked>');
			html.push('      <span style="margin:0 4px;_margin:0 2px;">当前页</span>');
			html.push('    </label>');
			html.push('    &nbsp;&nbsp;');
			html.push('    <label for="exportScope2">');
			html.push('      <input style="margin:2px 0;_margin:0;" type="radio" id="exportScope2" name="exportScope" value="2" onclick="OZ.View.exportLargeAlert()">');
			html.push('      <span style="margin:0 4px;_margin:0 2px;">全部</span>');
			html.push('    </label>');
			html.push('  </li>');
			html.push('  <li style="margin:2px;_margin:0;">');
			html.push('    <label for="exportScope3">');
			html.push('      <input style="margin:2px 0;_margin:0;" type="radio" id="exportScope3" name="exportScope" value="3">');
			html.push('      <span style="margin:0 4px;_margin:0 2px;">指定:</span>');
			html.push('    </label>');
			html.push('    <select id="startPage">');
			for(var i = 1; i <= totalPage; i++)
				html.push('      <option value="' + i + '">' + i);
			html.push('    </select>');
			html.push('    -');
			html.push('    <select id="endPage">');
			for(var i = 1; i <= totalPage; i++)
				html.push('      <option value="' + i + '">' + i);
			html.push('    </select>');
			html.push('    &nbsp;&nbsp;');
			html.push('  </li>');
			html.push('</ul>');
		}
		html.push('<div style="margin-top:8px;height:22px;line-height:22px;font-size:14px;font-weight:bold;color:#333;">选择导出字段</div>');
		html.push('<ul>{1}</ul>');
		html.push('<div style="padding:0 4px;text-align:right;">');
		html.push('  <a id="continue" style="text-decoration:underline;cursor:pointer;">继续</a>');
		html.push('  &nbsp;&nbsp;');
		html.push('  <a id="cancel" style="text-decoration:underline;cursor:pointer;">取消</a>');
		html.push('</div>');
		html.push('<input type="hidden" name="title">');
		html.push('<input type="hidden" name="exportFileName">');
		html.push('<input type="hidden" name="headerIds">');
		html.push('<input type="hidden" name="headerNames">');
		html.push('</form>');
		if(dir == "bottom"){
			html.push('<div style="position:relative;">');
			html.push('  <span class="oz-icon oz-icon-1103" style="position:absolute;margin-top:-1px;left:10px;"></span>');
			html.push('</div>');
		}
		html.push('</div>');
		
		// 选择导出的字段
		var columns = oz_grid_config.columns;
		var headerIds = [], headerNames = [];
		var fields = [], field,name;
		
		var convertFieldSplitSymbol = "";
		if((typeof getNeedConvertFieldSplitSymbol) == "function"){
			convertFieldSplitSymbol = getNeedConvertFieldSplitSymbol.call(this);
		}else{
			convertFieldSplitSymbol = true;
		}
		
		for(var i = 1; i < columns.length; i++){
			if(convertFieldSplitSymbol)
				field = columns[i].dataIndex.replace("_",".");
			else
				field = columns[i].dataIndex;
			headerIds.push(field);
			if(columns[i].text){
				name = columns[i].text;
			}else{
				name = field;
			}
			headerNames.push(name);
			fields.push('<li style="margin:2px;_margin:0;">');
			fields.push('  <label for="field' + i + '">');
			fields.push('    <input style="margin:2px 0;_margin:0;" type="checkbox" id="field' + i + '" name="field" value="' + field + '" checked>');
			fields.push('    <span style="margin:0 4px;_margin:0 2px;">' + name + '</span>');
			fields.push('  </label>');
			fields.push('</li>');
		}
		var title = $("body").attr("name");
		
		// 按钮事件
		var exporter = $(OZ.String.format(html.join(""),"",fields.join(""))).appendTo("body").css(p).show(); // 定位
		exporter.find("#continue").click(function(){ // 点击继续
			var $form = $("#exporter").find("form");			
			var _form = $form.get(0);

			// 计算导出的Url
			var url = "";
			if((typeof getViewExportUrl) == "function"){
				url = getViewExportUrl.call(this);
			}else{
				url = oz_grid_config.path +(oz_grid_config.path.indexOf("?")>-1?"&":"?")+ "action=exportPage";
			}
			url += "&exportFormat=xls&isExport=true";
			
			// 获取导出范围
			if(totalPage > 1){
				var exportScope = $form.find("input:checked[name='exportScope']").val();
				var startPage, endPage;
				if(exportScope == "1"){
					startPage = store.currentPage;
					endPage = store.currentPage;
				}else if(exportScope == "2"){					
					startPage = "-1";
					endPage = "-1";
				}else if(exportScope == "3"){
					startPage = $form.find("#startPage").val();
					endPage = $form.find("#endPage").val();
					if(endPage < startPage){
						var page = startPage;
						startPage = endPage;
						endPage = page;
					}
				}
				url += "&startPage=" + startPage;		// 起始页码
				url += "&endPage=" + endPage;			// 结束页码
				url += "&pageSize=" + store.pageSize;	// 每页最大条目数
			}
			if (store.sortname){
				url += "&sort=" + store.sortname;		// 排序名
				url += "&order=" + store.sortorder;		// 排序方向
			}
			
			// 用户的查询参数
			var eh=[];
			if (store.params && store.params.length) {
                for (var pi = 0; pi < store.params.length; pi++) {
                	eh.push('<input type="hidden" name="'+store.params[pi].name+'" value="'+store.params[pi].value+'">');
                }
            }
			if(eh.length){ 
				$form.append(eh.join(""));
			}
			
			// 处理表单的一些隐藏域
			var hiddens = $form.find("input:hidden");
			var title = $("body").data("name");
			hiddens.filter("[name='title'],[name='exportFileName']").val(title);
			var headerIds=[], headerNames=[];
			var checkboxes = $form.find("input:checked[name='field']");
			checkboxes.each(function(){
				headerIds.push(this.value);
				headerNames.push($(this).next().html());
			});
			hiddens.filter("[name='headerIds']").val(headerIds.join(","));
			hiddens.filter("[name='headerNames']").val(headerNames.join(","));
						
			//提交表单
			_form.action = url;
			_form.target = "blank";
			_form.submit();
			$("#exporter").remove();
		});
		exporter.find("#cancel").click(function(){//点击取消
			exporter.remove();
		});
	},
	exportLargeAlert:function(){
		var maxResule = 5000;
		var store = $('#'+oz_grid_config.id).data("widget-grid").store;	
		if(store.getTotalCount() > maxResule){
			OZ.Msg.warn("您所要导出的数据量太大(已超过" + maxResule + "条),导出时会耗费较长时间.");
		}
	}
};


//---------------- 页面初始化调用函数 ----------------
jQuery(function($){
	if((typeof onPage_Init) == "function"){
		onPage_Init();
	}else{
		oz_DefaultPage_Init();
	}
});

// 页面默认的刷新函数
function ozRefresh(data){
	ozTB_BtnRefresh_Clicked();
}

document.onkeypress=onkeydown;  
//禁止后退键  作用于IE、Chrome  
document.onkeydown=onkeydown;

function onkeydown()
{
	if ((event.keyCode==8) ) //屏蔽退格删除键  
	{   
	
	  if (window.event.srcElement.tagName.toUpperCase()!="INPUT" && window.event.srcElement.tagName.toUpperCase()!="TEXTAREA" && window.event.srcElement.tagName.toUpperCase()!="TEXT")  
	  {
	    event.keyCode=0;
	    event.returnValue=false;
	  }
	}

}