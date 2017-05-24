package cn.suntak.ems.equipmentdetails.action;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.oz.security.PermissionVerifier;
import cn.suntak.ems.common.service.CurrencyVService;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.oz.UserContextHolder;
import cn.oz.dao.Page;
import cn.oz.json.JSONArray;
import cn.oz.json.JSONObject;
import cn.oz.util.BeanUtils;
import cn.oz.web.util.ActionUtils;
import cn.oz.web.util.RequestUtils;
import cn.suntak.ems.common.action.EMSCRUDAction;
import cn.suntak.ems.equipmentdetails.domain.EquipmentDetails;
import cn.suntak.ems.equipmentdetails.service.EquipmentDetailsService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class EquipmentDetailsAction extends EMSCRUDAction<EquipmentDetails, EquipmentDetailsService>{

    private PermissionVerifier eqAdminVerifier=null;
    CurrencyVService currencyVService = null;

    @Override
    public void initAction() {
        super.initAction();
        this.currencyVService = this.getServiceBean("currencyVService");
        this.eqAdminVerifier = this.getServiceBean("eqAdminVerifier");
    }

    public ActionForward doDisableEquip(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Long id = RequestUtils.getLongParameter(request, "id", -1L);
        JSONObject json = new JSONObject();
        Boolean resule = this.getService().disableEquip(id);
        json.put("result",resule);
        json.put("msg","停用成功");
        return this.renderJson(response, json.toString());
    }
    public ActionForward doEnableEquip(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Long id = RequestUtils.getLongParameter(request, "id", -1L);
        JSONObject json = new JSONObject();
        Boolean resule = this.getService().enableEquip(id);
        json.put("result",resule);
        json.put("msg","启用成功");
        return this.renderJson(response, json.toString());
    }

    protected String getCreateForwardName(HttpServletRequest request, ActionForm form, EquipmentDetails domain) {
        return "create" + this.getEntityName();
    }

    public ActionForward addRelation(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Long equipmentId = RequestUtils.getLongParameter(request, "equipmentId", -1L);
        Long parentId = RequestUtils.getLongParameter(request, "parentId", -1L);
        Boolean flag = this.getService().addRelation(equipmentId,parentId);
        JSONObject json = new JSONObject();
        json.put("flag",flag);
        json.put("msg","关联成功");
        return this.renderJson(response, json.toString());
    }
    public ActionForward deleteRelation(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Long equipmentId = RequestUtils.getLongParameter(request, "equipmentId", -1L);
        Long parentId = RequestUtils.getLongParameter(request, "parentId", -1L);
        Boolean flag = this.getService().deleteRelation(equipmentId,parentId);
        JSONObject json = new JSONObject();
        json.put("flag",flag);
        json.put("msg","解除成功");
        return this.renderJson(response, json.toString());
    }
    public ActionForward aidsEquipment(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	  return mapping.findForward("aidsEquipmentDetails");
    }
    @Override
    protected void getPageData(HttpServletRequest request, Page page) throws Exception {
        Integer type  = RequestUtils.getIntParameter(request,"type",-1);
        Integer scrapState  = RequestUtils.getIntParameter(request,"scrapState",-1);
        this.getService().getPage(page,ActionUtils.getDbftSearchParams(request),getSearchQuery(request),type,scrapState);
    }

    public ActionForward pageForEQ(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Long parentId = RequestUtils.getLongParameter(request,"parentId",-1L);
        Page page = ActionUtils.getPage(request);
        page.setJsoner(this.getJsoner(request, form));
        if (parentId.equals(-1L)){
            return this.renderJson(response, ActionUtils.renderJsonPage(page, page.getJsoner()));
        }
        this.getService().getPageForEQ(page,ActionUtils.getDbftSearchParams(request),getSearchQuery(request),parentId);
        String e =  ActionUtils.renderJsonPage(page, page.getJsoner());
        this.beforeDisplay(request,form);
        return this.renderJson(response, e);
    }

    public ActionForward pageForEQList(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Long id = RequestUtils.getLongParameter(request,"id",-1L);
        String method = RequestUtils.getStringParameter(request,"method","");//addMain
        if (id.equals(-1L)){
            return this.renderJson(response, "");
        }
        Page page = ActionUtils.getPage(request);
        page.setJsoner(this.getJsoner(request, form));

        this.getService().getPageForEQList(page,ActionUtils.getDbftSearchParams(request),getSearchQuery(request),id,method);
        String e =  ActionUtils.renderJsonPage(page, page.getJsoner());
        this.beforeDisplay(request,form);
        return this.renderJson(response, e);
    }



    public ActionForward openAttach(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        EquipmentDetails domain = null;
        String edit = RequestUtils.getStringParameter(request,"edit","true");//addMain
        try {
            if(null == domain) {
                domain = this.loadDomain(request, form);
            }
            if(null == domain) {
                return  ActionUtils.forwardErrorPage(mapping,request,"请选择一条设备记录");
            } else {
                boolean e = true;
                this.renderForm(request, form, domain, e);
                String formForwardName = "attachEquipmentDetails";
                BeanUtils.copyProperties(form, domain);
                this.setDomain(request, domain);
                request.setAttribute(this.getFormBeanName(), form);
                request.setAttribute("edit",edit);
                return mapping.findForward(formForwardName);
            }
        } catch (Exception var8) {
            this.logger.error(var8.getMessage(), var8);
            return this.renderException(mapping, request, var8);
        }
    }

    @Override
    protected void save(HttpServletRequest request, ActionForm form, EquipmentDetails domain) throws Exception {
        domain.setOrganizationId(Long.valueOf(UserContextHolder.getCurUserInfo().getUnit().getCode()));
        this.getService().save(domain);
    }

    public ActionForward dlgEquipment(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception{
        this.beforeDisplay(request,form);
       return mapping.findForward("dlgEquipmentDetails");
    }

    public ActionForward dlgEquipmentY(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception{
        request.setAttribute("id",RequestUtils.getStringParameter("id", ""));
        request.setAttribute("method",RequestUtils.getStringParameter("method",""));
        this.beforeDisplay(request,form);
        return mapping.findForward("dlgEquipmentDetailsY");
    }
    
    public ActionForward dlgEquipmentG(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception{
        request.setAttribute("contractNo",RequestUtils.getStringParameter("contractNo", ""));
        request.setAttribute("fixedAssetsName",RequestUtils.getStringParameter("fixedAssetsName", ""));
        request.setAttribute("specificationModel",RequestUtils.getStringParameter("specificationModel", ""));
        request.setAttribute("lifeCycleId",RequestUtils.getStringParameter("lifeCycleId", ""));
        request.setAttribute("equipmentNos",RequestUtils.getStringParameter("equipmentNos", ""));
        request.setAttribute("type",RequestUtils.getStringParameter("type",""));
        return mapping.findForward("dlgEquipmentDetailsG");
    }

   /* public ActionForward getWaitEq(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception{
        String contractNo  = RequestUtils.getStringParameter("contractNo", "");
        String fixedAssetsName = RequestUtils.getStringParameter("fixedAssetsName", "");
        String specificationModel = RequestUtils.getStringParameter("specificationModel", "");
        Long lifeCycleId = RequestUtils.getLongParameter("lifeCycleId",-1L);
        List<EquipmentDetails> list = this.getService().getWEQList(contractNo,fixedAssetsName,specificationModel,lifeCycleId);
        JSONArray array = this.TranArray(list);
        return this.renderJson(response, array);
    }*/
    public ActionForward getEquipmentByType(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String contractNo = RequestUtils.getStringParameter("contractNo", "");
        String fixedAssetsName = RequestUtils.getStringParameter("fixedAssetsName", "");
        String specificationModel = RequestUtils.getStringParameter("specificationModel", "");
        Long lifeCycleId = RequestUtils.getLongParameter("lifeCycleId", -1L);
        Integer type = RequestUtils.getIntParameter("type",-1);
        List<EquipmentDetails> list = null;
        if(type==0){//待入厂设备
            list = this.getService().getIntoFactoryEquipment(contractNo, fixedAssetsName, specificationModel, lifeCycleId);
        }else if(type==1){//待验收设备
            list = this.getService().getIntoFactoryCheckEquipment(contractNo, fixedAssetsName, specificationModel, lifeCycleId);
        }else if(type==2){//可报废设备
            list = this.getService().getScrapEquipment(contractNo, fixedAssetsName, specificationModel, lifeCycleId);
        }else if(type==3){//可转移设备
            list = this.getService().getInernalTransferEquipment(contractNo, fixedAssetsName, specificationModel, lifeCycleId);
        }else if(type==4){//待更新设备
            list = this.getService().getRenewalEquipment(contractNo, fixedAssetsName, specificationModel, lifeCycleId);
        }else if(type==5){//待改造验收设备
            list = this.getService().getRenewalCheckEquipment(contractNo, fixedAssetsName, specificationModel, lifeCycleId);
        }

        JSONArray array = this.TranArray(list);
        return this.renderJson(response, array);
    }

	private JSONArray TranArray(List<EquipmentDetails> list) {
		JSONArray array = new JSONArray();
		if(list!=null&&list.size()>0){
			for(EquipmentDetails ed:list){
				JSONObject json = new JSONObject();
				json.put("contractNumber", ed.getContractNo());
				json.put("id", ed.getId());
				json.put("equipmentName",ed.getEquipmentName());
                json.put("equipmentNo",ed.getEquipmentNo());
				json.put("specificationModel", ed.getSpecificationModel());
                json.put("parentName", ed.getParentName());
                json.put("parentId", ed.getParentId());
				array.add(json);
			}
		}
		return array;
	}

    public ActionForward HPEquipmentDetails(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
        return mapping.findForward("HPEquipmentDetails");
    }

    @Override
    protected void initForm(HttpServletRequest request, ActionForm form, EquipmentDetails domain, boolean canEdit) {
        request.setAttribute("ebsEntity",domain.getEbsEntity());
        request.setAttribute("domain",domain);
        request.setAttribute("currencyOptions",currencyVService.getCurrencyOption());
        super.initForm(request, form, domain, canEdit);
    }

    @Override
    protected void afterCreate(HttpServletRequest request, ActionForm form, EquipmentDetails domain) throws Exception {
        domain.setOrganizationId(Long.valueOf(UserContextHolder.getCurUserInfo().getUnit().getCode()));
        super.afterCreate(request, form, domain);
    }

    @Override
    protected void beforeDisplay(HttpServletRequest request, ActionForm form) throws Exception {
        request.setAttribute("useDSelect",this.departmentVService.getUsedDepartmentOption());
        request.setAttribute("procedureSelect",this.departmentVService.getProcedureOption());
        super.beforeDisplay(request, form);
    }

    @Override
    protected String getViewToolbarBtns(HttpServletRequest request, ActionForm form) {
        if (this.eqAdminVerifier.verify(UserContextHolder.get().getCurUser())){
            return "btnCreateEquip,btnDoCanel,useDText,procedureText";
        }
        return "useDText,procedureText";
//        return super.getViewToolbarBtns(request, form);
    }


}