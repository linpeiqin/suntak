/**
 * Created by linking on 2016/8/4.
 */
function oz_GetTitle(json){
    return "添加配件";
}

function selectPart(target){
    var strUrl = contextPath + "/ems/partInfoAction.do?action=dlgPartInfo";
    new OZ.Dlg.create({
    	
        id:"dlg_partInfo",
        width:920, height:600,
        title:'选择配件',
        url: strUrl,
        onOk:function(rows){
            afterSelectPartInfo(rows,target);
        },onCancel:function(result){
        }
    });
}

function getPartsGridData(){
    return $('#partsGrid').datagrid("getData");
}
function checkData(){
    var $partsData = $('#partsGrid').datagrid("getData");
    if ($partsData.total>0){
        for (var i =0;i<$partsData.total;i++){
          /*  var ed = $('#partsGrid').datagrid('getEditor', { index: i, field: 'lineTypeId' });  //editIndex编辑时记录下的行号
            if (ed != null) {
                var lineTypeName = $(ed.target).combobox('getText');
                $('#partsGrid').datagrid('getRows')[i]['lineTypeName'] = lineTypeName;
            }*/
            var ee = $('#partsGrid').datagrid('getEditor', { index: i, field: 'isUrgent' });  //editIndex编辑时记录下的行号
            if (ee != null) {
                var urgentText = $(ee.target).combobox('getText');
                $('#partsGrid').datagrid('getRows')[i]['urgentText'] = urgentText;
            }
            $('#partsGrid').datagrid('endEdit', i);
            if (!$partsData.rows[i].qty){
                oz.Msg.info("请填写完整配件："+(i+1)+"行,数量");
                return false;
            }
        }
    }
    return true;
}
function afterSelectPartInfo(rows,target){
    var $partsData = $('#partsGrid').datagrid("getData");
    for (var i=0;i< rows.length;i++) {
        var p = true;
        for (var j =0;j<$partsData.total;j++){
            if (rows[i].partId==$partsData.rows[j].itemId){
                p = false;
                break;
            }
        }
        if (p) insertRow(rows[i],target);
    }
}
function getPRHead(){
    return  window.parent.getFormId();
}

