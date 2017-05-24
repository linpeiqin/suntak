package cn.suntak.ems.equipmentrepair.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import cn.oz.exception.OzException;
import cn.oz.service.CRUDServiceImpl;
import cn.oz.util.StringUtils;
import cn.suntak.ems.equipmentrepair.dao.RepairPlanTimeDao;
import cn.suntak.ems.equipmentrepair.domain.RepairPlan;
import cn.suntak.ems.equipmentrepair.domain.RepairPlanRule;
import cn.suntak.ems.equipmentrepair.domain.RepairPlanTime;
import cn.suntak.ems.equipmentrepair.service.RepairPlanTimeService;

public class RepairPlanTimeServiceImpl extends CRUDServiceImpl< RepairPlanTime, Long,  RepairPlanTimeDao> implements  RepairPlanTimeService{

	@Override
	public RepairPlanTime create() throws OzException {
		// TODO Auto-generated method stub
		return new RepairPlanTime();
	}

	@Override
	public void delByRuleId(Long planRuleId, int statusWaitValue) {
		// TODO Auto-generated method stub
		this.getSimpleDao().delByRuleId(planRuleId,statusWaitValue);
	}

	@Override
	public RepairPlanTime selLastFinishByRuleId(Long planRuleId,
			int statusFinishValue) {
		// TODO Auto-generated method stub
		return this.getSimpleDao().selLastFinishByRuleId(planRuleId,statusFinishValue);
	}

	@Override
	public List<RepairPlanTime> getByYearMonth(String yearMonthStr,String orgId) {
		// TODO Auto-generated method stub
		return this.getSimpleDao().getByYearMonth(yearMonthStr,orgId);
	}

	@Override
	public List<RepairPlanTime> getbYear(String year,String orgId) {
		// TODO Auto-generated method stub
		return this.getSimpleDao().getbYear(year,orgId);
	}

	@Override
	public boolean isExistByRuleAndYear(Long planRuleId, String year) {
		// TODO Auto-generated method stub
		return this.getSimpleDao().isExistByRuleAndYear(planRuleId,year);
	}

	@Override
	public List<RepairPlanTime> getByDateAndStatus(String begindateStr,String enddateStr,int status) {
		// TODO Auto-generated method stub
		return this.getSimpleDao().getByDateAndStatus(begindateStr,enddateStr,status);
	}
	
	@Override
	public Map<Long, List<RepairPlanTime>> groupByOrg(
			List<RepairPlanTime> planTimes) {
		// TODO Auto-generated method stub
		Long orgId = null;
		Map<Long, List<RepairPlanTime>> map = new HashMap<Long, List<RepairPlanTime>>();
		for(RepairPlanTime rpt : planTimes){
			if(rpt != null){
				orgId = rpt.getOrganizationId();
				if(orgId == null)
					continue;
			}else{
				continue;
			}
			List<RepairPlanTime> orgList = map.get(orgId);
			if(orgList == null)
				orgList = new ArrayList<RepairPlanTime>();
			orgList.add(rpt);
			map.put(orgId, orgList);
		}
		return map;
	}

}
