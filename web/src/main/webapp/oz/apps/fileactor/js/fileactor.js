(function() {
    var FileActorParser;

	FileActorParser = (function() {
		 var FileActorParser = function(form_field, options) {
			this.form_field = form_field;
			this.filedId = $(form_field).data("filedid");
			this.options = options != null ? options : {};
			this.set_default_values();
			this.setup();
			this.set_up_html();
			this.register_observers();
			this.finish_setup();
		}
		  var method = {
			  set_default_values:function(){
				  
			  },
			  setup:function(){
				  this.container = $(this.form_field);
			  },
			  set_up_html:function(){
				 this.addBtn =  this.container.find(".oz-actor-btns .oz-form-button2");
				 this.items_container = this.container.find('ul.oz-actor-items').first();
			  },
			  finish_setup:function(){
				  
			  },
			  item_mouseover:function(evt){
				 // '<div class="item-toolbar"><a href="javascript:void(0)" class="item-close" title="删除"></a></div>';
				  var target;
			      target = $(evt.target).hasClass("oz-actor-item") ? $(evt.target) : $(evt.target).parents(".oz-actor-item").first();
			      if (target) return this.result_do_highlight(target);
			  },
			  item_mouseout:function(evt){
				  //if ($(evt.target).hasClass("oz-actor-item" || $(evt.target).parents('.oz-actor-item').first())) {
			        return this.result_clear_highlight();
			     // }
			  },
			  result_do_highlight:function(el){
				  if (el.length) {
				        this.result_clear_highlight();
				        this.result_highlight = el;
				        this.result_highlight.addClass("item-hover");
				  }
			  },
			  result_clear_highlight:function(){
				  if (this.result_highlight) this.result_highlight.removeClass("item-hover");
			      return this.result_highlight = null;
			  },
			  register_observers:function(){
				  var _this = this;
				  this.container.click(function(evt){
					  
				  });
				  this.addBtn.click(function(evt){
					  _this.addAddrs();
				  });
				  this.items_container.find("li.oz-actor-item a").click(function(evt){
					  $(this).parent().parent().remove();
					  _this.updateValue();
				  });
				 //this.items = $("li.oz-actor-item", this.items_container);
				  this.items_container.mouseover(function(evt){
					  _this.item_mouseover(evt);
				  });
				  this.items_container.mouseout(function(evt){
					  _this.item_mouseout(evt);
				  });
				  this.items_container.dragsort({dragEnd:  function(){_this.updateValue()},placeHolderTemplate: "<li class='placeHolder'><div></div></li>"});
			  },
			  updateValue:function(){
				  var hiddenValue = [];
				  this.items_container.find("li.oz-actor-item").each(function(){
					  var value = $(this).data("value");
					  if(value){
						  hiddenValue.push($(this).find("span").text()+ "!!~~"+value);
					  }else{
						  hiddenValue.push($(this).find("span").text());
					  }
				  })
				  $("#" + this.filedId).val(hiddenValue.join("~~!!"));
				  this.addBtn.parent().appendTo( this.items_container);
				  this.change();
			  },
			  change:function(){
				  var change = this.container.data("onchange");
				  if(change && typeof change=="string"){
					  var fn = new Function("return "+change);
					  fn.apply(this.container);
				  }
			  },
			  getValue:function(){
					return $.map($("#" + this.filedId).val().split("~~!!"), function(a) {
						if(a){
							var ss = a.split("!!~~");
							return {name:ss[0],value:ss[1]};
						}
						return null;
					});
			  },
			  setValue:function(value){
				   var _this = this;
				  _this.items_container.find("li.oz-actor-item").remove();
				  this.addItems(value);
			  },
			  addItems:function(result){
				  var link,_this = this;
				  $.each(result,function(index,v){
					  //移除已经有的。
					  _this.items_container.find("li.oz-actor-item").filter(function(index) {
						  return $(this).data("value") == v.value;
					  }).remove();
					  
					  var li = $('<li class="oz-actor-item"  data-value="' + v.value + '"><span>' + v.name + '</span><div class="item-toolbar"><a href="javascript:void(0)" class="item-close"></a></div></li>');
					  _this.addBtn.parent().before(li);
				      return li;
				  });
				  this.items_container.find("li.oz-actor-item a").click(function(evt){
					  $(this).parent().parent().remove();
					  _this.updateValue();
				  });
				  this.items_container.mouseover(function(evt){
					  _this.item_mouseover(evt);
				  });
				  this.items_container.mouseout(function(evt){
					  _this.item_mouseout(evt);
				  });
				  _this.updateValue();
			  },
			  addAddrs : function() {
				  	var _this = this;
					var result = false;
					var onclick = this.container.data("onclick");
					if(onclick && typeof onclick=="string"){
						var fn = new Function("return "+onclick);
						result = fn.apply(_this);
					}
					if(result !== true){
						new OZ.Dlg.create({
							id : "Dlg_SelectFileActor",
							width : 300,
							height : 330,
							title : "选择对话框",
							url : contextPath + "/module/fileActorAction.do?action=dlgSelectActor&timeStamp=" + new Date().getTime(),
							onOk : function(value) {
								_this.addItems(value);
							},
							onCancel : function(value) {
							},
							selecteds:_this.getValue()
						});
					}
				}
		  };
		  $.extend(FileActorParser.prototype,method);
		  return FileActorParser;
	  })();
	
	$.FileActorParser = FileActorParser;
	
	 $.fn.extend({
		 fileActor: function(options) {
			return $(this).each(function(input_field) {
				if (!($(this)).data("fileActor")){
					var f = new FileActorParser(this, options);
					$(this).data("fileActor",f);
				}
			});
		}
	});
})();
