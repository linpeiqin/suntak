/**
 * Created by linking on 2016/8/5.
 */

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
var i = 0;
OZ.Form.resize = function (){
    var ch = $(window).height();
    $("#page-center").height(ch);
   if (i==1){
        $("#partsGrid").datagrid('resize');
   } else {
       i=1;
   }
}

$(function(){
    showOrHide($('#operation'));
    $('#partsGrid').datagrid({
        title:'配件清单',
        fit:true,
        singleSelect:true,
        idField:'partNo',
        url: contextPath + "/ems/orderHeadAction.do?action=getOrderLineJson&id="+$('#id').val(),
        rownumbers: true,
        loadMsg:'数据加载中请稍后……',
        pagination: true,
        columns:[[
            {field:'partNo',title:'配件编号',width:120,align:'center',sortable:true},
            {field:'partName',title:'配件名称',width:450},
            {field:'qty',title:'数量',width:80,align:'right'},
            {field:'price',title:'单价',width:60,formatter:formatterFixed},
            {field:'amount',title:'金额',width:60,formatter:formatterFixed}
        ]],
    });
});

function formatterFixed(value,row,index){
    if(value!=null)
        return value.toFixed(2);
}
