package cn.suntak.ems.equipmentrepair.dao.hibernate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.hibernate.transform.Transformers;

import cn.oz.dao.hibernate.SimpleDaoImpl;
import cn.suntak.ems.equipmentrepair.dao.YearPlanDetailDao;
import cn.suntak.ems.equipmentrepair.domain.YearPlanDetail;

public class YearPlanDetailDaoImpl extends SimpleDaoImpl<YearPlanDetail, Long> implements YearPlanDetailDao{

	@Override
	protected String[] getDbftSearchFields() {
		// TODO Auto-generated method stub
		return new String[]{};
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, String>> pakeDetails(Long yearPlanId) {
		// TODO Auto-generated method stub
		String sql = " select PROCEDURE,EQUIPMENT_ID,EQUIPMENT_NAME,EQUIPMENT_NO " +
		"from ems_dm_year_plan_detail " +
		"WHERE PLAN_ID=? " +
		"group by PROCEDURE,EQUIPMENT_ID,EQUIPMENT_NAME,EQUIPMENT_NO";
		Query q = this.getSession().createSQLQuery(sql);
		q.setLong(0, yearPlanId);
		q.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
		return q.list();
	}

	@Override
	public List<YearPlanDetail> getOrderDetails(Long yearPlanId) {
		// TODO Auto-generated method stub
		String hql = "FROM YearPlanDetail WHERE repairYearPlan.id = ? ORDER BY equipmentId,maintenaceMonth,maintenaceLevel ASC";
		List<Object> args = new ArrayList<Object>();
		args.add(yearPlanId);
		return this.find(hql, args.toArray());
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<HashMap<String, String>> getGroupLevel(Long yearPlanId) {
		// TODO Auto-generated method stub
		String sql = "select EQUIPMENT_ID||'@'||MAINTENACE_MONTH AS KEY_V,MAINTENACE_LEVEL " +
				"from ems_dm_year_plan_detail WHERE PLAN_ID=? " +
				"group by EQUIPMENT_ID||'@'||MAINTENACE_MONTH,MAINTENACE_LEVEL " +
				"ORDER BY MAINTENACE_LEVEL ASC";
		Query q = this.getSession().createSQLQuery(sql);
		q.setLong(0, yearPlanId);
		q.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
		return q.list();
	}

	@Override
	public void delByPlanId(Long yearPlanId) {
		// TODO Auto-generated method stub
		String hql = "DELETE FROM YearPlanDetail WHERE repairYearPlan.id = ?";
		Query q = this.getSession().createQuery(hql);
		q.setLong(0, yearPlanId);
		q.executeUpdate();
	}

}
