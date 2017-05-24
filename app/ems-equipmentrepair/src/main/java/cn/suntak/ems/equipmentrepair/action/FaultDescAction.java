package cn.suntak.ems.equipmentrepair.action;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.oz.util.BeanUtils;
import cn.oz.web.util.ActionUtils;
import cn.suntak.ems.common.action.EMSCRUDAction;
import cn.suntak.ems.equipmentrepair.domain.FaultDesc;
import cn.suntak.ems.equipmentrepair.service.FaultDescService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class FaultDescAction extends EMSCRUDAction<FaultDesc, FaultDescService>{
	 FaultDescService faultDescService;
	 public void initAction() {
	        this.faultDescService=this.getServiceBean("faultDescService");
	    }
	   
	 public ActionForward openView(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
	        FaultDesc domain = null;
	        try {
	            if(null == domain) {
	                domain = this.loadDomain(request, form);
	            }

	            if(null == domain) {
	                return  ActionUtils.forwardErrorPage(mapping,request,"请选择一条记录");
	            } else {
	                boolean e = true;
	                this.renderForm(request, form, domain, e);
	                String formForwardName = "readFaultDesc";
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
	public ActionForward openDlg(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		FaultDesc domain = null;
		try {
			if(null == domain) {
				domain = this.loadDomain(request, form);
			}

			if(null == domain) {
				return  ActionUtils.forwardErrorPage(mapping,request,"请选择一条记录");
			} else {
				boolean e = true;
				this.renderForm(request, form, domain, e);
				String formForwardName = "dfPartInfo";
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
	public ActionForward dlgFaultDesc(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception{
	        return mapping.findForward("dlgFaultDesc");
	    }
	public ActionForward dfFaultDesc(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception{
		return mapping.findForward("dfFaultDesc");
	}
	@Override
	protected void initForm(HttpServletRequest request, ActionForm form,
			FaultDesc domain, boolean canEdit) {
		// TODO Auto-generated method stub
		 request.setAttribute("faultTypeSelect",this.faultDescService.getFaultType());
	}
}