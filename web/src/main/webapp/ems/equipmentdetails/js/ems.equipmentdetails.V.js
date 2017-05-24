/**
 * Created by xsw on 2016/8/22.
 */

//重写视图尺寸方法
OZ.View.resize = function(){
    var ch = $(window).height()-$("#page-top").height();
    var tw = $("#page-center-tree").width();
    var cw = $(window).width()-tw;
    $("#page-center,#page-center-tree,#page-center-seperator").height(ch);
    $("#page-center-grid,#page-center-grid-top").width($(window).width()-$("#page-center-tree").width()-$("#page-center-seperator").width());
    $("#page-center-grid").height(ch/2);
    $("#moveLine").css("top",ch/2).css("left",tw);
    $("#tabCt").css("top",ch/2+5).css("left",tw).height(ch/2-5).width(cw);
    $("#tabCt").tabs("resize",{width:cw,height:ch/2-5,top:ch/2+5,left:tw});
    if(typeof(oz_grid_config) != "undefined"){
        $("#" + oz_grid_config.id).grid("resize");
    }
}

var strUrl1 = contextPath + "/ems/equipmentLifeCycleAction.do?action=display";
var strUrl2 = contextPath + "/ems/technicalParamsAction.do?action=display";
var strUrl3 = contextPath + "/ems/repairRecordAction.do?action=show";
var strUrl4 = contextPath + "/ems/repairPlanAction.do?action=displayTime";
var strUrl5 = contextPath + "/ems/equipmentDetailsAction.do?action=openAttach&edit=true";
var strUrl6 = contextPath + "/ems/partReplaceAction.do?action=display";
var strUrl7 = contextPath + "/ems/equipmentDetailsAction.do?action=aidsEquipment";
var strUrl8 = contextPath + "/ems/partInfoTreeAction.do?action=partDisplay";
var strUrl9 = contextPath + "/ems/maintainAction.do?action=maintainDisplay";
function oz_GetTitle(json){
    return "资产详细信息";
}
function fommaterForInstructions(value, json){
    if (value==null || value=="")
        return "";
    else if(value==true){
        return "是";
    } else if(value==true){
        return "";
    }
}
$(function(){
    initTree();
    $("#tabCt").tabs();
    $("#tabCt").tabs("activeTab","tab_01");
    loadSubPanel("IFRAME_01",strUrl1);
    loadSubPanel("IFRAME_02",strUrl2);
    loadSubPanel("IFRAME_03",strUrl3);
    loadSubPanel("IFRAME_04",strUrl4);
    loadSubPanel("IFRAME_05",strUrl5);
    loadSubPanel("IFRAME_06",strUrl6);
    loadSubPanel("IFRAME_07",strUrl7);
    loadSubPanel("IFRAME_08",strUrl8);
    loadSubPanel("IFRAME_09",strUrl9);
    $(".oz-tabs-with-icon").each(function(){
        var title =  $(this).attr('title');
        if (title=="配件更换记录"){
            $(this).css('width','120px');
        }
        if (title=="附件(说明书等)"){
            $(this).css('width','120px');
        }
    });
    initToolbar();
});
var treeType = "";
function initTree(){
    $('#naviTree').tree({
        children: [
            {text:"状态分类",
             type:-1,scrapState:0,children:
                [{text:"待入厂",type:0,scrapState:0},
                 {text:"待验收",type:1,scrapState:0},
                 {text:"待更新",type:5,scrapState:0},
                 {text:"更新待验收",type:6,scrapState:0},
                 {text:"工程完工",type:7,scrapState:0},
                 {text:"工程验收",type:8,scrapState:0},
                 {text:"使用中",type:2,scrapState:0},
                 {text:"已报废",type:3,scrapState:0},
                 {text:"停用设备",type:9,scrapState:0}
            ]}
           /* ,
            {
            text:"停用设备",scrapState:1,type:-1
            }*/
        ],
        click:function(e, data){
            treeType = data.type;
            type = data.type;
            scrapState = data.scrapState;
            OZ.View.reloadGrid({type:type,scrapState:scrapState, dbftsParams:""});
        }
    });
}
function oz_Row_DBLClicked(rowIndex,rowData){
    initTabs(rowData.id);
}

function initTabs(equipmentId){
    $("#IFRAME_01")[0].contentWindow.reloadGridSelf(equipmentId);
    $("#IFRAME_02")[0].contentWindow.reloadGridSelf(equipmentId);
    $("#IFRAME_03")[0].contentWindow.reloadGridSelf(equipmentId);
    $("#IFRAME_04")[0].contentWindow.reloadGridSelf(equipmentId);
    loadSubPanel("IFRAME_05",strUrl5+"&id="+equipmentId);
    $("#IFRAME_06")[0].contentWindow.reloadGridSelf("equipmentId",equipmentId);
    $("#IFRAME_07")[0].contentWindow.reloadGridSelf(equipmentId);
    $("#IFRAME_08")[0].contentWindow.reloadGridSelf(equipmentId);
    $("#IFRAME_09")[0].contentWindow.reloadGridSelf("equipmentId",equipmentId);
}

