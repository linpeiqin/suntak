function oz_Default_Open_Row(rowIndex,rowData,data){
    new OZ.Dlg.create({
        id:oz_grid_config.id+rowData.id,
        width:300, height:150,
        title:oz_GetTabTitle(rowData),
        url: OZ.addParamToUrl(oz_grid_config.path,"action="+ozOpenActionName+"&id=" + rowData.id),
        buttons:"none"
    });
}


function ozTB_DefaultBtnNew_Clicked(action,url){
    var url = url|| OZ.addParamToUrl(action, "action=create&equipmentId="+getEquipmentId());
    var rows = $('#techEditGrid').datagrid('getRows');
	if (rows){
		var index=rows.length;
	} else {
		index = 0;
	}
	$('#techEditGrid').datagrid('insertRow', {
		index: index,
		row:{
			id:-1
		}
	});
	$('#techEditGrid').datagrid('selectRow',index);
	$('#techEditGrid').datagrid('beginEdit',index);
}
function add(){
	    var rows = $('#techEditGrid').datagrid('getRows');
		if (rows){
			var index=rows.length;
		} else {
			index = 0;
		}
		$('#techEditGrid').datagrid('insertRow', {
			index: index,
			row:{
				id:-1
			}
		});
		$('#techEditGrid').datagrid('selectRow',index);
		$('#techEditGrid').datagrid('beginEdit',index);
}
function reloadData(equipmentId){
    var searchQuery = {};
    if ($("#ozQuery").val()!=""){
        searchQuery.dbftsParams = $("#ozQuery").val();
    }
    var eid = getEquipmentId()||equipmentId;
    if (eid){
    	 searchQuery.equipmentId = eid;
    	 $('#techEditGrid').datagrid('reload',{equipmentId:eid});
    }
}
function getEquipmentId(){
    var rows = window.parent.OZ.View.getGridSelection();
    if (rows.length==0){
        oz.Msg.info("请选择需要操作的数据！");
        return false;
    }
    if (rows.length>1){
        oz.Msg.info("请选择一个需要操作的数据记录！");
        return false;
    }
    return  rows[0].id;
}

function getEquipmentIds(){
    var rows = window.parent.OZ.View.getGridSelection();
    if (rows.length==0){
        return '-1';
    }
    if (rows.length>1){
    	return '-1';
    }
    return  rows[0].id;
}

function reloadGridSelf(equipmentId){
    reloadData(equipmentId);
}

function onBtnSearch_Clicked(searchCondition){
    reloadData();
}

function onBtnReset_Clicked(){
    $("#ozQuery").val("");
    reloadData();
}
$(function(){
    $('#techEditGrid').datagrid({
		title:'添加',
		fit:true,
        singleSelect:true,
        idField:'id',
        url: contextPath + "/ems/technicalParamsAction.do?action=getTechParaJson",
        queryParams:{equipmentId:getEquipmentIds},
        rownumbers: true,
        loadMsg:'数据加载中请稍后……',
        pagination: true,
		nowrap:false,
		striped:false,
		columns:[[
            {field:'technicalParam',title:'参数',width:150,align:'center',editor:'text'},
            {field:'paramValue',title:'值',width:160,editor:'text'},
            {field:'action',title:'操作',width:180,align:'center',
                formatter:function(value,row,index){
                	if (row.editing){
						var s = '<a href="javascript:void(0)" onclick="saverow(this)">保存</a> ';
						var c = '<a href="javascript:void(0)" onclick="cancelrow(this)">取消</a>';
						return s+c;
					} else {
						var e = '<a href="javascript:void(0)" onclick="editrow(this)">编辑</a> ';
						var d = '<a href="javascript:void(0)" onclick="deleterow(this)">删除</a>';
						return e+d;
					}
                }
            }
        ]],
        onBeforeEdit:function(index,row){
            row.editing = true;
            $(this).datagrid('refreshRow', index);
        },
        onAfterEdit:function(index,row){
            row.editing = false;
            $(this).datagrid('refreshRow', index);
        },
        onCancelEdit:function(index,row){
            row.editing = false;
            $(this).datagrid('refreshRow', index);
        },
        onLoadSuccess:function(data){
        	
        }
    });
	appendAddToBoor();
});
function appendAddToBoor(){
	$('.panel-title').addClass('panel-with-icon').after('<a href="javascript:void(0)" class="panel-icon icon-add" onclick="add()"/>');
}
function cancelrow(target){
	var index = getRowIndex(target);
	var row = $('#techEditGrid').datagrid('getRows')[index];
	var id = row.id;
	if(id==null||id==""||id=="-1"){
		$('#techEditGrid').datagrid('deleteRow', getRowIndex(target));
	}else{
		$('#techEditGrid').datagrid('cancelEdit', getRowIndex(target));
	}
}
function editrow(target){
	$('#techEditGrid').datagrid('beginEdit', getRowIndex(target));
}

function deleterow(target){
	oz.Msg.confirm('确定删除这一行？',function(r){
		var index = getRowIndex(target);
		var row = $('#techEditGrid').datagrid('getRows')[index];
		var id = row.id;
		$.post(
				contextPath + "/ems/technicalParamsAction.do?action=delete",
				{id:id},
				function(json){
					if(json.result === false){
						oz.Msg.info("删除失败");
					}else{
						$('#techEditGrid').datagrid('deleteRow', getRowIndex(target));
					}
				},
				"json"
		);
	});
}

function saverow(target){
	var index;
	if(target!=null){
		index = getRowIndex(target);
	}
	var row = $('#techEditGrid').datagrid('getRows')[index];
	$('#techEditGrid').datagrid('endEdit', index);
	var rowIndex = $('#techEditGrid').datagrid('getRowIndex',row);
	if (row){
		var id = row.id;	
		var technicalParam = row.technicalParam;
		var paramValue = row.paramValue;
		var equipmentId = getEquipmentId();
		$.post(
				contextPath + "/ems/technicalParamsAction.do?action=saveRow", 
				{technicalParam:technicalParam,paramValue:paramValue,id:id,equipmentId:equipmentId},
				function(json){
					if(json.result === true){
						$('#techEditGrid').datagrid('refreshRow', rowIndex);
						row.id=json.id;
					}else{
						 oz.Msg.info("保存失败");
					}
				},
				"json"
		);
		
	}
}
function getRowIndex(target){
	var tr = $(target).closest('tr.datagrid-row');
	return parseInt(tr.attr('datagrid-row-index'));
}