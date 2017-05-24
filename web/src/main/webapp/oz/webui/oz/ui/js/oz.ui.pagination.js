(function($) {
	
OZ.widget("OZ.Pagination",{
	$type: "pagination",
	options:{
		total: 1,
		pageSize: 10,
		pageNumber: 1,
		pageList: [10,20,30,50],
		loading: false,
		buttons: null,
		showPageList: true,
		showRefresh: true,
		
		onSelectPage: function(pageNumber, pageSize){},
		onBeforeRefresh: function(pageNumber, pageSize){},
		onRefresh: function(pageNumber, pageSize){},
		onChangePageSize: function(pageSize){},
		
		beforePageText: '第',
		afterPageText: '共{pages}页',
		displayMsg: '显示{from}到{to},共{total}记录'
	},
	_render:function(){
		var opts = this.options,self = this;
		var pager = this.element.addClass('oz-pagination').empty();
		var t = $('<table cellspacing="0" cellpadding="0" border="0"><tr></tr></table>').appendTo(pager);
		var tr = $('tr', t);
		var i;
		if (opts.showPageList){
			var ps = $('<select class="oz-pagination-page-list"></select>');
			for(i=0; i<opts.pageList.length; i++) {
				$('<option></option>')
						.text(opts.pageList[i])
						.attr('selected', opts.pageList[i]==opts.pageSize ? 'selected' : '')
						.appendTo(ps);
			}
			$('<td></td>').append(ps).appendTo(tr);
			
			opts.pageSize = parseInt(ps.val(),10);
			
			$('<td><div class="oz-pagination-btn-separator"></div></td>').appendTo(tr);
		}
		
		$('<td><a href="javascript:void(0)" data-linkbutton="{iconCls:\'oz-pagination-first\',id:\'paging-first\'}"></a></td>').appendTo(tr);
		$('<td><a href="javascript:void(0)" data-linkbutton="{iconCls:\'oz-pagination-prev\',id:\'paging-prev\'}"></a></td>').appendTo(tr);
		$('<td><div class="oz-pagination-btn-separator"></div></td>').appendTo(tr);
		
		$('<span style="padding-left:6px;"></span>')
				.html(opts.beforePageText)
				.wrap('<td></td>')
				.parent().appendTo(tr);
		$('<td><input class="oz-pagination-num" type="text" value="1" size="2"></td>').appendTo(tr);
		$('<span style="padding-right:6px;"></span>')
//				.html(opts.afterPageText)
				.wrap('<td></td>')
				.parent().appendTo(tr);
		
		$('<td><div class="oz-pagination-btn-separator"></div></td>').appendTo(tr);
		$('<td><a href="javascript:void(0)" data-linkbutton="{iconCls:\'oz-pagination-next\',id:\'paging-next\'}"></a></td>').appendTo(tr);
		$('<td><a href="javascript:void(0)" data-linkbutton="{iconCls:\'oz-pagination-last\',id:\'paging-last\'}"></a></td>').appendTo(tr);
		
		if (opts.showRefresh){
			$('<td><div class="oz-pagination-btn-separator"></div></td>').appendTo(tr);
			$('<td><a href="javascript:void(0)" linkbutton="{iconCls:\'oz-pagination-load\',id:\'paging-load\'}"></a></td>').appendTo(tr);
		}
		
		if (opts.buttons){
			$('<td><div class="oz-pagination-btn-separator"></div></td>').appendTo(tr);
			for(i=0; i<opts.buttons.length; i++){
				var btn = opts.buttons[i];
				if (btn == '-') {
					$('<td><div class="oz-pagination-btn-separator"></div></td>').appendTo(tr);
				} else {
					var td = $('<td></td>').appendTo(tr);
					$('<a href="javascript:void(0)"></a>')
							.css('float', 'left')
							.text(btn.text || '')
							.bind('click', eval(btn.handler || OZ.noop))
							.appendTo(td)
							.linkbutton({plain:true,
								iconCls:btn.iconCls || '',
								id:btn.id || ''
							});
				}
			}
		}
		
		$('<div class="oz-pagination-info"></div>').appendTo(pager);
		$('<div style="clear:both;"></div>').appendTo(pager);
		
		$('a', pager).linkbutton({plain:true});
		
		pager.find('#paging-first').unbind(this.$type).bind('click.'+this.$type, function(){
			if (opts.pageNumber > 1){
				self.selectPage(1);
			}
		});
		pager.find('#paging-prev').unbind(this.$type).bind('click.'+this.$type, function(){
			if (opts.pageNumber > 1){
				self.selectPage(opts.pageNumber - 1);
			}
		});
		pager.find('#paging-next').unbind(this.$type).bind('click.'+this.$type, function(){
			var pageCount = Math.ceil(opts.total/opts.pageSize);
			if (opts.pageNumber < pageCount) {
				self.selectPage(opts.pageNumber + 1);
			}
		});
		pager.find('#paging-last').unbind(this.$type).bind('click.'+this.$type, function(){
			var pageCount = Math.ceil(opts.total/opts.pageSize);
			if (opts.pageNumber < pageCount){
				self.selectPage(pageCount);
			}
		});
		pager.find('#paging-load').unbind(this.$type).bind('click.'+this.$type, function(){
			if (self._trigger("beforerefresh",null,{pageNumber:opts.pageNumber,pageSize:opts.pageSize} !== false )){
				self.selectPage(opts.pageNumber);
				self._trigger("refresh",null,{pageNumber:opts.pageNumber,pageSize:opts.pageSize});
			}
		});
		pager.find('input.oz-pagination-num').unbind(this.$type).bind('keydown.'+this.$type, function(e){
			if (e.keyCode == 13){
				var pageNumber = parseInt($(this).val(),10) || 1;
				self.selectPage(pageNumber);
			}
		});
		pager.find('.oz-pagination-page-list').unbind(this.$type).bind('change.'+this.$type, function(){
			opts.pageSize = $(this).val();
			self._trigger("changepage",null,{pageSize:opts.pageSize});
			var pageCount = Math.ceil(opts.total/opts.pageSize);
			self.selectPage(opts.pageNumber);
		});
		
		this.paper = pager;
	},
	_init:function(){
		this.showInfo();
	},
	selectPage : function (page){
		var opts = this.options;
		var pageCount = Math.ceil(opts.total/opts.pageSize);
		var pageNumber = page;
		if (page < 1){
			pageNumber = 1;
		}
		if (page > pageCount) {
			pageNumber = pageCount;
		}
		this._trigger("selectpage",null,{pageNumber:pageNumber,pageSize:opts.pageSize});
		opts.pageNumber = pageNumber;
		this.showInfo();
	},
	
	showInfo : function (){
		var opts = this.options;
		
		var pageCount = Math.ceil(opts.total/opts.pageSize);
		var num = this.element.find('input.oz-pagination-num');
		num.val(opts.pageNumber);
		
		var html = opts.afterPageText.replace(/\{pages\}/, pageCount);
		num.parent().next().find('span').html(html);
		
		var pinfo = opts.displayMsg;
		pinfo = pinfo.replace(/\{from\}/, opts.pageSize*(opts.pageNumber-1)+1);
		pinfo = pinfo.replace(/\{to\}/, Math.min(opts.pageSize*(opts.pageNumber), opts.total));
		pinfo = pinfo.replace(/\{total\}/, opts.total);
		
		this.element.find('.oz-pagination-info').html(pinfo);
		
		$('#paging-first,#paging-prev', this.element).linkbutton({
			disabled: (opts.pageNumber == 1)
		});
		$('#paging-next,#paging-last', this.element).linkbutton({
			disabled: (opts.pageNumber == pageCount)
		});
		if (opts.loading){
			this.loading();
		} else {
			this.loaded();
		}
	},
	loading:function(){
		this.options.loading = true;
		this.element.find('#paging-load').linkbutton("setIcon","oz-pagination-loading");
	},
	loaded:function(){
		this.options.loading = false;
		this.element.find('#paging-load').linkbutton("setIcon","oz-pagination-load");
	}
});
})(jQuery);