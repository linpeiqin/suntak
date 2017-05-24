(function(){
	var oz = window.oz || {};
	
	function selectCommentTpl(targetFieldId){
		var buttons = [{text:"&nbsp;管理&nbsp;", iconCls:'oz-icon-viewData', handler:function(result){ oz.comment.manageCommentTpl();}},
		               {text:"&nbsp;确定&nbsp;", iconCls:'oz-icon-ok', fnName:"ozDlgOkFn", handler:function(result){
						   $("#" + targetFieldId).val($("#" + targetFieldId).val() + result[0]);
					   }},
					   {text:"&nbsp;取消&nbsp;", iconCls:'oz-icon-cancel', handler:$.noop}];
		
		new OZ.Dlg.create({
			id:"dlg_SelectCommentTpl", 
			width:300, height:288,
			title:'选择常用批示语',
			url: contextPath + "/module/commentTplAction.do?action=dlgSelectTpl&ts=" + new Date().getTime(),
			buttons:buttons
		});
	}
	
	function editComment(id){
		new OZ.Dlg.create({ 
			id:"Dlg_EditFileComment", 
			width:320, height:160,
			title:"修改办理意见",
			url: contextPath + "/module/commentAction.do?action=dlgEditComment&id=" + id + "&ts=" + new Date().getTime(),
			onOk:function(result){
				$.post(contextPath + "/module/commentAction.do?action=update",
						{id:id, comment:result},function(){
							$("#fileComment_" + id).text(result);
						}
				)
			},
			onCancel:function(result){
				// do nothing...
			}
		});
	}
	
	function doSelectTpl(name,target){
		var buttons = [{text:"&nbsp;管理&nbsp;", iconCls:'oz-icon-viewData', handler:function(result){ oz.comment.create();}},
					   {text:"&nbsp;确定&nbsp;", iconCls:'oz-icon-ok', fnName:"ozDlgOkFn", handler:function(result){
						   $("#" + target).val(result[0]);
					   }},
					   {text:"&nbsp;取消&nbsp;", iconCls:'oz-icon-cancel', handler:$.noop}];
		new OZ.Dlg.create({ 
			id:"dlg_SelectCommentTpl", 
			width:300, height:288,
			title:'选择常用批示语',
			url: contextPath + "/module/commentTplAction.do?action=dlgSelectTpl&&ts=" + new Date().getTime(),
			buttons:buttons
		});
	}
	
	function doEdit(id){
		OZ.Msg.prompt("请输入新的意见：",function(result){
			$.post(contextPath + "/module/commentAction.do?action=update",
					{id:id,comment:result},function(){
						 $("#comment_" + id +" .comment-comment").text(result);
					}
			)
		   },$.noop,$("#comment_" + id +" .comment-comment").text(),true,"修改意见");
	}
	
	oz.comment = {
		edit:function(id){
			doEdit(id);
		},
		
		editComment:function(id){
			editComment(id);
		},
		
		// 该函数和selectTpl函数一样,但请优先使用该函数
		selectCommentTpl:function(targetFieldName, targetFieldId){
			var result = false;
			if((typeof onSelectCommentTpl) == "function"){
				result = onSelectCommentTpl.call(this, targetFieldName, targetFieldId);
			}
			if(result !== true){
				selectCommentTpl(targetFieldId);
			}
		},
		
		selectTpl:function(name, target){
			var result = false;
			if((typeof onSelectCommentTpl) == "function"){
				result = onSelectCommentTpl.call(this, name, target);
			}
			if(result !== true){
				doSelectTpl(name,target);
			}
		},
		
		manageCommentTpl:function(){
			OZ.openWindow({
				id: "win_manageCommentTpl",
				title: "常用批示语管理",
				url: contextPath +"/module/commentTplAction.do?action=display",
				refresh: true,
				beforeCloseFnName:"oz_Win_BeforeClose"
			});	
		},
		
		create:function(){
			OZ.openWindow({
				id: "win_createComment",
				title: "常用批示语",
				url: contextPath +"/module/commentTplAction.do?action=display",
				refresh: true,
				beforeCloseFnName:"oz_Win_BeforeClose"
			});	
		}
	};
	
	$(function() {
		$(".form-el-comments,.comments-logs").hover(function() {
			$(this).addClass("hover");
		}, function() {
			$(this).removeClass("hover");
		});
	});
	
})();