package cn.suntak.ems.equipmentrepair.dao.hibernate;



import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import cn.oz.UserContextHolder;
import cn.oz.dao.Page;
import cn.oz.dao.hibernate.SimpleDaoImpl;
import cn.oz.search.SearchQuery;
import cn.oz.util.StringUtils;
import cn.suntak.ems.equipmentrepair.dao.RepairPlanDao;
import cn.suntak.ems.equipmentrepair.domain.RepairPlan;
import cn.suntak.ems.equipmentrepair.domain.RepairPlanTime;

/**
 * 
 * 
 * @author linking	
 * @version 1.0.0
 * @since 1.0.0
 */
public class RepairPlanDaoImpl extends SimpleDaoImpl<RepairPlan, Long> implements RepairPlanDao {
	
	@Override
	protected String[] getDbftSearchFields() {
		return new String[] {"equipmentDetails.equipmentName","equipmentDetails.equipmentNo"};
	}


	@Override
	public List<RepairPlanTime> findDateScap(Date startDate, Date endDate) {
		List<Object> args = new ArrayList<Object>();
		String hql = "from RepairPlanTime repairPlanTime where 1 = 1 ";
		hql += " and repairPlanTime.actualDate between ? and ? ";
		args.add(startDate);
		args.add(endDate);
		String orgId = UserContextHolder.getCurUserInfo().getUnit().getCode();
		hql += " and repairPlanTime.repairPlanRule.repairPlan.organizationId = " + orgId;
		return this.find(hql,args.toArray());
	}

	@Override
	public void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long equipmentId,String classify) {
		List<Object> args = new ArrayList<Object>();
		String hql = "from RepairPlan repairPlan where 1=1 ";
		String fullTextSql = this.getDbftSearchCondition(this.getDbftSearchFields(), dbftSearchParams, "repairPlan", args);
		if(null != fullTextSql) {
			hql += "and " +fullTextSql;
		}

		// 添加其他检索条件
		if (null != searchQuery) {
			String sq = searchQuery.getQueryStatement("repairPlan", args);
			if (!StringUtils.isNullString(sq)){
				hql += "and " + sq;
			}
		}

		if (equipmentId!=-1){
			hql +="and repairPlan.equipmentDetails.id= ? ";
			args.add(equipmentId);
		}
		if (!classify.equals("other")){
			hql += initDateHql(classify);
		}
		hql += initOrgId();
		this.getPage(page, hql, args.toArray(), "repairPlan", page.getOrder());
	}
    private String initOrgId(){
		String orgId = UserContextHolder.getCurUserInfo().getUnit().getCode();
		return  " and repairPlan.organizationId = " + orgId;
	}
	@Override
	public Integer findDateScapNum(String scap, String type){

		List<RepairPlan> repairPlanList = null;
		String hql = this.initDateHql(scap);
		repairPlanList = this.findDateScap(type,hql);
		if (repairPlanList==null || repairPlanList.size()==0){
			return 0;
		}
		return repairPlanList.size();
	}

	private String initDateHql(String scap) {
		Calendar ca=Calendar.getInstance();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String today = formatter.format(new Date());
		if (scap.equals("OE")){
			return " and to_char(repairPlan.nextTime,'yyyy-MM-dd') < '"+today+"'";
		}
		//今天计划
		if (scap.equals("MT")){
			return " and to_char(repairPlan.nextTime,'yyyy-MM-dd') = '"+today+"'";
		}
		//明天计划
		if (scap.equals("DT")){
			try {
				ca.setTime(formatter.parse(today));
				ca.add(Calendar.DAY_OF_YEAR, +1);
				String nextDate = formatter.format(ca.getTime());
				return " and to_char(repairPlan.nextTime,'yyyy-MM-dd') = '"+nextDate+"'";
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		//这个月所有计划
		if (scap.equals("PM")){
			String ym = String.valueOf(ca.get(Calendar.YEAR)+"-"+String .valueOf(ca.get(Calendar.MONTH)+1));//得到年
			return  " and to_char(repairPlan.nextTime,'yyyy-MM') = '"+ym+"'";
		}
		return "";
	}

	private List<RepairPlan> findDateScap(String type,String datehql) {
		List<Object> args = new ArrayList<Object>();
		String hql = "from RepairPlan repairPlan where repairPlan.type = ? AND isOff = 0";
		args.add(type);
		hql += datehql;
		hql += initOrgId();
		return this.find(hql.toString(), args.toArray());
	}


	@Override
	public RepairPlan loadByEquipment(Long equipmentId,String type) {
		// TODO Auto-generated method stub
		String hql = "FROM RepairPlan WHERE equipmentDetails.id = ? AND type = ? AND isOff = 0";
		List<Object> args = new ArrayList<Object>();
		args.add(equipmentId);
		args.add(type);
		return this.findUnique(hql, args.toArray());
	}

	@Override
	public void getSViewPage(Page page, Long equipmentId) {
		List<Object> args = new ArrayList<Object>();
		String hql = "from RepairPlan repairPlan where 1=1 ";
		if (equipmentId==-1){
			hql += "and 1=2 ";
			this.getPage(page, hql, args.toArray(), "repairPlan", page.getOrder());
			return ;
		} else{
			hql +="and repairPlan.equipmentDetails.id= ? ";
			args.add(equipmentId);
		}
		hql += " order by repairPlan.maintenanceLevel asc";
		this.getPage(page, hql, args.toArray(), "repairPlan", page.getOrder());
	}

	@Override
	public List<RepairPlanTime> findAllByPlanId(Long planId) {
		List<Object> args = new ArrayList<Object>();
		String hql = "from RepairPlanTime repairPlanTime where 1=1 ";
		hql += " and repairPlanTime.repairPlanRule.repairPlan.id = ?";
		hql += " order by repairPlanTime.status asc,repairPlanTime.actualDate asc";
		args.add(planId);
		return this.find(hql.toString(), args.toArray());
	}

	@Override
	public void getPageTime(Page page, String dbftSearchParams, SearchQuery searchQuery, Long planId) {
		List<Object> args = new ArrayList<Object>();
		String hql = "from RepairPlanTime repairPlanTime where 1=1 ";
		hql += " and repairPlanTime.repairPlanRule.repairPlan.id = ? ";
		// 添加其他检索条件
		if (null != searchQuery) {
			String sq = searchQuery.getQueryStatement("repairPlanTime", args);
			if (!StringUtils.isNullString(sq)){
				hql += "and " + sq;
			}
		}
		hql += " order by repairPlanTime.status asc,repairPlanTime.actualDate asc";
		args.add(planId);
		this.getPage(page, hql, args.toArray(), "repairPlanTime", page.getOrder());
	}


	@Override
	public List<RepairPlan> loadAllByOrgId(String orgId) {
		List<Object> args = new ArrayList<Object>();
		String hql = "from RepairPlan repairPlan where 1=1 ";
		if(!StringUtils.isNullString(orgId)){
			hql += " AND repairPlan.organizationId = ?";
			args.add(Long.valueOf(orgId));
		}
		return this.find(hql, args.toArray());
	}

}