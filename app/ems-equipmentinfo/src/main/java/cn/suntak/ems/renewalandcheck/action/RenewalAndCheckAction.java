package cn.suntak.ems.renewalandcheck.action;


import cn.oz.UserContextHolder;
import cn.oz.exception.OzException;
import cn.oz.org.json.JSONArray;
import cn.oz.org.json.JSONObject;
import cn.oz.web.util.RequestUtils;
import cn.suntak.ems.equipmentdetails.domain.EquipmentDetails;
import cn.suntak.ems.equipmentlifecycle.action.EMSCRUD2Action;
import cn.suntak.ems.equipmentlifecycle.domain.EquipmentLifeCycle;
import cn.suntak.ems.renewal.domain.RenewalContract;
import cn.suntak.ems.renewalandcheck.domain.RenewalAndCheck;
import cn.suntak.ems.renewalandcheck.service.RenewalAndCheckService;
import org.apache.struts.action.ActionForm;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Field;
import java.util.*;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class RenewalAndCheckAction extends EMSCRUD2Action<RenewalAndCheck, RenewalAndCheckService>{

	protected void save(HttpServletRequest request, ActionForm form, RenewalAndCheck domain) throws Exception {
		if (domain.getNumber()==null || domain.getNumber().equals("")) {
			String number = this.fileNumberService.doCreateNumber("GZBHYS");
			domain.setNumber(number);
		}
		super.save(request, form, domain);
	}
	protected void afterSaveByAjax(HttpServletRequest request, ActionForm form, RenewalAndCheck domain, cn.oz.json.JSONObject json) throws Exception {
		json.put("lifeCycleId", domain.getEquipmentLifeCycle().getId());
		json.put("number",domain.getNumber());
	}


    @Override
	protected RenewalAndCheck getDomain(HttpServletRequest request, ActionForm form) throws Exception {
		RenewalAndCheck domain = super.getDomain(request,form);
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
			equipmentLifeCycle.setRemark("开始保存改造完工数据，还未同步数据");
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
		equipmentLifeCycle.setRenewalAndCheck(domain);
		domain.setEquipmentLifeCycle(equipmentLifeCycle);
		return domain;
	}


	@Override
	protected void afterCreate(HttpServletRequest request, ActionForm form, RenewalAndCheck domain) throws Exception {
		super.afterCreate(request, form, domain);
		Long equipmentId = RequestUtils.getLongParameter(request, "equipmentId", -1L);
		if (!equipmentId.equals(-1L)) {
			EquipmentDetails equipmentDetails = this.equipmentDetailsService.load(equipmentId);
			Set<EquipmentLifeCycle> elcs = equipmentDetails.getEquipmentLifeCycles();
			if(equipmentDetails.getToPerformContract()!=null){
				domain.setCurrency(equipmentDetails.getToPerformContract().getCurrency());
				domain.setContractNumber(equipmentDetails.getToPerformContract().getContractNo());
				domain.setAddedValue(equipmentDetails.getToPerformContract().getWorth());
				domain.setAgent(equipmentDetails.getToPerformContract().getSupplier());
				domain.setAgentId(equipmentDetails.getToPerformContract().getSupplierId());
				domain.setManufacturer("改造商");
				domain.setStartTime(null);
			}else{
				throw new OzException("不能重复填写改造单");
			}
			domain.setAssetsNumber(1);
			domain.setSerialNumber(equipmentDetails.getEquipmentNo());
			Set<EquipmentDetails> eqs = new HashSet<EquipmentDetails>();
			eqs.add(equipmentDetails);
			request.setAttribute("equipmentNos",this.TranArray(eqs));
		}
	}

	@Override
	protected void renderForm(HttpServletRequest request, ActionForm form, RenewalAndCheck domain, boolean canEdit) throws Exception {
		if (domain.getEquipmentLifeCycle()  != null) {
			request.setAttribute("oaType", domain.getEquipmentLifeCycle().getOaType());
			request.setAttribute("lifeCycleId", domain.getEquipmentLifeCycle().getId());
		}
		if (domain.getFixedAssetsName() != null && domain.getSpecificationModel() != null && domain.getContractNumber() != null && domain.getEquipmentLifeCycle() != null) {
			Set<EquipmentDetails> eqs = domain.getEquipmentLifeCycle().getEquipmentDetails();
			request.setAttribute("equipmentNos", this.TranArray(eqs));
		}
		super.renderForm(request, form, domain, canEdit);
	}

	@Override
	protected void afterSubmitEBS(Long id, String fileName, cn.oz.json.JSONObject json) {
		RenewalAndCheck renewalandcheck = this.getService().load(id);
		String contactNo = renewalandcheck.getContractNumber();
		Set<EquipmentDetails> equipments = renewalandcheck.getEquipmentLifeCycle().getEquipmentDetails();
		for(EquipmentDetails equipment : equipments){
			equipment.setType(2);
			Set<RenewalContract> rcs = equipment.getRenewalContracts();
			for(RenewalContract rc : rcs){
				if(rc.getContractNo().equals(contactNo)){
					rc.setState(2);
				}
			}
			this.equipmentDetailsService.save(equipment);
		}

		super.afterSubmitEBS(id, fileName,json);
	}
}