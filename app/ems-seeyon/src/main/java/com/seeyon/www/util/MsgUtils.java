package com.seeyon.www.util;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.Set;

import cn.oz.FileEntity;

/**
 * @version 1.0
 * @author Administrator
 *
 */
public class MsgUtils {
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private static HashMap<String,String> getPropertyMap(FileEntity entity){
		String entityName = entity.getClass().getSimpleName();
		 HashMap<String, String> map = null;
		 Properties prop = new Properties();
		 String tempUrl = "/filedMapping/"+entityName+".properties"; 
	     InputStream in = MsgUtils.class.getResourceAsStream(tempUrl);
		 try {
			  prop.load(in);
			  map = new HashMap<String, String>((Map) prop);
		 } catch (IOException e) {
			  e.printStackTrace();
		 }
		return map;
	}
	/**
	 * 
	 * @param name formName
	 * @param entity
	 * @return
	 */
	public static String getMessage(String name,FileEntity entity){
		
		StringBuffer sb = new StringBuffer();
		sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		sb.append("<formExport version=\"2.0\">");
		sb.append("<summary id=\"\" name=\""+name+"\"/>");
		sb.append("<values>");
		try {
			HashMap<String,String> data = getPropertyMap(entity);
			String str = paraseMap(data,entity);
			sb.append(str);
		} catch (NoSuchFieldException e) {
			e.printStackTrace();
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		sb.append("</values>");
        sb.append("</formExport>");
		return sb.toString();
	}
	
	@SuppressWarnings("unchecked")
	private static String paraseMap(HashMap<String,String> data,FileEntity entity) throws NoSuchFieldException, SecurityException, IllegalArgumentException, IllegalAccessException, NoSuchMethodException, InvocationTargetException{
		
		StringBuffer sb = new StringBuffer();
		if(data!=null){
			Set<Entry<String, String>> propertySet = data.entrySet();  
	        for (Object o : propertySet) {  
	            @SuppressWarnings("rawtypes")
				Map.Entry<String,String> entry = (Map.Entry)o;  
	            String key = entry.getKey();
	            String value = entry.getValue();
	            Method method = entity.getClass().getDeclaredMethod("get"+toUpperCaseFirstOne(key));
	            sb.append("<column name=\""+value+"\">");
	            Object entityValue = method.invoke(entity);
	            if(entityValue!=null&&!entityValue.equals("")){
					if(entityValue.getClass().getSimpleName().equals("Double")){
						BigDecimal db = new BigDecimal(entityValue.toString());
						entityValue = db.toPlainString();
					}
					sb.append("<value><![CDATA["+entityValue+"]]></value>");
				}
	            sb.append("</column>");
	        }
		}
		return sb.toString();
	}
	 public static String toUpperCaseFirstOne(String s)
	    {
	        if(Character.isUpperCase(s.charAt(0)))
	            return s;
	        else
	            return (new StringBuilder()).append(Character.toUpperCase(s.charAt(0))).append(s.substring(1)).toString();
	    }
	
}
