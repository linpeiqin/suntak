<!doctype html>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<html>
<oz:ui attachment="true" ex="oz-otabs,bootstrap" toolbar="true"/>
<head>
	<title>文种映射配置</title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css />
	<oz:css cssHref="/oz/apps/document/css/right.css"/>
</head>
<body data-name="文种映射配置">
<div class="ui-tab">
	<div class="navbar-fixed-top">
		<oz:toolbar action="document/def/rightAction">
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnBack" text="返回"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnSaveRight" text="保存" onclick="onSaveRight()" icon="oz-icon-save"></oz:tbButton>
		</oz:toolbar>
	</div>
	<div class="oz-page-form" >
		<div id="triggers" class="ui-tab-trigger">
			<div class="ui-tab-trigger-inner">
				<ul>
					<li class="ui-tab-trigger-item"><a hidefocus="hideFocus" href="javascript:void(0)"> <span>环节待办</span> </a>
					</li>
					<li class="ui-tab-trigger-item"><a hidefocus="hideFocus" href="javascript:void(0)"> <span>环节经办</span> </a>
					</li>
					<li class="ui-tab-trigger-item"><a hidefocus="hideFocus" href="javascript:void(0)"> <span>非办理</span> </a>
					</li>
					<li class="ui-tab-trigger-item"><a hidefocus="hideFocus" href="javascript:void(0)"> <span>办理中</span> </a>
					</li>
				</ul>
			</div>
		</div>
		<div class="row">
			<div class="span3 ui-tab-container form-inline">
				<div class="ui-tab-container-item"  id="activityFactor">
					<div class="well">
						<div class="nav-header">文档环节</div>
						<ul class="nav nav-list factor-list">
						</ul>
					</div>
					<div class="alert alert-info" style="margin: 10px 0 0 10px;">
						<strong>说明：</strong>配置待办中文件处于某个环节状态时拥有的权限。多个环节使用配置最大的权限。<br>
		            	<strong>缺省权限：</strong>基本权限，其他的权限会在此基础上叠加。
		            </div>
				</div>
				<div class="ui-tab-container-item"  id="activityDoneFactor">
					<div class="well">
						<div class="nav-header">
							文档环节
							<div class="dropdown" style="float: right;">
				                <a class="dropdown-toggle" data-toggle="dropdown"><i class=" icon-plus"></i> 添加 <span class="caret"></span></a>
				                <ul class="dropdown-menu pull-right" id="addFactorList">
				                </ul>
				              </div>
				          </div>
						<ul class="nav nav-list factor-list">
						</ul>
					</div>
					<div class="alert alert-info" style="margin: 10px 0 0 10px;">
						<strong>说明：</strong>在用户经办过的文件，使用历史的办理环节获取权限，该页的权限会作为办理过的全局附加上去。
		            </div>
				</div>
				<div class="ui-tab-container-item"  id="sidFactor">
					<div class="well">
						<div class="nav-header">
							文档操作对象
							<div class="dropdown" style="float: right;">
				                <a class="dropdown-toggle" data-toggle="dropdown"><i class=" icon-plus"></i> 添加 <span class="caret"></span></a>
				                <ul class="dropdown-menu pull-right">
				                  <li><a href="#" class="addFactor" cmd="addSystemUser">系统对象</a></li>
				                  <li class="divider"></li>
				                  <li><a href="#" class="addFactor" cmd="addDocUser">文种使用人</a></li>
				                  <li><a href="#" class="addFactor" cmd="addDocViewer">文种查看人</a></li>
				                  <li><a href="#" class="addFactor" cmd="addDocAdmin">文种管理人</a></li>
				                </ul>
				              </div>
						</div>
						<ul class="nav nav-list factor-list">
						</ul>
					</div>
					<div class="alert alert-info" style="margin: 10px 0 0 10px;">
		            	<strong>说明：</strong>人员在对该文件所拥有的权限，不管是否在办理中。
		            </div>
				</div>
				<div class="ui-tab-container-item"  id="sidTodoFactor">
					<div class="well">
						<div class="nav-header">
							文档操作对象
							<div class="dropdown" style="float: right;">
				                <a class="dropdown-toggle" data-toggle="dropdown"><i class=" icon-plus"></i> 添加 <span class="caret"></span></a>
				                <ul class="dropdown-menu pull-right">
				                  <li><a href="#" class="addFactor" cmd="addSystemUser">系统对象</a></li>
				                  <li class="divider"></li>
				                  <li><a href="#" class="addFactor" cmd="addDocUser">文种使用人</a></li>
				                  <li><a href="#" class="addFactor" cmd="addDocViewer">文种查看人</a></li>
				                  <li><a href="#" class="addFactor" cmd="addDocAdmin">文种管理人</a></li>
				                </ul>
				              </div>
						</div>
						<ul class="nav nav-list factor-list">
						</ul>
					</div>
					<div class="alert alert-info" style="margin: 10px 0 0 10px;">
		            	<strong>说明：</strong>人员在文件办理中所拥有的权限。
		            </div>
				</div>
			</div>
			<div class="span9 doc-element-list">
				<div style='line-height:23px;text-align: right;'>
					<html:form target="xmlTarget" action="document/documentXmlAction.do?action=importDefine" styleId="ozForm1"  enctype="multipart/form-data" style="padding-right: 20px;margin-bottom: 2px;'">
							<iframe style="display:none" src="about:blank"  id="xmlTarget"  name="xmlTarget" ></iframe>
							<button class="btn btn-info btn-small" type="button" onclick="copyRight()">复制</button>
							<button class="btn btn-info btn-small" type="button" onclick="applyRight()" id="applyRightBtn" disabled="disabled">应用</button>
							<button class="btn btn-primary btn-small"  type="button" onclick="onExportExecute();" >导出权限</button >
					         <a href="javascript:void(0)" style="color: white ;cursor:pointer;position: relative;" class="btn btn-danger btn-small">
					         	导入权限
					             <input type="file" name="xmlfile"  id="xmlfile" class="addfile"  style="cursor:pointer;width: 73px;height:20px;">
					         </a>
							<html:hidden property="id" styleId="defid"/>
						</html:form>
				</div>
	            <div style="padding: 3px;text-align: right;">
					
				</div>
				<div>
					<div class="row">
						<div class="span3 oz-right-title"  style="background-color: #D2512D;">表单元素</div>
						<div class="span6 oz-right-title"  style="background-color: #5CA52C;">元素权限</div>
					</div>
				</div>
				<div>
					<div class="row">
						<div class="span3" >&nbsp;</div>
						<div class="span6" id="selectRightBox" >
							<div class="span1 right-span " ><label class="checkbox"><input type='checkbox'  name="selectRight" value="0"/></label></div>
							<div class="span1 right-span " ><label class="checkbox"><input type='checkbox'  name="selectRight" value='1'/></label></div>
							<div class="span1 right-span " ><label class="checkbox"><input type='checkbox'  name="selectRight" value='2'/></label></div>
							<div class="span1 right-span " ><label class="checkbox"><input type='checkbox'  name="selectRight" value='3'/></label></div>
							<div class="span1 right-span " ><label class="checkbox"><input type='checkbox'  name="selectRight" value="4"/></label></div>
							<div class="span1 right-span " ><label class="checkbox"><input type='checkbox'  name="selectRight" value="5"/></label></div>
						</div>
					</div>
				</div>
				<div id="elementRights" ></div>
			</div>
		</div>
	</div>
