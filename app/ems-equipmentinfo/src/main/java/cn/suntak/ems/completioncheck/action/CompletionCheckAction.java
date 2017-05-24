package cn.suntak.ems.completioncheck.action;


import cn.oz.UserContextHolder;
import cn.oz.org.json.JSONArray;
import cn.oz.org.json.JSONObject;
import cn.oz.web.util.RequestUtils;
import cn.suntak.ems.completion.domain.Completion;
import cn.suntak.ems.completioncheck.domain.CompletionCheck;
import cn.suntak.ems.completioncheck.service.CompletionCheckService;
import cn.suntak.ems.equipmentdetails.domain.EquipmentDetails;
import cn.suntak.ems.equipmentlifecycle.action.EMSCRUD2Action;
import cn.suntak.ems.equipmentlifecycle.domain.EquipmentLifeCycle;
import cn.suntak.ems.filenumber.service.FileNumberService;
import org.apache.struts.action.ActionForm;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class CompletionCheckAction extends EMSCRUD2Action<CompletionCheck, CompletionCheckService>{


    private FileNumberService fileNumberService;
    @Override
    public void initAction() {
        super.initAction();
        this.fileNumberService = this.getServiceBean("fileNumberService");
    }
    protected void save(HttpServletRequest request, ActionForm form, CompletionCheck domain) throws Exception {
        if (domain.getNumber()==null || domain.getNumber().equals("")) {
            String number = this.fileNumberService.doCreateNumber("RCBH");
            domain.setNumber(number);
        }
        super.save(request, form, domain);
    }
    protected void afterSaveByAjax(HttpServletRequest request, ActionForm form, CompletionCheck domain, cn.oz.json.JSONObject json) throws Exception {
        json.put("number",domain.getNumber());
    }

    @Override
    protected CompletionCheck getDomain(HttpServletRequest request, ActionForm form) throws Exception {

        CompletionCheck domain = super.getDomain(request, form);
        String equipmentNos = RequestUtils.getStringParameter(request, "equipmentNos", "[]");
        JSONArray equipmentList = new JSONArray(equipmentNos);
        //如何关联设备小于1就直接返回，处理来自于保存之后打开的情况
        if (equipmentList.length() < 1) {
            return domain;
        }
        //如果存在设备关联，则清理掉原来关联的设备重新用这个前台传过来的数据做关联
        EquipmentLifeCycle equipmentLifeCycle = null;
        if (domain.getEquipmentLifeCycle() == null) {
            equipmentLifeCycle = new EquipmentLifeCycle();
            equipmentLifeCycle.setStartTime(new Date());
            equipmentLifeCycle.setCreatedDate(new Date());
            equipmentLifeCycle.setCreatedBy(UserContextHolder.getCurUserInfo().getName());
            equipmentLifeCycle.setRemark("开始保存工程完工数据，还未同步数据");
            equipmentLifeCycle.setType(domain.getType());
            equipmentLifeCycle.setOrganizationId(Long.valueOf(UserContextHolder.getCurUserInfo().getUnit().getCode()));
            domain.setOrganizationId(Long.valueOf(UserContextHolder.getCurUserInfo().getUnit().getCode()));
        } else {
            equipmentLifeCycle = domain.getEquipmentLifeCycle();
            equipmentLifeCycle.getEquipmentDetails().clear();
        }
        for (int i = 0; i < equipmentList.length(); i++) {
            JSONObject obj =  equipmentList.getJSONObject(i);
            Long equipmentId = Long.valueOf(obj.get("id").toString());
            //通过设备的编号找到设备
            EquipmentDetails equipmentDetails  = this.equipmentDetailsService.load(equipmentId);
            //将设备添加到生命周期中
            equipmentLifeCycle.getEquipmentDetails().add(equipmentDetails);
        }
        this.equipmentLifeCycleService.save(equipmentLifeCycle);
        equipmentLifeCycle.setCompletionCheck(domain);
        domain.setEquipmentLifeCycle(equipmentLifeCycle);
        return domain;
    }
}