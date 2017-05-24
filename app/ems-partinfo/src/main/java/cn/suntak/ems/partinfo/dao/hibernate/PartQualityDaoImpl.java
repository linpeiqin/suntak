package cn.suntak.ems.partinfo.dao.hibernate;



import cn.oz.dao.Page;
import cn.oz.dao.hibernate.SimpleDaoImpl;
import cn.oz.search.SearchQuery;
import cn.oz.util.StringUtils;
import cn.suntak.ems.partinfo.dao.PartQualityDao;
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
public class PartQualityDaoImpl extends SimpleDaoImpl<PartQuality, Long> implements PartQualityDao {

	@Override
	protected String[] getDbftSearchFields() {
		// TODO Auto-generated method stub
		return null;
	}
	public void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long partId) {
		// TODO Auto-generated method stub
		List<Object> args = new ArrayList<Object>();
		String hql = "from PartQuality partQuality where 1=1 ";
		String fullTextSql = this.getDbftSearchCondition(this.getDbftSearchFields(), dbftSearchParams, "partQuality", args);
		if(null != fullTextSql) {
			hql += "and " +fullTextSql;
		}
		// 添加其他检索条件
		if (null != searchQuery) {
			String sq = searchQuery.getQueryStatement("partQuality", args);
			if (!StringUtils.isNullString(sq)){
				String shq = sq.replace('_','.');
				hql += "and " + shq;
			}
		}
		if (partId!=-1){
			hql +="and partQuality.partId= ? ";
			args.add(partId);
		}
		this.getPage(page, hql, args.toArray(), "partQuality", page.getOrder());
	}


}