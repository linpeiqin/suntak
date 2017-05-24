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
						<div class="nav-header"">文档环节</div>
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
						<div class="nav-header"">
							文档环节
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
						<div class="nav-header"">
							文档人员
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
						<div class="nav-header"">
							文档人员
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
						<button class="btn btn-primary btn-small"  type="button" onclick="onExportExecute();" >导出权限</button >
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
							<div class="span1 right-span " ><label class="checkbox"><input type='checkbox'  name="selectRight" value="0"'/></label></div>
							<div class="span1 right-span " ><label class="checkbox"><input type='checkbox'  name="selectRight" value='1'/></label></div>
							<div class="span1 right-span " ><label class="checkbox"><input type='checkbox'  name="selectRight" value='2'/></label></div>
							<div class="span1 right-span " ><label class="checkbox"><input type='checkbox'  name="selectRight" value='3'/></label></div>
							<div class="span1 right-span " ><label class="checkbox"><input type='checkbox'  name="selectRight" value="4"'/></label></div>
							<div class="span1 right-span " ><label class="checkbox"><input type='checkbox'  name="selectRight" value="5"'/></label></div>
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
var editable = false;
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
</script>
</html>