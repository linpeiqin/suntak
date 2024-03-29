/**
 * OZ 消息框核心
 * 
 * @author king
 * @since 1.0
 * 
 * 依赖如下 oz-core oz-panel oz-window oz-linkbutton
 */
(function($) {
	function show(win, type, speed, timeout) {
		if (!win){
			return;
		}
		switch (type) {
		case null:
			win.show();
			break;
		case 'slide':
			win.slideDown(speed);
			break;
		case 'fade':
			win.fadeIn(speed);
			break;
		case 'show':
			win.show(speed);
			break;
		}

		var timer = null;
		if (timeout > 0) {
			timer = setTimeout(function() {
				hide(win, type, speed);
			}, timeout);
		}
		win.hover(function() {
			if (timer) {
				clearTimeout(timer);
			}
		}, function() {
			if (timeout > 0) {
				timer = setTimeout(function() {
					hide(win, type, speed);
				}, timeout);
			}
		});

	}
	function hide(win, type, speed) {
		if (!win){
			return;
		}
		switch (type) {
		case null:
			win.hide();
			break;
		case 'slide':
			win.slideUp(speed);
			break;
		case 'fade':
			win.fadeOut(speed);
			break;
		case 'show':
			win.hide(speed);
			break;
		}

		setTimeout(function() {
			win.remove();
		}, speed - 100);
	}
	function createDialog(title, content, buttons) {
		var win = $('<div class="oz-messager-body"></div>').appendTo('body');
		win.append(content);
		if (buttons) {
			var tb = $('<div class="oz-messager-button"></div>').appendTo(win);
			for ( var label in buttons) {
				$('<a></a>').attr('href', 'javascript:void(0)').text(label)
						.css('margin-left', 10).bind('click',
								eval(buttons[label])).appendTo(tb).linkbutton();
			}
		}
		win.window({
			title : title,
			width : 300,
			height : 'auto',
			modal : true,
			collapsible : false,
			minimizable : false,
			maximizable : false,
			resizable : false,
			closed : false,
			closable : false,
			close : function() {
				setTimeout(function() {
					win.window('destroy');
				}, 100);
			}
		});
		return win;
	}

	$.messager = {
		show : function(options) {
			var opts = $.extend({
				showType : 'slide',
				showSpeed : 600,
				width : 250,
				height : 100,
				msg : '',
				title : '',
				timeout : 1500
			}, options || {});

			var win = $('<div class="oz-messager-body"></div>').html(opts.msg).appendTo('body');
			win.window({
				title : opts.title,
				width : opts.width,
				height : opts.height,
				collapsible : false,
				minimizable : false,
				maximizable : false,
				shadow : false,
				draggable : false,
				resizable : false,
				closed : true,
				beforeopen : function() {
					show(win.window('window'), opts.showType, opts.showSpeed, opts.timeout);
					win.window('option', 'closed', false);
					
					if (opts.beforeOpenFn) {
						opts.beforeOpenFn();
					}
					return false;
				},
				beforeclose : function() {
					hide(win.window('window'), opts.showType, opts.showSpeed);
					win.window('option', 'closed', true);
					if (opts.beforeCloseFn) {
						opts.beforeCloseFn();
					}
					return false;
				}
			});
			
			// set the message window to the right bottom position
			win.window('window').css({
				left : 'auto',
				top : 'auto',
				right : 0,
				zIndex : OZ.window.Window.zIndex++,
				bottom : -document.body.scrollTop -document.documentElement.scrollTop
			});
			
			win.window('open');
		},

		alert : function(title, msg, icon, fn) {
			var content = '<div>' + msg + '</div>';
			switch (icon) {
			case 'error':
				content = '<div class="oz-messager-icon oz-messager-error"></div>' + content;
				break;
			case 'info':
				content = '<div class="oz-messager-icon oz-messager-info"></div>' + content;
				break;
			case 'question':
				content = '<div class="oz-messager-icon oz-messager-question"></div>' + content;
				break;
			case 'warning':
				content = '<div class="oz-messager-icon oz-messager-warning"></div>' + content;
				break;
			}
			content += '<div style="clear:both;"/>';

			var buttons = {};
			buttons[$.messager.defaults.ok] = function() {
				win.dialog({
					closed : true
				});
				if (fn) {
					fn();
					return false;
				}
			};
			buttons[$.messager.defaults.ok] = function() {
				win.window('close');
				if (fn) {
					fn();
					return false;
				}
			};
			var win = createDialog(title, content, buttons);
		},

		confirm : function(title, msg, fn) {
			var content = '<div class="oz-messager-icon oz-messager-question"></div>' + '<div>' + msg + '</div>' + '<div style="clear:both;"/>';
			var buttons = {};
			buttons[$.messager.defaults.ok] = function() {
				win.window('close');
				if (fn) {
					fn(true);
					return false;
				}
			};
			buttons[$.messager.defaults.cancel] = function() {
				win.window('close');
				if (fn) {
					fn(false);
					return false;
				}
			};
			var win = createDialog(title, content, buttons);
		},

		yesNoCancel : function(title, msg, fn) {
			var content = '<div class="oz-messager-icon oz-messager-question"></div>' + '<div>' + msg + '</div>' + '<div style="clear:both;"/>';
			var buttons = {};
			buttons[$.messager.defaults.yes] = function() {
				win.window('close');
				if (fn) {
					fn('y');
					return false;
				}
			};
			buttons[$.messager.defaults.no] = function() {
				win.window('close');
				if (fn) {
					fn('n');
					return false;
				}
			};
			buttons[$.messager.defaults.cancel] = function() {
				win.window('close');
				if (fn) {
					fn('c');
					return false;
				}
			};
			var win = createDialog(title, content, buttons);
		},
		
		prompt : function(title, msg, fn, value, multiline, isPassword,
				showIcon) {
			// 这里是改写的部分代码
			var content = (showIcon ? '<div class="oz-messager-icon oz-messager-question"></div>' : '')+ '<div style="margin-bottom:4px;">'+ msg + '</div>'	+ (showIcon ? '<br/>' : '')	+ '{0}'	+ '<div style="clear:both;"/>';
			if (multiline) {
				content = OZ.String.format(content,'<textarea class="oz-messager-input">'	+ (value || '') + '</textarea>');
			} else {
				content = OZ.String.format(content,'<input class="oz-messager-input" type="' + (isPassword ? "password" : "text")	+ '" value="' + (value || "") + '"/>');
			}
			var oldValue = value;

			var buttons = {};
			buttons[$.messager.defaults.ok] = function() {
				win.window('close');
				if (fn) {
					fn($('.oz-messager-input', win).val(), true, oldValue);
					return false;
				}
			};
			buttons[$.messager.defaults.cancel] = function() {
				win.window('close');
				if (fn) {
					fn($('.oz-messager-input', win).val(), false, oldValue);
					return false;
				}
			};
			var win = createDialog(title, content, buttons);
		}
	};

	$.messager.defaults = {
		ok : '确认',
		cancel : '取消',
		yes : ' 是 ',
		no : ' 否 '
	};

})(jQuery);

