//Gird
(function($) {
	var typeTimer, typeSearch = '';
	OZ.widget("OZ.Combox",{
		$type: "combox",
		options: {
			editable: false,
			autoWidth : true,
			menuTransition : "default",
			menuSpeed: 0,
			checkbox: true,
			multiple: false,
			inline: false,
			size:5
		},
		_render: function(){
			if( navigator.userAgent.match(/iPad|iPhone|Android/i) ) {
				return false;
			}
			// Element must be a select control
			if( this.dom.tagName.toLowerCase() !== 'select' ){
				return false;
			}
			var select = this.element,
				control = this.control = $('<a class="oz-combox" />');
			
			this.options.multiple = select.attr('multiple');
			//是否是内嵌方式
			this.options.inline = this.options.multiple || parseInt(select.attr('size'),10) > 1;
			
			//如果不是是下拉框，则不能编辑
			if(this.options.inline){
				this.options.editable = false;
			}
			//不是多选，不能使用多选框
			if(!this.options.multiple){
				this.options.checkbox = false;
			}
			
			//复制默认演示(class names, style 和  title)
			control
				.addClass(select.attr('class'))
				.attr('style', select.attr('style') || '')
				.attr('title', select.attr('title') || '')
				.attr('tabindex', parseInt(select.attr('tabindex'),10))
				.css('display', 'inline-block')
				.bind('focus.'+this.$type, function() {
					if( this !== document.activeElement ){
						$(document.activeElement).blur();
					}
					if( control.hasClass('oz-combox-active') ){
						return;
					}
					control.addClass('oz-combox-active');
					select.trigger('focus');
				})
				.bind('blur.'+this.$type, function() {
					if( !control.hasClass('oz-combox-active') ) {
						return;
					}
					control.removeClass('oz-combox-active');
					select.trigger('blur');
				});
			
			if( select.attr('disabled') ) {
				this.disable();
				select.attr('disabled',false);
			}
		},
		_init: function(){
			this._initOptions();
			
			var combox = this,
				select = this.element,
				control = this.control,
				options = this.selectOptions;
			
			if(this.options.inline ) {
				control
					.append(options)
					.addClass('oz-combox-inline')
					.addClass('oz-combox-menuShowing')
					.bind('keydown.'+this.$type, function(event) {
						combox._handleKeyDown(event);
					})
					.bind('keypress.'+this.$type, function(event) {
						combox._handleKeyPress(event);
					})
					.bind('mousedown.'+this.$type, function(event) {
						if( $(event.target).is('A.oz-combox-inline') ){
							event.preventDefault();
						}
						if( !control.hasClass('oz-combox-focus') ){
							control.focus();
						}
					})
					.insertAfter(select);
				
				// Auto-height based on size attribute
				if( !select[0].style.height ) {
					var size = select.attr('size') ? parseInt(select.attr('size'),10) : 5;
					// Draw a dummy control off-screen, measure, and remove it
					var tmp = control
						.clone()
						.removeAttr('id')
						.css({
							position: 'absolute',
							top: '-9999em'
						})
						.show()
						.appendTo('body');
					tmp.find('.oz-combox-options').html('<li><a>\u00A0</a></li>');
					optionHeight = parseInt(tmp.find('.oz-combox-options A:first').html('&nbsp;').outerHeight(),10);
					tmp.remove();
					control.height(optionHeight * size);
				}
			} else {
				//
				// Dropdown controls
				//
				
				var menuFun = function(event) {
					if( control.hasClass('oz-combox-menuShowing') ) {
						combox._hideMenus();
					} else {
						event.stopPropagation();
						// Webkit fix to prevent premature selection of options
						options.data('combox-down-at-x', event.screenX).data('combox-down-at-y', event.screenY);
						combox._showMenu();
					}
				};
				
				var textdom,
					arrow = $('<span class="oz-combox-arrow" />');
				
				//如果可编辑，则只有旁边的可以点击下拉
				if(combox.options.editable){
					
					arrow.bind('mousedown.'+this.$type, menuFun);
					
					textdom = $('<input type="text" class="oz-combox-input"/>');
					textdom
						.val($(select).find('OPTION:selected').text()|| '\u00A0')
						.attr("readonly",false)
						.bind('change.'+this.$type,function(){
							this.modify = true;
						})
						.bind('blur.'+this.$type,function(){
							if(this.modify){
								combox.value(this.value);
								this.modify = false;
							}
							if(!control.hasClass('oz-combox-active') ){
								control.blur();
							}
						})
						.bind('focus.'+this.$type,function(){
							event.preventDefault(); // Prevent options from being "dragged"
//							if( !control.hasClass('oz-combox-active') ) control.focus();
						});
					
				}else{
					control
						.bind('mousedown.'+this.$type,menuFun )
						.bind('keydown.'+this.$type, function(event) {
							combox._handleKeyDown(event);
						})
						.bind('keypress.'+this.$type, function(event) {
							combox._handleKeyPress(event);
						});
					
					textdom = $('<span class="oz-combox-label" />');
					textdom.text($(select).find('OPTION:selected').text()|| '\u00A0');
				}
				
				
	
				options.appendTo('BODY');
				control
					.addClass('oz-combox-dropdown')
					.append(textdom)
					.append(arrow)
					.insertAfter(select);
			}
			select.hide();
		},
		/**
		 * 设置显示的文本
		 */
		_setText:function(text){
			this.control.find('.oz-combox-input').val(text || '\u00A0' );
			this.control.find('.oz-combox-label').text(text || '\u00A0' );
		},
		/**
		 * 初始化可选项
		 */
		_initOptions:function(){
			var options = $('<ul class="oz-combox-options" />'),
				combox = this,
				select = this.element,
				control = this.control,
				settings = this.options;
			
			// Generate control
			var createOption = function() {
					var li = $('<li />'),
					a = $('<a />');
				li.addClass( $(this).attr('class') );
				a.attr('rel', $(this).val()).attr("title", $(this).text());
				
				if(settings.checkbox){
					a.append("<span class='oz-combox-checkbox'></span>");
					a.append(document.createTextNode( $(this).text()));
				}else{
					a.text($(this).text());
				}
				li.append(a);
				if( $(this).attr('disabled') ){
					li.addClass('oz-combox-disabled');
				}
				if( $(this).attr('selected') ){
					li.addClass('oz-combox-selected');
				}
				options.append(li);
			};
			
			if( select.find('OPTGROUP').length ) {
				select.find('OPTGROUP').each( function() {
					var optgroup = $('<li class="oz-combox-optgroup" />');
					optgroup.text($(this).attr('label'));
					options.append(optgroup);
					$(this).find('OPTION').each(createOption);
				});
			} else {
				select.find('OPTION').each(createOption);
			}
			
			options.data('combox', this);
			
			if( this.options.inline ) {
				options
					.find('A')
						.bind('mouseover.'+this.$type, function(event) {
							combox._addHover($(this).parent());
						})
						.bind('mouseout.'+this.$type, function(event) {
							combox._removeHover($(this).parent());
						})
						.bind('mousedown.'+this.$type, function(event) {
							event.preventDefault(); // Prevent options from being "dragged"
							if( !control.hasClass('oz-combox-active') ){
								control.focus();
							}
						})
						.bind('mouseup.'+this.$type, function(event) {
							combox._hideMenus();
							combox._selectOption($(this).parent(), event);
						});
				options
					.find(".oz-combox-checkbox")
						.bind('mousedown.'+this.$type, function(event) {
							event.preventDefault(); // Prevent options from being "dragged"
							if( !control.hasClass('oz-combox-active') ){
								control.focus();
							}
						})
						.bind('mouseup.'+this.$type, function(event) {
							combox._hideMenus();
							combox._selectOption($(this).parent().parent(), null);
							return false;
						});
			} else {
				// 下拉框
				options.addClass('oz-combox-dropdown-menu');
				if(options.children().size() === 0){
					options.append('<li>\u00A0</li>');
				}
				options
					.css('display', 'none')
					.appendTo('BODY')
					.find('A')
						.bind('mousedown.'+this.$type, function(event) {
							event.preventDefault(); // Prevent options from being "dragged"
							if( event.screenX === options.data('combox-down-at-x') && event.screenY === options.data('combox-down-at-y') ) {
								options.removeData('combox-down-at-x').removeData('combox-down-at-y');
								combox._hideMenus();
							}
						})
						.bind('mouseup.'+this.$type, function(event) {
							if( event.screenX === options.data('combox-down-at-x') && event.screenY === options.data('combox-down-at-y') ) {
								return;
							} else {
								options.removeData('combox-down-at-x').removeData('oz-combox-down-at-y');
							}
							combox._selectOption( $(this).parent());
							combox._hideMenus();
						})
						.bind('mouseover.'+this.$type, function(event) {
							combox._addHover( $(this).parent());
						})
						.bind('mouseout.'+this.$type, function(event) {
							combox._removeHover( $(this).parent());
						});
				//这里判定是否可编辑，如果可编辑，在最后面加上一个选择，
				if(settings.editable){
					this.editOption = $('<option value=""></option>');
					select.append(this.editOption);
				}
			}
			options.disableSelection();
			if(this.selectOptions){
				this.selectOptions.remove();
			}
			this.selectOptions = options;
			return options;
		},
		_showMenu: function(){
			var combox = this ,
				select = this.element,
				control = this.control,
				settings = this.options,
				options = this.selectOptions;
			
			if( settings.disabled === true ){
				return false;
			}
			
			this._hideMenus();
			
			// Auto-width
			if( settings.autoWidth ){
				options.css('width', control.outerWidth() - (parseInt(control.css('borderLeftWidth'),10) + parseInt(control.css('borderLeftWidth'),10)));
			}
			
			// Menu position
			options.css({
				top: control.offset().top + control.outerHeight() - (parseInt(control.css('borderBottomWidth'),10)),
				left: control.offset().left
			});
			
			// Show menu
			switch( settings.menuTransition ) {
				case 'fade':
					options.fadeIn(settings.menuSpeed);
					break;
				case 'slide':
					options.slideDown(settings.menuSpeed);
					break;
				default:
					options.show(settings.menuSpeed);
					break;
			}
			// Center on selected option
			var li = options.find('.oz-combox-selected:first');
			this._keepOptionInView(li, true);
			this._addHover(li);
			
			control.addClass('oz-combox-menuShowing');
			
			$(document).bind('mousedown.'+this.$type, function(event) {
				if( $(event.target).parents().andSelf().hasClass('oz-combox-options') ){
					return;
				}
				combox._hideMenus();
			});
		},
		_hideMenus: function(){
			if( $(".oz-combox-dropdown-menu").length === 0 ){
				return;
			}
			$(document).unbind('mousedown.'+this.$type);
			
			$(".oz-combox-dropdown-menu").each( function() {
				var options = $(this),
					combox = options.data('combox'),
					control = combox.control,
					settings = combox.options;
				switch( settings.menuTransition ) {
					case 'fade':
						options.fadeOut(settings.menuSpeed);
						break;
					case 'slide':
						options.slideUp(settings.menuSpeed);
						break;
					default:
						options.hide(settings.menuSpeed);
						break;
				}
				control.removeClass('oz-combox-menuShowing');
			});
		},
		/**
		 * 设置值
		 */
		value:function(value){
			var select = this.element;
			
			//如果有编辑的可选择，则用此值
			if(this.editOption){
				this.editOption.val(value);
				this.editOption.text(value);
			}
			
			select.val(value);
			value = select.val();
			var control = this.control,
				options = this.selectOptions;
			
			// Update label
			this._setText( select.find('OPTION:selected').text());
			
			// Update control values
			options.find('.oz-combox-selected').removeClass('oz-combox-selected');
			options.find('A').each( function() {
				if( typeof(value) === 'object' ) {
					for( var i = 0; i < value.length; i++ ) {
						if( $(this).attr('rel') == value[i] ) {
							$(this).parent().addClass('oz-combox-selected');
						}
					}
				} else {
					if( $(this).attr('rel') == value ) {
						$(this).parent().addClass('oz-combox-selected');
					}
				}
			});
			this._trigger("change");
		},
		/**
		 * 重新设置可选项
		 */
		setOptions : function(data) {
			var select = this.element,
				control = this.control,
				settings = this.options;
			switch(typeof(data) ) {
				case 'string':
					select.html(data);
					break;
				case 'object':
					select.html('');
					for( var i in data ) {
						if( data[i] === null ) {
							continue;
						}
						if( typeof(data[i]) === 'object' ) {
							var optgroup = $('<optgroup label="' + i + '" />');
							for( var j in data[i] ) {
								optgroup.append('<option value="' + j + '">' + data[i][j] + '</option>');
							}
							select.append(optgroup);
						} else {
							var option = $('<option value="' + i + '">' + data[i] + '</option>');
							select.append(option);
						}
					}
					break;
				
			}
			
			if( !control ){
				return;
			}
			// Generate new options
			this._initOptions();
			var options = this.selectOptions;
			if(this.options.inline ) {
				control.append(options);
			}else{
				this._setText( $(select).find('OPTION:selected').text());
				$("BODY").append(options);
			}
		},
		_selectOption : function(li, event) {
			li = $(li);
			var combox = this,
				control = combox.control,
				options = combox.selectOptions,
				select = combox.element,
				settings = combox.options;
			
			if( control.hasClass('oz-combox-disabled') ) {
				return false;
			}
			if( li.length === 0 || li.hasClass('oz-combox-disabled') ){
				return false;
			}
			if(settings.multiple) {
				if(event == null || event.metaKey){
					li.toggleClass('oz-combox-selected');
				} else if( event.shiftKey && control.data('combox-last-selected') ) {
					// If event.shiftKey is true, this will select all options between li and the last li selected
					li.toggleClass('oz-combox-selected');
					var affectedOptions;
					if( li.index() > control.data('combox-last-selected').index() ) {
						affectedOptions = li.siblings().slice(control.data('combox-last-selected').index(), li.index());
					} else {
						affectedOptions = li.siblings().slice(li.index(), control.data('combox-last-selected').index());
					}
					
					affectedOptions = affectedOptions.not('.oz-combox-optgroup, .oz-combox-disabled');
					
					if( li.hasClass('oz-combox-selected') ) {
						affectedOptions.addClass('oz-combox-selected');
					} else {
						affectedOptions.removeClass('oz-combox-selected');
					}
				} else {
					li.siblings().removeClass('oz-combox-selected');
					li.addClass('oz-combox-selected');
				}
				
			} else {
				li.siblings().removeClass('oz-combox-selected');
				li.addClass('oz-combox-selected');
			}
			
			if( control.hasClass('oz-combox-dropdown') ) {
				this._setText(li.text());
			}
			
			// Update original control's value
			var i = 0, selection = [];
			if(settings.multiple) {
				control.find('.oz-combox-selected A').each( function() {
					selection[i++] = $(this).attr('rel');
				});
			} else {
				selection = li.find('A').attr('rel');
			}
			
			// Remember most recently selected item
			control.data('combox-last-selected', li);
			
			// Change callback
			if( select.val() !== selection ) {
				select.val(selection);
				select.trigger('change');
			}
			return true;
			
		},
		/**
		 * 保持选中的项在下拉框中显示
		 */
		_keepOptionInView : function(li, center) {
			if( !li || li.length === 0 ){
				return;
			}
			var combox = this,
				control = combox.control,
				options = combox.selectOptions,
				scrollBox = control.hasClass('oz-combox-dropdown') ? options : options.parent(),
				top = parseInt(li.offset().top - scrollBox.position().top,10),
				bottom = parseInt(top + li.outerHeight(),10);
			
			if( center ) {
				scrollBox.scrollTop( li.offset().top - scrollBox.offset().top + scrollBox.scrollTop() - (scrollBox.height() / 2) );
			} else {
				if( top < 0 ) {
					scrollBox.scrollTop( li.offset().top - scrollBox.offset().top + scrollBox.scrollTop() );
				}
				if( bottom > scrollBox.height() ) {
					scrollBox.scrollTop( (li.offset().top + li.outerHeight()) - scrollBox.offset().top + scrollBox.scrollTop() - scrollBox.height() );
				}
			}
		},
		_handleKeyDown : function(event) {
			//
			// Handles open/close and arrow key functionality
			//
			var combox = this,
				control = combox.control,
				options = combox.selectOptions,
				select = combox.element,
				settings = combox.options,
				totalOptions = 0,
				i = 0;
			
			if( settings.disabled === true ) {
				return false;
			}
			
			switch( event.keyCode ) {
				case 8: // backspace
					event.preventDefault();
					typeSearch = '';
					break;
				case 9: // tab
				case 27: // esc
					combox._hideMenus();
					combox._removeHover();
					break;
				case 13: // enter
					if( control.hasClass('oz-combox-menuShowing') ) {
						combox._selectOption(options.find('LI.oz-combox-hover:first'), event);
						if( control.hasClass('oz-combox-dropdown') ){
							combox._hideMenus();
						}
					} else {
						combox._showMenu();
					}
					break;
				case 32: // space
					if( control.hasClass('oz-combox-menuShowing') ) {
						combox._selectOption(options.find('LI.oz-combox-hover:first'),null);
						if( control.hasClass('oz-combox-dropdown') ){
							combox._hideMenus();
						}
					} else {
						combox._showMenu();
					}
					break;
				case 38: // up
				//case 37: // left
					event.preventDefault();
					if( control.hasClass('oz-combox-menuShowing') ) {
						var prev = options.find('.oz-combox-hover').prev('LI');
						totalOptions = options.find('LI:not(.oz-combox-optgroup)').length;
						i = 0;
						while( prev.length === 0 || prev.hasClass('oz-combox-disabled') || prev.hasClass('oz-combox-optgroup') ) {
							prev = prev.prev('LI');
							if( prev.length === 0 ){
								prev = options.find('LI:last');
							}
							if( ++i >= totalOptions ){
								break;
							}
						}
						combox._addHover(prev);
						combox._keepOptionInView(prev);
					} else {
						combox._showMenu();
					}
					break;
				case 40: // down
				//case 39: // right
					event.preventDefault();
					if( control.hasClass('oz-combox-menuShowing') ) {
						var next = options.find('.oz-combox-hover').next('LI');
						totalOptions = options.find('LI:not(.oz-combox-optgroup)').length;
						i = 0;
						while( next.length === 0 || next.hasClass('oz-combox-disabled') || next.hasClass('oz-combox-optgroup') ) {
							next = next.next('LI');
							if( next.length === 0 ){
								next = options.find('LI:first');
							}
							if( ++i >= totalOptions ){
								break;
							}
						}
						combox._addHover(next);
						combox._keepOptionInView(next);
						
					} else {
						combox._showMenu();
					}
					break;
			}
		},
		/**
		 * 输入字符查找,不适合中文
		 */
		_handleKeyPress : function(event) {
			//
			// Handles type-to-find functionality
			//
			var combox = this,
				control = combox.control,
				options = combox.selectOptions,
				settings = combox.options,
				select = combox.element;
			
			if( settings.disabled === true ){
				return false;
			}
			switch( event.keyCode ) {
				case 9: // tab
				case 27: // esc
				case 13: // enter
				case 38: // up
				case 37: // left
				case 40: // down
				case 39: // right
					// Don't interfere with the keydown event!
					break;
				default: // Type to find
					if( !control.hasClass('oz-combox-menuShowing') ){
						combox._showMenu(select);
					}
					event.preventDefault();
					
					clearTimeout(typeTimer);
					typeSearch += String.fromCharCode(event.charCode || event.keyCode);
					
					options.find('A').each( function() {
						if( $(this).text().substr(0, typeSearch.length).toLowerCase() === typeSearch.toLowerCase() ) {
							combox._addHover($(this).parent());
							combox._keepOptionInView($(this).parent());
							return false;
						}
					});
					// Clear after a brief pause
					typeTimer = setTimeout( function() { typeSearch = ''; }, 1000);
					break;
			}
		},
		_addHover : function(li) {
			li = $(li);
			var options = this.selectOptions;
			options.find('.oz-combox-hover').removeClass('oz-combox-hover');
			li.addClass('oz-combox-hover');
		},
		_removeHover : function(li) {
			var options = this.selectOptions;
			options.find('.oz-combox-hover').removeClass('oz-combox-hover');
		},
		widget : function(){
			return this.control;
		},
		destroy: function(){
			this.base();
			this.control.remove();
			this.selectOptions || this.selectOptions.remove();
			this.element.show();
		},
		enable: function() {
			this.control.find('.oz-combox-input').attr("readonly",false);
			return this.base();
		},
		disable: function() {
			this.control.find('.oz-combox-input').attr("readonly",true);
			return this.base();
		}
	});
})(jQuery);