$(function(){
    var url = "";
    if (getPRHead()!=-1){
        url = contextPath + "/ems/pRHeadAction.do?action=getPRLineJson&id="+getPRHead();
    }

    var urgent =  [{ "isUrgent": "N", "urgentText": "否","selected":"selected" }, { "isUrgent": "Y", "urgentText": "是" }];
    $('#partsGrid').datagrid({
        title:'添加配件',
        fit:true,
        singleSelect:false,
        idField:'itemId',
        url: url,
        rownumbers: true,
        loadMsg:'数据加载中请稍后……',
        pagination: true,
        showFooter:true,  
        height:200,
        columns:[[
            {field:'isUrgent',title:'紧急',width:50,align:'center',editor: {
                type: 'combobox',
                options: {
                    data: urgent,
                    valueField: "isUrgent",
                    textField: "urgentText" ,
          /*          onLoadSuccess:function(){
                        $('#isUrgent').combobox('select', '0');
                    },*/
                    panelHeight: "auto",
                    editable: false ,
                    required:true} },
                    formatter: function(value,row){
                    return row.urgentText;
                }
            },
          /*  {field:'lineTypeId',title:'类型',width:80,align:'center',editor : {
                type : 'combobox',
                options : {
                	url:contextPath+ '/ems/pRLineAction.do?action=getLineTypeList',
                	valueField: "lineTypeId",/!* value是unitJSON对象的属性名 *!/
                    textField: "lineTypeName",/!* name是unitJSON对象的属性名 *!/
                    editable:false,
                    required:true,
                    panelHeight:'auto'
                }
                },
                formatter: function(value,row){
                    return row.lineTypeName;
                }
            },*/
            {field:'itemNo',title:'配件编号',width:80,align:'center'},
            {field:'itemName',title:'配件名称',width:340,align:'center'},
            {field:'itemUnit',title:'单位',width:50,align:'center'},
            {field:'qty',title:'数量',width:50,align:'right',editor:{type:'numberbox',options:{required:true}}},
            {field:'price',title:'价格',width:80,align:'right',editor:{type:'numberbox',options:{precision:4,required:true}}},
            {field:'amount',title:'总价',width:120,align:'right',precision:4},
            {field:'needReason',title:'用途',width:180,align:'center',editor:{type:'text'}},
            {field:'promisedDate',title:'预计到达日期',width:120,align:'right',editor:{type:'datebox',options:{required:true}}},
            {field:'needDate',title:'实际到达日期',width:80,align:'right'},
            {field:'action',title:'操作',width:180,align:'center',
                formatter:function(value,row,index){
                    if (row.editing){
                        var a = '<a href="javascript:void(0)" onclick="selectPart(this)">选择</a> ';
                        var b = '<a href="javascript:void(0)" onclick="saveRow(this)">确定</a> ';
                        var c = '<a href="javascript:void(0)" onclick="editRow(this)">编辑</a> ';
                        var d= '<a href="javascript:void(0)" onclick="cancelRow(this)">取消</a> ';
                        var e = '<a href="javascript:void(0)" onclick="deleteRow(this)">删除</a>';
                        return b+c+e;
                    }
                }
            }
        ]],
        
        onBeforeEdit:function(index,row){
            row.editing = true;
            $(this).datagrid('refreshRow', index);
            
        },
        onAfterEdit:function(index,row){
        	var price = row.price;
        	var qty = row.qty;
        	var amount = parseFloat(parseFloat(row.price) * parseFloat(row.qty));
            row.amount = amount.toFixed(4);
            row.editing = false;

            $(this).datagrid('refreshRow', index);
           
            
        },
        onEndEdit:function (index,row) {
            if (editIndex == undefined) { return true }
            if ($('#partsGrid').datagrid('validateRow', editIndex)) {
           /*     var ed = $('#partsGrid').datagrid('getEditor', { index: editIndex, field: 'lineTypeId' });  //editIndex编辑时记录下的行号
                if (ed != null) {
                    var lineTypeName = $(ed.target).combobox('getText');
                    $('#partsGrid').datagrid('getRows')[editIndex]['lineTypeName'] = lineTypeName;
                }
                var ee = $('#partsGrid').datagrid('getEditor', { index: editIndex, field: 'isUrgent' });  //editIndex编辑时记录下的行号*/
                if (ee != null) {
                    var urgentText = $(ee.target).combobox('getText');
                    $('#partsGrid').datagrid('getRows')[editIndex]['urgentText'] = urgentText;
                }
                $('#partsGrid').datagrid('endEdit', editIndex);
                editIndex = undefined;
                $(this).datagrid('refreshRow', index);
                return true;
            }
            else {return false;}
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

function getRowIndex(target){
    var tr = $(target).closest('tr.datagrid-row');
    return parseInt(tr.attr('datagrid-row-index'));
}

function deleteRow(target){
    $('#partsGrid').datagrid('deleteRow', getRowIndex(target));
}

function saveRow(target){
    var index = getRowIndex(target);
    var row = $('#partsGrid').datagrid('getData',index).rows[index];
 /*   var ed = $('#partsGrid').datagrid('getEditor', { index: index, field: 'lineTypeId' });
    if (ed != null) {
        row.lineTypeName = $(ed.target).combobox('getText');
    }*/
    var ee = $('#partsGrid').datagrid('getEditor', { index: index, field: 'isUrgent' });
    if (ee != null) {
        row.urgentText = $(ee.target).combobox('getText');
    }
    $('#partsGrid').datagrid('endEdit', getRowIndex(target));
    $(this).datagrid('refreshRow', index);
}
function editRow(target){
    $('#partsGrid').datagrid('beginEdit', getRowIndex(target));
}
function cancelRow(target){
    $('#partsGrid').datagrid('cancelEdit', getRowIndex(target));
}
function insertRow(json,target){
	var arr = {};
    arr.isUrgent = 'N';
  /*  arr.lineTypeId = 1;*/
	arr.itemNo = json.partNo;
	arr.itemName = json.partName;
	arr.price = parseFloat(json.price);
	arr.itemUnit = json.UOMCode;
	arr.itemId = json.itemId;
    var row = $('#partsGrid').datagrid('getSelected');
    if (row){
        var index = $('#partsGrid').datagrid('getRowIndex', row);
    } else {
        index = 0;
    }

    $('#partsGrid').datagrid('insertRow', {
        index: index,
        row:arr
    });
    $('#partsGrid').datagrid('selectRow',index);
    $('#partsGrid').datagrid('beginEdit',index);
}
function compute() {
    var rows = $('#partsGrid').datagrid('getRows')//获取当前的数据行
    var total = 0;//计算listprice的总和
    for (var i = 0; i < rows.length; i++) {
        total += rows[i]['amount'];
    }
    //新增一行显示统计信息
    $('#partsGrid').datagrid('appendRow', { price: '<b>合计：</b>', amount: total });
    }
