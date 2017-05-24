package cn.suntak.ems.equipmentrepair.dao.hibernate;

import cn.oz.UserContextHolder;
import cn.oz.dao.Page;
import cn.oz.dao.hibernate.SimpleDaoImpl;
import cn.oz.search.SearchQuery;
import cn.oz.util.StringUtils;
import cn.suntak.ems.equipmentrepair.dao.MaintainDao;
import cn.suntak.ems.equipmentrepair.domain.Maintain;
import cn.suntak.ems.equipmentrepair.domain.RepairRecord;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class MaintainDaoImpl extends SimpleDaoImpl<Maintain, Long> implements MaintainDao{

	@Override
	protected String[] getDbftSearchFields() {
		// TODO Auto-generated method stub
		return new String[]{"equipmentDetails.equipmentName","equipmentDetails.equipmentNo"};
	}
	@Override
	public void getSViewPage(Page page,Long equipmentId) {
		List<Object> args = new ArrayList<Object>();
		String hql = "from Maintain maintain where 1=1 ";
		Long orgId = Long.parseLong(UserContextHolder.getCurUserInfo().getUnit().getCode());
		hql+="and maintain.organizationId= ?";
		args.add(orgId);
		if (equipmentId == -1) {
			hql += "and 1=2 ";
			this.getPage(page, hql, args.toArray(), "maintain", page.getOrder());
			return;
		} else {
			hql += "and maintain.equipmentDetails.id= ? ";
			args.add(equipmentId);
		}
		this.getPage(page, hql, args.toArray(), "maintain", page.getOrder());
	}

	@Override
	public Integer findDateScapNum(String scap, String type) {
		List<Maintain> maintainList = null;
		String hql = this.initDateHql(scap);
		maintainList = this.findDateScap(type,hql);
		if (maintainList==null || maintainList.size()==0){
			return 0;
		}
		return maintainList.size();
	}
	private String initDateHql(String scap) {
		Calendar ca=Calendar.getInstance();
		//上月执行
		if (scap.equals("SY")){
			ca.add(Calendar.MONTH, -1);
		}
		Integer month = ca.get(Calendar.MONTH)+1;
		String ym = String.valueOf(ca.get(Calendar.YEAR)+"-"+(month<10?"0"+month:String.valueOf(month)));
		return  " and to_char(maintain.executTime,'yyyy-MM') = '"+ym+"'";
	}

	private List<Maintain> findDateScap(String type,String datehql) {
		List<Object> args = new ArrayList<Object>();
		String hql = "from Maintain maintain where 1=1 ";
		hql += datehql;
		Long orgId = Long.parseLong(UserContextHolder.getCurUserInfo().getUnit().getCode());
		hql+="and maintain.organizationId= ?";
		args.add(orgId);
		return this.find(hql.toString(), args.toArray());
	}
	@Override
	public void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long equipmentId,String classify) {
		List<Object> args = new ArrayList<Object>();
		String hql = "from Maintain maintain where 1=1 ";
		Long orgId = Long.parseLong(UserContextHolder.getCurUserInfo().getUnit().getCode());
		hql+="and maintain.organizationId= ?";
		args.add(orgId);
		String fullTextSql = this.getDbftSearchCondition(this.getDbftSearchFields(), dbftSearchParams, "maintain", args);
		if(null != fullTextSql) {
			hql += "and " +fullTextSql;
		}
		// 添加其他检索条件
		if (null != searchQuery) {
			String sq = searchQuery.getQueryStatement("maintain", args);
			if (!StringUtils.isNullString(sq)) {
				hql += "and " + sq;
			}
		}
		 if(equipmentId!=-1L) {
			hql += "and maintain.equipmentDetails.id= ? ";
			args.add(equipmentId);
		}
		if (!classify.equals("other")){
			hql += initDateHql(classify);
		}
		this.getPage(page, hql, args.toArray(), "maintain", page.getOrder());
	}
	@Override
	public boolean isExistByRepairTimeId(Long repairTimeId) {
		// TODO Auto-generated method stub
		Maintain bean = this.findUniqueBy("repairTimeId", repairTimeId);
		return bean == null?false:true;
	}
}
