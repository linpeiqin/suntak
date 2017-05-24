/**
 * 附件组件
 * dragon 2009-03-03
 * singleton
 * 
 * 引用:oz-core.js,
 */
OZ.Attachment = {
    /**
     * 选择文件并上传
     * @param {Object} config 配置信息
     * @config {String} pdt 附件所属文档的类型 
     * @config {String} pid 附件所属文档的id
     * @config {String} group 附件分组信息
     * @config {String} caller 调用者的标识符
     * @config {String} filter 可选：可以上传的文件扩展名(不含符号“.”)，多个扩展名间用“;”隔开，为空代表支持任意扩展名的文件
     * 			如“jpg,gif;txt”
     * @config {String} filterDescription 可选：可以上传的文件扩展名的描述信息，与filter参数要一一对应
     * 			如“图像文件;文本文件”
     * @config {Number} maxSize 可选：上传文件的大小限制，单位为MB，为空代表使用服务器限制的大小
     * @config {String} path 可选：附件所保存的相对路径，前后不要带路径分隔符，这是相对于{DATA}下的子目录路径
     * @config {Boolean} multiple 可选：是否启用多文件上传支持，默认为true，使用flash技术启用多文件上传；设为false将使用浏览器通用的文件上传技术
     */
    uploadFile: function(params, callback){
		var paramstr=""; 
		if ($.isFunction(params)) {
			callback = params;
		} else if (typeof params === "object") {
			params.pid = $("#" + params.caller).attr("pid");
			paramstr = $.param(params);
		} else {
			paramstr = params;
		}
		
		var config = {
		    id: 'ozUploadFileDlg',
            title: '上传文件',
            width: 380,height: 200,refresh: true,modal:false,
            onOk: function(result){
            	if(params.caller) OZ.Attachment.updateCaller(params.caller,result.atms);   // 更新附件列表
            	//调用上传文件成功的回调函数
            	if(callback){
            		callback.call(this,result.atms,result.pdt,result.pid);
            	}
            }
		};
		
		var url = contextPath + '/component/attachmentAction.do?action=uploadFile&'+paramstr;
	    config.url = url;
	    //alert("config.url="+config.url);
	    if(!config.onOk)
            config.onOk = function(retult){};  
		
		// 显示对话框
        OZ.Dlg.create(config);
    },
    
    /**
     * 下载附件
     * @param {Object} config 配置信息
     * @config {String} caller 调用者的标识符
     * @config {String} target 下载附件的iframe的name
     */
    downloadFile: function(config){
        var _id = OZ.Attachment.getSelected(config.caller);
        if(_id){
			_ids = _id.split(','); 
			var url = '';
			if (_ids.length>1){
				url = contextPath + '/component/attachmentAction.do?action=downloadZipByIds&ids=' + _id+'&pdt=' + encodeURIComponent(config.pdt);
			}else{
		    	url = contextPath + '/component/attachmentAction.do?action=downloadFile&id=' + _id;
			}
            window.open(url,'_blank');
        }else{
            OZ.Msg.info('请先选择要下载的附件！');
        }
    },
    viewFile: function(id,subject){
	    var url = contextPath + '/component/attachmentAction.do?action=viewer&id=' + id;
	    OZ.openWindow({
			id: "viewFile"+id,
			title: subject,
			url: url
		});
    },
    editFile : function(id,subject){
    	var url = contextPath + '/component/attachmentAction.do?action=editFile&id=' + id;
	    OZ.openWindow({
			id: "editFile"+id,
			title: subject,
			url: url
		});
    },
    downloadZip: function(config){
	    var url = contextPath + '/component/attachmentAction.do?action=downloadZip&pid=' + config.pid +'&pdt=' + encodeURIComponent(config.pdt)+'&group=' + config.group;
        window.open(url, '_blank');
    },
    expandATM: function(ctrlId){
    	if($("#" + ctrlId + "_EXPAND").hasClass("oz-atm-expand-icon")){
    		$("#" + ctrlId + "_EXPAND").removeClass("oz-atm-expand-icon");
    		$("#" + ctrlId + "_EXPAND").addClass("oz-atm-collapse-icon");
    		$("#" + ctrlId + "_DATAS").show();
    	}else{
    		$("#" + ctrlId + "_EXPAND").removeClass("oz-atm-collapse-icon");
    		$("#" + ctrlId + "_EXPAND").addClass("oz-atm-expand-icon");
    		$("#" + ctrlId + "_DATAS").hide();
    	}
    },
    /**
     * 删除附件
     * @param {Object} config 配置信息
     * @config {String} caller 调用者的标识符
     */
    deleteFile: function(config){
		var ctrlId = config.caller;
    	var selectItem = OZ.Attachment.getSelected(config.caller,true);
        if(selectItem==null || selectItem.length==0){
            OZ.Msg.info('请先选择要删除的附件！');
            return;
        }
		
		var _id = "";
		if($("[name='"+ctrlId + "_SELECTALL']").length>0 || selectItem.id==null){//使用复选框选择
			for(i=0;i<selectItem.length;i++){
				if(!selectItem[i].deletable){
					OZ.Msg.info('你选择的附件没有权限删除！');
					return;
			   }
			   if (_id==""){
					_id = selectItem[i].id;
			   }else{        	   
				   _id += ","+selectItem[i].id;
			   }
			}
		}else{
			if(!selectItem.deletable){
				OZ.Msg.info('你选择的附件没有权限删除！');
				return;
			}
			_id = selectItem.id;
		}       

    	OZ.Msg.confirm("确定要删除选中的附件吗？",function(){
		    var url = contextPath + '/component/attachmentAction.do?action=deleteFile&ids=' + _id;
			$.ajax({
				type: "POST",
				dataType: "json",
				url: url,
				success: function(json, _status){
			        // 删除选中的行
	                var dataTable = $("#"+config.caller + '_DATAS').get(0);
		            var rows = dataTable.rows;
		            var deleteRowIndex = -1;
		            var i;
					var ids = _id.split(',');
		            
		            for(i = rows.length - 1;i > 0 ;i--){
		            	for(j=0;j<ids.length;j++){
		            		
			                if(rows[i].getAttribute("attachmentId") == ids[j]){
			                    deleteRowIndex = rows[i].rowIndex;
		   	                    dataTable.deleteRow(deleteRowIndex);
		   	                    break;
			                }
		            	}
		            }
	       	        
	                // 更新后面所有行的样式
	                rows = dataTable.rows;
		            var isJiShuRow;                     // 是否是奇数行
	                if(deleteRowIndex != -1 && rows.length > deleteRowIndex ){
		                for(i = deleteRowIndex;i < rows.length ;i++){
		                    isJiShuRow = ((i % 2) != 0);
			                rows[i].className = 'oz-atm-data-tr' + (isJiShuRow ? '0' : '1');
			            }
	                }
	                
	                $("#"+config.caller+"_FILECOUNT").text("(" + (rows.length - 1) + ")");
	                $("#"+config.caller).trigger("fileChange","delete");
				},
				error: function(xhr, errorMsg, errorThrown){
					OZ.Msg.error("保存操作出现未处理异常！");
				}
			});
		});
    },
    
    /**
     * 清空内容 
     */
    clean: function(ctrlId){
	    var dataTable = $("#" + ctrlId + '_DATAS').find("tr:gt(0)").remove();
    },
    
    /**
     * 选择文件并上传后的界面显示更新处理
     * @param {string} caller 调用者的标识符
     * @param {Array} atms 已上传的附件信息列表
     */
    updateCaller: function(caller,atms){
		var dataTable = $("#"+caller + '_DATAS').get(0);
		var rows = dataTable.rows;
		var curRowCount = rows.length - 1;  // 减去标题行
		//alert(OZ.encode(atms));
		var row,cell,atm,i,j;
		var isJiShuRow;                     // 是否是奇数行
		var cmLen = 5;                      // 列数
		var t;
		for(i = 0;i < atms.length ;i++){
		    isJiShuRow = (((i + curRowCount) % 2) == 0);
		    atm = atms[i];
			row = dataTable.insertRow(-1);  // 插入新行
			// tr的属性attachmentId设为附件的id
			row.setAttribute("attachmentId",atm.id); 
			// tr的属性attachmentFormat设为附件的format
			row.setAttribute("attachmentFormat",atm.format); 
			row.className = 'oz-atm-data-tr' + (isJiShuRow ? '' : '1');
			
			// 插入单元格
			for(j = 0;j < cmLen ;j++){
				cell = row.insertCell(-1);
			    cell.className = 'oz-atm-data-td' + (j == cmLen - 1  ? '-end' : '');
				switch (j){
                    case 0:
				        cell.setAttribute('align', 'center');
				        cell.setAttribute('width', '25');
						if($("[name='"+caller + "_SELECTALL']").length>0 ){
					        cell.innerHTML = '<input name="' + caller + '_SELECT" type="checkbox" />';
						}else{
							cell.innerHTML = '<input name="' + caller + '_SELECT" type="radio" />';
						}

                        break;
                    case 1:
                    	t = "<a href=\"javascript:OZ.Attachment.downloadAttachment(";
                    	t += atm.id + "," + "'" + atm.format + "')\"/>" + atm.subject + "</a>";
                    	//if(atm.format=="doc" || atm.format=="tif" || atm.format=="tiff"){
                    	//	t += "<a href=\"javascript:OZ.Attachment.viewFile(";
                    	//	t += atm.id + "," + "'" + atm.subject + "')\"/>在线查看</a>";
                    	//}
                    	cell.innerHTML = t;
                        break;
                    case 2:
				        cell.setAttribute('width', '80');
				        cell.innerHTML = atm.fileSize;
                        break;
                    case 3:
				        cell.setAttribute('width', '80');
				        cell.innerHTML = (atm.createdDate||" ").split(" ")[0];
                        break;
                    case 4:
				        cell.setAttribute('width', '100');
				        cell.innerHTML = atm.authorName;
                        break;
                }
			}
		}
		
		$("#"+caller + "_FILECOUNT").text("(" + (rows.length - 1) + ")");
		$("#"+caller).trigger("fileChange","upload");
    },
    
	/**
     * 选择所有
     * @param {String} ctrlId 附件控件的id
     */
    selectAll: function(config){	
		var ctrlId=config.caller;		
	 
	 	if($("[name='"+ctrlId + "_SELECTALL']").length>0){
			if($("[name='"+ctrlId + "_SELECTALL']").attr("checked")){			 	
				//$("[name='"+ctrlId + "_SELECTALL']").attr("checked",'true');//全选
				$("[name='"+ctrlId + "_SELECT']").attr("checked",'true');//全选			 
			}else{				
				//$("[name='"+ctrlId + "_SELECTALL']").removeAttr("checked");
				$("[name='"+ctrlId + "_SELECT']").removeAttr("checked");
			}
		}		
    },
	
    /**
     * 获取当前选中的附件信息
     * @param {String} ctrlId 附件控件的id
     * @return {returnJson} 决定是否使用json返回更详细的信息{id:[id],format:[format]}，默认为false
     */
    getSelected: function(ctrlId,returnJson){
    	returnJson = returnJson || false;

		if($("[name='"+ctrlId + "_SELECTALL']").length>0){//使用复选框选择
			return OZ.Attachment.getSelectedByCheckBox(ctrlId,returnJson);
		}else{
			return OZ.Attachment.getSelectedByRadio(ctrlId,returnJson);
		}   
    },
	getSelectedByCheckBox: function(ctrlId,returnJson){
    	returnJson = returnJson || false;
	   // var selectedRadio = OZ.getSelectedRadio(ctrlId + '_SELECT');
    	var result = [];
    	var ids = "";
		    	    
	    var checkBoxes = document.getElementsByName(ctrlId + '_SELECT');
		var selectedCheckBox = [];
		for(var i = 0; i < checkBoxes.length; i++){
			if(checkBoxes[i].checked){
				selectedCheckBox.push(checkBoxes[i]);
			}
		}

	    if(selectedCheckBox && selectedCheckBox.length){
	    	for(i=0;i<selectedCheckBox.length;i++){
		    	var $tr = $(selectedCheckBox[i].parentNode.parentNode);
		    	// 所在行tr的attachmentId，即附件的id
		        var id = $tr.attr("attachmentId");  
		        if(returnJson){
		        	var attachmentInfo = {};
		        	attachmentInfo.id = id;
		        	// 所在行tr的attachmentFormat，即附件的扩展名
		        	attachmentInfo.format =  $tr.attr("attachmentFormat");
		        	attachmentInfo.deletable = $tr.data("deletable");
			        if(attachmentInfo.deletable===undefined){
			        	attachmentInfo.deletable = true;
			        }
			        result.push(attachmentInfo);
		        }else{
		        	if (ids=="")
		        		ids += id;
		        	else
		        		ids += "," + id;
		        }
	    	}
	    }else{
	    	return OZ.Attachment.getSelectedByRadio(ctrlId,returnJson)
	       // return returnJson ? {} : null;
	    }
	    
	    if(returnJson){
	    	return result;
	    }else{
	    	return ids;
	    }	    
    },
    /**
     * 获取当前选中的附件信息
     * @param {String} ctrlId 附件控件的id
     * @return {returnJson} 决定是否使用json返回更详细的信息{id:[id],format:[format]}，默认为false
     */
    getSelectedByRadio: function(ctrlId,returnJson){
    	returnJson = returnJson || false;
	    var selectedRadio = OZ.getSelectedRadio(ctrlId + '_SELECT');
	    if(selectedRadio){
	    	var $tr = $(selectedRadio.parentNode.parentNode);
	    	// 所在行tr的attachmentId，即附件的id
	        var id = $tr.attr("attachmentId");  
	        if(returnJson){
	        	var result = {};
	        	result.id = id;
	        	// 所在行tr的attachmentFormat，即附件的扩展名
		        result.format =  $tr.attr("attachmentFormat");
		        result.deletable = $tr.data("deletable");
		        if(result.deletable===undefined){
		        	result.deletable = true;
		        }
		        return result;
	        }else{
	        	return id;
	        }
	    }else{
	        return returnJson ? {} : null;
	    }
    },
    /**
     * 判断附件控件是否没有包含任何附件
     * @param {String} ctrlId 附件控件的id
     * @return {Boolean} 为空返回true
     */
    isEmpty: function(ctrlId){
		if($("[name='"+caller + "_SELECTALL']").length>0 ){
    		return $(":checkbox[name='" + ctrlId + "_SELECT" +"']",$("#" + ctrlId)).length == 0;
		}else{
			return $(":radio[name='" + ctrlId + "_SELECT" +"']",$("#" + ctrlId)).length == 0;
		}
    },
    /**
     * 改变附件控件所属文档的标识
     * @param {String} ctrlId 附件控件的id
     * @return {Boolean} 为空返回true
     */
    changePID: function(ctrlId, newPID){
    	var atm;
    	if(ctrlId){
    		atm = $("#" + ctrlId).attr("pid", newPID);
    	}else{
    		atm = $(".oz-atm-contaner-table").attr("pid", newPID);
    	}
    	    	
    	//如果使用flash控件则需要更新控件对应的unid
    	var control;
    	for(var i=0;i < OZ.Attachment.Flash.Controls.length;i++){
    		control = OZ.Attachment.Flash.Controls[i];
			var url = control.settings.upload_url;
			url = url.replace(/pid=([^&]*)/g,"pid="+newPID);
			ozlog.info("update flash upload url=" + url);
			try{
				control.setUploadURL(url);
			}catch(e){
			}
    	}
    },
    
    /**
     * 指定附件的id直接下载附件
     * @param {String} attachmentId 附件的id
     * @param {String} format 附件的格式
     * @param {String} target 下载附件的iframe的name
     */
  	downloadAttachment:function(id,format,target){
        if(id){
		    var url = contextPath + '/component/attachmentAction.do?action=downloadFile&id=' + id;
            window.open(url,target || '_blank');
        }else{
            OZ.Msg.info('必须配置所下载附件的id!');
        }
    }
};
OZ.Attachment.Flash = {};
OZ.Attachment.Flash.defaults = {
	EMPTY_INFO:"没有任何文件可上传",
	START_INFO:"开始上传文件...",
	PROGRESS_INFO:'<div class="oz-atm-progress-size">{0}</div>'+
		'<div class="oz-atm-progress-box">'+
		'<div class="oz-atm-progress-percent"></div>'+
		'</div>'+
		'<div title="取消上传" class="btn cancel" onmouseover="this.className=\'btn cancel-mouseOver\'" onmouseout="this.className=\'btn cancel\'"></div>',
	FINISHED_INFO:"上传完毕",
	ERROR_INFO:"上传失败:{0}",
	CANCEL_INFO:"已取消上传"
};
/** 自动初始化swfupload控件 */
OZ.Attachment.Flash.init = function(){
	ozlog.info("OZ.Attachment.Flash.init...");
	//如果不是ie就强制不使用SWFUpload(因session丢失问题)
	//if(!$.browser.msie){
	//	ozlog.info("browser is not ie,can not use SWFUpload!");
	//	$(".oz-atm-contaner-table[multiple='true']").attr("multiple","false");
	//}
	
	var atms = $(".oz-atm-contaner-table[multiple='multiple']");
	var baseUploadUrl = contextPath + "/component/attachmentAction.do";
	if(typeof(ozsid) != "undefined")
		baseUploadUrl += ";jsessionid=" + ozsid;
	// baseUploadUrl += "?action=uploadFileWithFlash&_encoding=true";
	baseUploadUrl += "?action=uploadFileWithFlash";
	OZ.Attachment.Flash.baseUploadUrl = baseUploadUrl;
	if(atms.length == 0) 
		return;
	
	SWFUpload.onload = function () {		
		atms.each(function(){
			var atm = $(this);
			if($("#" + atm.attr("id") + "_UPLOAD_PLACEHOLDER").length == 0){				
				return;
			}
			
			var url = baseUploadUrl + "&pdt=" + encodeURIComponent(atm.attr("pdt")) + "&pid=" + atm.attr("pid");
			url += (atm.attr("group").length>0 ? "&group=" + atm.attr("group") : "");
			url += (atm.attr("path").length>0 ? "&path=" + atm.attr("path") : "");
			var swfuCfg = {
				upload_url : url,
				flash_url : contextPath + "/oz/webui/swfupload/swfupload.swf",// "http://www.swfupload.org/swfupload.swf",
				file_post_name : "Filedata",
				file_types : "*.*",
				file_types_description: "所有文件",
				button_width: "60",
				button_height: "21",
				button_placeholder_id: atm.attr("id")+"_UPLOAD_PLACEHOLDER",
				button_text: '<span class="theFont">上传</span>',
				button_text_style: ".theFont{font-size:12;}",
				button_text_left_padding: 25,
				button_text_top_padding: 0,
				button_action : SWFUpload.BUTTON_ACTION.SELECT_FILES, 
				button_disabled : false, 
				button_cursor : SWFUpload.CURSOR.HAND, 
				button_window_mode : SWFUpload.WINDOW_MODE.TRANSPARENT,
				button_image_url : contextPath + "/oz/themes/default/images/attachment/upload-button_60x21.png", 
				debug:false,
				custom_settings : {
					atmId : atm.attr("id"),
					infoId : atm.attr("id")+"_INFO",
					totalSize: 0,
					finishedSize: 0
				},
				
				// The event handler functions
				file_queued_handler : OZ.Attachment.Flash.EventFn.fileQueued,
				file_queue_error_handler : OZ.Attachment.Flash.EventFn.fileQueueError,
				file_dialog_complete_handler : OZ.Attachment.Flash.EventFn.fileDialogComplete,
				upload_start_handler : OZ.Attachment.Flash.EventFn.uploadStart,
				upload_progress_handler : OZ.Attachment.Flash.EventFn.uploadProgress,
				upload_error_handler : OZ.Attachment.Flash.EventFn.uploadError,
				upload_success_handler : OZ.Attachment.Flash.EventFn.uploadSuccess,
				upload_complete_handler : OZ.Attachment.Flash.EventFn.uploadComplete,
				
				// 浏览器flash插件的控制：需要swfupload.swfobject.js插件的支持
				minimum_flash_version: "9.0.28",
				swfupload_pre_load_handler: OZ.Attachment.Flash.EventFn.swfuploadPreLoad,
				swfupload_load_failed_handler: OZ.Attachment.Flash.EventFn.swfuploadLoadFailed
			};
			ozlog.info("upload_url=" + swfuCfg.upload_url);
			
			//文件大小限制
			if(atm.attr("maxSize").length>0)
				swfuCfg.file_size_limit = atm.attr("maxSize");
			
			//文件过滤控制
			if(atm.attr("filter").length>0){
				var all = atm.attr("filter").split("|");
				swfuCfg.file_types = all[0];
				if(all.length >1)
					swfuCfg.file_types_description=all[1];
			}
			OZ.Attachment.Flash.Controls.push(new SWFUpload(swfuCfg));
		});
	};
	ozlog.info("OZ.Attachment.Flash.init...finished");
};

