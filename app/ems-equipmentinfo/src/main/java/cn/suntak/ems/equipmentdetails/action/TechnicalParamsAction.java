package cn.suntak.ems.equipmentdetails.action;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.oz.UserContextHolder;
import cn.oz.dao.Page;
import cn.oz.json.JSONObject;
import cn.oz.util.BeanUtils;
import cn.oz.web.util.ActionUtils;
import cn.oz.web.util.RequestUtils;
import cn.suntak.ems.common.action.EMSCRUDAction;
import cn.suntak.ems.equipmentdetails.domain.EquipmentDetails;
import cn.suntak.ems.equipmentdetails.domain.TechnicalParams;
import cn.suntak.ems.equipmentdetails.service.EquipmentDetailsService;
import cn.suntak.ems.equipmentdetails.service.TechnicalParamsService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class TechnicalParamsAction extends EMSCRUDAction<TechnicalParams, TechnicalParamsService> {
    private EquipmentDetailsService equipmentDetailsService;
    @Override
    public void initAction() {
        super.initAction();
        this.equipmentDetailsService = this.getServiceBean("equipmentDetailsService");
    }
    @Override
    protected TechnicalParams getDomain(HttpServletRequest request, ActionForm form) throws Exception {
        Long equipmentId = RequestUtils.getLongParameter(request,"equipmentId",-1L);
        long id = this.getFileId(request);
        TechnicalParams domain = null;
        if(this.isBlankId(id)) {
            domain = this.createDomain(request, form);
        } else {
            domain = this.loadDomain(request, form, id);
        }

        if(null == domain) {
            return null;
        } else {
            if (equipmentId!=-1L) {
                EquipmentDetails equipmentDetails = this.equipmentDetailsService.load(equipmentId);
                equipmentDetails.getTechnicalParams().add(domain);
                domain.setEquipmentDetails(equipmentDetails);
                domain.setOrganizationId(Long.valueOf(UserContextHolder.getCurUserInfo().getUnit().getCode()));
            }
            BeanUtils.copyProperties(domain, form);
            return domain;
        }
    }
    @Override
    protected void getPageData(HttpServletRequest request, Page page) throws Exception {
        Long equipmentId = RequestUtils.getLongParameter(request,"equipmentId",-1L);
        if (equipmentId!=-1L)
            this.getService().getPage(page, ActionUtils.getDbftSearchParams(request),getSearchQuery(request),equipmentId);
    }
    
    public ActionForward getTechParaJson(ActionMapping mapping, ActionForm form,
    		HttpServletRequest request, HttpServletResponse response)
    		throws Exception {
    	 Long equipmentId = RequestUtils.getLongParameter(request,"equipmentId",-1L);
    	 JSONObject json = null ;
    	 json = this.getService().getTechParaJson(ActionUtils.getDbftSearchParams(request),getSearchQuery(request),equipmentId);
    	return this.renderJson(response, json);
    }
    
//    saveRow
    public ActionForward saveRow(ActionMapping mapping, ActionForm form,
    		HttpServletRequest request, HttpServletResponse response)
    		throws Exception {
    	 JSONObject json = new JSONObject();
    	 try{
    		 TechnicalParams domain = this.getDomain(request, form);
        	 String technicalParam = RequestUtils.getStringParameter("technicalParam","");
        	 String paramValue = RequestUtils.getStringParameter("paramValue","");
        	 domain.setTechnicalParam(technicalParam);
        	 domain.setParamValue(paramValue);
        	 this.getService().save(domain);
        	 json.put("result", true);
        	 json.put("id", domain.getId());
    	 }catch(Exception e){
    		 json.put("result", false);
    		 json.put("msg", e.getMessage());
    		 e.printStackTrace();
    	 }
    	 return this.renderJson(response,json);
    }
    
    public ActionForward delete(ActionMapping mapping, ActionForm form,
    		HttpServletRequest request, HttpServletResponse response)
    		throws Exception {
    	 JSONObject json = new JSONObject();
    	 try{
    		 Long id = RequestUtils.getLongParameter("id", -1L);
    		 this.getService().delete(id);
        	 json.put("result", true);
    	 }catch(Exception e){
    		 json.put("result", false);
    		 json.put("msg", e.getMessage());
    		 e.printStackTrace();
    	 }
    	 return this.renderJson(response,json);
    }

}