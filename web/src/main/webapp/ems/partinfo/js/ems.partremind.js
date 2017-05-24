/**
 * Created by linking on 2016/12/12.
 */
Date.prototype.format  = function(fmt)
{
    var o = {
        "M+" : this.getMonth()+1,                 //月份
        "d+" : this.getDate(),                    //日
        "h+" : this.getHours(),                   //小时
        "m+" : this.getMinutes(),                 //分
        "s+" : this.getSeconds(),                 //秒
        "q+" : Math.floor((this.getMonth()+3)/3), //季度
        "S"  : this.getMilliseconds()             //毫秒
    };
    if(/(y+)/.test(fmt))
        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
    for(var k in o)
        if(new RegExp("("+ k +")").test(fmt))
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
    return fmt;
}

function getReminderPage1(){
    var today1 = new Date();
    var tomorrow1 = new Date();
    var lastMonth1 =  new Date();
    tomorrow1.setDate(today1.getDate()+1);
    lastMonth1.setMonth(today1.getMonth()-1);
    var pages = [];
    pages.push('<div id="part-top" class="oz-page-top">');
    pages.push('<div id="part-triggers" class="ui-tab-trigger" >');
    pages.push('<div id="part-div" class="ui-tab-trigger-inner">');
    pages.push('<ul id="ul2">');
    pages.push('<li id="part-tabLi1" class="ui-tab-trigger-item" data-id="part-tab1" ><a  "><span id="part-myAppTitle1" style="width: 100px">备件申购</span></a></li>');
    pages.push('<li id="part-tabLi2" class="ui-tab-trigger-item" data-id="part-tab2" ><a  "><span id="part-myAppTitle2" style="width: 100px">更换预警</span></a></li>');
    pages.push('</ul>');
    pages.push('</div>');
    pages.push('</div>');
    pages.push('</div>');
    pages.push('<div id="part-center"  class="ui-tab-container oz-page-center oz-user-height">');
    pages.push('<div class="ui-tab-container-item">');
    pages.push('<table class="PRPClass">');
    pages.push('<tr class="ems-form-table-headtr" >');
    pages.push('<td width="50%"></td>');
    pages.push('<td width="50%"></td>');
    pages.push('</tr>');
    pages.push('<tr>');
    pages.push('<td >急采备件未达项：</td>');
    pages.push('<td ><span id="PR_PART"></span></td>');
    pages.push('</tr>');
    pages.push('<tr>');
    pages.push('<td colspan="2"><span id="PR_PARTINFO"></span></td>');
    pages.push('</tr>');
    pages.push('</table>');
    pages.push('</div>');
    pages.push('<div class="ui-tab-container-item">');
    pages.push('<table  class="PRPClass">');
    pages.push('<tr class="ems-form-table-headtr" >');
    pages.push('<td width="50%"></td>');
    pages.push('<td width="50%"></td>');
    pages.push('</tr>');
    pages.push('<tr>');
    pages.push('<td>更换项：</td>');
    pages.push('<td><span id="GH_PART"></span></td>');
    pages.push('</tr>');
    pages.push('<tr>');
    pages.push('<td colspan="2"><span id="GH_PARTINFO"></span></td>');
    pages.push('</tr>');
    pages.push('</table>');
    pages.push('</div>');
    pages.push('</div>');
    return pages;
}
$(function(){
    var strInfo = [];
    strInfo = getReminderPage1();
    $("#pageTab1").html(strInfo.join('\n'));
    afterReminder1();
});


function afterReminder1(){
    initData1(appendPRLineData,appendPartWarnData);
  $(".ui-tab").oTabs().bind("select",function(e,index,tab){
    });
}

function initData1(cb,cb3){
    $.getJSON(
        contextPath + "/ems/pRLineAction.do?action=getPRLineJson&timeStamp=" + new Date().getTime(),
        function(json){
            if(json.result == true){
                cb(json);
            }
        }
    );
    $.getJSON(
        contextPath + "/ems/partInfoTreeAction.do?action=getPartWarnJson&timeStamp=" + new Date().getTime(),
        function(json){
            if(json.result == true){
                cb3(json);
            }
        }
    );
}
function appendPRLineData(data){
    for (var fa in data){
        var faData = data[fa];
        if (fa=='result')  continue;
        for (var la in faData){
            var info = '';
            var todoUrl = '';
            var idName = fa+'_'+la;
            if(idName == 'PR_PARTINFO'){
                var arr = faData[la];
                for(var i=0;i<arr.length;i++){
                    todoUrl = contextPath+"/ems/pRHeadAction.do?action=open&id="+arr[i].headId+"&timeStamp=" + new Date().getTime();
                    info += "第"+(i+1)+"项  "+"<a href=\"javascript:oz_Default_Open('"+idName+"','配件采购申请','"+todoUrl+"')\">"+arr[i].itemName+">>>数量    "+arr[i].qty+"</a></br>";
                }
            }else{
                todoUrl = contextPath+"/ems/pRHeadAction.do?action=display&timeStamp=" + new Date().getTime();
                info = "<text>"+faData[la]+"项</text>";
            }
            $('#'+idName).html(info);
        }

    }
}

function appendPartWarnData(data){
    for (var fa in data){
        var faData = data[fa];
        if (fa=='result')  continue;
        for (var la in faData){
            var info = '';
            var todoUrl = '';
            var planName='更换';
            var idName = fa+'_'+la;
            if(idName == 'GH_PARTINFO'){
                var arr = faData[la];
                for(var i=0;i<arr.length;i++){
                    todoUrl = contextPath+"/ems/partInfoTreeAction.do?action=display&flag=1&parentId="+arr[i].parentId+"&timeStamp=" + new Date().getTime();
                    info += "第"+(i+1)+"项  "+"<a href=\"javascript:openOzWindow('"+idName+"','配件关系树','"+todoUrl+"')\">"+arr[i].pathName+"</a></br>";
                }
            }else{
                info = faData[la]+"项";
            }
            $('#'+idName).html(info);
        }

    }
}

function openOzWindow(id,title,url){
    ozWindow.open({
        id:id,
        title:title,
        url:url,
        refresh:false
    });
}

function oz_Default_Open(id,title,url){
    new OZ.Dlg.create({
        width:1000, height:650,
        id:id,
        title:title,
        url:url,
        refresh:false,
        buttons:[{text:'关闭', handler:$.noop}],
        maximizable:true
    });
}




