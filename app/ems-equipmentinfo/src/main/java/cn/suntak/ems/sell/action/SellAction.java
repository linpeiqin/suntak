package cn.suntak.ems.sell.action;


import cn.oz.UserContextHolder;
import cn.oz.util.SelectOption;
import cn.suntak.ems.common.service.DepartmentVService;
import cn.suntak.ems.equipmentdetails.domain.EquipmentDetails;
import cn.suntak.ems.equipmentlifecycle.action.EMSCRUD2Action;
import cn.suntak.ems.equipmentlifecycle.domain.EquipmentLifeCycle;
import cn.suntak.ems.filenumber.service.FileNumberService;
import cn.suntak.ems.intofactory.domain.IntoFactory;
import cn.suntak.ems.renewal.domain.Renewal;
import cn.suntak.ems.sell.domain.Sell;
import cn.suntak.ems.sell.service.SellService;
import org.apache.struts.action.ActionForm;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class SellAction extends EMSCRUD2Action<Sell, SellService>{
	private FileNumberService fileNumberService;
	private DepartmentVService departmentVService;
	@Override
	public void initAction() {
		super.initAction();
		this.fileNumberService = this.getServiceBean("fileNumberService");
		this.departmentVService = this.getServiceBean("departmentVService");
	}
	protected void save(HttpServletRequest request, ActionForm form, Sell domain) throws Exception {
		if (domain.getNumber()==null || domain.getNumber().equals("")) {
			String number = this.fileNumberService.doCreateNumber("RCBH");
			domain.setNumber(number);
		}
		setEbsDep(domain);
		super.save(request, form, domain);
	}
	protected void afterSaveByAjax(HttpServletRequest request, ActionForm form, Sell domain, cn.oz.json.JSONObject json) throws Exception {
		json.put("number",domain.getNumber());
		json.put("lifeCycleId", domain.getEquipmentLifeCycle().getId());
	}
	 protected void afterGetDomain(EquipmentLifeCycle equipmentLifeCycle, Sell domain, EquipmentDetails equipmentDetails) {
	        super.afterGetDomain(equipmentLifeCycle,domain,equipmentDetails);
	        equipmentLifeCycle.setRemark("开始保存出售数据，还未同步数据");
	        equipmentLifeCycle.setType(domain.getType());
		    equipmentLifeCycle.setOrganizationId(Long.valueOf(UserContextHolder.getCurUserInfo().getUnit().getCode()));
		    domain.setOrganizationId(Long.valueOf(UserContextHolder.getCurUserInfo().getUnit().getCode()));
	        domain.setEquipmentLifeCycle(equipmentLifeCycle);
	    }
	private void setEbsDep(Sell domain){
		List<SelectOption> list = this.departmentVService.getDepartmentOption();
		if(domain.getUseDname()!=null){
			String userDname = domain.getUseDname();
			boolean flag = true;
			for(SelectOption item :list){
				if(userDname.equals(item.getName())){
					domain.setUseDebs(item.getValue());
					flag = false;
					break;
				}
			}
			if(flag){
				domain.setUseDebs("0");
			}
		}
		if(domain.getAscriptionMDname()!=null){
			String ascriptionMDname = domain.getAscriptionMDname();
			boolean flag = true;
			for(SelectOption item :list){
				if(ascriptionMDname.equals(item.getName())){
					domain.setAscriptionMDebs(item.getValue());
					break;
				}
			}
			if(flag){
				domain.setAscriptionMDebs("0");
			}
		}
	}
}