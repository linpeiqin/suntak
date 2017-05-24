package cn.suntak.ems.equipmentrepair.service.impl;

import cn.oz.exception.OzException;
import cn.oz.service.CRUDServiceImpl;
import cn.suntak.ems.equipmentrepair.dao.RepairPlanRuleDao;
import cn.suntak.ems.equipmentrepair.domain.RepairPlanRule;
import cn.suntak.ems.equipmentrepair.service.RepairPlanRuleService;

public class RepairPlanRuleServiceImpl extends CRUDServiceImpl< RepairPlanRule, Long,  RepairPlanRuleDao> implements  RepairPlanRuleService{

	
	@Override
	public RepairPlanRule create() throws OzException {
		// TODO Auto-generated method stub
		return new RepairPlanRule();
	}

	@Override
	public RepairPlanRule selRepairPlanRule(long planId,
			String maintenaceLevel) {
		// TODO Auto-generated method stub
		RepairPlanRule bean = this.simpleDao.selRepairPlanRule(planId,maintenaceLevel);
		return bean;
	}
	

}

