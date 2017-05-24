package cn.suntak.ems.partinfo.dao.hibernate;



import cn.oz.dao.Page;
import cn.oz.dao.hibernate.SimpleDaoImpl;
import cn.oz.search.SearchQuery;
import cn.oz.util.StringUtils;
import cn.suntak.ems.partinfo.dao.GroupInventoryDao;
import cn.suntak.ems.partinfo.dao.PartQualityDao;
import cn.suntak.ems.partinfo.domain.GroupInventory;
import cn.suntak.ems.partinfo.domain.PartQuality;

import java.util.ArrayList;
import java.util.List;

/**
 * 
 * 
 * @author linking	
 * @version 1.0.0
 * @since 1.0.0
 */
public class GroupInventoryDaoImpl extends SimpleDaoImpl<GroupInventory, Long> implements GroupInventoryDao {

	@Override
	protected String[] getDbftSearchFields() {
		// TODO Auto-generated method stub
		return null;
	}
	public void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, String partNo) {
		// TODO Auto-generated method stub
		List<Object> args = new ArrayList<Object>();
		String hql = "from GroupInventory groupInventory where 1=1 ";
		String fullTextSql = this.getDbftSearchCondition(this.getDbftSearchFields(), dbftSearchParams, "groupInventory", args);
		if(null != fullTextSql) {
			hql += "and " +fullTextSql;
		}
		// 添加其他检索条件
		if (null != searchQuery) {
			String sq = searchQuery.getQueryStatement("groupInventory", args);
			if (!StringUtils.isNullString(sq)){
				String shq = sq.replace('_','.');
				hql += "and " + shq;
			}
		}
		hql +="and groupInventory.partNo= ? ";
		args.add(partNo);
		this.getPage(page, hql, args.toArray(), "groupInventory", page.getOrder());
	}


}