$(function() {
    $('#partsGrid').datagrid({
        fit: true,
        singleSelect: true,
        idField: 'partId',
        url: contextPath + "/ems/repairRecordAction.do?action=getPartReplaceJson&id=" + getRepairRecord(),
        rownumbers: true,
        loadMsg: '数据加载中请稍后……',
        pagination: true,
        columns: [[
            {field: 'lineTypeName', title: '类型', width: 80, align: 'center'},
            {field: 'partNo', title: '配件编号', width: 80, align: 'center'},
            {field: 'partName', title: '配件名称', width: 450},
            {field:'section',title:'分段',width:60,align:'right'},
            {field: 'qty', title: '数量', width: 80, align: 'right'},
            {field: 'price', title: '单价', width: 80, align: 'right'},
            {field: 'totalPrice', title: '金额', width: 80, align: 'right'}
        ]]
    });
});

function getRepairRecord(){
    return  window.parent.getFormId();
}