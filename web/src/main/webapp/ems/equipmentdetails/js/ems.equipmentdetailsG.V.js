$(function(){
    var queryParams = {contractNo:contractNo,fixedAssetsName:fixedAssetsName,specificationModel:specificationModel,lifeCycleId:lifeCycleId,type:type};
    $('#edGrid').datagrid({
		fit:true,
        idField:'id',
        url: contextPath + "/ems/equipmentDetailsAction.do?action=getEquipmentByType",
        queryParams:queryParams,
        rownumbers: true,
        loadMsg:'数据加载中请稍后……',
        pagination: true,
		nowrap:false,
		striped:false,
        singleSelect:false,
        columns:[[
		    {field:'id',hidden:true},
            {field:'ck',checkbox:true,editor:{options: {on: true,off: false}}},/*,editor:{options: {on: true,off: false}}*/
            {field:'contractNumber',title:'合同编号',width:150},
            {field:'equipmentName',title:'设备名称',width:200},
            {field:'specificationModel',title:'规格型号',width:100},
            {field:'equipmentNo',title:'设备编号',width:100,editor:{type:'text'}},
            {field:'parentName',title:'主设备',width:100},
            {field:'parentId',hidden:true},
            {field:'action',title:'操作',width:100,formatter:operation}
        ]],
        onSelect:function(index,row){
            if(type==0){
                $('#edGrid').datagrid('beginEdit',index);
            }
        },
        onUnselect:function(index,row){
            if(type==0){
                var ed = $('#edGrid').datagrid('getEditor', {index:index,field:'equipmentNo'});
                $(ed.target).val('');
                $('#edGrid').datagrid('endEdit',index);
            }

        },
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
            var eNOs = [];
            if (equipmentNos){
                eNOs = eval('('+equipmentNos+')');
            }
            if (data.total>0){
                for (var index=0;index<data.total;index++){
                    if (eNOs.length>0){
                        for (var i = 0;i<eNOs.length;i++){
                             if (eNOs[i].id==data.rows[index].id){
                                data.rows[index].equipmentNo = eNOs[i].equipmentNo;
                                data.rows[index].parentName = eNOs[i].parentName;
                                $('#edGrid').datagrid('selectRow',index);
                            }
                        }
                    }
                    if(type==0){
                        $('#edGrid').datagrid('beginEdit',index);
                    }
                    data.rows[index].rowIndex = index;
                }
            }


        }
    });
    $('#edGrid').datagrid({selectOnCheck:$(this).is(':checked')});
});


function getRowIndex(target){
    var tr = $(target).closest('tr.datagrid-row');
    return parseInt(tr.attr('datagrid-row-index'));
}

function operation(value,row,index){
    var add = '<a href="javascript:void(0)" onclick="addParent(this)">添加主设备</a> ';
    var del = '<a href="javascript:void(0)" onclick="deleteRow(this)">删除</a> ';
    return add;
}

function saveRow(target){
    $('#edGrid').datagrid('endEdit', getRowIndex(target));
}
function editRow(target){
    $('#edGrid').datagrid('beginEdit', getRowIndex(target));
}
function cancelRow(target){
    $('#edGrid').datagrid('cancelEdit', getRowIndex(target));
}

function ozDlgOkFn() {
    var $edGrid = $('#edGrid').datagrid("getData");
    var $edSelectData = $('#edGrid').datagrid("getSelections");
    var $reData = [];
    for(var i =0;i<$edSelectData.length;i++){
        $('#edGrid').datagrid('endEdit', $edSelectData[i].rowIndex);
        if($edSelectData[i].equipmentNo==null||$edSelectData[i].equipmentNo==""){
            oz.Msg.info("填写设备编号");
            $('#edGrid').datagrid('beginEdit', $edSelectData[i].rowIndex);
            return;
        }
        delete $edSelectData[i]['editing'];
        $reData.push($edSelectData[i]);
    }
    return $reData;
}

function deleteRow(target){
    $('#edGrid').datagrid('deleteRow', getRowIndex(target));
}
function addParent(target){
    event.stopPropagation();
    var index  = getRowIndex(target);
    var row = $('#edGrid').datagrid('getRows')[index];
    var ed = $('#edGrid').datagrid('getEditor', {index:index,field:'equipmentNo'});
    var equipmentNo =  $(ed.target).val();

    if (!equipmentNo){
        oz.Msg.info("填写设备编号,再选择主设备");
        return false;
    }
    var strUrl = contextPath + "/ems/equipmentDetailsAction.do?action=dlgEquipmentY&id="+row.id+"&method=addMain";
    new OZ.Dlg.create({
        id:"dlg_equipment",
        width:800, height:600,
        title:'选择设备',
        url: strUrl,
        onOk:function(result){
            afterAddParent(result,row,target);
        },onCancel:function(result){
        }
    });
}

function afterAddParent(result,row,target){
    debugger;
    row.parentName = result.equipmentName;
    row.parentId = result.equipmentId;
    // $('#edGrid').datagrid('refreshRow', row.rowIndex);  
    $('#edGrid').datagrid('endEdit', row.rowIndex);
    $('#edGrid').datagrid('beginEdit', row.rowIndex);
}
function getRowIndex(target){
    var tr = $(target).closest('tr.datagrid-row');
    return parseInt(tr.attr('datagrid-row-index'));
}
$("#edGrid").datagrid({
    onClickRow : function(index, row){

    }
});
