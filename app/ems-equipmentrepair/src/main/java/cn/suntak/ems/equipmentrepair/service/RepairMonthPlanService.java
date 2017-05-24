package cn.suntak.ems.equipmentrepair.service;

import cn.oz.dao.Page;
import cn.oz.search.SearchQuery;
import cn.oz.service.SimpleService;
import cn.suntak.ems.equipmentrepair.domain.RepairMonthPlan;

public interface RepairMonthPlanService extends SimpleService<RepairMonthPlan, Long>{

	void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery);

	void grabPlanByMonth(String monthStr, String orgId);
	
	RepairMonthPlan loadByMonth(String monthStr, String orgId);

}
