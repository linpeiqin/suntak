<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/oz/includes/taglibs.jsp" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<html>
<oz:ui ex="bootstrap"/>
<head>
    <title>ApiTools</title>
    <%@ include file="/oz/includes/meta.jsp"%>
    <oz:css/>
    <style>

        /* Base class
        ------------------------- */
        .jumbotron {
            position: relative;
            padding: 40px 0;
            color: #fff;
            text-align: center;
            text-shadow: 0 1px 3px rgba(0,0,0,.4), 0 0 30px rgba(0,0,0,.075);
            background: #020031; /* Old browsers */
            background: -moz-linear-gradient(45deg,  #020031 0%, #6d3353 100%); /* FF3.6+ */
            background: -webkit-gradient(linear, left bottom, right top, color-stop(0%,#020031), color-stop(100%,#6d3353)); /* Chrome,Safari4+ */
            background: -webkit-linear-gradient(45deg,  #020031 0%,#6d3353 100%); /* Chrome10+,Safari5.1+ */
            background: -o-linear-gradient(45deg,  #020031 0%,#6d3353 100%); /* Opera 11.10+ */
            background: -ms-linear-gradient(45deg,  #020031 0%,#6d3353 100%); /* IE10+ */
            background: linear-gradient(45deg,  #020031 0%,#6d3353 100%); /* W3C */
            filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#020031', endColorstr='#6d3353',GradientType=1 ); /* IE6-9 fallback on horizontal gradient */
            -webkit-box-shadow: inset 0 3px 7px rgba(0,0,0,.2), inset 0 -3px 7px rgba(0,0,0,.2);
            -moz-box-shadow: inset 0 3px 7px rgba(0,0,0,.2), inset 0 -3px 7px rgba(0,0,0,.2);
            box-shadow: inset 0 3px 7px rgba(0,0,0,.2), inset 0 -3px 7px rgba(0,0,0,.2);
        }
        .jumbotron h1 {
            font-size: 80px;
            font-weight: bold;
            letter-spacing: -1px;
            line-height: 1;
        }
        .jumbotron p {
            font-size: 24px;
            font-weight: 300;
            line-height: 1.25;
            margin-bottom: 30px;
        }

        /* Link styles (used on .masthead-links as well) */
        .jumbotron a {
            color: #fff;
            color: rgba(255,255,255,.5);
            -webkit-transition: all .2s ease-in-out;
            -moz-transition: all .2s ease-in-out;
            transition: all .2s ease-in-out;
        }
        .jumbotron a:hover {
            color: #fff;
            text-shadow: 0 0 10px rgba(255,255,255,.25);
        }
    </style>
</head>
<body>

<!-- Subhead
================================================== -->
<header class="jumbotron subhead" id="overview">
    <div class="container">
        <h1>开放平台</h1>
        <p class="lead">嘉瑶开放平台 API调试工具</p>
    </div>
</header>

<div class="container" style="margin-top: 30px;">
<div class="container-fluid">
    <div class="row-fluid">
        <div class="span6">
            <form class="form-horizontal">
                <div class="control-group">
                    <label class="control-label" for="format">返回结果：</label>
                    <div class="controls">
                        <select id="format" name="format" style="width:195px;">
                            <option value="xml">XML</option>
                            <option value="json">JSON</option>
                        </select>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="apiCategoryId">API分类：</label>
                    <div class="controls">
                        <select id="apiCategoryId">
                            <option value="">--请选择API类目--</option>
                            <c:forEach items="${groups}" var="gr">
                                <option value="${gr.id}">${gr.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="apiCategoryId">API：</label>
                    <div class="controls" id="SipApinameDiv">
                                <select id="sip_apiname" name="sip_apiname" style="width:195px;">
                                    <option value="">--请选择API--</option>
                                </select>
                    </div>
                </div>
                <div class="control-group" style="display: none">
                    <label class="control-label">数据环境：</label>
                    <div class="controls">
                        <label class="checkbox inline">
                            <input type="radio" value="1" name="restId" checked=""> 沙箱
                        </label>
                        <label class="checkbox inline">
                            <input type="radio" value="2" name="restId"> 正式
                        </label>
                    </div>
                </div>
                <div class="control-group" style="display: none">
                    <label class="control-label">SDK类型：</label>
                    <div class="controls">
                        <label class="checkbox inline">
                            <input type="radio" value="JAVA" name="codeType" checked=""> JAVA
                        </label>
                        <label class="checkbox inline">
                            <input type="radio" value="PHP" name="codeType"> PHP
                        </label>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">提交方式：</label>
                    <div class="controls">
                        <label class="checkbox inline">
                            <input type="radio" value="2" name="sip_http_method" checked=""> POST
                        </label>
                        <label class="checkbox inline">
                            <input type="radio" value="1" name="sip_http_method"> GET
                        </label>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">app key：</label>
                    <div class="controls">
                        <input type="text" id="app_key" name="app_key" placeholder="请输入appKey">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">app secret：</label>
                    <div class="controls">
                        <input type="text" id="app_secret" name="app_secret" placeholder="请输入 appSecret">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">session key：</label>
                    <div class="controls">
                        <input type="text" id="session" name="session" placeholder="请输入session">
                    </div>
                </div>
                <div id="ParamDiv">

                </div>

                <div class="control-group">
                    <div class="controls">
                        <input type="button" value="提交测试" onclick="checkForm();this.blur();" class="btn">
                    </div>
                </div>
                <input type="hidden" name="appkey" id="appkey" value="12129701"/>
                <input type="hidden" name="api_soure" id="api_soure" value="0"/>
            </form>
        </div>
        <div class="span6">
            提交参数：
            <br>
            <textarea name="param" id="param" cols="90" rows="5" readonly="" class="input-xxlarge" ></textarea>
            <br>
            <br>
            返回结果：<span style="display:none" id="codeSearchButton"> <input type="button" style="width:100px;height:24px;*padding-top:3px;border:#666666 1px solid;cursor:pointer;" onfocus="blur();" onclick="errorCodeSearch();" value="查询错误原因"></span>
            <br>
            <textarea name="resultShow" id="resultShow" cols="90" rows="10" readonly="" class="input-xxlarge"></textarea>
            <br />
            <div style="display: none">
            <br />
            SDK 调用示例代码：
            <br />
            <textarea id="sampleCode" name="sampleCode" cols="90" rows="8"  readonly="" class="input-xxlarge"></textarea>
            </div>
        </div>
    </div>
</div>
</div>
</body>
<oz:js/>
<script type="text/javascript">
var apiArr = new Array();
var apiParamArr = new Array();
var api_name="";
    $("#apiCategoryId").change(function () {
        $.getJSON(contextPath + "/api/apiAction.do?action=apiList", {"group": this.value}, function (json) {
            var sel = document.createElement('SELECT');
            sel.setAttribute('name', 'sip_apiname');
            sel.setAttribute('id', 'sip_apiname');
            sel.setAttribute('style', 'width:195px;');
            var op = document.createElement('OPTION');
            op.setAttribute('value', '');
            op.innerHTML = '--请选择API--';
            sel.appendChild(op);
            $.each(json, function () {
                op = document.createElement('OPTION');
                op.setAttribute('value', this.value);
                op.innerHTML = this.name;
                sel.appendChild(op);
            })
            $('#SipApinameDiv').empty();
            $('#SipApinameDiv').append(sel);
            $('#ParamDiv').empty();
            $('#sip_apiname').on("change",function () {
                callgetParamListByApi(this);
            });
        });
        return false;
    });
    function callgetParamListByApi(o){
        var apiId = o.value;
        var apiName = o.options[o.selectedIndex].text;
        var selectedApiName = $("#sip_apiname").find("option:selected").text();
        if(apiId!=""){
            $.getJSON(contextPath + "/api/apiAction.do?action=api", {"api": apiId}, function (json) {
                apiParamArr = json;
                var str = '<table class="table">';
                str += '<tr><td>将鼠标移至说明上，查看参数介绍；<span style="color:red">*</span> 表示必填，<span style="color:blue">*</span> 表示几个参数中必填一个；</a></td>';
                str += '</tr>';
                str += '</table>';
                for (var i=0; i<apiParamArr.length; i++){
                    str += '<div class="control-group">';
                    str +=        '<label class="control-label">' + apiParamArr[i].name + '：</label>';
                    str +=         '<div class="controls">';
                    if(apiParamArr[i].name == 'fields'){
                        str += '<input type="' + apiParamArr[i].type + '" id="apiParam_' + apiParamArr[i].name + '" name="' + apiParamArr[i].name + '" value="'+getDefaultFields(selectedApiName)+'" />';
                    } else if (apiParamArr[i].type == 'file'){
                        str += '<iframe id="apirightframe" name="apirightframe" width="325px" height="28px" frameborder=0  scrolling="no" src="imgUpload.htm?imgName=' + apiParamArr[i].name + '"></iframe>';
                        str += '<input type="hidden" name="' + apiParamArr[i].name + '" id="apiParam_' + apiParamArr[i].name + '" value=""/>';
                    } else{
                        str += '<input type="' + apiParamArr[i].type + '" id="apiParam_' + apiParamArr[i].name + '" name="' + apiParamArr[i].name + '" value="" />';
                    }
                    if ('isMust' == apiParamArr[i].classname){
                        str += ' <span style="color:red">*</span> ';
                    }
                    else
                    if('mSelect' == apiParamArr[i].classname){
                        str += ' <span style="color:blue">*</span> ';
                    }
                    else{
                        str += '<span style="color:blue">&nbsp</span>';
                    }
                    str += '<a href="javascript:void(0);" title="' + apiParamArr[i].desc + '" class="explain">说明</a>';
                    str +=       '</div>';
                    str +='</div>';
                }
                $('#ParamDiv').html(str);
            });
        }
    }


    function checkForm(){
        //cilai
        var sip_apiname_id = $('#sip_apiname').val();
        $('#param').val("");
        $('#resultShow').val("");
        $('#codeSearchButton').hide();
        if ('' == $('#apiCategoryId').val()){
            alert('请选择API类目');
            return false;
        }
        if ('' == sip_apiname_id){
            alert('请选择API');
            return false;
        }
        if ('' == $('#app_key').val()){
            alert('请输入app key');
            $('#app_key').focus()
            return false;
        }
        if ('' == $('#app_secret').val()){
            alert('请输入app secret');
            $('#app_secret').focus()
            return false;
        }
        if (document.getElementsByName('sip_http_method')[0].checked){
            ajaxRequest('POST', sip_apiname_id);
        } else{
            ajaxRequest('GET', sip_apiname_id);
        }

    }

    function ajaxRequest(sip_http_method, sip_apiname_id){
        var restId = -1;
        if (document.getElementsByName('restId')[0].checked){
            restId = 1;
        }
        else{
            restId = 2;
        }
        var api_soure = $('#api_soure').val();
        var app_key = $('#app_key').val();
        var app_secret = $('#app_secret').val();
        var session = $('#session').val();
        var paramString =  'format=' + $('#format').val() +
                '&method=' + sip_apiname_id +
                '&restId=' + restId +
                '&api_soure=' + api_soure +
                '&app_key=' + app_key +
                '&app_secret=' + app_secret +
                '&sip_http_method=' +  sip_http_method ;
        if ('undefined' != typeof(apiParamArr)){
            for (var i = 0; i < apiParamArr.length; i++){
                paramString += '&' + apiParamArr[i].name + '=' + $("#apiParam_"+apiParamArr[i].name).val();
            }
        }
        //IE兼容中文
        paramString = encodeURI(paramString) + '&session=' + encodeURIComponent(session);

        var callback = function(response){
            response = response.split('^|^');
            //var response1 = response[0].replace(/(<br>)/g, '\r\n');
            var response1 = response[0];
            var response2 = response[1];
            var response3 = response[2];
            if ('-1' != response2.indexOf('<code>26</code>') || '-1' != response2.indexOf('"code":26') || '-1' != response2.indexOf('<code>27</code>') || '-1' != response2.indexOf('"code":27')){
                if ($("#api_soure").val() == 0){
                    alert('调用此api需要绑定用户，请用户登录后再操作！');
                    bindUser();
                }
                else{
                    if ('' == $('#session').val()){
                        alert('请输入session key！');
                    }
                    else{
                        alert('无效session key,请重新输入session key！');
                    }
                    $('#session').focus();
                }
            }else{
                response1 = response1.replace(new RegExp("&quot;","gm"),'"').replace(new RegExp("%2C","gm"),',').replace(new RegExp("&amp;","gm"),"&");
                $('#param').val(response1);
                response2 = response2.replace(new RegExp("&quot;","gm"),'"');
                response2 = response2.replace(new RegExp("&lt;","gm"),'<').replace(new RegExp("&gt;","gm"),'>');
                response2 = response2.replace(new RegExp("&amp;amp;","gm"),'&').replace(new RegExp("&amp;","gm"),'&');
                //如果格式为xml，IE下缩进xml
                if ('xml' == $('#format').val() && window.ActiveXObject){
                    var rdr = new ActiveXObject("MSXML2.SAXXMLReader");
                    var wrt = new ActiveXObject("MSXML2.MXXMLWriter");
                    wrt.indent = true;
                    rdr.contentHandler = wrt;
                    try{
                        rdr.parse(response2);
                        $('#resultShow').val(wrt.output);
                    }
                    catch(err){
                        $('#resultShow').val(response2);
                    }
                }
                else{
                    $('#resultShow').val(response2);
                }
                //如果是错误，则显示错误button
                if ('-1' != response2.indexOf('error_response')) {
                    document.getElementById("apiCategoryIdForCodeSearch").value=document.getElementById("apiCategoryId").value;
                    document.getElementById("apiNameForCodeSearch").value=api_name;
                    document.getElementById("error").value=response2;
                    document.getElementById("codeSearchButton").style.display="";
                }

                if (document.getElementById('apiParam_image') != null){
                    document.getElementById('apiParam_image').value = '';
                }
                response3 = response3.replace(new RegExp("&quot;","gm"),'"').replace(new RegExp("%2C","gm"),',');
                response3 = response3.replace(new RegExp("&lt;","gm"),'<').replace(new RegExp("&gt;","gm"),'>').replace(new RegExp("&amp;","gm"),"&");
                document.getElementById("sampleCode").value=response3;

            }
        }
        //发送请求
        if ('POST' == sip_http_method){
            $.post(contextPath + "/api/apiAction.do?action=apiResult", paramString, callback);
        }
        else{
            $.get(contextPath + "/api/apiAction.do?action=apiResult", paramString, callback);
        }
    }
</script>
</html>