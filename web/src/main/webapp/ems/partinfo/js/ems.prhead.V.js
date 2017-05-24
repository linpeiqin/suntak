function oz_GetTitle(json){
    return "备件采购申请";
}
function formatEbsStatus(value,json){
    if(value==-1|| value=="")
        return "<a style= 'color: black'>未同步</a>";
    else if (value==0)
        return "<a style= 'color: grey'>同步失败</a>";
    else if (value==1)
        return "<a style= 'color: green'>同步成功</a>";
}
