package cn.suntak.ems.equipmentrepair.action;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;

import cn.oz.dao.Page;
import cn.oz.web.util.ActionUtils;
import cn.oz.web.util.RequestUtils;
import cn.suntak.ems.common.action.EMSCRUDAction;
import cn.suntak.ems.equipmentrepair.domain.RepairMonthPlan;
import cn.suntak.ems.equipmentrepair.service.MonthPlanDetailService;
import cn.suntak.ems.equipmentrepair.service.RepairMonthPlanService;

public class RepairMonthPlanAction  extends EMSCRUDAction<RepairMonthPlan, RepairMonthPlanService>{

	private MonthPlanDetailService monthPlanDetailService;
	
	@Override
	public void initAction() {
		// TODO Auto-generated method stub
		this.monthPlanDetailService = getServiceBean("monthPlanDetailService");
	}
	
	@Override
	protected void initForm(HttpServletRequest request, ActionForm form,
			RepairMonthPlan domain, boolean canEdit) {
		// TODO Auto-generated method stub
		Long id = RequestUtils.getLongParameter("id",-1);
		if(id != -1){
			RepairMonthPlan bean = this.getService().load(id);
			request.setAttribute("bean", bean);
			List<Map<String,String>> details = monthPlanDetailService.pakeDetails(id);
			request.setAttribute("details", details);
			String year = bean.getPlanMonth().substring(0, 4);
			String month = bean.getPlanMonth().substring(5, 7);
			Calendar   cal   =   Calendar.getInstance();
	        cal.set(Calendar.YEAR,Integer.parseInt(year));
	        cal.set(Calendar.MONTH,Integer.parseInt(month)-1);
	        cal.set(Calendar.DATE, 1);  
	        cal.roll(Calendar.DATE, -1); 
	        int maxDate = cal.get(Calendar.DATE);
	        request.setAttribute("maxDate", maxDate);
		}
		 
	}
	
	@Override
	protected void getPageData(HttpServletRequest request, Page page)
			throws Exception {
		// TODO Auto-generated method stub
		 this.getService().getPage(page, ActionUtils.getDbftSearchParams(request), getSearchQuery(request));
	}
}
