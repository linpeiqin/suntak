package cn.suntak.ems.equipmentrepair.service.impl;

import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import cn.oz.dao.Page;
import cn.oz.exception.OzException;
import cn.oz.search.SearchQuery;
import cn.oz.service.CRUDServiceImpl;
import cn.oz.util.StringUtils;
import cn.suntak.ems.equipmentrepair.dao.RepairYearPlanDao;
import cn.suntak.ems.equipmentrepair.domain.RepairPlan;
import cn.suntak.ems.equipmentrepair.domain.RepairPlanRule;
import cn.suntak.ems.equipmentrepair.domain.RepairPlanTime;
import cn.suntak.ems.equipmentrepair.domain.RepairYearPlan;
import cn.suntak.ems.equipmentrepair.domain.YearPlanDetail;
import cn.suntak.ems.equipmentrepair.service.RepairPlanTimeService;
import cn.suntak.ems.equipmentrepair.service.RepairYearPlanService;
import cn.suntak.ems.equipmentrepair.service.YearPlanDetailService;

public class RepairYearPlanServiceImpl extends CRUDServiceImpl< RepairYearPlan, Long,  RepairYearPlanDao> implements RepairYearPlanService{

	private RepairPlanTimeService repairPlanTimeService;
	private YearPlanDetailService yearPlanDetailService;
	
	
	public void setRepairPlanTimeService(RepairPlanTimeService repairPlanTimeService) {
		this.repairPlanTimeService = repairPlanTimeService;
	}
	
	

	public void setYearPlanDetailService(YearPlanDetailService yearPlanDetailService) {
		this.yearPlanDetailService = yearPlanDetailService;
	}



	@Override
	public RepairYearPlan create() throws OzException {
		// TODO Auto-generated method stub
		return new RepairYearPlan();
	}

	@Override
	public RepairYearPlan loadByYear(String year,String orgId) {
		// TODO Auto-generated method stub
		return this.getSimpleDao().loadByYear(year,orgId);
	}

	@Override
	public RepairYearPlan grabPlanByYear(String year,String orgId) {
		// TODO Auto-generated method stub
		List<RepairPlanTime> planTimes = repairPlanTimeService.getbYear(year,orgId);
		RepairYearPlan yearPlan = null;
		if(planTimes != null && !planTimes.isEmpty()){
			if(!StringUtils.isNullString(orgId)){
				 yearPlan = loadByYear(year,orgId);
				 if(yearPlan != null){
					yearPlanDetailService.delByPlanId(yearPlan.getId());
				}else{
					yearPlan = new RepairYearPlan();
					yearPlan.setOrganizationId(Long.valueOf(orgId));
				}
				yearPlan.setPlanYear(year);
				yearPlan.setPlanTime(new Date());
				yearPlan.setStatus(RepairYearPlan.STATUS_DEF);
				yearPlan.setYearPlanDetails(initYearPlanDetails(planTimes,yearPlan));
				this.save(yearPlan);
			}else{
				Map<Long, List<RepairPlanTime>> groupByOrg = repairPlanTimeService.groupByOrg(planTimes);
				if(groupByOrg != null && !groupByOrg.isEmpty()){
					Iterator<Entry<Long, List<RepairPlanTime>>> it = groupByOrg.entrySet().iterator();
					while (it.hasNext()) {
						Map.Entry<Long, List<RepairPlanTime>> entry = it.next();
						Long org = entry.getKey();
						List<RepairPlanTime> times = entry.getValue();
						yearPlan = loadByYear(year,org+"");
						 if(yearPlan != null){
							yearPlanDetailService.delByPlanId(yearPlan.getId());
						}else{
							yearPlan = new RepairYearPlan();
							yearPlan.setOrganizationId(Long.valueOf(org));
						}
						yearPlan.setPlanYear(year);
						yearPlan.setPlanTime(new Date());
						yearPlan.setStatus(RepairYearPlan.STATUS_DEF);
						yearPlan.setYearPlanDetails(initYearPlanDetails(times,yearPlan));
						this.save(yearPlan);
					}

				}
			}
			
			
		}
		return null;
	}
	
	public Set<YearPlanDetail> initYearPlanDetails(List<RepairPlanTime> planTimes,RepairYearPlan repairYearPlan){
		Set<YearPlanDetail> details = null;
		if(planTimes != null && !planTimes.isEmpty()){
			details = new HashSet<YearPlanDetail>();
			for(RepairPlanTime rpt : planTimes){
				YearPlanDetail yearPlanDetail = new YearPlanDetail();
				yearPlanDetail.setRepairYearPlan(repairYearPlan);
				yearPlanDetail.setMaintenaceMonth(rpt.getPlanDate().getMonth()+1);
				RepairPlanRule rpr = rpt.getRepairPlanRule();
				if(rpr != null){
					yearPlanDetail.setMaintenaceLevel(rpr.getMaintenaceLevel());
					RepairPlan plan = rpr.getRepairPlan();
					if(plan != null && plan.getEquipmentDetails() != null){
						yearPlanDetail.setEquipmentId(plan.getEquipmentDetails().getId());
						yearPlanDetail.setEquipmentName(plan.getEquipmentDetails().getEquipmentName());
						yearPlanDetail.setEquipmentNo(plan.getEquipmentDetails().getEquipmentNo());
						yearPlanDetail.setProcedure(plan.getEquipmentDetails().getProcedure());
					}
				}
				details.add(yearPlanDetail);
			}
		}
		return details;
	}



	@Override
	public void getPage(Page page, String dbftSearchParams,
			SearchQuery searchQuery) {
		// TODO Auto-generated method stub
		this.simpleDao.getPage(page, dbftSearchParams, searchQuery);
	}

}
