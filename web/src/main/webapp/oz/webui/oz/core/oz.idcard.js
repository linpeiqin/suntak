/**
 * 平台对身份证号处理的函数集
 * 
 * @author CD826
 * @since 5.2.0
 * @version: 5.2.0 
 */
OZ.extend({
	IDCard:{
		/**
		 * 验证给定的身份证号是否是合法的身份证号
		 * @param idCardId 所要验证的身份证号
		 * @return 如果验证成功则返回true,否则返回相应的错误信息
		 */
		validate:function(idCardId){
			// 身份证的地区代码对照
			var aCity = { 11:"北京", 12:"天津", 13:"河北", 14:"山西", 15:"内蒙古", 
						  21:"辽宁", 22:"吉林", 23:"黑龙江", 
						  31:"上海", 32:"江苏", 33:"浙江", 34:"安徽", 35:"福建", 36:"江西", 37:"山东", 
						  41:"河南", 42:"湖北", 43:"湖南", 44:"广东", 45:"广西", 46:"海南", 
						  50:"重庆", 51:"四川", 52:"贵州", 53:"云南", 54:"西藏", 
						  61:"陕西", 62:"甘肃", 63:"青海", 64:"宁夏", 65:"新疆", 
						  71:"台湾", 81:"香港", 82:"澳门", 91:"国外" };			
			
			
			// 出生日期
			var birthday;
				
			// 验证长度与格式规范性的正则,15位或者18位
			var pattern = new RegExp(/(^\d{15}$)|(^\d{17}(\d|x|X)$)/i);		
			if(pattern.exec(idCardId)){
				// 验证身份证的合法性的正则
				pattern = new RegExp(/^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/);
				if(pattern.exec(idCardId)) {
					// 获取15位证件号中的出生日期并转位正常日期		
					birthday = "19" + idCardId.substring(6,8) + "-" + idCardId.substring(8,10) + "-" + idCardId.substring(10,12);			
				}else{
					idCardId = idCardId.replace(/x|X$/i, "a");
					
					// 获取18位证件号中的出生日期
					birthday = idCardId.substring(6,10) + "-" + idCardId.substring(10,12) + "-" + idCardId.substring(12,14);
					
					// 校验18位身份证号码的合法性
					var sum = 0;
					for (var i = 17; i >= 0; i--) {
						sum += (Math.pow(2, i) % 11) * parseInt(idCardId.charAt(17 - i), 11);
					}
						
					if (sum % 11 != 1) {
						return "身份证号码不符合国定标准规定,请检查.";
					}			
				}
					
				// 检测证件地区的合法性								
				if (aCity[parseInt(idCardId.substring(0, 2))] == null){
					return "身份证号码中的证件地区未知,请检查.";
				}

				var dateStr = new Date(birthday.replace(/-/g, "/"));
				if (birthday != (dateStr.getFullYear() + "-" + OZ.IDCard.appendZero(dateStr.getMonth()+1) + "-" + OZ.IDCard.appendZero(dateStr.getDate()))){
					return "身份证号码中的出生日期非法,请检查.";							
				}
				return true;
			}else{	
				return "身份证号码不符合国定标准规定,请检查.";
			}
		},
		
		/**
		 * 获取出生日期
		 * @param idCardId 所要解析的身份证号
		 * @return 如果解析成功则返回出生日期,格式为:yyyy-mm-dd.否则返回空值
		 */
		parseBirthday:function(idCardId){
			// 出生日期
			var birthday;
				
			// 验证长度与格式规范性的正则,15位或者18位
			var pattern = new RegExp(/(^\d{15}$)|(^\d{17}(\d|x|X)$)/i);		
			if(pattern.exec(idCardId)){
				// 验证身份证的合法性的正则
				pattern = new RegExp(/^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/);
				if(pattern.exec(idCardId)) {
					// 获取15位证件号中的出生日期并转位正常日期		
					birthday = "19" + idCardId.substring(6,8) + "-" + idCardId.substring(8,10) + "-" + idCardId.substring(10,12);			
				}else{
					// 获取18位证件号中的出生日期
					idCardId = idCardId.replace(/x|X$/i, "a");
					birthday = idCardId.substring(6,10) + "-" + idCardId.substring(10,12) + "-" + idCardId.substring(12,14);
					
					// 校验18位身份证号码的合法性
					var sum = 0;
					for (var i = 17; i >= 0; i--)
						sum += (Math.pow(2, i) % 11) * parseInt(idCardId.charAt(17 - i), 11);
					if (sum % 11 != 1)
						return "";	// 身份证号格式错误,返回空值
				}
				
				var dateStr = new Date(birthday.replace(/-/g, "/"));
				if (birthday != (dateStr.getFullYear() + "-" + OZ.IDCard.appendZero(dateStr.getMonth()+1) + "-" + OZ.IDCard.appendZero(dateStr.getDate()))){
					return "";							
				}else{
					return birthday;
				}
			}else{	
				return "";
			}
		},
		
		/**
		 * 获取性别
		 * @param idCardId 所要解析的身份证号
		 * @return 如果解析成功则返回性别0表示女性,1表示男性.否则返回空值
		 */
		parseSex:function(idCardId){
			// 出生日期
			var sex;
				
			// 验证长度与格式规范性的正则,15位或者18位
			var pattern = new RegExp(/(^\d{15}$)|(^\d{17}(\d|x|X)$)/i);		
			if(pattern.exec(idCardId)){
				if(idCardId.length == 15)
					sex = idCardId.substr(12,3);
				else
					sex = idCardId.substr(14,3);
				return (parseInt(sex) % 2) + "";	// 转换成字符串
			}else{	
				return "";
			}
		},
		
		appendZero:function(temp){
			if(temp < 10){
				return "0" + temp;
			}else{
				return temp;
			}
		}
	}
});