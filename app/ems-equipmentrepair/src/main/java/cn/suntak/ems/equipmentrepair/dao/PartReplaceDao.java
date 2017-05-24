package cn.suntak.ems.equipmentrepair.dao;



import cn.oz.dao.Page;
import cn.oz.dao.SimpleDao;
import cn.oz.search.SearchQuery;
import cn.suntak.ems.equipmentrepair.domain.PartReplace;

import java.util.Set;

/**
 * 
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public interface PartReplaceDao extends SimpleDao<PartReplace, Long> {
	
	void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long partId, String type);

    Set<PartReplace> loadByPartId(Long partId);

    Set<PartReplace> loadByEquipmentId(Long equipmentId);
}