<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
<oz:ui templete="view" tree="true"/>
<html>
<head>
    <title>
        <oz:messageSource code="oz.config.optiongroup"/>
    </title>
    <%@ include file="/oz/includes/meta.jsp"%>
    <oz:css/>
</head>
<body class="oz-body" data-name="<oz:messageSource code="oz.config.optiongroup"/>">
<div id="page-top" class="oz-page-top">
    <oz:toolbar action="api/apiGroupAction" searchButton="normal">
        <oz:tbSeperator/>
        <oz:tbButton id="btnBack"/>
        <oz:tbSeperator></oz:tbSeperator>
        <oz:tbButton id="btnNew"></oz:tbButton>
        <oz:tbSeperator></oz:tbSeperator>
        <oz:tbButton id="btnDelete"></oz:tbButton>
        <oz:tbSeperator></oz:tbSeperator>
        <oz:tbButton id="btnViewData" text="oz.config.optiongroup.button.viewdata" icon="oz-icon-1416" onclick="onBtnViewData_Clicked()"></oz:tbButton>
    </oz:toolbar>
</div>
<div id="page-center" class="oz-page-center">
    <oz:grid action="api/apiGroupAction" sortName="name" sortOrder="asc" fit="true">
        <oz:column field="id" checkbox="true" title=""/>
        <oz:column field="name" title="名称" sortable="true" width="160" />
        <oz:column field="code" title="编码" sortable="true" width="160" />
    </oz:grid>
</div>
</body>
<oz:js />
<script type="text/javascript">

    function onRow_DBLClicked(rowIndex, json){
        openOptionGroup(json.id, json.canEdit);
    }

    function onBtnNew_Clicked(){
        new OZ.Dlg.create({
            id:"Dlg_OptionGroup",
            width:480, height:320,
            title:'新建分类',
            url: contextPath + "/api/apiGroupAction.do?action=create",
            onOk:function(result){
                OZ.View.reloadGrid();
            },
            onCancel:function(result){
                // do nothing...
            }
        });
    }

    function openOptionGroup(id, canEdit){
        openOptionGroupDlg(contextPath + "/api/apiGroupAction.do?action=open&id=" + id, '<oz:messageSource code="oz.view"/><oz:messageSource code="oz.config.optiongroup"/>', canEdit, id);
    }

    function openOptionGroupDlg(strUrl, title, canEdit, id){
        strUrl += "&timeStamp=" + new Date().getTime();
        var buttons = [];
        if(canEdit){
            if(null == id || id.length == 0 || "-1" == id){
                buttons = [{text:'确定', iconCls:'oz-icon-ok', handler:function(){
                    OZ.View.reloadGrid();
                }},
                    {text:'取消', iconCls:'oz-icon-cancel', handler:$.noop}
                ];
            }else{
                buttons = [{text:'查看数据', iconCls:'oz-icon-viewData', handler:function(){
                    openViewDataDlg(id);
                }},
                    {text:'确定', iconCls:'oz-icon-ok', handler:function(){
                        OZ.View.reloadGrid();
                    }},
                    {text:'取消', iconCls:'oz-icon-cancel', handler:$.noop}
                ];
            }
        }else{
            buttons = [{text:'查看数据', iconCls:'oz-icon-viewData', handler:function(){
                openViewDataDlg(id);
            }},
                {text:'关闭', iconCls:'oz-icon-cancel', handler:$.noop}
            ];
        }
        if(canEdit){
            new OZ.Dlg.create({
                id:"Dlg_OptionGroup",
                width:480, height:320,
                title:title,
                url: strUrl,
                buttons:buttons
            });
        }else{
            new OZ.Dlg.create({
                id:"Dlg_OptionGroup",
                width:480, height:320,
                title:title,
                url: strUrl,
                buttons:buttons
            });
        }
    }

    function onBtnViewData_Clicked(){
        var rows = OZ.View.getGridSelection();
        if (null == rows || rows.length != 1) {
            OZ.Msg.info('<oz:messageSource code="oz.config.optiongroup.select.isnotone"/>');
            return;
        }
        openViewDataDlg(rows[0].id);
    }

    function openViewDataDlg(groupId){
        var strUrl = contextPath + "/api/apiGroupAction.do?action=viewOptionItems&id=" + groupId;
        strUrl += "&timeStamp=" + new Date().getTime();
        new OZ.Dlg.create({
            id:"Dlg_ViewOptionItemData",
            width:640, height:463,
            title:'<oz:messageSource code="oz.config.optiongroup.button.viewdata"/>',
            url: strUrl,
            buttons:[{text:'关闭', iconCls:'oz-icon-cancel', handler:$.noop}]
        });
    }
</script>
</html>