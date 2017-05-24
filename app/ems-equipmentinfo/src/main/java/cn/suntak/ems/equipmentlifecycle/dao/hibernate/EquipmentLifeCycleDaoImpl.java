package cn.suntak.ems.equipmentlifecycle.dao.hibernate;



import java.util.ArrayList;
import java.util.List;

import cn.oz.dao.Page;
import cn.oz.dao.hibernate.SimpleDaoImpl;
import cn.oz.search.SearchQuery;
import cn.oz.util.StringUtils;
import cn.suntak.ems.equipmentlifecycle.dao.EquipmentLifeCycleDao;
import cn.suntak.ems.equipmentlifecycle.domain.EquipmentLifeCycle;

/**
 * 
 * 
 * @author linking	
 * @version 1.0.0
 * @since 1.0.0
 */
public class EquipmentLifeCycleDaoImpl extends SimpleDaoImpl<EquipmentLifeCycle, Long> implements EquipmentLifeCycleDao {
	
	@Override
	protected String[] getDbftSearchFields() {
		return new String[] {};
	}
	
	@Override
	public void getPage(Page page,String dbftSearchParams,SearchQuery searchQuery, Long equipmentId) {
		
		List<Object> args = new ArrayList<Object>();
		String hql = "select equipmentLifeCycle from EquipmentLifeCycle equipmentLifeCycle join equipmentLifeCycle.equipmentDetails equipmentDetails  where 1=1 and equipmentDetails.scrapState = 0";

		String fullTextSql = this.getDbftSearchCondition(this.getDbftSearchFields(), dbftSearchParams, "equipmentLifeCycle", args);
		if(null != fullTextSql) {
			hql += "and " +fullTextSql;
		}
		// 添加其他检索条件
		if (null != searchQuery) {
			String sq = searchQuery.getQueryStatement("equipmentLifeCycle", args);
			if (!StringUtils.isNullString(sq)){
				hql += "and " + sq;
			}
			
		}
		if (equipmentId!=-1){
			hql +="and equipmentDetails.id = ? ";
			args.add(equipmentId);
		}
		String order = "";
		if (page.getOrder().equals("typeName")){
			order = "type";
		} else {
			order = page.getOrder();
		}
        this.getPage(page, hql, args.toArray(), "equipmentLifeCycle", order);
	}

	@Override
	public EquipmentLifeCycle loadByProcessId(String processId) {
		List<EquipmentLifeCycle> list = this.findBy("processId",processId);
		if(list!=null)
			return list.get(0);
		else return null;
	}


}