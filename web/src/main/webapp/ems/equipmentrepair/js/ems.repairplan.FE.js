/**
 * Created by linking on 2016/8/4.
 */


function oz_GetTitle(json){
    return "保养计划";
}

function beforeSave(){
	var bln = false;
	 if ($("#equipmentId").val()==-1){
	      oz.Msg.info("请选择设备!");
	      return false;
	  }
	  $(":checkbox").each(function(){
		  var checked = this.checked;
		  if(checked){
			  bln = true;
			  return true;
		  }
	  });
	  if(bln){
		  var id = $("#id").val();
		  if(id == ''){
			  var notExt = true;
			  var equipmentId = $("#equipmentId").val();
				var strUrl = contextPath + "/ems/repairPlanAction.do?action=checkData";
				$.ajax({
		            type: "post",
		            async: false,
		            url: strUrl,
		            data: {equipmentId:equipmentId},
		            dataType: "json",
		            success: function (json) {
		            	if(json.isExt){
							oz.Msg.info('该设备已做保养计划，请勿重复添加！');
							notExt = false;
						}
		            },
		            error: function (err) {
		                alert(err);
		            }
		        });
				return notExt;
		  }
		}else{
			oz.Msg.info("最少选择一个保养规则！");
			return false;
		}
	 
}
function onBtnSave_Success(){
	loadSubPanel("iframe1",contextPath + "/ems/repairPlanAction.do?action=displayTime&planId="+$('#id').val()+"&barShow=${barShow}");
}
function doDistribution(user) {
    $('#maintenancePeson').val(user.name);
    $('#maintenancePesonId').val(user.id);
}

function disabledItems(index,bln){
	var dayNumObj = $("#dayNum_"+index);
	initDayNum(false,dayNumObj);
	$(dayNumObj).attr("disabled",true); 
	var intervalObj = $("#interval_"+index);
	initInterval(index,bln);
	$(intervalObj).attr("disabled",true);
}

function relieveDisabled(index,bln){
	var dayNumObj = $("#dayNum_"+index);
	initDayNum(true,dayNumObj);
	$(dayNumObj).attr("disabled",false); 
	var intervalObj = $("#interval_"+index);
	initInterval(index,bln);
	$(intervalObj).attr("disabled",false);
}

function initDayNum(checked,dayNumObj){
	if(checked){
		var dayNum = $(dayNumObj).val();
		if(dayNum == ''){
			var randomNum = Math.random()*10*3+1;
			$(dayNumObj).val(parseInt(randomNum));
		}
	}
}

function levelClick(obj){
	var levelChecked = obj.checked;
	var index = $(obj).attr("lvlValue");
	if(levelChecked){
		relieveDisabled(index,true);
	}else{
		disabledItems(index,true);
	}
	
}

function checkDayNum(obj){
	var dayNum = obj.value;
	 var regu = /^[1-9]\d*$/;
	var flag=regu.test(dayNum);
	if(!flag){       //不符合规则则随机生成
		var randomNum = Math.random()*10*3+1;
		$(obj).val(parseInt(randomNum));
	}
}

function ozTB_DefaultBtnEdit_Clicked(action){
	document.location.replace(OZ.addParamToUrl(action, "action=edit&id=" + $("#id").val()+"&barShow=false"));
}