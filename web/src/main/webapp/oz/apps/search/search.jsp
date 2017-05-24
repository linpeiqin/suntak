<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<%@page import="cn.oz.message.MessageSourceHelper"%>
<%@page import="cn.oz.component.search.SearchPage"%>
<html>
<oz:ui templete="form" panel="true" tabs="true" tree="true" dialog="true" window="true"/>
<head>
	<title><oz:messageSource code="oz.compass.search"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/> 
    <style type="text/css">
        #page a ,#page strong{
            width: 23px;
            height: 22px;
            line-height: 22px;
            font-size: 14px;
            text-align: center;
            line-height: 22px;
            display: inline-block;
            border: 1px solid #E7ECF0;
            background: white;
            margin-right: 5px;
            text-decoration: none;
            vertical-align: middle;
            border-image: initial;
        }
        #page a:hover {
            background: #EBEBEB;
        }
        #page strong {
            border: 0;
            border-image: initial;
        }
        #page .n {
            width: 60px;
            font-family: "宋体";
            line-height: 24px;
            overflow: hidden;
        }
        strong, b {
            font-weight: bolder;
        }
    </style>
</head>
<body data-name="<oz:messageSource code="oz.compass.search"/>">
	<logic:notPresent name="page">
		<html:form action="/component/searchAction.do?action=search" method="get" onsubmit="return query.value!=''"  styleId="searchForm">
			<div style="position:relative;height:100%;">
				<div style="position:absolute;left:50%;top:100px;margin-left:-330px;">
					<div style="position:relative;width:570px; margin:auto; padding:auto;top:0px;">
						<div style="text-align: center;font: x-large;line-height:60px;font-size: 30px;"><oz:messageSource code="oz.compass.search.fields.search"/></div>
						<input type="text" id="query" name="query" style="width:460px;height:30px;font-size:20px;">&nbsp;&nbsp;
						<button type="submit" style="width:80px;height:30px;font-size:20px;"><oz:messageSource code="oz.compass.search.buttons.search"/></button>
                        <div style="text-align: center;line-height:30px;">
                        <logic:iterate id="fullSearchItem"  name="fullSearchItems">
                            <html:multibox property="alias" ><bean:write name="fullSearchItem" property="value"/></html:multibox> <bean:write name="fullSearchItem" property="name"/>
                        </logic:iterate>
                        </div>
					</div>
					<br/>
				<!-- 	<div style="position:relative;width:570px; margin:auto; padding:auto;top:0px;text-align:center;">
						<a href="javascript:onUpdateIndex_Clicked()"><oz:messageSource code="oz.compass.search.buttons.update.index"/></a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="javascript:onAdvanceSearch_Clicked()"><oz:messageSource code="oz.compass.search.buttons.advance.search"/></a>
					</div> -->
				</div>
			</div>
		</html:form>
	</logic:notPresent>
	<logic:present name="page">
		<html:form action="/component/searchAction.do?action=search" method="get" onsubmit="return query.value!=''" styleId="searchForm">
			<div style="padding: 5px;">
				<html:text styleId="query" name="searchForm" property="query" style="width:400px;height:30px;font-size:20px;"/>
				<button type="submit" style="width:60px;height:30px;font-size:20px;"><oz:messageSource code="oz.compass.search.buttons.search"/></button>
                <div style="line-height:30px;"><logic:iterate id="fullSearchItem"  name="fullSearchItems">
                        <html:multibox property="alias" ><bean:write name="fullSearchItem" property="value"/></html:multibox> <bean:write name="fullSearchItem" property="name"/>
                </logic:iterate></div>
			</div>
			<div style="margin:5px 0; padding: 5px;background-color: #D9E1F7">
				<oz:messageSource code="oz.compass.search.msg.result.1"/> <bean:write name="page" property="totalCount" format="###,###,###,###"/> 
				<oz:messageSource code="oz.compass.search.msg.result.2"/> <bean:write name="page" property="searchTime" format="#"/> 
				<oz:messageSource code="oz.compass.search.msg.result.3"/>
			</div>
			<div style="padding-left:10px;">
				<ol style="width: 600px;">
					<logic:iterate id="result" name="page" property="fileList">
						<li style="margin-bottom: 14px;">
							<h3 style="font-size: medium;font-weight: normal;font-family: arial,sans-serif;">
                                <a style="color:#0000CC;text-decoration: underline" href="javascript:openResult('<bean:write name="result" property="docType"/>','<bean:write name="result" property="id"/>','<bean:write name="result"  property="type"/>')"><bean:write name="result"  property="subject" filter="false"/></a>
							</h3>
                            <div style="color:#0E774A;line-height: 1.54;">
                                <bean:write name="result" property="type"/> <bean:write name="result" property="fileDate" format="yyyy-MM-dd"/>
                            </div>
							<div style="line-height: 1.54;">
								<logic:notEmpty name="result"  property="content">
									<bean:define id="hitContent" name="result"  property="content"></bean:define>
									<%
										String outa = String.valueOf(hitContent);
									
											out.println(outa+"...");
									
									%>
								</logic:notEmpty>
							</div>
						</li>
					</logic:iterate>
				</ol>
				<div style="font-size: medium; padding: 20px 6px;" id="page">
					<bean:define id="cpage" name="page"/>
					<% 
					   String pageString = "";
					   SearchPage searchPage = (SearchPage)cpage;
						int pageNo = searchPage.getPageNo();
						int totalPage = searchPage.getTotalPages();
						int startPage = 1;
						int endPage = totalPage;
                        
						if(pageNo > 5){
							startPage = pageNo - 5;
							endPage = pageNo + 4;
                        }else{
                        	endPage = 10;
                        }

						if(pageNo != 1){
							pageString+=("<a href='searchAction.do?" + searchPage.getSearchUrl(pageNo-1) + "' class='n'>" + MessageSourceHelper.getMessage("oz.pre.page")+ "</a>");
						}
						
						for(; startPage <= endPage && startPage <= totalPage; startPage++){
							if(pageNo == startPage){
								pageString+=("<strong>"+startPage +"</strong>");
							}else{
								pageString+=("<a href='searchAction.do?"+searchPage.getSearchUrl(startPage)+"'>" + startPage + "</a>");
							}
						}
						if(pageNo!=totalPage){
							pageString+=("<a href='searchAction.do?"+searchPage.getSearchUrl(pageNo+1)+"' class='n'>" + MessageSourceHelper.getMessage("oz.next.page") + "</a>");
						}
                        out.print(pageString);
					%>
				</div>
			</div>
		</html:form>
	</logic:present>
</body>
<oz:js/>
<script type="text/javascript">
var ui=0;

function doSearch(pageNo){
	$("#searchForm").submit();
}

function openResult(alias,id,aobj){
	OZ.openWindow({
		id: "search-" + alias + id,
		title: aobj,
		url: contextPath + "/config/doctypeAction.do?action=openByDocType&fileId=" + id + "&doctype=" + alias,
		tabTip:aobj
	});
}

function onUpdateIndex_Clicked(){
	$.getJSON(
		contextPath + "/component/searchAction.do?action=doStart&timeStamp=" + new Date().getTime(),
		{},
		function(json){
			OZ.Msg.info(json.msg);
		}
	);
}

function onAdvanceSearch_Clicked(){
	alert("等待将功能定位到表单自定义中的查询");
}
</script>
</html>