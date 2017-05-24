/**
 * 平台对货币处理的函数集
 * 
 * 版本: 1.0.0
 * 作者：dragon 2010-10-27
 */
OZ.extend({
	Currency:{
		/**转换指定的数字为货币格式，如12345-->￥12,345.00
		 * @param num 要转换的数字
		 * @param type 货币类型：$、￥，默认为￥
		 */
		convert2digit:function(num, type){
			//ozlog.info("num=" + num);
			type = type || '';
			
			num = num.toString().replace(/\$|\,/g,'');
			if(isNaN(num))
				num = "00.00";
			sign = (num == (num = Math.abs(num)));
			num = Math.floor(num*100+0.50000000001);
			cents = num % 100;
			num = Math.floor(num/100).toString();
			if(cents < 10)
				cents = "0" + cents;
			for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
				num = num.substring(0, num.length-(4*i+3)) + ',' + num.substring(num.length - (4 * i + 3));
			return (type + ((sign) ? '' : '-') + num + '.' + cents);
		},
		
		/**转换指定的数字或货币转换为中文大写格式，如12345.79-->人民币壹万两千三佰肆拾五元捌角玖分
		 * http://hi.baidu.com/cntboy/blog/item/e69fcd18275447b84aedbca5.html
		 * http://tech.163.com/05/0906/14/1SVME2TE00091589.html
		 * 功能如下：
		 * 1、对一给定字符串，如：1234.55，转换成正确的中文货币描述：如：人民币壹仟贰佰叁拾四元五角五分
		 * 2、输入的字符串形式可以是以下几种：带分隔符的，如：123,456,789.00；不带分隔符的，如：123456789
		 * 3、输出的中文货币描述要符合规范，如：0.3----人民币三角；0.33----人民币三角三分；1----人民币壹元整
		 * 100----人民币壹佰元整；1001----人民币壹仟零壹元整；10000001----人民币壹仟万零壹元整；
		 * 1001001----人民币壹仟零壹万零壹元整，等
		 * 4、最大转换能到百亿
		 * 
		 * @param currencyDigits 要转换的数字
		 */
		convert2cn:function(currencyDigits){
			var isNegative = false;
			if(currencyDigits < 0){
				isNegative = true;
				currencyDigits = Math.abs(currencyDigits);
			}
			
			// Constants:
			var MAXIMUM_NUMBER = 99999999999.99;
			// Predefine the radix characters and currency symbols for output:
			var CN_ZERO = "零";
			var CN_ONE = "壹";
			var CN_TWO = "贰";
			var CN_THREE = "叁";
			var CN_FOUR = "肆";
			var CN_FIVE = "伍";
			var CN_SIX = "陆";
			var CN_SEVEN = "柒";
			var CN_EIGHT = "捌";
			var CN_NINE = "玖";
			var CN_TEN = "拾";
			var CN_HUNDRED = "佰";
			var CN_THOUSAND = "仟";
			var CN_TEN_THOUSAND = "万";
			var CN_HUNDRED_MILLION = "亿";
			var CN_SYMBOL = "";
			var CN_DOLLAR = "元";
			var CN_TEN_CENT = "角";
			var CN_CENT = "分";
			var CN_INTEGER = "整";
	
			// Variables:
			var integral; // Represent integral part of digit number.
			var decimal; // Represent decimal part of digit number.
			var outputCharacters; // The output result.
			var parts;
			var digits, radices, bigRadices, decimals;
			var zeroCount;
			var i, p, d;
			var quotient, modulus;
	
			// Validate input string:
			currencyDigits = currencyDigits.toString();
			currencyDigits = currencyDigits.replace(/\$|￥|\,/g,'');
			if (currencyDigits == "") {
				return "";
			}
			if (currencyDigits.match(/[^,.\d]/) != null) {
				return ("Invalid characters in the input string!");
			}
			if ((currencyDigits).match(/^((\d{1,3}(,\d{3})*(.((\d{3},)*\d{1,3}))?)|(\d+(.\d+)?))$/) == null) {
				return ("Illegal format of digit number!");
			}
	
			// Normalize the format of input digits:
			currencyDigits = currencyDigits.replace(/,/g, ""); // Remove comma
																// delimiters.
			currencyDigits = currencyDigits.replace(/^0+/, ""); // Trim zeros at the
																// beginning.
			// Assert the number is not greater than the maximum number.
			if (Number(currencyDigits) > MAXIMUM_NUMBER) {
				return ("Too large a number to convert!");
			}
	
			// Process the coversion from currency digits to characters:
			// Separate integral and decimal parts before processing coversion:
			parts = currencyDigits.split(".");
			if (parts.length > 1) {
				integral = parts[0];
				decimal = parts[1];
				// Cut down redundant decimal digits that are after the second.
				decimal = decimal.substr(0, 2);
			} else {
				integral = parts[0];
				decimal = "";
			}
			// Prepare the characters corresponding to the digits:
			digits =[CN_ZERO, CN_ONE, CN_TWO, CN_THREE, CN_FOUR, CN_FIVE,
					CN_SIX, CN_SEVEN, CN_EIGHT, CN_NINE];
			radices = ["", CN_TEN, CN_HUNDRED, CN_THOUSAND];
			bigRadices = ["", CN_TEN_THOUSAND, CN_HUNDRED_MILLION];
			decimals = [CN_TEN_CENT, CN_CENT];
			// Start processing:
			outputCharacters = "";
			// Process integral part if it is larger than 0:
			if (Number(integral) > 0) {
				zeroCount = 0;
				for (i = 0; i < integral.length; i++) {
					p = integral.length - i - 1;
					d = integral.substr(i, 1);
					quotient = p / 4;
					modulus = p % 4;
					if (d == "0") {
						zeroCount++;
					} else {
						if (zeroCount > 0) {
							outputCharacters += digits[0];
						}
						zeroCount = 0;
						outputCharacters += digits[Number(d)] + radices[modulus];
					}
					if (modulus === 0 && zeroCount < 4) {
						outputCharacters += bigRadices[quotient];
					}
				}
				outputCharacters += CN_DOLLAR;
			}
			// Process decimal part if there is:
			if("0" == decimal || "00" == decimal)
				decimal = "";
			if (decimal != "") {
				// 当只有一位的时候输出：X角整
				if(decimal.length == 1){
					outputCharacters += digits[Number(decimal)] + decimals[0] + CN_INTEGER;
				}else{
					d = decimal.substr(0, 1);
					if (d != "0") {
						outputCharacters += digits[Number(d)] + decimals[0];
					}else{
						// 仅输出零
						outputCharacters += CN_ZERO;
					}
					d = decimal.substr(1, 1);
					if (d != "0") {
						outputCharacters += digits[Number(d)] + decimals[1];
					}else{
						outputCharacters += CN_INTEGER;
					}
				}				
			}
			
			// Confirm and return the final output string:
			if (outputCharacters == "") {
				outputCharacters = CN_ZERO + CN_DOLLAR;
			}
			if (decimal == "") {
				outputCharacters += CN_INTEGER;
			}
			outputCharacters = CN_SYMBOL + outputCharacters;
			if(isNegative)
				outputCharacters = "负" + outputCharacters;
			return outputCharacters;
		}
	}
});

// 中国货币格式化
function ozCurrencyFormatter(value){
	return OZ.Currency.convert2digit(value, "￥");
}