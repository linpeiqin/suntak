package cn.suntak.ems.partinfo.action;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.oz.UserContextHolder;
import cn.oz.dao.Page;
import cn.oz.util.BeanUtils;
import cn.oz.web.util.ActionUtils;
import cn.oz.web.util.RequestUtils;
import cn.suntak.ems.common.action.EMSCRUDAction;
import cn.suntak.ems.partinfo.domain.PartInfo;
import cn.suntak.ems.partinfo.service.PartInfoService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class PartInfoAction extends EMSCRUDAction<PartInfo, PartInfoService>{
    public ActionForward dlgPartInfo(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception{
    	boolean checkboxBln = RequestUtils.getBooleanParameter("checkboxBln", true);
    	request.setAttribute("checkboxBln", checkboxBln);
        return mapping.findForward("dlgPartInfo");
    }

    @Override
    protected void getPageData(HttpServletRequest request, Page page) throws Exception {
            String code = UserContextHolder.getCurUserInfo().getUnit().getCode();
            this.getService().getPage(page,ActionUtils.getDbftSearchParams(request),getSearchQuery(request),Long.valueOf(code));
    }
    public ActionForward openAttach(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        PartInfo domain = null;
        try {
            if(null == domain) {
                domain = this.loadDomain(request, form);
            }

            if(null == domain) {
                return  ActionUtils.forwardErrorPage(mapping,request,"请选择一条配件记录");
            } else {
                boolean e = true;
                this.renderForm(request, form, domain, e);
                String formForwardName = "attachPartInfo";
                BeanUtils.copyProperties(form, domain);
                this.setDomain(request, domain);
                request.setAttribute(this.getFormBeanName(), form);
                return mapping.findForward(formForwardName);
            }
        } catch (Exception var8) {
            this.logger.error(var8.getMessage(), var8);
            return this.renderException(mapping, request, var8);
        }
    }

    public ActionForward HPPartInfo(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        return mapping.findForward("HPPartInfo");
    }
}