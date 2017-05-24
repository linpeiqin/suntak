/**
 * Created by linking on 2016/8/5.
 */
var requiredList = ['partNo','partName','type','amount','price','total','startInventory','endInventory'];

function beforeSave(){
    var $partsData = $('#partsGrid').datagrid("getData");
   if ($partsData.total==0){
       oz.Msg.info("请填写配件清单");
       return false;
    }

    var k1=true,k2=true,k3=true;
    for (var i =0;i<$partsData.total;i++){
        $('#partsGrid').datagrid('endEdit', i);
        delete $partsData.rows[i]['editing'];
        var p="";
        for (var j=0;j<requiredList.length;j++){
            if (!$partsData.rows[i][requiredList[j]]){
                p += requiredList[j]+",";
            }
        }
        if (p!==""){
            oz.Msg.info("请填写完整清单："+(i+1)+"行,"+p);
            return false;
        }
    }
    if ($('#operation').val()=='1'&&　$('#equipmentId').val()=='-1'){
        oz.Msg.info("出库请填写设备");
        return false;
    }
   $("#orderLines1").val($.toJSON($partsData.rows));
}
function showOrHide(b) {
    var $b = $(b);
    if ($b.val() == 0) {
        $('.equipmentClass, .outClass, #btnSelectEquipment').hide();
        $('.inClass').show();
        $('.outClass').val('');
        $('#equipmentId').val(-1);
    } else {
        $('.equipmentClass,.outClass,#btnSelectEquipment').show();
        $('.inClass').val('').hide();
    }
}



$(function(){
    showOrHide($('#operation'));
    $('#partsGrid').datagrid({
        title:'添加配件',
        fit:true,
        singleSelect:true,
        idField:'partNo',
        url: contextPath + "/ems/orderHeadAction.do?action=getOrderLineJson&id="+$('#id').val(),
        rownumbers: true,
        loadMsg:'数据加载中请稍后……',
        pagination: true,
        columns:[[
            {field:'partNo',title:'配件编号',width:80,align:'center'},
            {field:'partName',title:'配件名称',width:500},
            {field:'qty',title:'数量',width:80,align:'right',editor:{type:'numberbox',options:{required:true}}},
            {field:'price',title:'单价',width:60,editor:{type:'numberbox',options:{precision:2,required:true}},formatter:formatterFixed},
            {field:'amount',title:'金额',width:60,formatter:formatterFixed},
            {field:'action',title:'操作',width:  150,align:'center',
                formatter:function(value,row,index){
                    if (row.editing){
                        var a = '<a href="javascript:void(0)" onclick="selectPart(this)">选择</a> ';
                        var b = '<a href="javascript:void(0)" onclick="saveRow(this)">确定</a> ';
                        var c = '<a href="javascript:void(0)" onclick="editRow(this)">编辑</a> ';
                        var d= '<a href="javascript:void(0)" onclick="cancelRow(this)">取消</a> ';
                        var e = '<a href="javascript:void(0)" onclick="deleteRow(this)">删除</a>';
                        return /*a+*/b+c+e;
                    }
                }
            }
        ]],
        onBeforeEdit:function(index,row){
            row.editing = true;
            $(this).datagrid('refreshRow', index);
        },
        onAfterEdit:function(index,row){
            row.total = parseInt(row.amount)*parseFloat(row.price);
            row.editing = false;
            $(this).datagrid('refreshRow', index);
        },
        onCancelEdit:function(index,row){
            row.editing = false;
            $(this).datagrid('refreshRow', index);
        },
        onLoadSuccess:function(data){
            if (data.total>0){
                for (var index=0;index<data.total;index++){
                    $('#partsGrid').datagrid('beginEdit',index);
                }
            }
        }
    });
    appendInsToBoor();
});
function formatterFixed(value,row,index){
    if(value!=null)
        return value.toFixed(2);
}

function getRowIndex(target){
    var tr = $(target).closest('tr.datagrid-row');
    return parseInt(tr.attr('datagrid-row-index'));
}

function deleteRow(target){
    $('#partsGrid').datagrid('deleteRow', getRowIndex(target));
}

function saveRow(target){
    $('#partsGrid').datagrid('endEdit', getRowIndex(target));
}
function editRow(target){
    $('#partsGrid').datagrid('beginEdit', getRowIndex(target));
}
function cancelRow(target){
    $('#partsGrid').datagrid('cancelEdit', getRowIndex(target));
}
function selectPart(target){
    var strUrl = contextPath + "/ems/partInfoAction.do?action=dlgPartInfo";
    new OZ.Dlg.create({
        id:"dlg_partInfo",
        width:600, height:600,
        title:'选择配件',
        url: strUrl,
        onOk:function(rows){
            afterSelectPartInfo(rows,target);
        },onCancel:function(result){
        }
    });
}

function insertRow(json,target){
    var row = $('#partsGrid').datagrid('getSelected');

    if (row){
        var index = $('#partsGrid').datagrid('getRowIndex', row);
    } else {
        index = 0;
    }

    $('#partsGrid').datagrid('insertRow', {
        index: index,
        row:json
    });
    $('#partsGrid').datagrid('selectRow',index);
    $('#partsGrid').datagrid('beginEdit',index);
}

function afterSelectPartInfo(rows,target){
    var $partsData = $('#partsGrid').datagrid("getData");
    for (var i=0;i< rows.length;i++) {
        var p = true;
        for (var j =0;j<$partsData.total;j++){
            if (rows[i].partNo==$partsData.rows[j].partNo){
                p = false;
                break;
            }
        }
        if (p) insertRow(rows[i],target);
    }
}