package cn.suntak.ems.equipmentlifecycle.service;

import cn.oz.IdEntity;
import cn.oz.dao.Page;
import cn.oz.search.SearchQuery;
import cn.oz.service.SimpleService;
import cn.suntak.ems.equipmentlifecycle.domain.EquipmentLifeCycle;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public interface EquipmentLifeCycleService extends SimpleService<EquipmentLifeCycle, Long>{

	void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long equipmentId);

	Boolean sendOAExamin(Long lcid,String processId);

	EquipmentLifeCycle loadByProcessId(String processId);

	IdEntity getBeanByProcessIdAndType(String type, String processId);
}