/**
 * oz消息框控件
 * 
 * 版本: 1.0 作者：dragon 2010-07-26 依赖：jquery、jquery-easyui
 * 说明：对jquery-easyui消息框简单的封装，并将prompt方法扩展为支持多行文本输入
 */
OZ.Messager = {
	/**
	 * 提示框
	 * 
	 * @param {String}
	 *            msg 提示信息
	 * @param {String}
	 *            onOk [可选]点击确认按钮的回调函数
	 * @param {String}
	 *            title [可选]标题,默认为OZ.Messager.DEFAULT_TITLE
	 * @param {String}
	 *            icon [可选]显示的图标类型：error,question,info,warning，默认不显示图标
	 */
	alert : function(msg, title, onOk, icon) {
		$.messager.alert(title || OZ.Messager.DEFAULT_TITLE, msg, icon, onOk);
	},
	/**
	 * 确认框
	 * 
	 * @param {String}
	 *            msg 提示信息
	 * @param {String}
	 *            onOk 点击确认|是按钮的回调函数
	 * @param {String}
	 *            onCancel [可选]点击取消|否按钮的回调函数
	 * @param {String}
	 *            title [可选]标题,默认为OZ.Messager.DEFAULT_TITLE
	 */
	confirm : function(msg, onOk, onCancel, title) {
		$.messager.confirm(title || OZ.Messager.DEFAULT_TITLE, msg, function(
				value) {
			if (value) {
				if (typeof onOk == "function"){
					onOk.call(this, true);
				}
			} else {
				if (typeof onCancel == "function"){
					onCancel.call(this, false);
				}
			}
		});
	},
	/**
	 * 输入框
	 * 
	 * @param {String}
	 *            msg 提示信息
	 * @param {String}
	 *            onOk 点击确认按钮的回调函数
	 * @param {String}
	 *            onCancel [可选]点击取消按钮的回调函数
	 * @param {String}
	 *            value [可选]文本输入框默认显示的内容
	 * @param {Boolean}
	 *            multiline [可选]是否为多行文本输入，默认为false(单行文本输入)
	 * @param {String}
	 *            title [可选]标题,默认为OZ.Messager.DEFAULT_TITLE
	 * @param {Boolean}
	 *            isPassword
	 *            [可选]是否是密码输入框，默认为false(文本输入框)，只有在multiline为非true的情况下有效
	 * @param {Boolean}
	 *            showIcon [可选]是否显示图标，默认为false(不显示)
	 */
	prompt : function(msg, onOk, onCancel, value, multiline, title, isPassword,
			showIcon) {
		$.messager.prompt(title || OZ.Messager.DEFAULT_TITLE, msg, function(
				value, isOk, oldValue) {
			if (isOk) {
				if (typeof onOk == "function"){
					onOk.call(this, value, oldValue);
				}
			} else {
				if (typeof onCancel == "function"){
					onCancel.call(this, value, oldValue);
				}
			}
		}, value, multiline, isPassword, showIcon);
	},
	/**
	 * 询问对话框：Yes|No|Cancel
	 * 
	 * @param {String} msg 提示信息
	 * @param {String} onYes 点击是按钮的回调函数
	 * @param {String} onNo 点击否按钮的回调函数
	 * @param {String} onCancel 点击取消按钮的回调函数
	 * @param {String} title [可选]标题,默认为OZ.Messager.DEFAULT_TITLE
	 */
	yesNoCancel : function(msg, onYes, onNo, onCancel, title) {
		$.messager.yesNoCancel(title || OZ.Messager.DEFAULT_TITLE, msg, function(value) {
			if ('y' == value) {
				if (typeof onYes == "function"){
					onYes.call(this);
				}
			}else if ('n' == value) {
				if (typeof onNo == "function"){
					onNo.call(this);
				}
			} else {
				if (typeof onCancel == "function"){
					onCancel.call(this);
				}
			}
		});
	},
	/** 信息提示框：提示框icon=info的简化使用版 */
	info : function(msg, title, onOk) {
		OZ.Messager.alert(msg, title, onOk, "info");
	},
	/** 信息警告框：提示框icon=warning的简化使用版 */
	warn : function(msg, title, onOk) {
		OZ.Messager.alert(msg, title, onOk, "warning");
	},
	/** 错误提示框：提示框icon=error的简化使用版 */
	error : function(msg, title, onOk) {
		OZ.Messager.alert(msg, title, onOk, "error");
	},
	/** 信息提问框：提示框icon=question的简化使用版 */
	question : function(msg, title, onOk) {
		OZ.Messager.alert(msg, title, onOk, "question");
	},
	/**
	 * 自动提醒框：显示在页面右下角并可以自动隐藏的消息提示框
	 * 
	 * @param {Object}
	 *            config 配置对象
	 * @config {String} showType 消息框弹出的动画类型：
	 *         null,slide(底部滑出滑入),fade(右下角射出射入),show(慢慢出现消失)，默认为slide
	 * @config {String} showSpeed 定义消息框自动隐藏的速度(单位为毫秒)，默认为600
	 * @config {String} width 消息框的宽度，默认为250
	 * @config {String} height 消息框的高度，默认为100
	 * @config {String} msg 消息内容
	 * @config {String} title 标题
	 * @config {String} timeout 消息框显示的停留时间(单位为毫秒)，默认为4000，设为0则不会自动隐藏
	 */
	show : function(config) {
		$.messager.show($.extend({
			title : OZ.Messager.DEFAULT_TITLE
		}, config));
	},
	/** 自动提醒框的slide简化使用版:滑出滑入效果 */
	slide : function(msg, timeout, width, height, title, beforeOpenFn, beforeCloseFn) {
		var c = {
			showType : 'slide',
			msg : msg
		};
		if (typeof timeout != "undefined" && timeout != null){
			c.timeout = timeout;
		}
		if (typeof width != "undefined" && width != null){
			c.width = width;
		}
		if (typeof height != "undefined" && height != null){
			c.height = height;
		}
		if (typeof title != "undefined" && title != null){
			c.title = title;
		}
		if (typeof beforeOpenFn != "undefined" && beforeOpenFn != null){
			c.beforeOpenFn = beforeOpenFn;
		}
		if (typeof beforeCloseFn != "undefined" && beforeCloseFn != null){
			c.beforeCloseFn = beforeCloseFn;
		}
		OZ.Messager.show(c);
	},
	/** 自动提醒框的fade简化使用版：渐渐显示消失效果 */
	fade : function(msg, timeout, width, height, title, beforeOpenFn, beforeCloseFn) {
		var c = {
			showType : 'fade',
			msg : msg
		};
		if (typeof timeout != "undefined" && timeout != null){
			c.timeout = timeout;
		}
		if (typeof width != "undefined" && width != null){
			c.width = width;
		}
		if (typeof height != "undefined" && height != null){
			c.height = height;
		}
		if (typeof title != "undefined" && title != null){
			c.title = title;
		}
		if (typeof beforeOpenFn != "undefined" && beforeOpenFn != null){
			c.beforeOpenFn = beforeOpenFn;
		}
		if (typeof beforeCloseFn != "undefined" && beforeCloseFn != null){
			c.beforeCloseFn = beforeCloseFn;
		}
		OZ.Messager.show(c);
	},
	/** 自动提醒框的show简化使用版：从角落飞出飞入效果 */
	fly : function(msg, timeout, width, height, title, beforeOpenFn, beforeCloseFn) {
		var c = {
			showType : 'show',
			msg : msg
		};
		if (typeof timeout != "undefined" && timeout != null){
			c.timeout = timeout;
		}
		if (typeof width != "undefined" && width != null){
			c.width = width;
		}
		if (typeof height != "undefined" && height != null){
			c.height = height;
		}
		if (typeof title != "undefined" && title != null){
			c.title = title;
		}
		if (typeof beforeOpenFn != "undefined" && beforeOpenFn != null){
			c.beforeOpenFn = beforeOpenFn;
		}
		if (typeof beforeCloseFn != "undefined" && beforeCloseFn != null){
			c.beforeCloseFn = beforeCloseFn;
		}
		OZ.Messager.show(c);
	}
};
OZ.Msg = OZ.Messager;

/** 国际化 */
OZ.Messager.DEFAULT_TITLE = "系统提示";