function disableEquip(){

    var rows = OZ.View.getGridSelection();
    if (rows.length==0){
        oz.Msg.info("请选择需要操作的数据！");
        return false;
    }
    if (rows.length>1){
        oz.Msg.info("请选择一个需要操作的数据记录！");
        return false;
    }
    if (rows[0].type!=2){
        oz.Msg.info("只有使用中的设备才能停用！");
        return false;
    }

    if (rows[0].scrapState==1){
        oz.Msg.info("该设备已经停用！");
        return false;
    }

    var apiUrl = contextPath+"/ems/equipmentDetailsAction.do?action=doDisableEquip";
    var json = {};
    json.id = rows[0].id;
    $.getJSON(apiUrl,json,function(reJson){
        if (reJson!=null&&reJson.result==true){
            oz.Msg.info(reJson.msg);
            OZ.View.reloadGrid();
        }
    });
}

function enableEquip(){

    var rows = OZ.View.getGridSelection();
    if (rows.length==0){
        oz.Msg.info("请选择需要操作的数据！");
        return false;
    }
    if (rows.length>1){
        oz.Msg.info("请选择一个需要操作的数据记录！");
        return false;
    }
    if (rows[0].type!=9) {
        oz.Msg.info("只有停用中的设备才能启用！");
        return false;
    }

    var apiUrl = contextPath+"/ems/equipmentDetailsAction.do?action=doEnableEquip";
    var json = {};
    json.id = rows[0].id;
    $.getJSON(apiUrl,json,function(reJson){
        if (reJson!=null&&reJson.result==true){
            oz.Msg.info(reJson.msg);
            OZ.View.reloadGrid();
        }
    });
}
function initToolbar(){
    var equipName = '<ul class="oz-btn-mouseout" id="equipName"><li class="oz-btn-left"></li><li class="oz-btn-center">资产名称: </li><li class="oz-btn-center"><input id="equipmentNameText" style="width :110px;height:20px"/></li><li class="oz-btn-right"></li></ul><div class="oz-btn-seperator"></div>';
    var useD = '<ul class="oz-btn-mouseout" id="useD"><li class="oz-btn-left"></li><li class="oz-btn-center">使用部门: </li><li class="oz-btn-center"><input id="useDText" style="width :80px;height:20px"/></li><li class="oz-btn-right"></li></ul><div class="oz-btn-seperator"></div>';
    var procedure = '<ul class="oz-btn-mouseout" id="procedure"><li class="oz-btn-left"></li><li class="oz-btn-center">工序: </li><li class="oz-btn-center"><input id="procedureText" style="width :80px;height:20px"/></li><li class="oz-btn-right"></li></ul><div class="oz-btn-seperator"></div>';
    var equipNo = '<ul class="oz-btn-mouseout" id="equipNo"><li class="oz-btn-left"></li><li class="oz-btn-center">设备编号: </li><li class="oz-btn-center"><input id="equipNoText" style="width :80px;height:20px"/></li><li class="oz-btn-right"></li></ul><div class="oz-btn-seperator"></div>';
    var searchButton = '<div class="oz-tb-searchbutton-wrap"><ul><li><input type="text" id="ozQuery" name="ozQuery" class="searchquey" onkeydown="ozTB_Query_KeyDown(event)"></li><li id="ozBtnSearch" class="oz-btn-search" title="查询" onclick="ozTB_BtnSearch_Clicked()"><div class="oz-icon oz-icon-search"></div></li><li id="ozBtnSearchClear" class="oz-btn-search" title="清空" onclick="ozTB_BtnReset_Clicked()"><div class="oz-icon oz-icon-search-clear"></div>'
    var sButton = '<ul class="oz-btn" id="btnDoSearch" onclick="doSearch()"><li class="oz-btn-left"></li><li class="oz-btn-center oz-btn-icon"><div class="oz-icon oz-icon-0732"></div></li><li class="oz-btn-center"><span>查询</span></li><li class="oz-btn-right"></li></ul>';
    // useD+
    $('#page-top :last(.oz-btn-seperator)').last().after(equipName+equipNo+sButton);
    $('.oz-tb').append(searchButton);
}
function  doSearch() {
    var searchQuery = {};
    if(null != $("#equipmentNameText").val() && $("#equipmentNameText").val().length > 0){
        searchQuery._LIS_equipmentName = $("#equipmentNameText").val();
    }else{
        searchQuery._NES_equipmentName= '-1';
    }
    if('-1' != $("#useDTextSEL").val() && $("#useDTextSEL").val().length > 0){
        searchQuery._EQS_ebsEntity_userDId = $("#useDTextSEL").val();
    }
    if('-1' != $("#procedureTextSEL").val() && $("#procedureTextSEL").val().length > 0){
        searchQuery._EQS_ebsEntity_userDId = $("#procedureTextSEL").val();
    }
    if(null != $("#equipNoText").val() && $("#equipNoText").val().length > 0){
        searchQuery._LIS_equipmentNo = $("#equipNoText").val();
    }
    if(treeType!=""){
        searchQuery._EQI_type = treeType;
    }
    searchQuery.dbftsParams = "";
    OZ.View.reloadGrid(searchQuery);
}
function onBtnSearch_Clicked(searchCondition) {
    var searchQuery = {};
    if(treeType!=""){
        searchQuery._EQI_type = treeType;
    }
    searchQuery.dbftsParams = searchCondition;
    OZ.View.reloadGrid(searchQuery);
}