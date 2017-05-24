//时间格式
function renderpublisherDate(value, json){
    if (value==null || value=="")
        return "";
    else if (value.length>10){
        return value.substring(0,19); 
    }else{
        return value;
    }
}
//日期
function renderpublisherDate2(value, json){
    if (value==null || value=="")
        return "";
    else if (value.length>10){
        return value.substring(0,11);
    }else{
        return value;
    }
}

//金额格式
function moneyFormatter(value, json){
    if (value==null || value=="")
        return "";
   else{
        return value.toFixed(4);
    }
}

