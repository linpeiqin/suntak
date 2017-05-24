<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui templete="form" attachment="true"/> 
<head>
	<title>上传文件</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" onLoad="init()">
	<html:form styleId="thisForm" action="/component/attachmentAction?action=uploadFile&isSubmit=true" enctype="multipart/form-data" method="post">
        <div style="vertical-align: middle; border: 0px solid blue;">
            <input type="file" id="ozFileUpload" style="display:none;"/>
            <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" style="table-layout:fixed;">
              <tr>
                <td height="31" class="atmTop">
                 <div class="atmTop-left">已添加 <span id="fileNum" style="color:#993300;">0</span> 个文件</div>
                <div class="atmTop-right">
                <a id="container1" class="addfile" style="border:0px; cursor:pointer;">
                    <input name="file_0" type="file" style="width:0;" class="addfile"  onchange="createnew();" />
                </a>
                </div>
                </td>
              </tr>
              <tr>
                <td valign="top">
                    <input id="btnSubmit" type="button" value="提交" onClick="submitForm();" style="display:none;" />
                    <html:hidden  styleId="pid"  property="pid"/>
                    <html:hidden  styleId="pdt"  property="pdt"/>
                    <html:hidden  styleId="group" property="group"/>
                    <html:hidden  styleId="filter" property="filter"/>
                    <html:hidden  styleId="filterDescription" property="filterDescription"/>
                    <html:hidden  styleId="maxSize" property="maxSize"/>
                    <html:hidden  styleId="errorMsg" property="errorMsg"/>
                   	<html:hidden  styleId="path" property="path"/>
                  	<html:hidden  styleId="multiple" property="multiple"/>
                    <div class="fileList-overflow" style="display:inline-block;">
                    	<div id="container2"></div>
                    </div>
                </td>
              </tr>
            </table>
        </div>
    </html:form>
</body>
<oz:js/>
<script type="text/javascript">
var fileNum=0;
var fileNumber = 0;
function createnew(){
    var c_a = $('#container1').get(0);// 找到上传控件的a容器
    var c_div = $('#container2').get(0);// 放置文件的容器
    var fileCtr = c_a.firstChild;// 上传控件
    
    if(navigator.appName.indexOf("Explorer") > -1){
        fileCtr = c_a.firstChild;
    } 
    else{
        fileCtr=getFirstFileCtrInFF(c_a);
    }
    
    var subDiv = document.createElement("div");// 将放置到c_div中的容器
	subDiv.className="subDiv";
    var span1 = document.createElement("span");// 上传的文件
    
    if(navigator.appName.indexOf("Explorer") > -1){
        span1.innerText =fileCtr.value.substring(fileCtr.value.lastIndexOf('\\')+1,fileCtr.value.length);
    } 
    else{
        span1.textContent =fileCtr.value.substring(fileCtr.value.lastIndexOf('\\')+1,fileCtr.value.length);
    }        
    
    var imgFileType=document.createElement("div");
    imgFileType.className="fileComm file-"+fileCtr.value.substring(fileCtr.value.lastIndexOf('.')+1,fileCtr.value.length);
    
    var img2 = document.createElement("img");// 删除图片按钮
    img2.src = contextPath + "/oz/themes/default/images/attachment/delFile.gif";
	img2.border = "0";
	img2.align = "absmiddle";
	img2.className = "delFile-icon";
    img2.onclick = function(){this.parentNode.parentNode.removeChild(this.parentNode);fileNum--;DisplayFileNum(fileNum);}
    
    fileCtr.style.height=0;
    
    subDiv.appendChild(imgFileType);
    subDiv.appendChild(span1);
    subDiv.appendChild(img2);        
    subDiv.appendChild(fileCtr);        
    
    
    c_div.appendChild(subDiv);
    fileNumber++;
    fileNum++;
    
    DisplayFileNum(fileNum);
    
    var newFileCtr = document.createElement("input");
    newFileCtr.type = "file";
    newFileCtr.className = "addfile";
    //newFileCtr.runat = "server";
    newFileCtr.name = "file_"+fileNumber;
    newFileCtr.onchange = createnew;
    while(c_a.firstChild){
        c_a.removeChild(c_a.firstChild);
    }
    
    c_a.appendChild(newFileCtr);
}

//在FF中取得上传input
function getFirstFileCtrInFF(c_a){
   var tmp;
   var fileCtrs = c_a.childNodes;
   for(var i=0; i<fileCtrs.length; i++) {
       if(fileCtrs[i].type=="file")
       {
          return fileCtrs[i]; 
       } 
   }
   return tmp;
}
//显示文件个数
function DisplayFileNum(value){
   if(navigator.appName.indexOf("Explorer") > -1){
       $("#fileNum").get(0).innerText =value;
   } 
   else{
       $("#fileNum").get(0).textContent =value;
   }
}

//是否有文件要上传
function IfEmpty(){
   if(fileNum<=0)
       return false;
   else
       return true;  
}

/* 提交后的文件信息,类型为Array */
<logic:present name="atms">
var atms = <bean:write name="atms" filter="false"/>;
</logic:present>
<logic:notPresent name="atms">
var atms = null;
</logic:notPresent>

/* 提交表单上传文件 */
function submitForm(){
    if(validate()){
        thisForm.submit();
    }
}
function $F(id){
	return $("#"+id).val();
}
function validate(){
    if(!IfEmpty()){
        OZ.Msg.info("请先选择要上传的文件！");
        return false;
    }
    return true;
}

/* 更新调用者的信息 */
function init(){
    var errorMsg = $F('errorMsg');
    if(errorMsg.length > 0){
        OZ.Msg.info(errorMsg);
    }else{
        if(atms){    // 表单提交成功
        	ozlog.info("OZ.Dlg.fireButtonEvent");
            OZ.Dlg.fireButtonEvent(0,'ozUploadFileDlg');
        }
    }
}

/* 返回上传结果的函数 */
function ozDlgOkFn(){
    if(atms){    // 表单提交成功就返回
        var result = {atms:atms, pdt:$('#pdt').val(), pid:$('#pid').val()};
        return result;
    }else{
        submitForm();
        return false;
    }
    
    /*
    // 测试代码
    return {
        caller: 'ATM01',
        atms: [
            {Unid: 'newUnid01', Subject: '测试文档01.doc', Author: '测试用户01', FileSize: '12KB', FileDate: '2008-10-10'},
            {Unid: 'newUnid02', Subject: '测试文档02.doc', Author: '测试用户02', FileSize: '370KB', FileDate: '2008-11-11'}
        ]
    };
    */
}
</script>
</html>