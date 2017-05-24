package cn.suntak.ems.equipmentrepair.service;

import cn.oz.dao.Page;
import cn.oz.search.SearchQuery;
import cn.oz.service.SimpleService;
import cn.suntak.ems.equipmentrepair.domain.RepairYearPlan;

public interface RepairYearPlanService  extends SimpleService<RepairYearPlan, Long>{

	RepairYearPlan loadByYear(String year,String orgId);

	RepairYearPlan grabPlanByYear(String year,String orgId);

	void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery);

}
