package cn.suntak.ems.equipmentrepair.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

import cn.oz.service.SimpleService;
import cn.suntak.ems.equipmentrepair.domain.RepairPlanTime;

public interface RepairPlanTimeService extends SimpleService<RepairPlanTime, Long>{

	void delByRuleId(Long planRuleId, int statusWaitValue);

	RepairPlanTime selLastFinishByRuleId(Long planRuleId, int statusFinishValue);

	List<RepairPlanTime> getByYearMonth(String nextMonthStr,String orgId);

	List<RepairPlanTime> getbYear(String year,String orgId);

	boolean isExistByRuleAndYear(Long planRuleId, String year);

	List<RepairPlanTime> getByDateAndStatus(String begindateStr,String enddateStr,int status);
	
	Map<Long, List<RepairPlanTime>> groupByOrg(List<RepairPlanTime> planTimes);


	

}
