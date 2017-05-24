(function($) {

OZ.widget("OZ.Linkbutton", {
	$type: "linkbutton",
	options:{
		id: null,
		disabled: false,
		plain: false,
		text: '',
		iconCls: null
	},
	_render:function(){
		var opts = this.options,el = this.element;
		opts.text = opts.text || $.trim(el.html());
		el.empty();
		el.addClass('oz-l-btn');
		if (opts.id){
			el.attr('id', opts.id);
		} else {
			el.removeAttr('id');
		}
		if (opts.plain){
			el.addClass('oz-l-btn-plain');
		} else {
			el.removeClass('oz-l-btn-plain');
		}
		
		if (opts.text){
			el.html(opts.text).wrapInner('<span class="oz-l-btn-left"><span class="oz-l-btn-text"></span></span>');
			if (opts.iconCls){
				el.find('.oz-l-btn-text').addClass(opts.iconCls).css('padding-left', '20px');
			}
		} else {
			el.html('&nbsp;').wrapInner('<span class="oz-l-btn-left"><span class="oz-l-btn-text"><span class="oz-l-btn-empty"></span></span></span>');
			if (opts.iconCls){
				el.find('.oz-l-btn-empty').addClass(opts.iconCls);
			}
		}
		this._setDisabled(opts.disabled);
	},
	_setDisabled :function (disabled){
		var el = this.element,opts = this.options;
		if (disabled){
			var href = el.attr('href');
			if (href){
				opts.href = href;
				//el.attr('href', '###');
			}
			var onclick = el.attr('onclick');
			if (onclick) {
				opts.onclick = onclick;
				el.unbind('click');
			}
			el.addClass('oz-l-btn-disabled');
		} else {
			if (opts.href) {
				el.attr('href', opts.href);
			}
			if (opts.onclick) {
				el.bind("click",opts.onclick);
			}
			el.removeClass('oz-l-btn-disabled');
		}
		opts.disabled = !disabled;
	},
	enable: function() {
		return this._setDisabled(false );
	},
	disable: function() {
		return this._setDisabled(true );
	},
	setIcon:function(iconCls){
		var el = this.element,opts = this.options;
		el.find('.'+opts.iconCls).removeClass(opts.iconCls).addClass(iconCls);
		opts.iconCls = iconCls;
	}
});

})(jQuery);
