package cn.suntak.ems.equipmentrepair.dao.hibernate;

import java.util.ArrayList;
import java.util.List;

import cn.oz.UserContextHolder;
import cn.oz.dao.Page;
import cn.oz.dao.hibernate.SimpleDaoImpl;
import cn.oz.search.SearchQuery;
import cn.oz.util.StringUtils;
import cn.suntak.ems.equipmentrepair.dao.RepairYearPlanDao;
import cn.suntak.ems.equipmentrepair.domain.RepairYearPlan;

public class RepairYearPlanDaoImpl extends SimpleDaoImpl<RepairYearPlan, Long> implements RepairYearPlanDao{

	@Override
	protected String[] getDbftSearchFields() {
		// TODO Auto-generated method stub
		return new String[]{};
	}

	@Override
	public RepairYearPlan loadByYear(String year,String orgId) {
		// TODO Auto-generated method stub
		String hql = "FROM RepairYearPlan WHERE planYear = ?";
		List<Object> args = new ArrayList<Object>();
		args.add(year);
		if(!StringUtils.isNullString(orgId)){
			hql += " AND organizationId = ?";
			args.add(Long.valueOf(orgId));
		}
		return this.findUnique(hql, args.toArray());
	}

	@Override
	public void getPage(Page page, String dbftSearchParams,
			SearchQuery searchQuery) {
		// TODO Auto-generated method stub
		List<Object> args = new ArrayList<Object>();
		String hql = "from RepairYearPlan repairYearPlan where 1=1 ";
		String fullTextSql = this.getDbftSearchCondition(this.getDbftSearchFields(), dbftSearchParams, "repairPlan", args);
		if(null != fullTextSql) {
			hql += "and " +fullTextSql;
		}

		// 添加其他检索条件
		if (null != searchQuery) {
			String sq = searchQuery.getQueryStatement("repairYearPlan", args);
			if (!StringUtils.isNullString(sq)){
				hql += "and " + sq;
			}
		}

		hql += initOrgId();
		this.getPage(page, hql, args.toArray(), "repairYearPlan", page.getOrder());
	}
	
	
	private String initOrgId(){
		String orgId = UserContextHolder.getCurUserInfo().getUnit().getCode();
		return  " and repairYearPlan.organizationId = " + orgId;
	}

}
