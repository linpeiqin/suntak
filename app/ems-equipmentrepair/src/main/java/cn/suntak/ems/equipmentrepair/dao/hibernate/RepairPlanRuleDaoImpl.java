package cn.suntak.ems.equipmentrepair.dao.hibernate;

import java.util.ArrayList;
import java.util.List;

import cn.oz.dao.hibernate.SimpleDaoImpl;
import cn.suntak.ems.equipmentrepair.dao.RepairPlanRuleDao;
import cn.suntak.ems.equipmentrepair.domain.RepairPlanRule;

public class RepairPlanRuleDaoImpl extends SimpleDaoImpl<RepairPlanRule, Long> implements RepairPlanRuleDao{

	@Override
	protected String[] getDbftSearchFields() {
		// TODO Auto-generated method stub
		return new String[]{};
	}

	@Override
	public RepairPlanRule selRepairPlanRule(long planId,
			String maintenaceLevel) {
		// TODO Auto-generated method stub
		String hql = "FROM RepairPlanRule WHERE repairPlan.id = ? AND maintenaceLevel = ?";
		List<Object> args = new ArrayList<Object>();
		args.add(planId);
		args.add(maintenaceLevel);
		RepairPlanRule bean = this.findUnique(hql, args.toArray());
		return bean;
	}

}
