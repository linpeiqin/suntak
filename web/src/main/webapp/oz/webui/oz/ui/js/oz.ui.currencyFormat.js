(function($) {
	$.fn.currencyFormat = function(options) {
		// 判断是否已经渲染过,如果是则不再渲染
		if($(this).data("rended") === true){
			return this;
		}
		$(this).data("rended", true);
		
		var defaults = {
			prefix: '￥ ',
            suffix: '',
			centsSeparator: '.',
			thousandsSeparator: ',',
			limit: false,
			centsLimit: 2,
			clearPrefix: false,
            clearSufix: false,
			allowNegative: false
		};

		var options = $.extend(defaults, options);
		return this.each(function() {
			// pre defined options
			var obj = $(this);
			var is_number = /[0-9]/;

			// load the pluggings settings
			var prefix = options.prefix;
            var suffix = options.suffix;
			var centsSeparator = options.centsSeparator;
			var thousandsSeparator = options.thousandsSeparator;
			var limit = options.limit;
			var centsLimit = options.centsLimit;
			var clearPrefix = options.clearPrefix;
            var clearSuffix = options.clearSuffix;
			var allowNegative = options.allowNegative;

			// skip everything that isn't a number
			// and also skip the left zeroes
			function to_numbers(str) {
				var formatted = '';
				var hasCentsSeparator = false;
				for (var i = 0; i < (str.length); i++){
					char_ = str.charAt(i);
					if (formatted.length == 0 && char_ == 0) 
						char_ = false;

					if (char_ && (char_.match(is_number) || centsSeparator == char_)){
						if(centsSeparator == char_){
							if(hasCentsSeparator)
								continue;
							else
								hasCentsSeparator = true; 
						}
						
						if (limit) {
							if (formatted.length < limit) 
								formatted = formatted + char_;
							else{
								OZ.Msg.slide("对不起，您的输入超过了最大长度限制");
							}
						} else {
							formatted = formatted + char_;
						}
					}
				}
				return formatted;
			}

			// format to fill with zeros to complete cents chars
			function fill_with_zeroes (str) {
				//while (str.length < (centsLimit + 1)) 
				//	str = '0' + str;
				return str;
			}

			// format as currency
			function currency_format (str) {
				// formatting settings
				var formatted = fill_with_zeroes(to_numbers(str));
				var thousandsFormatted = '';
				var thousandsCount = 0;

				// Checking CentsLimit
				if(centsLimit == 0) {
					centsSeparator = "";
					centsVal = "";
				}

				// split integer from cents
				var integerVal = "";
				var centsVal = "";
				if(formatted.indexOf(centsSeparator) > 0){
					integerVal = formatted.substr(0, formatted.indexOf(centsSeparator));
					centsVal = formatted.substr(formatted.indexOf(centsSeparator) + 1, centsLimit);
				}else if(formatted.indexOf(centsSeparator) == 0){
					centsVal = formatted.substr(formatted.indexOf(centsSeparator) + 1, centsLimit);
				}else{
					integerVal = formatted;
				}
				if(integerVal == "")
					integerVal = "0";
				if(centsVal == "")
					for(var i = 0; i < centsLimit; i++)
						centsVal += "0";
				
				// apply cents pontuation
				formatted = integerVal + centsSeparator + centsVal;

				// apply thousands pontuation
				if (thousandsSeparator || $.trim(thousandsSeparator) != "") {
					for (var j = integerVal.length; j > 0; j--) {
						char_ = integerVal.substr(j-1, 1);
						thousandsCount++;
						if (thousandsCount%3 == 0) 
							char_ = thousandsSeparator + char_;
						thousandsFormatted = char_ + thousandsFormatted;
					}
					
					//
					if (thousandsFormatted.substr(0,1) == thousandsSeparator) 
						thousandsFormatted = thousandsFormatted.substring(1, thousandsFormatted.length);
					formatted = thousandsFormatted + centsSeparator + centsVal;
				}

				// if the string contains a dash, it is negative - add it to the begining (except for zero)
				if (allowNegative && str.indexOf('-') != -1 && (integerVal != 0 || centsVal != 0)) 
					formatted = '-' + formatted;

				// apply the prefix
				if (prefix) 
					formatted = prefix + formatted;
                
                // apply the suffix
				if (suffix) 
					formatted = formatted + suffix;
				return formatted;
			}

			// filter what user type (only numbers and functional keys)
			function key_check (e) {
				var code = (e.keyCode ? e.keyCode : e.which);
				var typed = String.fromCharCode(code);
				var functional = false;
				// var str = obj.val();
				// var newValue = currency_format(str + typed);

				// allow key numbers, 0 to 9
				if((code >= 48 && code <= 57) || (code >= 96 && code <= 105)) 
					functional = true;
				
				// check Backspace, Tab, Enter, Delete, and left/right arrows
				if (code ==  8) 
					functional = true;
				if (code ==  9) 
					functional = true;
				if (code == 13) 
					functional = true;
				if (code == 46) 
					functional = true;
				if (code == 37) 
					functional = true;
				if (code == 39) 
					functional = true;
				if (allowNegative && (code == 189 || code == 109)) 
					functional = true; // dash as well
				
				// 判断是否是小数点
				if (code == 110 || code == 190)
					functional = true;
				
				if (!functional) {
					e.preventDefault();
					e.stopPropagation();
					// if (str != newValue) 
					//	obj.val(newValue);
				}
			}

			// inster formatted currency as a value of an input field
			function currency_it () {
				var str = obj.val();
				var currency = currency_format(str);
				if (str != currency) 
					obj.val(currency);
			}

			// Add prefix on focus
			function add_prefix() {
				var val = obj.val();
				obj.val(prefix + val);
			}
            
            function add_suffix() {
				var val = obj.val();
				obj.val(val + suffix);
			}

			// Clear prefix on blur if is set to true
			function clear_prefix() {
				if($.trim(prefix) != '' && clearPrefix) {
					var array = obj.val().split(prefix);
					if(array.length > 1)
						obj.val(array[1]);
					else
						obj.val(array[0]);
				}
			}
            
            // Clear suffix on blur if is set to true
			function clear_suffix() {
				if($.trim(suffix) != '' && clearSuffix) {
					var array = obj.val().split(suffix);
					obj.val(array[0]);
				}
			}

			// bind the actions
			if($(this).attr("readonly") == "readonly"){
				// 只读状态,不用绑定事件
			}else{
				$(this).bind('keydown.currency_format', key_check);
				// $(this).bind('keyup.currency_format', currency_it);
				$(this).bind('focusout.currency_format', currency_it);
				$(this).bind('focusin.currency_format', function() {
					var field = $(this).val();
					if(field.length == 0)
			        	return "0.00";
					
			        field = field.split("");
			        var result = "";
			        for(var i = 0; i < field.length; i++) {        	
			            if(!isNaN(field[i]) || field[i] == "-" || field[i] == "."){ 
							result += field[i];
			            }
			        }
					$(this).val(result);
				});
			}
			
			// Clear Prefix and Add Prefix(暂时不用这些事件)
			clearPrefix = false;
			if(clearPrefix) {
				$(this).bind('focusout.currency_format', function() {
					clear_prefix();
				});

				$(this).bind('focusin.currency_format', function() {
					add_prefix();
				});
			}
			
			// Clear Suffix and Add Suffix(暂时不用这些事件)
			clearSuffix = false;
			if(clearSuffix) {
				$(this).bind('focusout.currency_format', function() {
                    clear_suffix();
				});

				$(this).bind('focusin.currency_format', function() {
                    add_suffix();
				});
			}

			// If value has content
			var curVal = $(this).val();
			if(null == curVal || curVal.length == 0)
				$(this).val("0");
			if ($(this).val().length>0) {
				currency_it();
				clear_prefix();
                clear_suffix();
			}
		});
	};
	
    $.fn.uncurrencyFormat = function(){
      return $(this).unbind(".currency_format");
    };

    $.fn.unmaskVal = function(){
        var field = $(this).val();
        if(field.length == 0)
        	return "0.00";
        field = field.split("");
        var result = "";
        for(var i = 0; i < field.length; i++) {        	
            if(!isNaN(field[i]) || field[i] == "-" || field[i] == "."){ 
				result += field[i];
            }
        }
        return result;
    };
})(jQuery);