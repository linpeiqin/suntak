package cn.suntak.ems.equipmentrepair.action;


import cn.oz.dao.Page;
import cn.oz.web.util.ActionUtils;
import cn.oz.web.util.RequestUtils;
import cn.suntak.ems.common.action.EMSCRUDAction;
import cn.suntak.ems.equipmentrepair.domain.PartReplace;
import cn.suntak.ems.equipmentrepair.service.PartReplaceService;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class PartReplaceAction extends EMSCRUDAction<PartReplace, PartReplaceService>{
    public ActionForward openPR(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        return mapping.findForward("readPartReplace");
    }
    public ActionForward editPR(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        return mapping.findForward("editPartReplace");
    }

    @Override
    protected void getPageData(HttpServletRequest request, Page page) throws Exception {
        Long equipmentId = RequestUtils.getLongParameter(request,"equipmentId",-1L);
        Long partId = RequestUtils.getLongParameter(request,"partId",-1L);
        if (partId!=-1L)
            this.getService().getPage(page, ActionUtils.getDbftSearchParams(request),getSearchQuery(request),partId,"P");
        if (equipmentId!=-1L){
            this.getService().getPage(page, ActionUtils.getDbftSearchParams(request),getSearchQuery(request),equipmentId,"E");
        }
    }
}