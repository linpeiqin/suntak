//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package cn.suntak.ems.equipmentlifecycle.action;

import java.lang.reflect.Field;
import java.util.Date;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.oz.UserContextHolder;
import cn.suntak.ems.common.service.DepartmentVService;
import cn.suntak.ems.equipmentlifecycle.domain.EBSEntity;
import cn.suntak.ems.equipmentlifecycle.service.EbsViewService;
import cn.suntak.ems.filenumber.service.FileNumberService;
import cn.suntak.ems.intofactory.domain.IntoFactory;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import cn.oz.AppContext;
import cn.oz.FileEntity;
import cn.oz.IdEntity;
import cn.oz.exception.OzException;
import cn.oz.org.json.JSONArray;
import cn.oz.org.json.JSONObject;
import cn.oz.service.SimpleService;
import cn.oz.util.BeanUtils;
import cn.oz.web.util.RequestUtils;
import cn.suntak.ems.common.action.EMSCRUDAction;
import cn.suntak.ems.common.service.EMSCRUD2Service;
import cn.suntak.ems.equipmentdetails.domain.EquipmentDetails;
import cn.suntak.ems.equipmentdetails.service.EquipmentDetailsService;
import cn.suntak.ems.equipmentlifecycle.domain.EMSEntity;
import cn.suntak.ems.equipmentlifecycle.domain.EquipmentLifeCycle;
import cn.suntak.ems.equipmentlifecycle.service.EquipmentLifeCycleService;
import cn.suntak.ems.transdata.service.TransDataService;

public class EMSCRUD2Action<T extends EMSEntity, S extends EMSCRUD2Service<T, Long>> extends EMSCRUDAction<T, S> {
	protected EquipmentDetailsService equipmentDetailsService;
	protected EquipmentLifeCycleService equipmentLifeCycleService;

	private EbsViewService ebsViewService;
	protected FileNumberService fileNumberService;
	protected DepartmentVService departmentVService;

    @Override
    public void initAction() {
        super.initAction();
		this.ebsViewService = this.getServiceBean("ebsViewService");
        this.equipmentDetailsService = this.getServiceBean("equipmentDetailsService");
        this.equipmentLifeCycleService = this.getServiceBean("equipmentLifeCycleService");

		this.fileNumberService = this.getServiceBean("fileNumberService");
		this.departmentVService = this.getServiceBean("departmentVService");
    }
    @Override
    protected T loadDomain(HttpServletRequest request, ActionForm form) throws Exception {
        Long lifeCycleId = RequestUtils.getLongParameter(request,"lifeCycleId",-1L);
        T domain = null;
        if (!lifeCycleId.equals(-1L)){
            domain= this.getService().loadByCycleId(lifeCycleId);
            return domain;
        }
        domain = super.loadDomain(request,form);
        return domain;
    }

	@Override
	protected void renderForm(HttpServletRequest request, ActionForm form, T domain, boolean canEdit) throws Exception {
		super.renderForm(request, form, domain, canEdit);
	}

