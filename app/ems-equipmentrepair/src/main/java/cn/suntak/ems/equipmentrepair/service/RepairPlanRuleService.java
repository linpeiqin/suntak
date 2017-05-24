package cn.suntak.ems.equipmentrepair.service;

import javax.servlet.http.HttpServletRequest;

import cn.oz.service.SimpleService;
import cn.suntak.ems.equipmentrepair.domain.RepairPlan;
import cn.suntak.ems.equipmentrepair.domain.RepairPlanRule;

public interface RepairPlanRuleService extends SimpleService<RepairPlanRule, Long>{

	RepairPlanRule selRepairPlanRule(long planId, String maintenaceLevel);


}
