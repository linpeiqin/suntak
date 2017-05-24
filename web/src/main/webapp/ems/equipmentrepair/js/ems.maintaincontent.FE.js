
function deletedata(){
      $("input[name='selectedBox']:checked").each(function() { // 遍历选中的checkbox
          var n = $(this).parents("#maintainContentGrid tr").index();  // 获取checkbox所在行的顺序
	            $("table#maintainContentGrid").find("tr:eq("+n+")").remove();
     });
	
}

/**添加新行*/ 
function addNew(){   
	var _len = $("#maintainContentGrid tr").length; 
	$("#maintainContentGrid").append("<tr id="+_len+" align='center'>"
			  +"<td class='oz-property'>"
			  +"<input type='checkbox' name='selectedBox' width='5%'/>"
			  +"</td>"
			  +"<td class='oz-property' width='35%'><input type='text' name='content' id='content_"+_len+"'/></td>"
	          +"<td class='oz-property' width='10%'><input type='checkbox' name='mCheck_"+_len+"' id='mCheck_"+_len+"'  value='1'/></td>"
	          +"<td class='oz-property' width='10%'><input type='checkbox' name='mClear_"+_len+"' id='mClear_"+_len+"'  value='1'/></td>"
	          +"<td class='oz-property' width='10%'><input type='checkbox' name='mAdjust_"+_len+"' id='mAdjust_"+_len+"'  value='1'/></td>"
	          +"<td class='oz-property' width='10%'><input type='checkbox' name='mLubric_"+_len+"' id='mLubric_"+_len+"' value='1'/></td>"
	          +"<td class='oz-property' width='10%'><input type='checkbox' name='mRepair_"+_len+"' id='mRepair_"+_len+"' value='1'/></td>"
	          +"<td class='oz-property' width='10%'><input type='checkbox' name='mChange_"+_len+"' id='mChange_"+_len+"' value='1'/></td>"
	          +"</tr>"); 
}  