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
import cn.suntak.ems.equipmentrepair.dao.RepairRecordDao;
import cn.suntak.ems.equipmentrepair.domain.RepairPlan;
import cn.suntak.ems.equipmentrepair.domain.RepairRecord;

/**
 * 
 * 
 * @author linking	
 * @version 1.0.0
 * @since 1.0.0
 */
public class RepairRecordDaoImpl extends SimpleDaoImpl<RepairRecord, Long> implements RepairRecordDao {
	
	@Override
	protected String[] getDbftSearchFields() {
		return new String[] {"equipmentDetails.equipmentName","equipmentDetails.equipmentNo","maintenanceNo",};
	}

	@Override
	public void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long equipmentId,String classify) {
		List<Object> args = new ArrayList<Object>();
		String hql = "from RepairRecord repairRecord where 1=1 ";
		String fullTextSql = this.getDbftSearchCondition(this.getDbftSearchFields(), dbftSearchParams, "repairRecord", args);
		if(null != fullTextSql) {
			hql += "and " +fullTextSql;
		}
		// 添加其他检索条件
		if (null != searchQuery) {
			String sq = searchQuery.getQueryStatement("repairRecord", args);
			if (!StringUtils.isNullString(sq)){
				hql += "and " + sq;
			}
		}

		if (equipmentId!=-1){
			hql +="and repairRecord.equipmentDetails.id= ? ";
			args.add(equipmentId);
		}
		if (!classify.equals("other")){
			hql += initDateHql(classify);
		}
		hql += initPermissionHql();
		hql += initOrgId();
		hql +=" order by repairRecord.status asc";
		this.getPage(page, hql, args.toArray(), "repairRecord", page.getOrder());
	}
	private String initOrgId(){
		String orgId = UserContextHolder.getCurUserInfo().getUnit().getCode();
		return  " and repairRecord.organizationId = " + orgId;
	}
	@Override
	public void getSViewPage(Page page,Long equipmentId) {
		List<Object> args = new ArrayList<Object>();
		String hql = "from RepairRecord repairRecord where 1=1 ";
		if (equipmentId==-1){
			hql += "and 1=2 ";
			this.getPage(page, hql, args.toArray(), "repairRecord", page.getOrder());
			return ;
		} else{
			hql +="and repairRecord.equipmentDetails.id= ? ";
			args.add(equipmentId);
		}
		hql += initPermissionHql();
		hql += " order by repairRecord.status asc";
		this.getPage(page, hql, args.toArray(), "repairRecord", page.getOrder());
	}
	private String initPermissionHql() {
		String permissionHql = "";
		Boolean isMaintenancer = UserContextHolder.getCurUser().hasPermission("EMS_DM_MAINTENANCE_OPERATION");
		Boolean isDistributor =  UserContextHolder.getCurUser().hasPermission("EMS_DM_DISTRIBUT_OPERATION");
		Boolean isRepair =  UserContextHolder.getCurUser().hasPermission("EMS_DM_REPAIRED_OPERATION");

		if (isMaintenancer){
			permissionHql += " and repairRecord.status !=1 ";
		} else
		if (isDistributor){
			permissionHql +=" and (repairRecord.status =0 or repairRecord.status = 3)";
		} else
		if (isRepair){
			permissionHql +=" and repairRecord.status =1 and repairRecord.maintenancePerson.id="+UserContextHolder.getCurFileAuthor().getId();
			permissionHql +=" or repairRecord.status = 3";
		} else {
			permissionHql +="and repairRecord.status = 3";
		}

		return permissionHql;
	}

	@Override
	public Integer findDateScapNum(String scap, String type){
		List<RepairRecord> repairRecordList = null;
		String hql = this.initDateHql(scap);
		repairRecordList = this.findDateScap(type,hql);
		if (repairRecordList==null || repairRecordList.size()==0){
			return 0;
		}
		return repairRecordList.size();
	}

	@Override
	public Boolean updateStatus(Long id, Integer status) {
		try{
			RepairRecord repairRecord = this.get(id);
			repairRecord.setStatus(status);
			this.save(repairRecord);
			return true;
		} catch (Exception e){
			return false;
		}
	}



	private String initDateHql(String scap) {
		Calendar ca=Calendar.getInstance();
		//上月执行
		if (scap.equals("SY")){
			ca.add(Calendar.MONTH, -1);
		}
		Integer month = ca.get(Calendar.MONTH)+1;
		String ym = String.valueOf(ca.get(Calendar.YEAR)+"-"+(month<10?"0"+month:String.valueOf(month)));
		return  " and to_char(repairRecord.endTime,'yyyy-MM') = '"+ym+"'";
	}
	private List<RepairRecord> findDateScap(String type,String datehql) {
		List<Object> args = new ArrayList<Object>();
		String hql = "from RepairRecord repairRecord where 1=1 ";
		hql += datehql;
		hql += " and repairRecord.status = 3";
		hql += initOrgId();
		return this.find(hql.toString(), args.toArray());
	}

}