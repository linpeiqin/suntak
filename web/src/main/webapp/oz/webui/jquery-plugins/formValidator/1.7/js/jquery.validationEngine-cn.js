(function($) {
	$.fn.validationEngineLanguage = function() {};
	$.validationEngineLanguage = {
		newLang: function() {
			$.validationEngineLanguage.allRules = 	{"required":{    			// Add your regex rules here, you can take telephone as an example
						"regex":"none",
						"alertText":"* 这是一个必填项",
						"alertTextCheckboxMultiple":"* 请选择一个选项",
						"alertTextCheckboxe":"* 请选择一个选项"},
					"length":{
						"regex":"none",
						"alertText":"*输入字符长度需要在 ",
						"alertText2":" 到 ",
						"alertText3": " "},
					"maxCheckbox":{
						"regex":"none",
						"alertText":"* 选择超出了允许选择的选项"},	
					"minCheckbox":{
						"regex":"none",
						"alertText":"* 请选择 ",
						"alertText2":" 选项"},	
					"confirm":{
						"regex":"none",
						"alertText":"* 您输入的不匹配"},		
					"telephone":{
						"regex":"/^[0-9\-\(\)\ ]+$/",
						"alertText":"* 无效的电话号码"},	
					"email":{
						"regex":"/^[a-zA-Z0-9_\.\-]+\@([a-zA-Z0-9\-]+\.)+[a-zA-Z0-9]{2,4}$/",
						"alertText":"* 无效的电子邮件地址"},	
					"date":{
                         "regex":"/^[0-9]{4}\-\[0-9]{1,2}\-\[0-9]{1,2}$/",
                         "alertText":"* 无效日期, 格式为：YYYY-MM-DD"},
					"double":{
						"regex":"/^(-?)(([0-9]{0,10})(\\.[0-9]{0,2})?)$/",
						"alertText":"* 请输入一个合法的数值，最大为十亿(即10位)，小数位最多为2位"},		 
					"number":{
						"regex":"/^[0-9\ ]+$/",
						"alertText":"* 请输入数字"},	
					"noSpecialCaracters":{
						"regex":"/^[0-9a-zA-Z]+$/",
						"alertText":"* 不允许输入任何字符"},						
					"onlyLetter":{
						"regex":"/^[a-zA-Z\ \']+$/",
						"alertText":"* 只允许输入字符"}
			}		
		}
	}
})(jQuery);

$(document).ready(function() {	
	$.validationEngineLanguage.newLang()
});