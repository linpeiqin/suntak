package cn.suntak.ems.equipmentrepair.dao;

import cn.oz.dao.SimpleDao;
import cn.suntak.ems.equipmentrepair.domain.RepairPlanRule;

public interface RepairPlanRuleDao extends SimpleDao<RepairPlanRule, Long>{

	RepairPlanRule selRepairPlanRule(long planId, String maintenaceLevel);

}
