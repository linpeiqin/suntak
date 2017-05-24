package cn.suntak.ems.equipmentrepair.dao;

import cn.oz.dao.Page;
import cn.oz.dao.SimpleDao;
import cn.oz.search.SearchQuery;
import cn.suntak.ems.equipmentrepair.domain.RepairMonthPlan;

public interface RepairMonthPlanDao extends SimpleDao<RepairMonthPlan, Long>{

	void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery);

	RepairMonthPlan loadByMonth(String monthStr, String orgId);
}
