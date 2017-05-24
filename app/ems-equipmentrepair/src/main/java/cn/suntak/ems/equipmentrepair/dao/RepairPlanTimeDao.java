package cn.suntak.ems.equipmentrepair.dao;

import java.util.List;

import cn.oz.dao.SimpleDao;
import cn.suntak.ems.equipmentrepair.domain.RepairPlanTime;

public interface RepairPlanTimeDao extends SimpleDao<RepairPlanTime, Long>{

	void delByRuleId(Long planRuleId, int statusWaitValue);

	RepairPlanTime selLastFinishByRuleId(Long planRuleId, int statusFinishValue);

	List<RepairPlanTime> getByYearMonth(String yearMonthStr,String orgId);

	List<RepairPlanTime> getbYear(String year,String orgId);

	boolean isExistByRuleAndYear(Long planRuleId, String year);

	List<RepairPlanTime> getByDateAndStatus(String begindateStr,String enddateStr,int status);

}
