(function($) {
	
	OZ.widget("OZ.tree.Node",{
		$type: "node"
	});

	/**
	 * 递归子类，进行选择操作
	 */
	function setChildCheckbox(node){
		var childck = node.next("ul").find('.oz-tree-checkbox');
		childck.removeClass('oz-tree-checkbox0 oz-tree-checkbox1 oz-tree-checkbox2');
		if (node.find('.oz-tree-checkbox').hasClass('oz-tree-checkbox1')){
			childck.addClass('oz-tree-checkbox1');
		} else {
			childck.addClass('oz-tree-checkbox0');
		}
	}
	
	/**
	 * 递归父类，进行选择操作
	 */
	function setParentCheckbox(node){
		var isAllNull =function(n){
			var ck = n.find('.oz-tree-checkbox');
			if (ck.hasClass('oz-tree-checkbox1') || ck.hasClass('oz-tree-checkbox2')){
				return false;
			}
			var b = true;
			n.parent().siblings().each(function(){
				if (!$(this).find('.oz-tree-checkbox').hasClass('oz-tree-checkbox0')){
					b = false;
				}
			});
			return b;
		};
		var isAllSelected = function(n){
			var ck = n.find('.oz-tree-checkbox');
			if (ck.hasClass('oz-tree-checkbox0') || ck.hasClass('oz-tree-checkbox2')){
				return false;
			}
			var b = true;
			n.parent().siblings().each(function(){
				if (!$(this).find('.oz-tree-checkbox').hasClass('oz-tree-checkbox1')){
					b = false;
				}
			});
			return b;
		};
		var pnode = getParentNode(node[0]);
		if (pnode){
			var ck = $(pnode.target).find('.oz-tree-checkbox');
			ck.removeClass('oz-tree-checkbox0 oz-tree-checkbox1 oz-tree-checkbox2');
			if (isAllSelected(node)){
				ck.addClass('oz-tree-checkbox1');
			} else if (isAllNull(node)){
				ck.addClass('oz-tree-checkbox0');
			} else {
				ck.addClass('oz-tree-checkbox2');
			}
			setParentCheckbox($(pnode.target));
		}
	}
	function getParentNode(param){
		var node = $(param).parent().parent().prev();
		if (node.length){
			return $.extend({}, $.data(node[0], 'tree-node'), {
				target: node[0],
				checked: node.find('.oz-tree-checkbox').hasClass('oz-tree-checkbox1')
			});
		} else {
			return null;
		}
	}
	
	OZ.widget("OZ.tree.Panel",{
		$type: "tree",
		options:{
			url: null,
			accordion:false,
			animate: false,
			checkbox: false,
			checkable: true,
			cascade:false,
			paramkeys:[],
			nodeFilter:function(){return true;}
		},
		_render:function(){
			var tree = this.element;
			tree.addClass('oz-tree');
			if(!this.options.checkable){
					tree.addClass('oz-tree-nocheckable');
			}
			this.children = this.options.children || [];
			function initData(d, tree){
				tree.find(">li").each(function() {
					var node = $(this);
					var item = node.data("node")||{};
					item.text = node.find(">span").html();
					if (!item.text) {
						item.text = node.html();
					}
					item.checked = item.checked == "true";
					item.state = item.state || "open";
					var subTree = node.find(">ul");
					if (subTree.length) {
						item.children = [];
						initData(item.children, subTree);
					}
					d.push(item);
				});
			}
			initData(this.children, tree);
			this._reinit();
		},
		_reinit:function(){
			var opts = this.options;
			if (this.children.length == 0 && opts.url){
				this.request(this.element, {id:"-1"});
			}else{
				var rederChild = $.map(this.children,function(item){
					return $.extend({},item,true);
				})
				this._renderChildren(this.element,rederChild);	
			}
		},
		_init:function(){
			var opts = this.options;
			if (opts.data){
				
			}
			this._initTreeEvents();
		},
		_renderChildren:function(node,children){
			if (this.element == node) {
				node.empty();
			}
			var opts = this.options;
			var self = this;
			function appendNodes(ul, children, depth){
				children = $.grep(children,opts.nodeFilter);
				var isFirst = depth == 0;
				for(var i=0; i<children.length; i++){
					var item = children[i];
					var last = (i == children.length-1);
					
					var li = $('<li></li>').appendTo(ul);
					
					if (item.state != 'closed'){
						item.state = 'open';
					}
					//放标题
					var node = $('<div class="oz-tree-node"></div>').appendTo(li).addClass(item.nodeCls).addClass("tree-depth-"+depth);
					node.attr('node-id', item.id);
					
					last && node.addClass("oz-tree-node-last");
					
					$('<span class="oz-tree-title"></span>').html(item.text).appendTo(node);
					if ((opts.checkbox || item.checkbox) && item.checkbox !== false){
						if (item.checked){
							$('<span class="oz-tree-checkbox oz-tree-checkbox1"></span>').prependTo(node);
						} else {
							$('<span class="oz-tree-checkbox oz-tree-checkbox0"></span>').prependTo(node);
						}
					}
					var isRequest  = false;
					if (item.children){
						var subul = $('<ul  class="oz-tree-node-ul" ></ul>').appendTo(li);
						
						//同步加载
						if(item.children===true){
							item.children=null;
							isRequest = true;
						}
							
						if (item.state == 'open'){
							$('<span class="oz-tree-folder oz-tree-folder-open"></span>').addClass(item.iconCls).prependTo(node);
							$('<span class="oz-tree-hit oz-tree-expanded"></span>').prependTo(node);
						} else {
							$('<span class="oz-tree-folder"></span>').addClass(item.iconCls).prependTo(node);
							$('<span class="oz-tree-hit oz-tree-collapsed"></span>').prependTo(node);
							subul.css('display','none');
						}
						if(!isRequest){
							appendNodes(subul, item.children, depth+1);
						}
					} else {
						if (item.state == 'closed'){
							$('<span class="oz-tree-folder"></span>').addClass(item.iconCls).prependTo(node);
							$('<span class="oz-tree-hit oz-tree-collapsed"></span>').prependTo(node);
						} else {
							$('<span class="oz-tree-file"></span>').addClass(item.iconCls).prependTo(node);
							$('<span class="oz-tree-indent oz-tree-nothit"></span>').prependTo(node);
						}
					}
					
					for(var j=0; j<depth; j++){
						$('<span class="oz-tree-indent"></span>').prependTo(node);
					}
					$('<span class="oz-tree-fix"></span>').prependTo(node);
					isFirst && $('<div  class="oz-tree-li-lt" ></div><div  class="oz-tree-li-rt" ></div><div  class="oz-tree-li-lb" ></div><div  class="oz-tree-li-rb" ></div>').appendTo(li);
					node.disableSelection();
					item.rendered = true;
					$.data(node[0], 'tree-node', item);
					
					if(isRequest){
						self.request(subul, {id:item.id});
					}
					
//					影响性能，IE下很慢
//					if( i==children.length-1){
//						if(self.options.cascade){
//							setParentCheckbox($(node));
//						}
//					}
				}
			}
			//获取深度
			var depth = $(node).prev().find('>span.oz-tree-indent,>span.oz-tree-hit').length;
			if($(node).prev().size()){
				$.data($(node).prev()[0], 'tree-node').children = children;
			}
			appendNodes(node, children, depth);
			
		},
		_initTreeEvents:function(){
			var opts = this.options;
			var tree = this.element;
			var self = this;
			$('.oz-tree-node', tree).live('dblclick.tree', function(e){
				self.toggle(this);
				self._trigger("dblclick",e,$.extend({},$.data(this, 'tree-node'),{target: this}));
			}).live('click.tree', function(e){
				self.selectNode(this);
				self._trigger("click",e,$.extend({},$.data(this, 'tree-node'),{target: this}));
			}).live('mouseenter.tree', function(){
				$(this).addClass('oz-tree-node-hover');
				return false;
			}).live('mouseleave.tree', function(){
				$(this).removeClass('oz-tree-node-hover');
				return false;
			});
			
			$('.oz-tree-hit', tree).live('click.tree', function(){
				var node = $(this).parent();
				self.toggle(node);
				return false;
			}).live('mouseenter.tree', function(){
				if ($(this).hasClass('oz-tree-expanded')){
					$(this).addClass('oz-tree-expanded-hover');
				} else {
					$(this).addClass('oz-tree-collapsed-hover');
				}
			}).live('mouseleave.tree', function(){
				if ($(this).hasClass('oz-tree-expanded')){
					$(this).removeClass('oz-tree-expanded-hover');
				} else {
					$(this).removeClass('oz-tree-collapsed-hover');
				}
			});
			
			$('.oz-tree-checkbox', tree).live('click.tree', function(){
				if(!self.options.checkable){
					return;
				}
				if ($(this).hasClass('oz-tree-checkbox0')){
					$(this).removeClass('oz-tree-checkbox0').addClass('oz-tree-checkbox1');
				} else if ($(this).hasClass('oz-tree-checkbox1')){
					$(this).removeClass('oz-tree-checkbox1').addClass('oz-tree-checkbox0');
				} else if ($(this).hasClass('oz-tree-checkbox2')){
					$(this).removeClass('oz-tree-checkbox2').addClass('oz-tree-checkbox1');
				}
				if(self.options.cascade){
					setParentCheckbox($(this).parent());
					setChildCheckbox($(this).parent());
				}
				return false;
			});
		},
		toggle :function( node){
			var hit = $('>span.oz-tree-hit', node);
			if (hit.length === 0){
				return;	// is a leaf node
			}
			if (hit.hasClass('oz-tree-expanded')){
				this.collapse(node);
			} else {
				this.expand(node);
			}
		},
		expand : function (node){
			var opts = this.options;
			
			var hit = $('>span.oz-tree-hit', node);
			if (hit.length === 0){
				return;	// is a leaf node
			}
			if (hit.hasClass('oz-tree-collapsed')){
				hit.removeClass('oz-tree-collapsed oz-tree-collapsed-hover').addClass('oz-tree-expanded');
				hit.next().addClass('oz-tree-folder-open');
				var ul = $(node).next("ul");
				if (ul.length){
					if (opts.animate){
						ul.slideDown();
					} else {
						ul.css('display','block');
					}
				} else {
					var data = $.data($(node)[0], 'tree-node');
					var subul = $('<ul></ul>').insertAfter(node);
					this.request(subul, data);	// request children nodes data
				}
				
				var opts = this.options;
				if(opts.accordion){
					var self = this;
					var li = $(node).parent();
					if($(self.element).find(">li").index(li) > -1 ){
						li.siblings("li").each(function() {
							var node = $(this).find(">div.oz-tree-node");
							self.collapse(node);
						})
					}
				}
				
			}
		},
		collapse : function (node){
			var opts = this.options;
			
			var hit = $('>span.oz-tree-hit', node);
			if (hit.length === 0){
				return;	// is a leaf node
			}
			if (hit.hasClass('oz-tree-expanded')){
				hit.removeClass('oz-tree-expanded oz-tree-expanded-hover').addClass('oz-tree-collapsed');
				hit.next().removeClass('oz-tree-folder-open');
				if (opts.animate){
					$(node).next("ul").slideUp();
				} else {
					$(node).next("ul").css('display','none');
				}
			}
		},
		request:function(ul,param){
			var opts = this.options;
			var requestUrl = opts.urlFn?opts.urlFn.call(this,param):null;
			requestUrl = requestUrl || opts.url;
			if (!requestUrl){
				return;
			}
			var self = this;
			param = param || {};
			var requestData = {};
			requestData.id = param.id;
			//其他的参数
			if(opts.paramkeys){
				$.each(opts.paramkeys,function(index,key){
					param[key] && (requestData[key]=param[key]);
				});
			}
			var folder = $(ul).prev().find('>span.oz-tree-folder');
			folder.addClass('oz-tree-loading');
			$.ajax({
				type: 'post',
				url: requestUrl,
				data: requestData,
				dataType: 'json',
				success: function(data){
					folder.removeClass('oz-tree-loading');
					self._renderChildren(ul, data);
					if (opts.onLoadSuccess){
						opts.onLoadSuccess.apply(this, arguments);
					}
				},
				error: function(){
					folder.removeClass('oz-tree-loading');
					if (opts.onLoadError){
						opts.onLoadError.apply(this, arguments);
					}
				}
			});
		},
		isLeaf:function(param){
			var node = $(param);
			var hit = $('>span.oz-tree-hit', node);
			return hit.length === 0;
		},
		selectNode:function(node,show){
			if(this._trigger("beforeselected",null,$.extend({},$.data(node, 'tree-node'),{target: node})) === false){
				return false;
			}
			$('div.oz-tree-node-selected', this.element).removeClass('oz-tree-node-selected');
			$(node).addClass('oz-tree-node-selected');
			this._trigger("selected",null,$.extend({},$.data(node, 'tree-node'),{target: node}));
			if(show){
				this.expandNode(node);
			}
		},
		expandNode:function(node){
			var pnode = getParentNode(node);
			if (pnode){
				var t = $(pnode.target);
				this.expand(t);
				this.expandNode(t);
			}
		},
		getParentNode:function(param){
			return getParentNode(param);
		},
		setCheckable:function(b){
			this.options.checkable = b;
			this.element[b?"removeClass":"addClass"]("oz-tree-nocheckable");
		}
	});
	
	OZ.tree.Panel.implement({
		reload:function(){
			$(this.element).empty();
			this._reinit();
		},
		getChecked :function (includeParent){
			var selector=".oz-tree-checkbox1";
			if(includeParent){
				selector += ",.oz-tree-checkbox2";
			}
			var nodes = [];
			this.element.find(selector).each(function(){
				var node = $(this).parent();
				nodes.push($.extend({}, $.data(node[0], 'tree-node'), {
					target: node[0],
					checked: node.find('.oz-tree-checkbox').hasClass(selector)
				}));
			});
			return nodes;
		},
		getUnChecked :function (includeParent){
			var selector=".oz-tree-checkbox0";
			if(includeParent){
				selector += ",.oz-tree-checkbox2";
			}
			var nodes = [];
			this.element.find(selector).each(function(){
				var node = $(this).parent();
				nodes.push($.extend({}, $.data(node[0], 'tree-node'), {
					target: node[0],
					checked: node.find('.oz-tree-checkbox').hasClass(selector)
				}));
			});
			return nodes;
		},
		getSelected :function (){
			var node = this.element.find('div.oz-tree-node-selected');
			if (node.length){
				return $.extend({}, $.data(node[0], 'tree-node'), {
					target: node[0],
					checked: node.find('.oz-tree-checkbox').hasClass('oz-tree-checkbox1')
				});
			} else {
				return null;
			}
		},
		getRoots:function(){
			var nodes = [];
			$(this.element).find(">li").each(function() {
				var node = $(this).find(">div.oz-tree-node");
				nodes.push($.extend( {}, $.data(node[0], "tree-node"), {
					target : node[0],
					checked : node.find(".oz-tree-checkbox").hasClass("oz-tree-checkbox1")
				}));
			});
			return nodes;
		},
		getChildren:function(node){
			var children = [];
			var findChildren = function(node) {
				node.next("ul").find("div.oz-tree-node").each(
						function() {
							children.push($.extend( {}, $.data(this, "tree-node"), {
								target : this,
								checked : $(this).find(".oz-tree-checkbox").hasClass(
										"oz-tree-checkbox1")
							}));
						});
			};
			if (node) {
				findChildren($(node));
			} else {
				var roots = this.getRoots();
				for ( var i = 0; i < roots.length; i++) {
					children.push(roots[i]);
					findChildren($(roots[i].target));
				}
			}
			return children;
		},
		collapseAll:function(){
			var nodes = this.getRoots();
			var self = this;
			$.each(nodes,function(){
				self.collapse(this.target);
				var children = self.getChildren(this.target);
				$.each(children,function(){
					self.collapse(this.target);
				});
			});
		},
		expandAll:function(){
			var nodes = this.getRoots();
			var self = this;
			$.each(nodes,function(){
				self.expand(this.target);
				var children = self.getChildren(this.target);
				$.each(children,function(){
					self.expand(this.target);
				});
			});
		},
		append : function (param){
			var node = $(param.parent);
			var ul = node.next("ul");
			if (ul.length === 0){
				ul = $('<ul></ul>').insertAfter(node);
			}
			if (param.data && param.data.length){
				var nodeIcon = node.find('span.oz-tree-file');
				if (nodeIcon.length){
					nodeIcon.removeClass('oz-tree-file').addClass('oz-tree-folder');
					var hit = $('<span class="oz-tree-hit oz-tree-expanded"></span>').insertBefore(nodeIcon);
					if (hit.prev().length){
						hit.prev().remove();
					}
				}
			}
			this._renderChildren(ul, param.data);
		},
		remove :function (param){
			var node = $(param);
			var li = node.parent();
			var ul = li.parent();
			li.remove();
			if (ul.find('li').length === 0){
				var prev = ul.prev();
				prev.find('.oz-tree-folder').removeClass('oz-tree-folder').addClass('oz-tree-file');
				prev.find('.oz-tree-hit').remove();
				$('<span class="oz-tree-indent"></span>').prependTo(prev);
				if (ul[0] != target){
					ul.remove();
				}
			}
		},
		update:function (options) {
			var node = $(options.target);
			var data = $.data(options.target, "tree-node");
			if (data.iconCls) {
				node.find(".oz-tree-icon").removeClass(data.iconCls);
			}
			$.extend(data, options);
			$.data(options.target, "tree-node", data);
			node.attr("node-id", data.id);
			node.find(".oz-tree-title").html(data.text);
			if (data.iconCls) {
				node.find(".oz-tree-icon").addClass(data.iconCls);
			}
			var ck = node.find(".oz-tree-checkbox");
			ck.removeClass("oz-tree-checkbox0 oz-tree-checkbox1 oz-tree-checkbox2");
			if (data.checked) {
				ck.addClass("oz-tree-checkbox1");
			} else {
				ck.addClass("oz-tree-checkbox0");
			}
		},
		setSelectState:function(id){
			if(id){
				var node = $("div.oz-tree-node[node-id="+id+"]", this.element);
				this.selectNode(node);
			}
		}
	});
	
})(jQuery);