OZ.Attachment.Flash.Controls = [];//已初始化的flash控件的记录
OZ.Attachment.Flash.EventFn = {
	/**file_queued_handler
	 * 当文件选择对话框关闭消失时，如果选择的文件成功加入上传队列，那么针对每个成功加入的文件都会
	 * 触发一次该事件（N个文件成功加入队列，就触发N次此事件）。
	 */
	fileQueued:function(file){
		this.customSettings.totalSize += file.size;
	},
	/**file_queue_error_handler
	 * 当选择文件对话框关闭消失时，如果选择的文件加入到上传队列中失败，那么针对每个出错的文件都会触发一次该事件
	 * (此事件和fileQueued事件是二选一触发，文件添加到队列只有两种可能，成功和失败)。
	 * 文件添加队列出错的原因可能有：超过了上传大小限制，文件为零字节，超过文件队列数量限制，设置之外的无效文件类型。
	 * 具体的出错原因可由error code参数来获取，error code的类型可以查看SWFUpload.QUEUE_ERROR中的定义。
	 */
	fileQueueError:function(file, errorCode, message){
		document.getElementById(this.customSettings.infoId).innerHTML = OZ.Attachment.Flash.defaults.ERROR_INFO;
	},
	/**file_dialog_complete_handler
	 * 当选择文件对话框关闭，并且所有选择文件已经处理完成（加入上传队列成功或者失败）时，此事件被触发，
	 * number of files selected是选择的文件数目，number of files queued是此次选择的文件中成功加入队列的文件数目。
	 */
	fileDialogComplete:function(numberOfFilesSelected, numberOfFilesQueued){
		ozlog.info("selected:" + numberOfFilesSelected + ";queued:" + numberOfFilesQueued+";total:" + this.customSettings.totalSize);
		var getsize = function(totalSize){
			var sizeInfo;
			if(totalSize > 1024*1024){//>1MB
				sizeInfo = (totalSize/1024/1024).toFixed(1) + " MB"
			}else if(totalSize > 1024){//>1KB
				sizeInfo = (totalSize/1024).toFixed(1) + " KB"
			}else{
				sizeInfo = totalSize + " 字节"
			}
			return sizeInfo;
		};
		try {
			if (numberOfFilesSelected > 0) {
				if (numberOfFilesQueued > 0) {
					//构建上传的进度条
					var sizeInfo = getsize(this.customSettings.totalSize);
				
					var infoWraper = $("#" + this.customSettings.atmId + " .oz-atm-info");
					infoWraper.html("");
					$(OZ.String.format(OZ.Attachment.Flash.defaults.PROGRESS_INFO, sizeInfo)).appendTo(infoWraper);
					//绑定取消事件
					var othis = this;
					infoWraper.find(".btn").click(function(){
						ozlog.warn("cancelUpload");
						othis.cancelUpload();
						othis.customSettings.cancel = true;
					});
					
					//自动开始上传:默认只会上传第一个文件，需要在uploadComplete控制继续上传
					this.startUpload();
				}else{
					var msg = OZ.Attachment.Flash.defaults.EMPTY_INFO;
					if(null != this.settings.file_size_limit && this.settings.file_size_limit.length > 0 && this.settings.file_size_limit != "0")
						msg += "，或者您所上传文件的大小超过了" + getsize(this.settings.file_size_limit*1024) + "的限制。";
					document.getElementById(this.customSettings.infoId).innerHTML = msg;
				}
			}
		} catch(ex){
	        ozlog.error("" + ex);
		}
	},
	/**upload_start_handler
	 * 在文件往服务端上传之前触发此事件，可以在这里完成上传前的最后验证以及其他你需要的操作，例如添加、修改、删除post数据等。
	 * 在完成最后的操作以后，如果函数返回false，那么这个上传不会被启动，并且触发uploadError事件（code为ERROR_CODE_FILE_VALIDATION_FAILED），
	 * 如果返回true或者无返回，那么将正式启动上传。
	 */
	uploadStart:function(file){
		ozlog.info("uploadStart:" + file.name);
		//document.getElementById(this.customSettings.infoId).innerHTML = OZ.Attachment.Flash.defaults.START_INFO;
	},
	/**upload_progress_handler
	 * 该事件由flash定时触发，提供三个参数分别访问上传文件对象、已上传的字节数，总共的字节数。
	 * 因此可以在这个事件中来定时更新页面中的UI元素，以达到及时显示上传进度的效果。
	 * 注意: 在Linux下，Flash Player只在所有文件上传完毕以后才触发一次该事件，官方指出这是
	 * Linux Flash Player的一个bug，目前SWFpload库无法解决
	 */
	uploadProgress:function(file, bytesComplete, totalBytes){
		var percent = ((this.customSettings.finishedSize + bytesComplete)/this.customSettings.totalSize * 100).toFixed(0) + "%";
		ozlog.debug("uploadProgress:["+percent+"][" + bytesComplete + "/" + totalBytes + "]" + file.name);
		$("#" + this.customSettings.atmId + " .oz-atm-progress-percent").width(percent);
	},
	/**upload_success_handler
	 * 当文件上传的处理已经完成（这里的完成只是指向目标处理程序发送了Files信息，只管发，不管是否成功接收），
	 * 并且服务端返回了200的HTTP状态时，触发此事件。
	 * 此时文件上传的周期还没有结束，不能在这里开始下一个文件的上传。
	 */
	uploadSuccess:function(file, serverData){
		ozlog.info("uploadSuccess:" + file.name + ";serverData=" + serverData);
		this.customSettings.finishedSize+=file.size;//累计已上传的字节数
        // serverData = decodeURIComponent(serverData);
		var atms=$.parseJSON(serverData);
    	OZ.Attachment.updateCaller(this.customSettings.atmId,atms);   // 更新附件列表
	},
	/**upload_complete_handler
	 * 当上传队列中的一个文件完成了一个上传周期，无论是成功(uoloadSuccess触发)还是失败(uploadError触发)，此事件都会被触发，
	 * 这也标志着一个文件的上传完成，可以进行下一个文件的上传了。
	 */
	uploadComplete:function(file){
		ozlog.info("uploadComplete:" + file.name);
		var stats = this.getStats();
		if (stats.files_queued > 0 && !this.customSettings.cancel){
			this.startUpload();
		}else{
			//全部上传完毕后的处理
			this.customSettings.totalSize=0;
			this.customSettings.finishedSize=0;
			if (this.customSettings.cancel){
				document.getElementById(this.customSettings.infoId).innerHTML = OZ.Attachment.Flash.defaults.CANCEL_INFO;
			}else{
				document.getElementById(this.customSettings.infoId).innerHTML = OZ.Attachment.Flash.defaults.FINISHED_INFO;
			}
			window.setTimeout('OZ.Attachment.Flash.EventFn.clean.call(null,"' + this.customSettings.infoId+'")',1000*5);
		}
	},
	clean:function(infoId){
		var t = $("#" + infoId);
		t.fadeOut("normal",function(){t.html("").show()});
	},
	/**upload_error_handler
	 * 当上传队列中的一个文件完成了一个上传周期，无论是成功(uoloadSuccess触发)还是失败(uploadError触发)，此事件都会被触发，
	 * 这也标志着一个文件的上传完成，可以进行下一个文件的上传了。
	 * SWFUpload.UPLOAD_ERROR
	 */
	uploadError:function(file, errorCode, message){
		ozlog.error("uploadError:" + file.name + ";errorCode:" + errorCode + ";message:" + message);
		document.getElementById(this.customSettings.infoId).innerHTML = OZ.Attachment.Flash.defaults.ERROR_INFO.format(file.name);
	},
	/**swfupload_pre_load_handler
	 */
	swfuploadPreLoad:function(){
		ozlog.info("swfuploadPreLoad");
	},
	/**swfupload_load_failed_handler
	 */
	swfuploadLoadFailed:function(){
		ozlog.error("swfuploadLoadFailed");
	}
};
$(function(){
	OZ.Attachment.Flash.init();
});