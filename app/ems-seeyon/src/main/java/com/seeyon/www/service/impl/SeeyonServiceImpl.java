package com.seeyon.www.service.impl;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import cn.oz.AppContext;
import cn.oz.FileEntity;
import cn.oz.exception.OzException;
import cn.oz.service.CRUDServiceImpl;
import cn.oz.service.SimpleService;
import cn.suntak.ems.equipmentdetails.domain.EquipmentDetails;
import cn.suntak.ems.equipmentlifecycle.domain.EMSEntity;
import cn.suntak.ems.equipmentlifecycle.domain.EquipmentLifeCycle;
import cn.suntak.ems.equipmentlifecycle.service.EquipmentLifeCycleService;

import com.seeyon.www.dao.SeeyonDao;
import com.seeyon.www.domain.Seeyon;
import com.seeyon.www.service.SeeyonService;
import com.seeyon.www.util.AxHelper;
import com.seeyon.www.util.MsgUtils;

public class SeeyonServiceImpl  extends CRUDServiceImpl< Seeyon, Long,  SeeyonDao> implements  SeeyonService{

	private EquipmentLifeCycleService equipmentLifeCycleService;
	
	@Override
	public Seeyon create() throws OzException {
		return null;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map<String,String>  callOaInterface(Long id, String templateCode, String entityName,String formMain) {
		String serviceName = entityName+"Service";
		Map<String,String> map = new HashMap<String,String>();
		try{
			SimpleService service = AppContext.getServiceFactory().getService(serviceName);
			FileEntity entity = (FileEntity) service.load(id);
			EMSEntity emsEntity = (EMSEntity) entity;
			Field field = entity.getClass().getDeclaredField("equipmentLifeCycle");
			field.setAccessible(true);
			EquipmentLifeCycle equipmentLifeCycle = (EquipmentLifeCycle) field.get(entity);
			if(equipmentLifeCycle.getOaType()!=null){
				if(equipmentLifeCycle.getOaType()==1){
					map.put("flag", "e");
					map.put("errorNumber","EMS");
					map.put("errorMessage", "已同步，审批中");
					return map;
				}
				if(equipmentLifeCycle.getOaType()==2){
					map.put("flag", "e");
					map.put("errorNumber","EMS");
					map.put("errorMessage", "审批完成，不能同步");
					return map;
				}
			}
			if(entityName.equals("intoFactoryAndCheck")||entityName.equals("renewalAndCheck")){
				map.put("flag","true");
				equipmentLifeCycle.setOaType(2);
				this.equipmentLifeCycleService.save(equipmentLifeCycle);
				return map;
			}
			String msg = MsgUtils.getMessage(formMain, entity);
			map = AxHelper.callOaInterface(templateCode,msg);
			if(map.get("flag")!=null&&!map.get("flag").equals("e")){
				if(!map.get("processId").equals("-1")){
					this.equipmentLifeCycleService.sendOAExamin(equipmentLifeCycle.getId(),map.get("processId"));
				}
			}

		}catch (Exception e) {
			this.logger.error(e.getMessage());
			map.put("flag","e");
			map.put("msg",e.getMessage());
			e.printStackTrace();
		}
		return map;
	}

	public void setEquipmentLifeCycleService(EquipmentLifeCycleService equipmentLifeCycleService) {
		this.equipmentLifeCycleService = equipmentLifeCycleService;
	}

	public EquipmentLifeCycleService getEquipmentLifeCycleService() {
		return equipmentLifeCycleService;
	}

}
