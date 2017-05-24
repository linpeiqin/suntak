package cn.suntak.ems.partinfo.action;


import javax.servlet.http.HttpServletRequest;

import cn.oz.dao.Page;
import cn.oz.web.util.ActionUtils;
import cn.oz.web.util.RequestUtils;
import org.apache.struts.action.ActionForm;

import cn.oz.web.struts.action.CRUD2Action;
import cn.suntak.ems.partinfo.domain.PartQuality;
import cn.suntak.ems.partinfo.service.PartQualityService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class PartQualityAction extends CRUD2Action<PartQuality, PartQualityService> {
    private PartQualityService  partQualityService;
    
    @Override
    public void initAction() {
    	super.initAction();
    	this.partQualityService = this.getServiceBean("partQualityService");
    }

	protected void initForm(HttpServletRequest request, ActionForm form, PartQuality domain, boolean canEdit) {
		request.setAttribute("qualityTypeSelect", this.partQualityService.getQualityType());
	}

	protected void afterCreate(HttpServletRequest request, ActionForm form, PartQuality domain) throws Exception {
		Long partId = RequestUtils.getLongParameter(request, "partId", -1L);
		domain.setPartId(partId);
	}
	protected void getPageData(HttpServletRequest request, Page page) throws Exception {
		Long partId = RequestUtils.getLongParameter(request,"partId",-1L);
		if (partId!=-1L)
			this.getService().getPage(page, ActionUtils.getDbftSearchParams(request),getSearchQuery(request),partId);
	}

	@Override
	protected void beforeSave(HttpServletRequest request, ActionForm form)
			throws Exception {
		super.beforeSave(request, form);
	}
}