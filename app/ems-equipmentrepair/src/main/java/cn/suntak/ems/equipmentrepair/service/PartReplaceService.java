package cn.suntak.ems.equipmentrepair.service;

import cn.oz.dao.Page;
import cn.oz.search.SearchQuery;
import cn.oz.service.SimpleService;
import cn.suntak.ems.equipmentrepair.domain.PartReplace;

import java.util.Set;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public interface PartReplaceService extends SimpleService<PartReplace, Long>{

	void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long partId, String e);

    Set<PartReplace> loadByEquipmentId(Long equipmentId);

    Set<PartReplace> loadByPartId(Long partId);
}
