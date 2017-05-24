package cn.suntak.ems.equipmentrepair.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import cn.oz.AppContext;
import cn.oz.UserContextHolder;
import cn.oz.config.helper.DataDictHelper;
import cn.oz.dao.Page;
import cn.oz.exception.OzException;
import cn.oz.search.SearchQuery;
import cn.oz.service.CRUDServiceImpl;
import cn.oz.util.SelectOption;
import cn.suntak.ems.equipmentrepair.dao.MaintainDao;
import cn.suntak.ems.equipmentrepair.domain.Maintain;
import cn.suntak.ems.equipmentrepair.domain.RepairPlan;
import cn.suntak.ems.equipmentrepair.domain.RepairPlanRule;
import cn.suntak.ems.equipmentrepair.domain.RepairPlanTime;
import cn.suntak.ems.equipmentrepair.service.MaintainService;
import cn.suntak.ems.equipmentrepair.service.RepairPlanTimeService;

public class MaintainServiceImpl extends CRUDServiceImpl< Maintain, Long,  MaintainDao> implements  MaintainService{

	@Override
	public Maintain create() throws OzException {
		// TODO Auto-generated method stub
		Maintain maintain = new Maintain();
//		maintain.setExecutDate(new Date());
		return maintain;
	}

	@Override
	public List<SelectOption> getMaintenaceLevel() {
		// TODO Auto-generated method stub
		List<SelectOption> selectOptions = new ArrayList<SelectOption>();
		SelectOption[] dict = DataDictHelper.getOptions("BYJB", null, true, true);
		for(int i=0;i<dict.length;i++)
		{
			selectOptions.add(dict[i]);
		}
		return selectOptions;
	}

	@Override
	public void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long equipmentId,String classify) {
		this.getSimpleDao().getPage(page,dbftSearchParams,searchQuery,equipmentId,classify);
	}

	@Override
	public void getSViewPage(Page page, Long equipmentId) {
		this.simpleDao.getSViewPage(page,equipmentId);
	}

	@Override
	public Integer findDateScapNum(String by, String maintain) {
		return this.simpleDao.findDateScapNum(by, maintain);
	}

	@Override
	public void pushMaintainByDate(String begindateStr,String enddateStr) {
		// TODO Auto-generated method stub
		RepairPlanTimeService repairPlanTimeService = AppContext.getServiceFactory().getService("repairPlanTimeService");
		List<RepairPlanTime> repairPlanTimes = repairPlanTimeService.getByDateAndStatus(begindateStr,enddateStr,RepairPlanTime.STATUS_WAIT_VALUE);
		RepairPlan plan = null;
		RepairPlanRule planRule = null;
		if(repairPlanTimes != null && !repairPlanTimes.isEmpty()){
			for(RepairPlanTime planTime : repairPlanTimes){
				if(planTime != null){
					boolean isExt = this.isExistByRepairTimeId(planTime.getId());
					if(isExt)
						continue;
					planRule = planTime.getRepairPlanRule();
					if(planRule != null){
						plan = planRule.getRepairPlan();
						if(plan == null){
							continue;
						}
					}else{
						continue;
					}
				}else{
					continue;
				}
				Maintain maintain = new Maintain();
				maintain.setMaintainLevel(planRule.getMaintenaceLevel());
				maintain.setEquipmentDetails(plan.getEquipmentDetails());
				maintain.setOrganizationId(plan.getOrganizationId());
				maintain.setRepairTimeId(planTime.getId());
				maintain.setPlanDate(planTime.getActualDate());
				maintain.setStatus(Maintain.STATUS_WAIT_VALUE);
				this.save(maintain);
			}
		}
	}

	private boolean isExistByRepairTimeId(Long repairTimeId) {
		// TODO Auto-generated method stub
		return this.getSimpleDao().isExistByRepairTimeId(repairTimeId);
	}


}
