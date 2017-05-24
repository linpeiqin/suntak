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

function getReminderPage(){
    var today = new Date();
    var tomorrow = new Date();
    var lastMonth =  new Date();
    tomorrow.setDate(today.getDate()+1);
    lastMonth.setMonth(today.getMonth()-1);
    var page = [];
    page.push('<div id="page-top" class="oz-page-top">');
    page.push('<div id="triggers" class="ui-tab-trigger" >');
    page.push('<div class="ui-tab-trigger-inner">');
    page.push('<ul>');
  /*  page.push('<li id="tab1Li" class="ui-tab-trigger-item" data-id="tab1" ><a  href="javascript:void(0)"><span id="myAppTitle1" style="width: 100px">保养计划</span></a></li>');*/
    page.push('<li id="tab2Li" class="ui-tab-trigger-item" data-id="tab2" ><a  href="javascript:void(0)"><span id="myAppTitle2" style="width: 100px">维保记录</span></a></li>');
/*    page.push('<li id="tab3Li" class="ui-tab-trigger-item" data-id="tab3" ><a  href="javascript:void(0)"><span id="myAppTitle3" style="width: 80px">更换预警</span></a></li>');*/
    page.push('</ul>');
    page.push('</div>');
    page.push('</div>');
    page.push('</div>');
    page.push('<div id="page-center"  class="ui-tab-container oz-page-center oz-user-height">');
/*    page.push('<div class="ui-tab-container-item" >');
    page.push('<table class="RMPlanClass">');
    page.push('<tr class="ems-form-table-headtr" >');
    page.push('<td width="30%"></td>');
    page.push('<td width="15%"></td>');
    page.push('<td width="30%"></td>');
    page.push('<td width="25%"></td>');
    page.push('</tr>');
    page.push('<tr>');
    page.push('<td colspan="3">超期未执行计划</td>');
    page.push('<td><span id="OE_MAINTAIN"></span></td>');
    page.push('</tr>');
    page.push('<tr>');
    page.push('<td colspan="3" >今日到期（'+today.format("yyyy-MM-dd")+'）</td>');
    page.push('<td><span id="MT_MAINTAIN"></span></td>');
    page.push('</tr>');
    page.push('<tr>');
    page.push('<td colspan="3">明日到期（'+tomorrow.format("yyyy-MM-dd")+'）</td>');
    page.push('<td><span id="DT_MAINTAIN"></span></td>');
    page.push('<tr>');
    page.push('<td colspan="3">本月计划（'+today.format("yyyy年MM月")+'）</td>');
    page.push('<td><span id="PM_MAINTAIN"></span></td>');
    page.push('</tr>');
    page.push('</table>');
    page.push('</div>');*/
    page.push('<div class="ui-tab-container-item">');
    page.push('<table class="RMRecordClass">');
    page.push('<tr class="ems-form-table-headtr" >');
    page.push('<td width="50%"></td>');
    page.push('<td width="50%"></td>');
    page.push('</tr>');
    page.push('<tr>');
    page.push('<td colspan="2">本月执行（'+today.format("yyyy年MM月")+'）</td>');
    page.push('</tr>');
    page.push('<tr>');
    page.push('<td>维修：</td>');
    page.push('<td><span id="BY_REPAIR"></span></td>');
    page.push('</tr>');
    page.push('<tr>');
    page.push('<td>保养：</td>');
    page.push('<td><span id="BY_MAINTAIN"></span></td>');
    page.push('</tr>');
    page.push('<tr>');
    page.push('<td colspan="2">上月执行（'+lastMonth.format("yyyy年MM月")+'）</td>');
    page.push('</tr>');
    page.push('<tr>');
    page.push('<td>维修：</td>');
    page.push('<td><span id="SY_REPAIR"></span></td>');
    page.push('</tr>');
    page.push('<tr>');
    page.push('<td>保养：</td>');
    page.push('<td><span id="SY_MAINTAIN"></span></td>');
    page.push('</tr>');
    page.push('</table>');
    page.push('</div>');
    page.push('</div>');
    return page;
}
$(function(){
    var strInfo = [];
    strInfo = getReminderPage();
    $("#pageTab").html(strInfo.join('\n'));
    afterReminder();
});


function afterReminder(){
    initData(appendPlanData,appendRecordData);
    $(".ui-tab").oTabs().bind("select",function(e,index,tab){
    });
}

function initData(cb,cb2){
  /*  $.getJSON(
        contextPath + "/ems/repairPlanAction.do?action=getRMPlanJson&timeStamp=" + new Date().getTime(),
        function(json){
            if(json.result == true){
                cb(json);
            }
        }
    );*/

    $.getJSON(
        contextPath + "/ems/repairRecordAction.do?action=getRMRecordJson&timeStamp=" + new Date().getTime(),
        function(json){
            if(json.result == true){
                cb2(json);
            }
        }
    );
/*    $.getJSON(
        contextPath + "/ems/partInfoTreeAction.do?action=getPartWarnJson&timeStamp=" + new Date().getTime(),
        function(json){
            if(json.result == true){
                cb3(json);
            }
        }
    );*/
}

function appendPlanData(data){
    for (var fa in data){
        var faData = data[fa];
        if (fa=='result')  continue;
        for (var la in faData){
            var planName='保养';
            var idName = fa+'_'+la;
            var todoUrl = contextPath+"/ems/repairPlanAction.do?action=display&classify="+fa+"&timeStamp=" + new Date().getTime();
            var info = "<a href=\"javascript:openOzWindow('"+idName+"','"+planName+"计划"+"','"+todoUrl+"')\">"+faData[la]+"项</a>";
            $('#'+idName).html(info);
        }
    }
}
function appendRecordData(data){
    var todoUrl = "";
    for (var fa in data){
        var faData = data[fa];
        if (fa=='result')  continue;
        for (var la in faData){
            var planName=(la=='REPAIR'?'维修':'保养');
            var idName = fa+'_'+la;
            var todoUrl = contextPath+"/ems/"+(la=='REPAIR'?'repairRecordAction':'maintainAction')+".do?action=display&classify="+fa+"&timeStamp=" + new Date().getTime();
            var info = "<a href=\"javascript:openOzWindow('"+idName+"','"+planName+"记录"+"','"+todoUrl+"')\">"+faData[la]+"项</a>";
            $('#'+idName).html(info);
        }
    }
}








