package cn.suntak.ems.equipmentrepair.dao.hibernate;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;

import cn.oz.dao.hibernate.SimpleDaoImpl;
import cn.oz.util.StringUtils;
import cn.suntak.ems.equipmentrepair.dao.RepairPlanTimeDao;
import cn.suntak.ems.equipmentrepair.domain.RepairPlanTime;

public class RepairPlanTimeDaoImpl extends SimpleDaoImpl<RepairPlanTime, Long> implements RepairPlanTimeDao{

	@Override
	protected String[] getDbftSearchFields() {
		// TODO Auto-generated method stub
		return new String[]{};
	}

	@Override
	public void delByRuleId(Long planRuleId, int statusWaitValue) {
		// TODO Auto-generated method stub
		String hql = "DELETE FROM RepairPlanTime WHERE repairPlanRule.id = ? AND status = ?";
		Query q = this.getSession().createQuery(hql);
		q.setLong(0, planRuleId).setInteger(1, statusWaitValue);
		q.executeUpdate();
	}

	/**
	 * 根据规则id获取某状态下最新一条记录
	 */
	@SuppressWarnings("unchecked")
	@Override
	public RepairPlanTime selLastFinishByRuleId(Long planRuleId,
			int statusFinishValue) {
		// TODO Auto-generated method stub
		String hql = "FROM RepairPlanTime WHERE repairPlanRule.id = ? AND status = ? ORDER BY planDate DESC";
		Query q = this.getSession().createQuery(hql);
		q.setLong(0, planRuleId).setInteger(1, statusFinishValue);
		q.setFirstResult(0);
		q.setMaxResults(1);
		List<RepairPlanTime> list = q.list();
		if(list != null && !list.isEmpty())
			return list.get(0);
		return null;
	}

	@Override
	public List<RepairPlanTime> getByYearMonth(String yearMonthStr,String orgId) {
		// TODO Auto-generated method stub
		String hql = "FROM RepairPlanTime WHERE to_char(planDate,'yyyy-MM') = ?";
		List<Object> args = new ArrayList<Object>();
		args.add(yearMonthStr);
		if(!StringUtils.isNullString(orgId)){
			hql += " AND organizationId = ?";
			args.add(Long.valueOf(orgId));
		}
		return this.find(hql, args.toArray());
	}

	@Override
	public List<RepairPlanTime> getbYear(String year,String orgId) {
		// TODO Auto-generated method stub
		String hql = "FROM RepairPlanTime WHERE to_char(planDate,'yyyy') = ?";
		List<Object> args = new ArrayList<Object>();
		args.add(year);
		if(!StringUtils.isNullString(orgId)){
			hql += " AND organizationId = ?";
			args.add(Long.valueOf(orgId));
		}
		return this.find(hql, args.toArray());
	}

	@Override
	public boolean isExistByRuleAndYear(Long planRuleId, String year) {
		// TODO Auto-generated method stub
		String hql = "FROM RepairPlanTime WHERE repairPlanRule.id = ? AND to_char(planDate,'yyyy') = ?";
		List<Object> args = new ArrayList<Object>();
		args.add(planRuleId);
		args.add(year);
		List<RepairPlanTime> list = this.find(hql, args.toArray());
		if(list != null && !list.isEmpty())
			return true;
		return false;
	}

	@Override
	public List<RepairPlanTime> getByDateAndStatus(String begindateStr,String enddateStr,int status) {
		// TODO Auto-generated method stub
		String hql = "FROM RepairPlanTime WHERE to_char(actualDate,'yyyy-MM-dd') between ? AND ? AND status = ?";
		List<Object> args = new ArrayList<Object>();
		args.add(begindateStr);
		args.add(enddateStr);
		args.add(status);
		return this.find(hql, args.toArray());
	}


}
