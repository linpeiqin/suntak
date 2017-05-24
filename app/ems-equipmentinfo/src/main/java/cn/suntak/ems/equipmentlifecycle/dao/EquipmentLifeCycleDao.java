package cn.suntak.ems.equipmentlifecycle.dao;



import cn.oz.dao.Page;
import cn.oz.dao.SimpleDao;
import cn.oz.search.SearchQuery;
import cn.suntak.ems.equipmentlifecycle.domain.EquipmentLifeCycle;

/**
 * 
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public interface EquipmentLifeCycleDao extends SimpleDao<EquipmentLifeCycle, Long> {
	
	void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long equipmentId);

	EquipmentLifeCycle loadByProcessId(String processId);
}