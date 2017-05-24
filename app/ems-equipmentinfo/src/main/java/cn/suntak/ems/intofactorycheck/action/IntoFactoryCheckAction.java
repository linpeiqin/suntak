package cn.suntak.ems.intofactorycheck.action;

import cn.oz.UserContextHolder;
import cn.oz.org.json.JSONArray;
import cn.oz.org.json.JSONObject;
import cn.oz.util.SelectOption;
import cn.oz.web.util.RequestUtils;
import cn.suntak.ems.common.service.DepartmentVService;
import cn.suntak.ems.completioncheck.domain.CompletionCheck;
import cn.suntak.ems.equipmentdetails.domain.EquipmentDetails;
import cn.suntak.ems.equipmentdetails.service.EquipmentDetailsService;
import cn.suntak.ems.equipmentlifecycle.action.EMSCRUD2Action;
import cn.suntak.ems.equipmentlifecycle.domain.EquipmentLifeCycle;
import cn.suntak.ems.equipmentlifecycle.service.EquipmentLifeCycleService;
import cn.suntak.ems.filenumber.service.FileNumberService;
import cn.suntak.ems.intofactory.domain.IntoFactory;
import cn.suntak.ems.intofactorycheck.domain.IntoFactoryCheck;
import cn.suntak.ems.intofactorycheck.service.IntoFactoryCheckService;
import org.apache.struts.action.ActionForm;
import org.springframework.beans.BeanUtils;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Field;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class IntoFactoryCheckAction extends EMSCRUD2Action<IntoFactoryCheck, IntoFactoryCheckService> {


    protected void save(HttpServletRequest request, ActionForm form, IntoFactoryCheck domain) throws Exception {
        if (domain.getNumber()==null || domain.getNumber().equals("")) {
            String number = this.fileNumberService.doCreateNumber("YSBH");
            domain.setNumber(number);
        }
        super.save(request, form, domain);
    }

    @Override
    protected void renderForm(HttpServletRequest request, ActionForm form, IntoFactoryCheck domain, boolean canEdit) throws Exception {
        if(domain.getEquipmentLifeCycle()!=null){
            request.setAttribute("oaType",domain.getEquipmentLifeCycle().getOaType());
            request.setAttribute("lifeCycleId",domain.getEquipmentLifeCycle().getId());
        }
        if(domain.getFixedAssetsName()!=null&&domain.getSpecificationModel()!=null&&domain.getContractNumber()!=null&&domain.getEquipmentLifeCycle()!=null){
            Set<EquipmentDetails> eqs = domain.getEquipmentLifeCycle().getEquipmentDetails();
            request.setAttribute("equipmentNos",this.TranArray(eqs));
        }
        super.renderForm(request, form, domain, canEdit);
    }

    protected void afterSaveByAjax(HttpServletRequest request, ActionForm form, IntoFactoryCheck domain, cn.oz.json.JSONObject json) throws Exception {
        json.put("lifeCycleId", domain.getEquipmentLifeCycle().getId());
        json.put("number",domain.getNumber());
    }
    protected void afterGetDomain(EquipmentLifeCycle equipmentLifeCycle, IntoFactoryCheck domain, EquipmentDetails equipmentDetails) {
        equipmentLifeCycle.setRemark("开始保存入厂验收数据，还未同步数据");
        equipmentLifeCycle.setType(domain.getType());
        equipmentLifeCycle.setOrganizationId(Long.valueOf(UserContextHolder.getCurUserInfo().getUnit().getCode()));
        domain.setOrganizationId(Long.valueOf(UserContextHolder.getCurUserInfo().getUnit().getCode()));
        domain.setEquipmentLifeCycle(equipmentLifeCycle);
        super.afterGetDomain(equipmentLifeCycle,domain,equipmentDetails);
    }

    @Override
    protected void afterSubmitEBS(Long id, String fileName, cn.oz.json.JSONObject json) {
        IntoFactoryCheck intoFactoryCheck = this.getService().load(id);
        Set<EquipmentDetails> eqs = intoFactoryCheck.getEquipmentLifeCycle().getEquipmentDetails();
        for(EquipmentDetails eq : eqs) {
            eq.setType(2);
            eq.setInstallationLocation(intoFactoryCheck.getInstallationLocation());
            eq.setEquipmentName(intoFactoryCheck.getFixedAssetsName());
            this.equipmentDetailsService.save(eq);
        }
        super.afterSubmitEBS(id,fileName,json);
    }

    @Override
    protected IntoFactoryCheck getDomain(HttpServletRequest request, ActionForm form) throws Exception {
        IntoFactoryCheck domain = super.getDomain(request,form);
        String equipmentNos = RequestUtils.getStringParameter(request,"equipmentNos","[]");
        JSONArray equipmentList  = new JSONArray(equipmentNos);
        //如何关联设备小于1就直接返回，处理来自于保存之后打开的情况
        if (equipmentList.length()<1){
            return domain;
        }
        //如果存在设备关联，则清理掉原来关联的设备重新用这个前台传过来的数据做关联
        EquipmentLifeCycle equipmentLifeCycle = null;
        if (domain.getEquipmentLifeCycle()==null) {
            equipmentLifeCycle = new EquipmentLifeCycle();
            equipmentLifeCycle.setStartTime(new Date());
            equipmentLifeCycle.setCreatedDate(new Date());
            equipmentLifeCycle.setCreatedBy(UserContextHolder.getCurUserInfo().getName());
            equipmentLifeCycle.setRemark("开始保存入厂验收数据，还未同步数据");
            equipmentLifeCycle.setType(domain.getType());
            equipmentLifeCycle.setOrganizationId(Long.valueOf(UserContextHolder.getCurUserInfo().getUnit().getCode()));
            domain.setOrganizationId(Long.valueOf(UserContextHolder.getCurUserInfo().getUnit().getCode()));
        } else {
            equipmentLifeCycle = domain.getEquipmentLifeCycle();
            equipmentLifeCycle.getEquipmentDetails().clear();
        }
        for (int i = 0; i < equipmentList.length(); i++) {
            JSONObject obj =  equipmentList.getJSONObject(i);
            JSONArray names = obj.names();
            EquipmentDetails equipmentDetails = null;
            Long equipmentId = null;
            String equipmentNo = null;
            //找到设备的id与设备的编号
            for(int j = 0;j<names.length();j++){
                String name = names.get(j).toString();
                if (name.equals("id")){
                    equipmentId = Long.valueOf(obj.get(names.get(j).toString()).toString());
                }
                if (name.equals("equipmentNo")){
                    equipmentNo =  obj.get(names.get(j).toString()).toString();
                }
            }
            //通过设备的编号找到设备
            equipmentDetails = this.equipmentDetailsService.load(equipmentId);
            //set设备的编号
            equipmentDetails.setEquipmentNo(equipmentNo);
            //将设备添加到生命周期中
            if (!equipmentNo.equals(""))
                equipmentLifeCycle.getEquipmentDetails().add(equipmentDetails);

        }
        this.equipmentLifeCycleService.save(equipmentLifeCycle);
        equipmentLifeCycle.setIntoFactoryCheck(domain);
        domain.setEquipmentLifeCycle(equipmentLifeCycle);
        return domain;
    }

    @Override
    protected void afterCreate(HttpServletRequest request, ActionForm form, IntoFactoryCheck domain) throws Exception {
        Long equipmentId = RequestUtils.getLongParameter(request, "equipmentId", -1L);
        if (!equipmentId.equals(-1L)){
            EquipmentDetails equipmentDetails = this.equipmentDetailsService.load(equipmentId);
            Set<EquipmentLifeCycle> elcs =  equipmentDetails.getEquipmentLifeCycles();
            for (EquipmentLifeCycle elc : elcs){
                if (elc.getType().equals("intoFactory")){
                    String[] fields  = {"contractNumber","fixedAssetsName","specificationModel","fixedAssetsType","agent","estimateUsefulLife",
                            "ascriptionMDname","ascriptionMDebs","customsNo",
                            "useDname","useDebs","estimateUsefulLife",
                            "ascriptionMD","useD","isImported","isDevelop",
                    "agentId","origin","manufacturer","manufacturerId","WPATI","intoFactoryTime","ascriptionMD","installationLocation","useD","installationPersonnel","originalValue","installationCost","tariff","other","totalValue"};
                    this.copyProperties(elc.getIntoFactory(),domain,fields);
                    break;
                }
            }
            domain.setAssetsNumber(1);
            domain.setSerialNumber(equipmentDetails.getEquipmentNo());
            Set<EquipmentDetails> eqs = new HashSet<EquipmentDetails>();
            eqs.add(equipmentDetails);
            request.setAttribute("equipmentNos",this.TranArray(eqs));
        }
        super.afterCreate(request, form, domain);
    }


}