package cn.suntak.ems.equipmentrepair.dao.hibernate;

import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.hibernate.transform.Transformers;

import cn.oz.dao.hibernate.SimpleDaoImpl;
import cn.suntak.ems.equipmentrepair.dao.MonthPlanDetailDao;
import cn.suntak.ems.equipmentrepair.domain.MonthPlanDetail;

public class MonthPlanDetailDaoImpl extends SimpleDaoImpl<MonthPlanDetail, Long> implements MonthPlanDetailDao{

	@Override
	protected String[] getDbftSearchFields() {
		// TODO Auto-generated method stub
		return new String[]{};
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, String>> pakeDetails(Long monthPlanId) {
		// TODO Auto-generated method stub
		String sql = " select PROCEDURE,EQUIPMENT_NAME,EQUIPMENT_NO,MAINTENACE_LEVEL,MAINTENACE_DATE," +
				"','||listagg(MAINTENACE_DAY, ',') within group( order by MAINTENACE_DAY)||',' as MAINTENACE_DAY " +
				"from ems_dm_month_plan_detail " +
				"WHERE PLAN_ID=? " +
				"group by procedure,EQUIPMENT_NAME,EQUIPMENT_NO,MAINTENACE_LEVEL,MAINTENACE_DATE";
		Query q = this.getSession().createSQLQuery(sql);
		q.setLong(0, monthPlanId);
		q.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
		return q.list();
	}

	@Override
	public void delByPlanId(Long monthPlanId) {
		// TODO Auto-generated method stub
		String hql = "DELETE FROM MonthPlanDetail WHERE repairMonthPlan.id = ?";
		Query q = this.getSession().createQuery(hql);
		q.setLong(0, monthPlanId);
		q.executeUpdate();
	}

}
