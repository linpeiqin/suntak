$(function() {
    $('#partsGrid').datagrid({
        fit: true,
        singleSelect: true,
        idField: 'itemId',
        url: contextPath + "/ems/pRHeadAction.do?action=getPRLineJson&id="+getPRHead(),
        rownumbers: true,
        loadMsg: '数据加载中请稍后……',
        pagination: true,
        columns: [[
            {field:'urgentText',title:'紧急',width:50,align:'center'},
     /*       {field:'lineTypeName',title:'类型',width:80,align:'center'},*/
            {field:'itemNo',title:'配件编号',width:80,align:'center'},
	    	{field:'itemName',title:'配件名称',width:280,align:'center'},
	    	{field:'itemUnit',title:'单位',width:50,align:'center'},
	    	{field:'qty',title:'数量',width:50,align:'right',precision:4},
	    	{field:'price',title:'价格',width:80,align:'right',precision:4},
	    	{field:'amount',title:'总价',width:100,align:'right',precision:4},
            {field:'needReason',title:'用途',width:180,align:'center'},
	    	{field:'promisedDate',title:'预计到达日期',width:120,align:'right'},
            {field:'needDate',title:'实际到达日期',width:120,align:'right'}
        ]],
        onLoadSuccess:function(data){
            if (data.total>0){
            	compute();
            }

        }
    });

});
function compute() {
    var rows = $('#partsGrid').datagrid('getRows')//获取当前的数据行
    var total = 0;//计算listprice的总和
    for (var i = 0; i < rows.length; i++) {
        total += rows[i]['amount'];
    }
    //新增一行显示统计信息
    $('#partsGrid').datagrid('appendRow', { price: '<b>合计：</b>', amount: total });
    }
function getPRHead(){
    return  window.parent.getFormId();
}