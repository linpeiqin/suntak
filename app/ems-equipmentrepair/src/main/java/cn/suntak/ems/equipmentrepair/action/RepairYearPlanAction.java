package cn.suntak.ems.equipmentrepair.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.oz.UserContextHolder;
import cn.oz.dao.Page;
import cn.oz.json.JSONObject;
import cn.oz.util.StringUtils;
import cn.oz.web.util.ActionUtils;
import cn.oz.web.util.RequestUtils;
import cn.suntak.ems.common.action.EMSCRUDAction;
import cn.suntak.ems.equipmentrepair.domain.RepairYearPlan;
import cn.suntak.ems.equipmentrepair.service.RepairYearPlanService;
import cn.suntak.ems.equipmentrepair.service.YearPlanDetailService;

public class RepairYearPlanAction  extends  EMSCRUDAction<RepairYearPlan, RepairYearPlanService>{
	  private YearPlanDetailService yearPlanDetailService;
	  
	  @Override
		public void initAction() {
			// TODO Auto-generated method stub
			this.yearPlanDetailService = getServiceBean("yearPlanDetailService");
		}
	  @Override
		protected void initForm(HttpServletRequest request, ActionForm form,
				RepairYearPlan domain, boolean canEdit) {
			// TODO Auto-generated method stub
			Long id = RequestUtils.getLongParameter("id",-1);
			if(id != -1){
				RepairYearPlan bean = this.getService().load(id);
				request.setAttribute("bean", bean);
//				List<Map<String,String>> details = yearPlanDetailService.pakeDetails(id);
//				request.setAttribute("details", details);
				List<Map<String,String>> details = yearPlanDetailService.pakeDetails(id);
				request.setAttribute("details", details);
				List<HashMap<String, String>> groupList = yearPlanDetailService.getGroupLevel(id);
				Map<String,String> groupMap = null;
				if(groupList != null && !groupList.isEmpty()){
					groupMap = new HashMap<String, String>();
					for(HashMap<String, String> listMap : groupList){
						if(listMap != null){
							if(listMap.containsKey("KEY_V") && listMap.containsKey("MAINTENACE_LEVEL")){
								groupMap.put(listMap.get("KEY_V"), listMap.get("MAINTENACE_LEVEL"));
							}
						}
					}
				}
				request.setAttribute("groupMap", groupMap);
			}
			 
		}
	  
	  public ActionForward checkExist(ActionMapping mapping, ActionForm form,
				HttpServletRequest request, HttpServletResponse response) throws Exception {
			JSONObject json = new JSONObject();
			String year = request.getParameter("year");
			String orgId = UserContextHolder.getCurUserInfo().getUnit().getCode();
			RepairYearPlan bean = null;
			boolean isExt = false;
			if(!StringUtils.isNullString(year)){
				bean = this.getService().loadByYear(year,orgId);
				if(bean != null)
					isExt = true;
			}
			json.put("isExt", isExt);
			return this.renderJson(response, json.toJSONString());
		}
	  
	public ActionForward createByYear(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		JSONObject json = new JSONObject();
		String year = request.getParameter("year");
		String orgId = UserContextHolder.getCurUserInfo().getUnit().getCode();
		this.getService().grabPlanByYear(year,orgId);
		json.put("result", true);
		return this.renderJson(response, json.toJSONString());
	}
	
	@Override
	protected void getPageData(HttpServletRequest request, Page page)
			throws Exception {
		// TODO Auto-generated method stub
		 this.getService().getPage(page, ActionUtils.getDbftSearchParams(request), getSearchQuery(request));
	}
}
