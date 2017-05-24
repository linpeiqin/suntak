package cn.suntak.ems.equipmentlifecycle.service.impl;


import java.lang.reflect.Field;
import java.util.Date;

import cn.oz.IdEntity;
import cn.oz.UserContextHolder;
import cn.oz.config.domain.DataDict;
import cn.oz.config.helper.DataDictHelper;
import cn.oz.dao.Page;
import cn.oz.exception.OzException;
import cn.oz.search.SearchQuery;
import cn.oz.service.CRUDServiceImpl;
import cn.suntak.ems.equipmentlifecycle.dao.EquipmentLifeCycleDao;
import cn.suntak.ems.equipmentlifecycle.domain.EquipmentLifeCycle;
import cn.suntak.ems.equipmentlifecycle.service.EquipmentLifeCycleService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class EquipmentLifeCycleServiceImpl extends CRUDServiceImpl< EquipmentLifeCycle, Long,  EquipmentLifeCycleDao> implements  EquipmentLifeCycleService{

	@Override
	public EquipmentLifeCycle create() throws OzException {
		EquipmentLifeCycle lifeCycle = new EquipmentLifeCycle();
		lifeCycle.setCreatedBy(UserContextHolder.getCurUser().getName());
		lifeCycle.setCreatedDate(new Date());
		return lifeCycle;
	}

	@Override
	public void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long equipmentId) {
		this.getSimpleDao().getPage(page, dbftSearchParams,searchQuery,equipmentId);
	}

	@Override
	public Boolean sendOAExamin(Long lcid, String processId){
		try{
			EquipmentLifeCycle domain = this.load(lcid);
			DataDict data = DataDictHelper.getDataDict( "OASPZT","1");
			String msg = data.getName();
			domain.setRemark(msg);
			domain.setOaType(1);
			domain.setOaDate(new Date());
			domain.setProcessId(processId);
			this.save(domain);
		}catch(Exception ex){
			this.logger.error("更改OA审批状态错误"+ex.getMessage());
			return false;
		}
		return true;
	}

	@Override
	public EquipmentLifeCycle loadByProcessId(String processId) {
		return this.simpleDao.loadByProcessId(processId);
	}

	@Override
	public IdEntity getBeanByProcessIdAndType(String type, String processId) {
		EquipmentLifeCycle lifeCycle = this.simpleDao.loadByProcessId(processId);
		IdEntity idEntity = null;
		try {
			Field field = lifeCycle.getClass().getDeclaredField(type);
			field.setAccessible(true);
			idEntity  = (IdEntity) field.get(lifeCycle);
		} catch (NoSuchFieldException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}
		return idEntity;
	}

}