</div>
</body>
<oz:organizeJs/>
<oz:js/>
<oz:js jsId="oz-adapter"/>
<script type="text/javascript">
var defId = "${param.id}";
var editable = true;
</script>
<oz:js jsSrc="/oz/apps/document/js/right.js"/>
<script type="text/javascript">
function onExportExecute(){
	if($("#id").val() == -1){
		OZ.Msg.info("文档未保存，不能执行导出。");
		return false;
	}else{
		window.open(contextPath+"/document/documentXmlAction.do?action=exportDefine&id="+defId);
	}	
	return false;
}

function upload(){
	$("#defid").val(defId);
	$("#ozForm1").submit();
	$("#xmlfile").val("");
}

function uploadLoaded(){
	var i = $('#xmlTarget');
	if (i.contentDocument) var d = i.contentDocument;
	else if (i.contentWindow) var d = i.contentWindow.document;
	else var d = window.frames["xmlTarget"].document;
	if (d.location.href == "about:blank") return true;
	loadRightData();
	OZ.Msg.info(d.body.innerHTML);
}

$(function(){
	$("#xmlTarget").load(uploadLoaded);
	$("#xmlfile").click(function(){
		if($("#id").val() == -1){
			OZ.Msg.info("文档未保存，不能执行导出。");
			return false;
		}
	});
	$("#xmlfile").change(upload);
});
</script>
</html>