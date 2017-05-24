package cn.suntak.ems.equipmentrepair.service.impl;



import cn.oz.dao.Page;
import cn.oz.exception.OzException;
import cn.oz.search.SearchQuery;
import cn.oz.service.CRUDServiceImpl;
import cn.suntak.ems.equipmentrepair.dao.PartReplaceDao;
import cn.suntak.ems.equipmentrepair.domain.PartReplace;
import cn.suntak.ems.equipmentrepair.service.PartReplaceService;

import java.util.Set;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class PartReplaceServiceImpl extends CRUDServiceImpl< PartReplace, Long,  PartReplaceDao> implements  PartReplaceService{

	@Override
	public PartReplace create() throws OzException {
		
		return new PartReplace();
	}


	@Override
	public void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long partId,String type) {
		this.getSimpleDao().getPage(page,dbftSearchParams,searchQuery,partId,type);
	}

	@Override
	public Set<PartReplace> loadByEquipmentId(Long equipmentId) {
		return this.getSimpleDao().loadByEquipmentId(equipmentId);
	}

	@Override
	public Set<PartReplace> loadByPartId(Long partId) {
		return this.getSimpleDao().loadByPartId(partId);
	}

}