	protected void afterGetDomain(EquipmentLifeCycle equipmentLifeCycle, T domain, EquipmentDetails equipmentDetails) {
    	Set<EquipmentDetails> equipmentDetailss = equipmentLifeCycle.getEquipmentDetails();
    	for(EquipmentDetails eq:equipmentDetailss){
    		String type = equipmentLifeCycle.getType();
    			Set<EquipmentLifeCycle> lifeSet = eq.getEquipmentLifeCycles();
    			for(EquipmentLifeCycle el:lifeSet){
                    if(el.getId()==equipmentLifeCycle.getId())
                        continue;
    				if(el.getType().equals(type)){
    					throw new OzException(eq.getEquipmentName()+"不能重复"+el.getTypeName());
    				}
    			}
    	}
    }

    
    protected String getFormToolbarBtns(HttpServletRequest request, ActionForm form, T domain, boolean canEdit) {
    	if(domain.getId()==0||domain.getId()==-1){
    		return "";
    	}
    	if(domain instanceof EMSEntity){
    		EMSEntity entity = (EMSEntity)domain;
    		if(entity.getEquipmentLifeCycle().getEbsType()!=null&&entity.getEquipmentLifeCycle().getEbsType()==1){
    			return "1";
    		}
    		return "";
    	}
    	return null;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
    protected void afterSubmitEBS(Long id, String fileName, cn.oz.json.JSONObject json) {
    	String serviceName = fileName+"Service";
    	SimpleService service = AppContext.getServiceFactory().getService(serviceName);
		FileEntity entity = (FileEntity) service.load(id);
		if(entity instanceof EMSEntity){
			Field field = null ;
			try {
				field = entity.getClass().getDeclaredField("equipmentLifeCycle");
				field.setAccessible(true);
				EquipmentLifeCycle equipmentLifeCycle = (EquipmentLifeCycle) field.get(entity);
				equipmentLifeCycle.setEbsDate(new Date());
				equipmentLifeCycle.setEbsType(1);
				this.equipmentLifeCycleService.save(equipmentLifeCycle);
			} catch (NoSuchFieldException e) {
				e.printStackTrace();
			} catch (SecurityException e) {
				e.printStackTrace();
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			}
		}
    	super.afterSubmitEBS(id, fileName,json);
    }

	@Override
	protected void afterCreate(HttpServletRequest request, ActionForm form, T domain) throws Exception {
		Long equipmentId = RequestUtils.getLongParameter(request, "equipmentId", -1L);
		EquipmentDetails equipmentDetails = this.equipmentDetailsService.load(equipmentId);
		if(equipmentDetails.getEbsEntity()==null){
			return;
		}
		EBSEntity ebsEntity = equipmentDetails.getEbsEntity();

		domain.setCanUseLife(ebsEntity.getCanUseLife());
		domain.setUsefulLife(ebsEntity.getUsefulLife());
		domain.setOriginalValue(ebsEntity.getOriginalValue());
		domain.setNetWorth(ebsEntity.getNetWorth());
		domain.setCost(ebsEntity.getCost());
		//2017年5月12日 11:46:05
		domain.setFixedAssetsName(equipmentDetails.getEquipmentName());
		domain.setSpecificationModel(ebsEntity.getSpecificationModel());
		domain.setFixedAssetsType(ebsEntity.getFixedAssetsType());
		domain.setSerialNumber(ebsEntity.getSerialNumber());
		domain.setAscriptionMDebs(ebsEntity.getManagerDId());
		domain.setUseDebs(ebsEntity.getUserDId());
		domain.setManufacturer(ebsEntity.getManufacturerName());
		domain.setInstallationLocation(ebsEntity.getInstallSite());
		domain.setStartTime(ebsEntity.getStartTime());
		domain.setContractNumber(equipmentDetails.getContractNo());
		//lifeCycle
		EMSEntity emsEntity = equipmentDetails.getLifeCycle("intoFactory","intoFactoryAndCheck","internalTransfer","renewal","renewalAndCheck");
		if(emsEntity!=null){
			domain.setAgent(emsEntity.getAgent());
			domain.setAgentId(emsEntity.getAgentId());
			domain.setAscriptionMD(emsEntity.getAscriptionMD());
			domain.setAscriptionMDname(emsEntity.getAscriptionMDname());
			domain.setUseD(emsEntity.getUseD());
			domain.setUseDname(emsEntity.getUseDname());
			domain.setIsImported(emsEntity.getIsImported());
			domain.setIsDevelop(emsEntity.getIsDevelop());
		}
		super.afterCreate(request, form, domain);
	}

	public EbsViewService getEbsViewService() {
		return ebsViewService;
	}

	public void setEbsViewService(EbsViewService ebsViewService) {
		this.ebsViewService = ebsViewService;
	}

	protected cn.oz.json.JSONArray TranArray(Set<EquipmentDetails> list) {
		cn.oz.json.JSONArray array = new cn.oz.json.JSONArray();
		if (list != null && list.size() > 0) {
			for (EquipmentDetails ed : list) {
				cn.oz.json.JSONObject json = new cn.oz.json.JSONObject();
				json.put("contractNumber", ed.getContractNo());
				json.put("id", ed.getId());
				json.put("equipmentName", ed.getEquipmentName());
				json.put("equipmentNo", ed.getEquipmentNo());
				json.put("specificationModel", ed.getSpecificationModel());
				json.put("parentName", ed.getParentName());
				json.put("parentId", ed.getParentId());
				array.add(json);
			}
		}
		return array;
	}
	protected void copyProperties(Object source, Object target, String[] fields) throws NoSuchFieldException, IllegalAccessException {
		if(fields!=null&&fields.length>0){
			for(String fieldName:fields){
				Field fieldSource = source.getClass().getDeclaredField(fieldName);
				fieldSource.setAccessible(true);
				Field fieldTarget = target.getClass().getDeclaredField(fieldName);
				fieldTarget.setAccessible(true);
				if(fieldSource!=null&&fieldTarget!=null){
					fieldTarget.set(target,fieldSource.get(source));
				}
			}
		}
	}
}
