<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<!--[if IEMobile 7 ]>
<html class="no-js iem7"><![endif]-->
<!--[if lt IE 9]>
<html class="no-js lte-ie8"><![endif]-->
<!--[if (gt IE 8)|(gt IEMobile 7)|!(IEMobile)|!(IE)]><!-->
<html class="no-js" lang="en"><!--<![endif]-->
<head>
    <meta charset="utf-8">
    <title>API介绍 - OZ文档中心</title>
    <meta name="author" content="OZ">
    <%@ include file="/oz/includes/meta.jsp"%>
    <oz:css/>

    <meta name="description"
          content="&middot 基本规范 介绍 数据格式 认证流程 &middot API接口  &hellip;">


    <!-- http://t.co/dKP3o1e -->
    <meta name="HandheldFriendly" content="True">
    <meta name="MobileOptimized" content="320">
    <meta name="viewport" content="width=device-width, initial-scale=1">


    <link rel="canonical" href="t.gem-soft.com/api/introduce">
    <link href="favicon.ico" rel="icon">
    <oz:js jsSrc="/oz/apps/api/js/jquery.js"/>
    <oz:js jsSrc="/oz/apps/api/js/prettify.js"/>
    <oz:css cssHref="/oz/apps/api/css/screen.css"/>
    <script type="text/javascript">
        $(function () {
            $('table th').each(function (i, th) {
                if ($(th).html().match(/描述/)) {
                    $(th).css({width: 220});
                }
                if ($(th).html().match(/名称|参数名/)) {
                    $(th).css({width: 100});
                }
                if ($(th).html().match(/是否必须|是否隐私/)) {
                    $(th).css({width: 60});
                }
                if ($(th).html().match(/类型/)) {
                    $(th).css({width: 100});
                }
            });
            //menu
            var pathname = window.location.href;
            $(".section a").each(function (i, a) {
                if (a.href == pathname || (a.href + "/") == pathname) {
                    $(a).parent().addClass('on');
                    if ($(a).parent().hasClass('top-h')) {
                        $(a).parent().next('.list-second').show();
                    }
                    $(a).parents('li').show();
                    $(a).parents('li').prev('.top-h').addClass("on");
                }
            });
            $(".section li.api").on('click', function (ev) {
                if (!$(this).hasClass("top-h")) {
                    $('.section li.on').removeClass("on");
                    $(this).addClass("on");
                }
            });
            $('.section li.top-h').on('click', function (ev) {
                $(this).next('.list-second').toggle();
                $(this).toggleClass("on");
            });
            $('.section h2').on("click", function (ev) {
                $(this).next('.list-top').toggle();
            });
            $('.section li.new').each(function (i, news) {
                var html = '<span class="new-tip">new</span>';
                var parent = $(this).parents('.list-second');
                if (parent.length != 0) {
                    var pt = parent.prev('.top-h');
                    $(html).appendTo(pt);
                    pt.addClass("new");
                }
                $(html).appendTo(this);
            });
        });
    </script>

</head>
<body>
<div id="wrap">
<a href="#top" class="backtotop" id="backtotop"><i class="icon"></i><span>返回顶部</span></a>
<div id="header">

</div>
<div id="main">
<div id="content">

<div class="sidebar">
<h1>
    <img src="<oz:contextPath/>/oz/apps/api/images/api-logo.png">
</h1>

<div class="section">
<h2>· 基本规范</h2>
<ul class="list-top">
    <li class="api">
        <a href="#api-introduce">介绍</a>
    </li>
</ul>
<h2>· API接口</h2>
<ul class="list-top">

<c:forEach items="${groups}" var="group">
    <li class="api top-h">
        <span class="top-h-text">${group.name}</span>
        <span class="arrow"></span>
    </li>
    <li class="list-second" style="display:none">
        <ul>
            <c:forEach items="${group.methods}" var="apiMethod">
                <li class="api">
                    <a href="#method-${apiMethod.id}">${apiMethod.methodName}</a>
                </li>
            </c:forEach>
            <c:if test="${not empty group.dataStructs}">
            <li class="api top-h">
                <span class="top-h-text">数据结构</span>
                <span class="arrow"></span>
            </li>
            <li class="list-second">
                <ul>
                    <c:forEach items="${group.dataStructs}" var="structs">
                        <li class="api">
                            <a href="#model-${structs.id}">${structs.name}</a>
                        </li>
                    </c:forEach>
                </ul>
            </li></c:if>
        </ul>
    </li>
</c:forEach>


</ul>
<h2>· 相关工具</h2>
<ul class="list-top">
    <li class="api">
        <a href="#sdk">SDK</a>
    </li>
    <li class="api">
        <a href="?action=apiTools">API调试工具</a>
    </li>
</ul>
</div>
</div>

