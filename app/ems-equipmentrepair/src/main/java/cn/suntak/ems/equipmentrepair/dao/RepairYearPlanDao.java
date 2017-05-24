package cn.suntak.ems.equipmentrepair.dao;

import cn.oz.dao.Page;
import cn.oz.dao.SimpleDao;
import cn.oz.search.SearchQuery;
import cn.suntak.ems.equipmentrepair.domain.RepairYearPlan;

public interface RepairYearPlanDao extends SimpleDao<RepairYearPlan, Long>{

	RepairYearPlan loadByYear(String year,String orgId);

	void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery);

}
