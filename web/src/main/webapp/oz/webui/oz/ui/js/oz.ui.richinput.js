/**
 * RichInput
 * 富输入框，可控制区块选择
 */
(function($) {
	/**
	 * 获取输入框中光标的位置
	 */
	$.fn.extend({
		selectionPos : function(value) {
			var elem = this[0];
			if (elem && (/textarea/i.test( elem.nodeName ) || elem.type === "text")) {
				if ($.browser.msie) {
					var rng;
					if (/textarea/i.test( elem.nodeName )) {
						rng = elem.createTextRange();
					} else {
						rng = document.selection.createRange();
					}
					if (value === undefined) {
						rng.moveStart("character", -elem.value.length);
						return rng.text.length;
					} else if (typeof value === "number") {
						var index = this.position();
						rng.moveStart("character", value);
						rng.moveEnd("character", value - index + 1);
						rng.select();
					}
				} else {
					if (value === undefined) {
						return elem.selectionStart;
					} else if (typeof value === "number") {
						elem.selectionEnd = value;
						elem.selectionStart = value;
					}
				}
			} else {
				if (value === undefined){
					return undefined;
				}
			}
		}
	});
	
	var inited = false;
	var currentInput = null;
	
	OZ.widget("OZ.Richinput",{
		$type: "richinput",
		options: {
			/**
			 * 分隔符
			 */
			splitChar:";",
			/**
			 * 数据显示
			 */
			displayFormat:function(data){
				if(typeof data == "string"){
					data = {value:data};
				}
				data.splitChar = this.options.splitChar;
				return $.render('<div unselectable="on" class="valueItem" itemId="${this.id}" itemValue="${this.value}"><strong>${this.value}</strong><em>&lt;${this.value}&gt;</em>${splitChar}</div>',data);
			},
			/**
			 * 是否可键盘输入
			 */
			inputable: false,
			/**
			 * 是否可编辑
			 */
			editable:true
		},
		_render: function(){
			var self = this;
			this.element.addClass("oz-richInput");
			this.element.append("<div style='position: absolute; color: rgb(160, 160, 160); padding-top: 1px; display: none; '></div>" +
					"<div class='oz-edit'><input type='text' tabindex='1'/><span class='wdhlpr'></span></div>" +
					"<div style='clear:both;border:none;margin:0;padding:0;' unselectable='on'></div>");
			
			this.edit = $(".oz-edit",this.element);
			this.input = $(":input",this.edit);
			this.inputhpl = $(".wdhlpr",this.edit);

			var self = this;
			this.element.click(function(event){
				currentInput = self;
				if(this==event.target && self.options.editable){
					//获取所有选项，判定光标的位置
					var items = $(".valueItem",self.element);
					var clientX = event.pageX;
					var clientY = event.pageY;
					
					var found = null;
					items.each(function(){
						var pos = $(this).position();
						if(pos.left + 1 > clientX && clientX > pos.left - 5 && pos.top - 1 < clientY && clientY < pos.top + $(this).height()){
							found = this;
						}
					});
					if(found){
						var ls = $(found).prevAll().filter(".valueItem").get().reverse();
						var rs = $(found).nextAll().andSelf().filter(".valueItem");
						self.edit.before(ls);
						self.edit.after(rs);
					}else{
						self.edit.before(items);
					}
					self.input.focus();
					$(".valueItem",this).removeClass("valueItem-active");
					return false;
				}
			});
			
			this.edit.click(function(){
				$(".valueItem",self.element).removeClass("valueItem-active");
			});
			
			$(".valueItem",this.element).live("click",function(event){
				currentInput = self;
				if(!self.options.editable){
					return false;
				}
				if(event.ctrlKey){
					if($(this).hasClass("valueItem-active")){
						$(this).removeClass("valueItem-active");
					}else{
						$(this).addClass("valueItem-active");
					}
				}else{
					$(".valueItem",self.element).removeClass("valueItem-active");
					$(this).addClass("valueItem-active");
				}
				return false;
			});
			//只执行一次的方法
			if(!inited){
				$(document).click(function(event){
					//$(".valueItem",self.element).removeClass("valueItem-active");
				}).keydown(function(event){
					if(currentInput == null || currentInput.input != event.target)
						return;					
					if(currentInput && currentInput.options.editable && currentInput.element){
						//删除选中状态的内容
						//del or backspace 
						if(event.which == 46 || event.which == 8){
							currentInput.input.focus();
							var item = $(".valueItem-active",currentInput.element);
							item.remove();
							self._trigger("onchange",null,[self.getItems(),$(item).data("richinput-item")]);
							return false;
						}
					}
				});
				inited = true;
			}
			
			this.input.bind('keydown.'+this.$type,function(event){
				if(!(self.options.editable || self.options.inputable)){
					return false;
				}
				
				//backspace
				if(event.keyCode == 8){
					if(self.input.val()=='' && self.edit.prev().hasClass("valueItem")) {
						var item = self.edit.prev();
						item.remove();
						self._trigger("onchange",null,[self.getItems(),$(item).data("richinput-item")]);
						return false;
					}
				}
				//backspace
				if(event.keyCode == 46){
					if(self.input.val()=='' && self.edit.next().hasClass("valueItem")) {
						var item = self.edit.next();
						item.remove();
						self._trigger("onchange",null,[self.getItems(),$(item).data("richinput-item")]);
						return false;
					}
				}
				//left
				if(event.keyCode == 37 && self.input.selectionPos()===0){
					if(self.input.val()==''){
						var pre = self.edit.prev();
						if(pre.size() && pre.hasClass("valueItem")){
							self.edit.after(pre);
							return false;
						}
					}else{
						self._makeInput(true);
					}
				}
				//right
				if(event.keyCode == 39 && self.input.selectionPos()==self.input.val().length){
					if(self.input.val()==''){
						var next = self.edit.next();
						if(next.size() && next.hasClass("valueItem")){
							self.edit.before(next);
							return false;
						}
					}else{
						self._makeInput();
					}
				}
				//;
				if(event.keyCode == 186){
					return self._makeInput();
				}
				return self.options.inputable;
			});
			//统计宽度，把div显示弄宽
			this.input.bind("keypress."+this.$type,function(event){
				self.inputhpl.text(self.input.val()+"WW");
				var w = self.inputhpl.width();
				if(w > self.element.width()){
					w = self.element.width();
				}
				self.input.width(w);
			});
			//失去焦点，把内容添加显示出来
			this.input.bind("blur."+this.$type,function(event){
				return self._makeInput();
			});
		},
		_makeInput: function(isRight){
			if(this.input.val()==""){
				return false;
			}
			this.addItem(this.input.val(),isRight,true);
			this.clearInput();
			return false;
		},
		clearInput:function(){
			this.input.val("");
			this.inputhpl.text("WW");
			this.edit.width(13);
		},
		addItem:function(data,isRight,change){
			var self = this;
			if ( $.isArray( data ) ) {
				$.each( data, function( index , data) {
					return self.addItem.call( self, data, isRight );
				});
			} else {
				var item = this.options.displayFormat.call(this,data);
				$(item).data("richinput-item",data);
				if(isRight){
					this.edit.after(item);
				}else{
					this.edit.before(item);
				}
			}
			if(change === true){
				self._trigger("onchange",null,[self.getItems(),data]);
			}
		},
		clearAll:function(){
			 $(".valueItem",this.element).remove();
		},
		getItems:function(){
			var items = $(".valueItem",this.element);
			var values =  $.map(items,function(ele,index){
				return $(ele).data("richinput-item");
			})
			return values;
		},
		getSelectedItems:function(){
			return $(".valueItem-active",this.element);
		}
	});
})(jQuery);