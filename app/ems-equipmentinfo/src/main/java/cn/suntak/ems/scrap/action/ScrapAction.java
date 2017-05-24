package cn.suntak.ems.scrap.action;


import cn.oz.UserContextHolder;
import cn.oz.exception.OzException;
import cn.oz.org.json.JSONArray;
import cn.oz.org.json.JSONObject;
import cn.oz.util.SelectOption;
import cn.oz.web.util.RequestUtils;
import cn.suntak.ems.common.service.DepartmentVService;
import cn.suntak.ems.equipmentdetails.domain.EquipmentDetails;
import cn.suntak.ems.equipmentdetails.service.EquipmentDetailsService;
import cn.suntak.ems.equipmentlifecycle.action.EMSCRUD2Action;
import cn.suntak.ems.equipmentlifecycle.domain.EquipmentLifeCycle;
import cn.suntak.ems.equipmentlifecycle.service.EquipmentLifeCycleService;


import cn.suntak.ems.filenumber.service.FileNumberService;
import cn.suntak.ems.intofactory.domain.IntoFactory;
import cn.suntak.ems.intofactorycheck.domain.IntoFactoryCheck;

import cn.suntak.ems.renewal.domain.Renewal;
import cn.suntak.ems.renewal.domain.RenewalContract;
import cn.suntak.ems.renewalcheck.domain.RenewalCheck;
import cn.suntak.ems.scrap.domain.Scrap;
import cn.suntak.ems.scrap.service.ScrapService;
import org.apache.struts.action.ActionForm;

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
public class ScrapAction extends EMSCRUD2Action<Scrap, ScrapService> {


	private EquipmentDetailsService equipmentDetailsService;
	private EquipmentLifeCycleService equipmentLifeCycleService;
	private FileNumberService fileNumberService;
	private DepartmentVService departmentVService;
	@Override
	public void initAction() {
		super.initAction();
		this.equipmentDetailsService = this.getServiceBean("equipmentDetailsService");
		this.equipmentLifeCycleService = this.getServiceBean("equipmentLifeCycleService");
		this.fileNumberService = this.getServiceBean("fileNumberService");
		this.departmentVService = this.getServiceBean("departmentVService");
	}


	protected void afterGetDomain(EquipmentLifeCycle equipmentLifeCycle, Scrap domain, EquipmentDetails equipmentDetails) {
		super.afterGetDomain(equipmentLifeCycle, domain, equipmentDetails);
		equipmentLifeCycle.setRemark("开始保存报废数据，还未同步数据");
		equipmentLifeCycle.setType(domain.getType());
		equipmentLifeCycle.setOrganizationId(Long.valueOf(UserContextHolder.getCurUserInfo().getUnit().getCode()));
		domain.setOrganizationId(Long.valueOf(UserContextHolder.getCurUserInfo().getUnit().getCode()));
		domain.setEquipmentLifeCycle(equipmentLifeCycle);
	}


	protected void save(HttpServletRequest request, ActionForm form, Scrap domain) throws Exception {
		if (domain.getNumber()==null || domain.getNumber().equals("")) {
			String number = this.fileNumberService.doCreateNumber("BFBH");
			domain.setNumber(number);
		}
		super.save(request, form, domain);
	}
	protected void afterSaveByAjax(HttpServletRequest request, ActionForm form, Scrap domain, cn.oz.json.JSONObject json) throws Exception {
		json.put("number",domain.getNumber());
		json.put("lifeCycleId", domain.getEquipmentLifeCycle().getId());
	}

	@Override
	protected void renderForm(HttpServletRequest request, ActionForm form, Scrap domain, boolean canEdit) throws Exception {
		if (domain.getEquipmentLifeCycle() != null) {
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
	protected Scrap getDomain(HttpServletRequest request, ActionForm form) throws Exception {
		Scrap domain = super.getDomain(request, form);
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
			equipmentLifeCycle.setRemark("开始保存报废数据，还未同步数据");
			equipmentLifeCycle.setType(domain.getType());
			equipmentLifeCycle.setOrganizationId(Long.valueOf(UserContextHolder.getCurUserInfo().getUnit().getCode()));
			domain.setOrganizationId(Long.valueOf(UserContextHolder.getCurUserInfo().getUnit().getCode()));
		} else {
			equipmentLifeCycle = domain.getEquipmentLifeCycle();
			equipmentLifeCycle.getEquipmentDetails().clear();
		}
		for (int i = 0; i < equipmentList.length(); i++) {
			JSONObject obj = equipmentList.getJSONObject(i);
			JSONArray names = obj.names();
			EquipmentDetails equipmentDetails = null;
			Long equipmentId = null;
			String equipmentNo = null;
			//找到设备的id与设备的编号
			for (int j = 0; j < names.length(); j++) {
				String name = names.get(j).toString();
				if (name.equals("id")) {
					equipmentId = Long.valueOf(obj.get(names.get(j).toString()).toString());
				}
				if (name.equals("equipmentNo")) {
					equipmentNo = obj.get(names.get(j).toString()).toString();
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
		equipmentLifeCycle.setScrap(domain);
		domain.setEquipmentLifeCycle(equipmentLifeCycle);
		return domain;
	}

	@Override
	protected void afterCreate(HttpServletRequest request, ActionForm form, Scrap domain) throws Exception {
		super.afterCreate(request, form, domain);
		Long equipmentId = RequestUtils.getLongParameter(request, "equipmentId", -1L);
		if (!equipmentId.equals(-1L)) {
			EquipmentDetails equipmentDetails = this.equipmentDetailsService.load(equipmentId);
			if(equipmentDetails.containLifeCycle("scrap")){
				throw new OzException("不能重复填写报废单");
			}
			Set<EquipmentLifeCycle> elcs = equipmentDetails.getEquipmentLifeCycles();
			for (EquipmentLifeCycle elc : elcs){
				if(elc.getIntoFactory()!=null){
					domain.setFaTechnicalIndex(elc.getIntoFactory().getZCYLJSZB());
					domain.setOrigin(elc.getIntoFactory().getOrigin());
					break;
				}else if(elc.getIntoFactoryAndCheck()!=null){
					domain.setFaTechnicalIndex(elc.getIntoFactoryAndCheck().getZCYLJSZB());
					domain.setOrigin(elc.getIntoFactoryAndCheck().getOrigin());
					break;
				}
			}
			domain.setNetWorth(domain.getCost());
			domain.setAssetsNumber(1);
			domain.setSerialNumber(equipmentDetails.getEquipmentNo());
			Set<EquipmentDetails> eqs = new HashSet<EquipmentDetails>();
			eqs.add(equipmentDetails);
			request.setAttribute("equipmentNos",this.TranArray(eqs));
		}

	}

	@Override
	protected void afterSubmitEBS(Long id, String fileName, cn.oz.json.JSONObject json) {
		Scrap renewal = this.getService().load(id);
		Set<EquipmentDetails> eqs = renewal.getEquipmentLifeCycle().getEquipmentDetails();
		for(EquipmentDetails eq : eqs) {
			eq.setType(3);
			this.equipmentDetailsService.save(eq);
		}
		super.afterSubmitEBS(id, fileName, json);
	}
}