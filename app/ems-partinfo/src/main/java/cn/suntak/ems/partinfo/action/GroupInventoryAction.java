package cn.suntak.ems.partinfo.action;


import javax.servlet.http.HttpServletRequest;

import cn.oz.dao.Page;
import cn.oz.web.util.ActionUtils;
import cn.oz.web.util.RequestUtils;
import cn.suntak.ems.partinfo.domain.GroupInventory;
import cn.suntak.ems.partinfo.service.GroupInventoryService;
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
public class GroupInventoryAction extends CRUD2Action<GroupInventory, GroupInventoryService> {
    protected void getPageData(HttpServletRequest request, Page page) throws Exception {
        String partNo = RequestUtils.getStringParameter(request,"partNo","-1");
        if (!partNo.equals("-1"))
            this.getService().getPage(page, ActionUtils.getDbftSearchParams(request),getSearchQuery(request),partNo);
    }
}