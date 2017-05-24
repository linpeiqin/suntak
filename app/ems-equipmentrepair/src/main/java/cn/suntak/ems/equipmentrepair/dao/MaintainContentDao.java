package cn.suntak.ems.equipmentrepair.dao;

import cn.oz.dao.Page;
import cn.oz.dao.SimpleDao;
import cn.oz.search.SearchQuery;
import cn.suntak.ems.equipmentrepair.domain.MaintainContent;

public interface MaintainContentDao extends  SimpleDao <MaintainContent, Long>{
	void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery);

	int delByMaintainId(Long maintainId);

}
