/**
 * 表单公式运算类
 * 使用方式
 * <input type="text" name="result" id="result" data-formula="float(SUM(#a1,#a2,#a3))" data-format="{}人民币">
 * OR
 * $("#ID").formula('float(SUM(#a1,#a2,#a3))','{}人民币');
 */
(function($) {
	var root;
	root = this;
	root.OZ = root.OZ || {};
	
	$.extend($.expr[":"], {
		data : function(elem, i, match) {
			return $(elem).data(match[3]) !== undefined;
		}
	});
	var __throw = function(error) {
		if (console) {
			if (console.warn) {
				console.warn(error);
				return;
			}

			if (console.log) {
				console.log(error);
				return;
			}
		}
		throw (error);
	};

	var formula= function(_formula) {
		return formula.calculate(_formula);
	};

	var method = {
		idVal : function(name) {
			var result = $(name).val();
			if (isFinite(result)) {
				return Number(result);
			}
			return result;
		},
		int : function(num) {
			return parseInt(num);
		},
		float : function(num, point) {
			point = point || 2;
			var num = new Number(num);
			return num.toFixed(point)
		},
		MAX : function() {
			var args = [].slice.call(arguments);
			if (args.length <= 1) {
				return 0;
			}
			var newArgs = [];
			$.each(args, function() {
				if (isFinite(this)) {
					newArgs.push(this);
				}
			});
			return Math.max.apply(this, newArgs);
		},
		AVG : function() {
			var args = [].slice.call(arguments);
			if (args.length == 0) {
				return 0;
			}
			var _sum = this.SUM.apply(null, args);
			return this.float(_sum / args.length);
		},
		SUM : function() {
			var args = [].slice.call(arguments);
			if (args.length == 0) {
				return 0;
			}
			var num = 0;
			for ( var i = 0; i < args.length; i++) {
				if (!isFinite(args[i])) {
					continue;
				}
				num += args[i];
			}
			return num;
		},
		COUNTIF : function() {
			var args = [].slice.call(arguments);
			if (args.length <= 1) {
				return 0;
			}
			var criteria = args.pop();
			var count = 0;
			$.each(args, function(index, arg) {
				if (arg == criteria) {
					count++;
				}
			});
			return count;
		},
		IF : function(logical_test, value_if_true, value_if_false) {
			return logical_test ? value_if_true : value_if_false;
		}
	};

	$.extend(formula, {
		__cache : {},
		version : '0.1.0-stable',
		settings : {},
		_method : method
	});

	formula.register = function(fname, fn) {
		var _method = this._method;

		if (_method.hasOwnProperty(fname)) {
			return false;
		}

		return _method[fname] = fn;
	};

	formula.unregister = function(fname) {
		var _method = this.o_method;

		if (_method.hasOwnProperty(fname)) {
			return delete _method[fname];
		}
	};

	formula.formula = function(options) {
		var that = this;
		var fns = [];
		for ( var m in formula._method) {
			fns.push(m);
		}
		var FNS = new RegExp("(" + fns.join("|") + ")", "g");

		this.parse = function(markup) {
			var _that = this;
			var tmpl = 'var p="",$=jQuery,call;';
			tmpl += "p=";
			tmpl += $.trim(markup)
						.replace(/(#((?:[\w]|[^\x00-\xa0]|\\.)+))/ig, "idVal('$1')")
						.replace(FNS, " _m\.$1")
						.replace(/\t/g, '\\t')+ "; return p";

			this._render = new Function('jQuery', '_m', tmpl);

			this.calculate = function() {
				return _that._render.call(this, $, formula._method);
			};
			return this;
		};
	};

	formula.compile = function(tpl) {
		try {
			var engine = this.__cache[tpl] ? this.__cache[tpl]
					: new this.formula(this.options).parse(tpl);

			this.__cache[tpl] = engine;

			return engine;

		} catch (e) {
			__throw('FORMULA Compile Exception: ' + e.message);
			return {
				calculate : function() {
				}
			};
		}
	};

	formula.calculate = function(_formula) {
		return this.compile(_formula).calculate();
	};

	oz.formula = formula;
		
	$.fn.formula = function(_formula) {
		var that = this;
		if (_formula != undefined) {
			var calculateChange = function(e) {
				var v = formula(_formula);
				that.val(v);
				that.trigger("change", e);
			};
			var matchs = ("" + _formula).match(/#((?:[\w]|[^\x00-\xa0]|\\.)+)/igm);
			if (matchs) {
				$.unique(matchs);
				$(matchs.join(",")).bind("change", calculateChange);
			}
			var event = new jQuery.Event("change");
			calculateChange(event);
		}
	};

	$(function() {
		$(":input:data(formula)").each(function() {
			var el = $(this);
			el.formula(el.data("formula"));
		});
	});
})(jQuery);