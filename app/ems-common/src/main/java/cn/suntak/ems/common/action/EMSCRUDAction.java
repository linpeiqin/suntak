//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package cn.suntak.ems.common.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.oz.IdEntity;
import cn.oz.dao.Page;
import cn.oz.json.JSONObject;
import cn.oz.search.SearchUtils;
import cn.oz.service.SimpleService;
import cn.oz.web.struts.action.CRUD2Action;
import cn.oz.web.util.ActionUtils;
import cn.oz.web.util.RequestUtils;
import cn.suntak.ems.common.service.CategoriesVService;
import cn.suntak.ems.common.service.CurrencyVService;
import cn.suntak.ems.common.service.DepartmentVService;
import cn.suntak.ems.common.service.EmployeeVService;
import cn.suntak.ems.common.service.EmployeesVService;
import cn.suntak.ems.common.service.OrgVService;
import cn.suntak.ems.common.service.PoMethodVService;
import cn.suntak.ems.common.service.ShipToLocationVService;
import cn.suntak.ems.common.service.SuppliersVService;
import cn.suntak.ems.transdata.service.TransDataService;

public class EMSCRUDAction<T extends IdEntity, S extends SimpleService<T, Long>> extends CRUD2Action<T, S> {
    protected DepartmentVService departmentVService;
    protected TransDataService transDataService;
    private CategoriesVService categoriesVService;
    private SuppliersVService suppliersVService;
    private CurrencyVService  currencyVService;
    private EmployeeVService  employeeVService;
    private EmployeesVService  employeesVService;
    private OrgVService  orgVService;
    private ShipToLocationVService  shipToLocationVService;
    private PoMethodVService   poMethodVService;

    @Override
    public void initAction() {
        this.departmentVService = this.getServiceBean("departmentVService");
        this.transDataService = this.getServiceBean("transDataService");
        this.categoriesVService = this.getServiceBean("categoriesVService");
        this.suppliersVService = this.getServiceBean("suppliersVService");
        this.currencyVService = this.getServiceBean("currencyVService");
        this.employeeVService = this.getServiceBean("employeeVService");
        this.employeesVService = this.getServiceBean("employeesVService");
        this.orgVService = this.getServiceBean("orgVService");
        this.shipToLocationVService = this.getServiceBean("shipToLocationVService");
        this.poMethodVService = this.getServiceBean("poMethodVService");
    }

    @Override
    protected void initForm(HttpServletRequest request, ActionForm form, T domain, boolean canEdit) {
        request.setAttribute("departmentSelect",this.departmentVService.getDepartmentOption());
        request.setAttribute("manageDSelect",this.departmentVService.getManageDepartmentOption());
        request.setAttribute("useDSelect",this.departmentVService.getUsedDepartmentOption());
        request.setAttribute("fixedAssetsTypeSelect",this.categoriesVService.getCategoriesOption());
        request.setAttribute("currencySelect",this.currencyVService.getCurrencyOption());
        request.setAttribute("orgSelect",this.orgVService.getOrgOption());
        request.setAttribute("shipToLocationSelect",this.shipToLocationVService.getShipToLocationOption());
        request.setAttribute("poMethodSelect",this.poMethodVService.getPoMethodOption());
        super.initForm(request, form, domain, canEdit);
    }

    protected void afterSubmitEBS(Long id, String fileName,JSONObject result) {
		
	}
    
    public ActionForward submitEBS(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception{
        JSONObject json = new JSONObject();
        Long id = RequestUtils.getLongParameter(request,"id",-1L);
        String fileName = RequestUtils.getStringParameter(request,"fileName","-1");
        String type = RequestUtils.getStringParameter(request,"type","-1");
        JSONObject result = null;
        if (type.equals("-1")){
            if (id==-1 || fileName.equals("-1")) {
                json.put("msg", "该单不存在或交换数据名不存在，请联系管理员！");
                return this.renderJson(response, json.toJSONString());
            }
            result = this.transDataService.exeSql(id, fileName);
            json.put("msg", result.get("msg"));
            json.put("flag",result.get("code").equals("0")?"Y":"N");
            if(result.get("code")!=null&&result.get("code").equals("0")){
                 afterSubmitEBS(id,fileName,json);
            }
            return this.renderJson(response, json.toJSONString());
        }
        result = this.transDataService.submitEBS(id,type);
        json.put("msg",result.get("msg"));
        json.put("flag",result.get("code").equals("0")?"Y":"N");
        afterSubmitEBS(id,fileName,json);
        return this.renderJson(response, json.toJSONString());
    }

    public ActionForward dlgAgent(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception{
        return mapping.findForward("dlgAgent");
    }
    public ActionForward dlgEmployee(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception{
        return mapping.findForward("dlgEmployee");
    }
    public ActionForward dlgEmployees(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception{
        return mapping.findForward("dlgEmployees");
    }
    @Override
    protected void getPageData(HttpServletRequest request, Page page) throws Exception {
       String type = RequestUtils.getStringParameter(request, "type", "-1");
       request.setAttribute("type",type);
        if (!type.equals("-1")&&type.equals("agent")) {
            this.suppliersVService.getPage(page, ActionUtils.getDbftSearchParams(request), SearchUtils.getSearchQuery(request));
        }
        else if (!type.equals("-1")&&type.equals("employee"))
        {
            this.employeeVService.getPage(page, ActionUtils.getDbftSearchParams(request), SearchUtils.getSearchQuery(request));
        }
        else if(!type.equals("-1")&&type.equals("employees"))
        {
        	this.employeesVService.getPage(page, ActionUtils.getDbftSearchParams(request), SearchUtils.getSearchQuery(request));
        }
        else {
        	super.getPageData(request, page);
        }
    }

    @Override
    protected void beforeCreate(HttpServletRequest request, ActionForm form) throws Exception {
        request.setAttribute("equipmentId",RequestUtils.getStringParameter(request,"equipmentId","-1"));
    }


}