<div class="doc-api-single" id="api-introduce">
    <div class="hentry" role="article">
        <div class="header">
            <h1 class="entry-title">API介绍</h1>
        </div>
        <div class="entry-content">
            <h1>API介绍</h1>

            <h2>联系方式</h2>

            <p>无论在开发过程中遇到任何问题,都可以发邮件:</p>
            <table>
                <thead>
                <tr>
                    <th>职责</th>
                    <th>人员</th>
                    <th>邮箱</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>平台负责人</td>
                    <td>cd826</td>
                    <td>cd826[at]gem-soft.com</td>
                </tr>
                <tr>
                    <td>其它</td>
                    <td></td>
                    <td>dev[at]gem-soft.com</td>
                </tr>
                </tbody>
            </table>
            <br>
        </div>
    </div>
</div>

<c:forEach items="${groups}" var="group">
    <c:forEach items="${group.methods}" var="apiMethod">

<div class="doc-api-single" id="method-${apiMethod.id}">
    <div class="hentry" role="article">
        <div class="header">
            <h1 class="entry-title">${apiMethod.method} ${apiMethod.methodName} </h1>
        </div>
        <div class="entry-content">
            <h1>说明</h1>

            <p>${apiMethod.description}</p>

            <h1>API用户授权类型</h1>

            <p><c:choose>
                <c:when test="${apiMethod.needInSession=='Y'}">需要</c:when>
                <c:otherwise>不需要</c:otherwise>
            </c:choose></p>

            <h1>API请求参数进行签名</h1>

            <p><c:choose>
                <c:when test="${apiMethod.ignoreSign=='Y'}">需要</c:when>
                <c:otherwise>不需要</c:otherwise>
            </c:choose></p>

            <h1>应用级输入参数</h1>
            <table>
                <thead>
                <tr>
                    <th>名称</th>
                    <th>类型</th>
                    <th>是否必须</th>
                    <th>示例值</th>
                    <th>默认值</th>
                    <th>描述</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${apiMethod.requestFields}" var="requestField">
                    <tr>
                        <td>${requestField.field}</td>
                        <td>${requestField.struct.code}</td>
                        <td><c:choose>
                            <c:when test="${requestField.required=='Y'}">必须</c:when>
                            <c:otherwise>不必须</c:otherwise>
                        </c:choose></td>
                        <td>${requestField.exampleValue}</td>
                        <td>${requestField.defaultValue}</td>
                        <td>${requestField.description}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <h1>返回结果</h1>
            <table>
                <thead>
                <tr>
                    <th>参数名</th>
                    <th>类型</th>
                    <th>是否必须</th>
                    <th>示例值</th>
                    <th>描述</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${apiMethod.responseFields}" var="responseField">
                    <tr>
                        <td>${responseField.field}</td>
                        <td><c:if test="${responseField.struct.simple!='Y'}"><a href="#model-${responseField.struct.id}"></c:if> ${responseField.struct.code}<c:if test="${responseField.isArray=='Y'}">[]</c:if><c:if test="${responseField.struct.simple!='Y'}"></a></c:if></td>
                        <td><c:choose>
                            <c:when test="${responseField.isArray=='Y'}">是</c:when>
                            <c:otherwise>否</c:otherwise>
                        </c:choose></td>
                        <td>${responseField.exampleValue}</td>
                        <td>${responseField.description}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <h1>错误码</h1>
            <table>
                <thead>
                <tr>
                    <th>错误码</th>
                    <th>错误描述</th>
                    <th>解决方案</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
</div>
    </c:forEach>



    <c:if test="${not empty group.dataStructs}">
<div class="doc-api-single" id="user-models">
    <div class="hentry" role="article">
        <div class="header">
            <h1 class="entry-title">用户数据结构列表 </h1>
        </div>
        <div class="entry-content">
             <c:forEach items="${group.dataStructs}" var="dataStruct">
            <h2 id="model-${dataStruct.id}">${dataStruct.code} ${dataStruct.name}</h2>
            <table>
                <thead>
                <tr>
                    <th>名称</th>
                    <th>类型</th>
                    <th>是否隐私</th>
                    <th>示例值</th>
                    <th>描述</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${dataStruct.fields}" var="field">
                    <tr>
                        <td>${field.field}</td>
                        <td><c:if test="${field.fieldStruct.simple!='Y'}"><a href="#model-${field.fieldStruct.id}"></c:if> ${field.fieldStruct.code}<c:if test="${field.isArray=='Y'}">[]</c:if><c:if test="${field.fieldStruct.simple!='Y'}"></a></c:if></td>
                        <td>否</td>
                        <td>${field.exampleValue}</td>
                        <td>${field.description}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            </c:forEach>
            <br>

<pre>
    <code>注:</code>
</pre>
        </div>

    </div>
</div>
</c:if>
</c:forEach>



</div>
</div>
<div class="footer">
    <div id="footer">
        <a href="http://www.gem-soft.com">嘉瑶软件</a>?2013
        <a class="footer-item" href="http://www.miibeian.gov.cn/" target="_blank">粤ICP备12062601号</a>
    </div>
</div>
</div>

</body>
<oz:js />
<script type="text/javascript">

</script>
</html>