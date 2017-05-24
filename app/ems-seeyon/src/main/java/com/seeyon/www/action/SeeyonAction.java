package com.seeyon.www.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.seeyon.www.util.AxHelper;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.oz.json.JSONObject;
import cn.oz.web.struts.action.CRUD2Action;
import cn.oz.web.util.RequestUtils;

import com.seeyon.www.domain.Seeyon;
import com.seeyon.www.service.SeeyonService;

public class SeeyonAction extends CRUD2Action<Seeyon, SeeyonService>{

	public ActionForward callOaInterface(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		Long id = RequestUtils.getLongParameter("id", -1);
		String templateCode = RequestUtils.getStringParameter("templateCode", "");
		String fileName = RequestUtils.getStringParameter("fileName", "");
		String formMain = RequestUtils.getStringParameter("formMain", "");
		Map<String,String> map = this.getService().callOaInterface(id,templateCode,fileName,formMain);
		JSONObject json = new JSONObject();
		//{errorMessage=模板不存在:EIntoFactory_01, flag=e, errorNumber=50125}
		if(map!=null){
			if(map.get("flag").equals("e")){
				if(map.get("errorNumber").equals("EMS")){
					json.put("msg", map.get("errorMessage"));
				}else{
					json.put("msg", map.get("errorMessage")+" <br/>  错误代码:"+map.get("errorNumber"));
				}
				json.put("result",false);
			}else{
				json.put("result", true);
				json.put("msg", "同步成功");
			}
		}
		return this.renderJson(response, json);
	}
}
