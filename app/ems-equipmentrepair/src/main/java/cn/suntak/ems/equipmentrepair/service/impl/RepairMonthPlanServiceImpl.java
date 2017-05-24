package cn.suntak.ems.equipmentrepair.service.impl;

import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import cn.oz.AppContext;
import cn.oz.dao.Page;
import cn.oz.exception.OzException;
import cn.oz.search.SearchQuery;
import cn.oz.service.CRUDServiceImpl;
import cn.oz.util.StringUtils;
import cn.suntak.ems.equipmentrepair.dao.RepairMonthPlanDao;
import cn.suntak.ems.equipmentrepair.domain.MonthPlanDetail;
import cn.suntak.ems.equipmentrepair.domain.RepairMonthPlan;
import cn.suntak.ems.equipmentrepair.domain.RepairPlan;
import cn.suntak.ems.equipmentrepair.domain.RepairPlanRule;
import cn.suntak.ems.equipmentrepair.domain.RepairPlanTime;
import cn.suntak.ems.equipmentrepair.domain.RepairYearPlan;
import cn.suntak.ems.equipmentrepair.service.MonthPlanDetailService;
import cn.suntak.ems.equipmentrepair.service.RepairMonthPlanService;
import cn.suntak.ems.equipmentrepair.service.RepairPlanTimeService;

public class RepairMonthPlanServiceImpl extends CRUDServiceImpl< RepairMonthPlan, Long,  RepairMonthPlanDao> implements RepairMonthPlanService{

	@Override
	public RepairMonthPlan create() throws OzException {
		// TODO Auto-generated method stub
		return new RepairMonthPlan();
	}

	@Override
	public void getPage(Page page, String dbftSearchParams,
			SearchQuery searchQuery) {
		// TODO Auto-generated method stub
		this.simpleDao.getPage(page, dbftSearchParams, searchQuery);
	}
	
	

	@Override
	public void grabPlanByMonth(String monthStr, String orgId) {
		// TODO Auto-generated method stub
		RepairPlanTimeService repairPlanTimeService = AppContext.getServiceFactory().getService("repairPlanTimeService");
		MonthPlanDetailService monthPlanDetailService = AppContext.getServiceFactory().getService("monthPlanDetailService");
		List<RepairPlanTime> planTimes = repairPlanTimeService.getByYearMonth(monthStr,orgId);
		RepairMonthPlan repairMonthPlan = null;
		if(planTimes != null && !planTimes.isEmpty()){
			if(!StringUtils.isNullString(orgId)){
				repairMonthPlan = loadByMonth(monthStr,orgId);
				 if(repairMonthPlan != null){
					 monthPlanDetailService.delByPlanId(repairMonthPlan.getId());
				}else{
					repairMonthPlan = new RepairMonthPlan();
					repairMonthPlan.setOrganizationId(Long.valueOf(orgId));
				}
				 repairMonthPlan.setPlanMonth(monthStr);
				 repairMonthPlan.setPlanTime(new Date());
				 repairMonthPlan.setStatus(RepairMonthPlan.STATUS_DEF);
				 repairMonthPlan.setMonthPlanDetails(initMonthPlanDetails(planTimes,repairMonthPlan));
				 this.save(repairMonthPlan);
			}else{
				Map<Long, List<RepairPlanTime>> groupByOrg = repairPlanTimeService.groupByOrg(planTimes);
				if(groupByOrg != null && !groupByOrg.isEmpty()){
					Iterator<Entry<Long, List<RepairPlanTime>>> it = groupByOrg.entrySet().iterator();
					while (it.hasNext()) {
						Map.Entry<Long, List<RepairPlanTime>> entry = it.next();
						Long org = entry.getKey();
						List<RepairPlanTime> times = entry.getValue();
						repairMonthPlan = loadByMonth(monthStr,org+"");
						 if(repairMonthPlan != null){
							 monthPlanDetailService.delByPlanId(repairMonthPlan.getId());
						}else{
							repairMonthPlan = new RepairMonthPlan();
							repairMonthPlan.setOrganizationId(Long.valueOf(org));
						}
						 repairMonthPlan.setPlanMonth(monthStr);
						 repairMonthPlan.setPlanTime(new Date());
						 repairMonthPlan.setStatus(RepairMonthPlan.STATUS_DEF);
						 repairMonthPlan.setMonthPlanDetails(initMonthPlanDetails(times,repairMonthPlan));
						 this.save(repairMonthPlan);
					}

				}
			}
		}
	}
	
	public Set<MonthPlanDetail> initMonthPlanDetails(List<RepairPlanTime> times,RepairMonthPlan repairMonthPlan){
		Set<MonthPlanDetail> details = new HashSet<MonthPlanDetail>();
		if(times != null && !times.isEmpty()){
			for(RepairPlanTime rpt : times){
				if(rpt != null){
					MonthPlanDetail bean = new MonthPlanDetail();
					bean.setRepairMonthPlan(repairMonthPlan);
					bean.setMaintenaceDate(rpt.getPlanDate());
					bean.setMaintenaceDay(rpt.getPlanDate().getDate());
					bean.setFactMaintenaceDate(rpt.getActualDate());
					bean.setFactMaintenaceDay(rpt.getActualDate().getDate());
					RepairPlanRule rpr = rpt.getRepairPlanRule();
					if(rpr != null){
						bean.setMaintenaceLevel(rpr.getMaintenaceLevel());
						RepairPlan plan = rpr.getRepairPlan();
						if(plan != null && plan.getEquipmentDetails() != null){
							bean.setEquipmentId(plan.getEquipmentDetails().getId());
							bean.setEquipmentName(plan.getEquipmentDetails().getEquipmentName());
							bean.setEquipmentNo(plan.getEquipmentDetails().getEquipmentNo());
							bean.setProcedure(plan.getEquipmentDetails().getProcedure());
						}
					}
					details.add(bean);
				}
			}
		}
		return details;
	}

	@Override
	public RepairMonthPlan loadByMonth(String monthStr, String orgId) {
		return this.getSimpleDao().loadByMonth(monthStr,orgId);
	}

}
