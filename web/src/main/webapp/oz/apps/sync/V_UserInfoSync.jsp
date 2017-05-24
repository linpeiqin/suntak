<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view" tree="true"/>
<html>
<head>
	<title><oz:messageSource code="oz.mdu.organize.ouinfo"/></title>
	<%@ include file="/oz/includes/meta.jsp"%>
	<oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.mdu.organize.ouinfo"/>">
	<div id="page-top" class="oz-page-top">
		<oz:toolbar action="ldap/userInfoSyncAction" searchButton="normal">
			<oz:tbSeperator/>
			<oz:tbButton id="btnBack"/>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnNewUnit" text="同步" icon="oz-icon-0214" onclick="executeSync()"></oz:tbButton>
			<oz:tbSeperator></oz:tbSeperator>
			<oz:tbButton id="btnRefresh"></oz:tbButton>
		</oz:toolbar>
	</div>	
	<div id="page-center" class="oz-page-center">
		<div id="page-center-tree" class="oz-page-center-tree">
			<ul id="ouInfoTree"></ul>
		</div>
		<div id="page-center-seperator" class="oz-page-center-seperator"></div>
		<div id="page-center-grid" class="oz-page-center-grid">
			<oz:grid action="ldap/userInfoSyncAction" onDblClickRow="void()" sortName="userInfo.orderNo" sortOrder="asc" fit="true" pagination="true" excel="true">
				<oz:column field="id" checkbox="true"/>
				<oz:column field="name" title="oz.cmpn.ldap.sync.userinfo.fields.username" width="240" sortable="false" formatter="oz_DefaultFormatter"/>
                <oz:column field="mode" title="oz.cmpn.ldap.sync.fields.mode" width="80" sortable="false" formatter="userInfoTypeFormatter"/>
                <oz:column field="lastUpdate" title="oz.cmpn.ldap.sync.fields.lastupdate" width="140" sortable="false"/>
			</oz:grid>
		</div>		
	</div>
</body>
<oz:js />
<script type="text/javascript">
var _ouId = -1;

function userInfoTypeFormatter(value, json){
    if(value == 1)
        return '自动';
    if(value == 2)
        return '手动';
    return '不同步';
}

function ozRefresh(){
	onBtnRefresh_Clicked();
}

function onBtnRefresh_Clicked(){
	oz_ReloadGrid();
	$('#ouInfoTree').tree("reload");
}

function executeSync(){
    var rows = OZ.View.getGridSelection();
    if (null == rows || rows.length == 0) {
        OZ.Msg.info('请选择要同步的人员。');
        return;
    }

    var ids=[];
    for(var i=0;i<rows.length;i++){
        ids.push(rows[i].id);
    }

    OZ.Msg.confirm(
            '是否对选择的人员执行同步操作？',
            function(){
                $.getJSON(
                        contextPath + "/ldap/userInfoSyncAction.do?action=sync&timeStamp=" + new Date().getTime(),
                        {ids:ids.join(";")},
                        function(json){
                            if(json.result == true){
                                OZ.Msg.info('同步操作成功！');
                                OZ.View.reload();
                            }else{
                                OZ.Msg.info(json.msg);
                            }
                        }
                );
            }
    );
}


$(function(){
	$('#ouInfoTree').tree({
		url: contextPath + '/organize/ouTreeAction.do?action=getTree&timeStamp=' + new Date().getTime(),
		click:function(e, data){
			$("#ozQuery").val("");
			_ouId = data.id;
			OZ.View.reloadGrid({ouId:_ouId, dbftsParams:""});
		}
	});
});
</script>
</html>