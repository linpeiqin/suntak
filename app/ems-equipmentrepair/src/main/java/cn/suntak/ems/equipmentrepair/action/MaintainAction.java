package cn.suntak.ems.equipmentrepair.action;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.oz.UserContextHolder;
import cn.oz.dao.Page;
import cn.oz.util.BeanUtils;
import cn.oz.util.StringUtils;
import cn.oz.web.util.ActionUtils;
import cn.oz.web.util.RequestUtils;
import cn.suntak.ems.common.action.EMSCRUDAction;
import cn.suntak.ems.equipmentrepair.domain.Maintain;
import cn.suntak.ems.equipmentrepair.domain.MaintainContent;
import cn.suntak.ems.equipmentrepair.service.MaintainContentService;
import cn.suntak.ems.equipmentrepair.service.MaintainService;
import cn.suntak.ems.equipmentrepair.service.RepairPlanService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class MaintainAction extends EMSCRUDAction<Maintain, MaintainService>{

	private MaintainContentService maintainContentService;
	private RepairPlanService repairPlanService;
	
    public void initAction() {
	        this.maintainContentService = this.getServiceBean("maintainContentService");
		   	this.repairPlanService = this.getServiceBean("repairPlanService");
	    }
	@Override
	protected void initForm(HttpServletRequest request, ActionForm form,
			Maintain domain, boolean canEdit) {
		// TODO Auto-generated method stub
		request.setAttribute("maintainLevelSelect",this.getService().getMaintenaceLevel());
		Long id = RequestUtils.getLongParameter("id", -1);
		if(id != -1){
			Maintain bean = this.getService().load(id);
			request.setAttribute("bean", bean);
		}
		domain.setExecutTime(new Date());
		domain.setMaintainPerson(UserContextHolder.getCurFileAuthor());
	}
	
	@Override
	protected Maintain createDomain(HttpServletRequest request, ActionForm form) throws Exception {
		Maintain domain = this.getService().create();
		domain.setExecutTime(new Date());
		domain.setMaintainPerson(UserContextHolder.getCurFileAuthor());
		return domain;
	}

	protected void save(HttpServletRequest request, ActionForm form, Maintain domain) throws Exception {
		Long orgId = Long.parseLong(UserContextHolder.getCurUserInfo().getUnit().getCode());
//		Long repairPlanId = domain.getRepairPlanId();
		if(null != orgId) {
			domain.setOrganizationId(orgId);
		}
//		if(-1 != repairPlanId && null != repairPlanId){
//			RepairPlan repairPlan = this.repairPlanService.load(repairPlanId);
//			repairPlan.setIsOff(1);
//		}
		this.getService().save(domain);
	}

	@Override
	protected void afterSave(HttpServletRequest request, ActionForm form, Maintain domain) throws Exception {
//		Long repairPlanId = domain.getRepairPlanId();
//		RepairPlan repairPlan = this.repairPlanService.load(repairPlanId);
//		repairPlan.setMaintainId(domain.getId());
		super.afterSave(request, form, domain);
	}

	public ActionForward maintainDisplay(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		return mapping.findForward("showMaintain");
	}
	@Override
	protected void beforeDisplay(HttpServletRequest request, ActionForm form) throws Exception {
		request.setAttribute("classify",RequestUtils.getStringParameter(request, "classify", "other"));
	}
	@Override
	protected void getPageData(HttpServletRequest request, Page page) throws Exception {
		Long equipmentId = RequestUtils.getLongParameter(request,"equipmentId",-1L);
		String classify = RequestUtils.getStringParameter(request, "classify", "other");
		String viewType = RequestUtils.getStringParameter(request, "viewType", "other");
		if (viewType.equals("other"))
			this.getService().getPage(page, ActionUtils.getDbftSearchParams(request), getSearchQuery(request), equipmentId,classify);
		else
			this.getService().getSViewPage(page, equipmentId);
	}
	@Override
	protected Maintain getDomain(HttpServletRequest request, ActionForm form)
			throws Exception {
		// TODO Auto-generated method stub
		long id = this.getFileId(request);
		Maintain domain = null;
		if (this.isBlankId(id)) {
			domain = this.createDomain(request, form);
		} else {
			domain = this.loadDomain(request, form, id);
			maintainContentService.delByMaintainId(id);
		}

		BeanUtils.copyProperties(domain, form);
		String[] contents = request.getParameterValues("content");
		List<MaintainContent> maintainContents = new ArrayList<MaintainContent>();
		
		String mCheck,mClear,mAdjust,mLubric,mRepair,mChange;
		if(contents != null){
			for(int i=0;i<contents.length;i++){
				if(!StringUtils.isNullString(contents[i])){
					MaintainContent maintainContent = new MaintainContent();
					maintainContent.setMaintain(domain);
					mCheck = request.getParameter("mCheck_"+i);
					mClear = request.getParameter("mClear_"+i);
					mAdjust = request.getParameter("mAdjust_"+i);
					mLubric = request.getParameter("mLubric_"+i);
					mRepair = request.getParameter("mRepair_"+i);
					mChange = request.getParameter("mChange_"+i);
					maintainContent.setContent(contents[i]);
					maintainContent.setmCheck(mCheck);
					maintainContent.setmClear(mClear);
					maintainContent.setmAdjust(mAdjust);
					maintainContent.setmLubric(mLubric);
					maintainContent.setmRepair(mRepair);
					maintainContent.setmChange(mChange);
					maintainContents.add(maintainContent);
				}
				
			}
		}
		domain.setMaintainContents(maintainContents);
		domain.setStatus(Maintain.STATUS_FINISH_VALUE);
		return domain;
	}
}