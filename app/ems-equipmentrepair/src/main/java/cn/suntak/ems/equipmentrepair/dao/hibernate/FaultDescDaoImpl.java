package cn.suntak.ems.equipmentrepair.dao.hibernate;



import java.util.ArrayList;
import java.util.List;

import cn.oz.dao.Page;
import cn.oz.dao.hibernate.SimpleDaoImpl;
import cn.oz.search.SearchQuery;
import cn.oz.util.StringUtils;
import cn.suntak.ems.equipmentrepair.dao.FaultDescDao;
import cn.suntak.ems.equipmentrepair.domain.FaultDesc;

/**
 * 
 * 
 * @author linking	
 * @version 1.0.0
 * @since 1.0.0
 */
public class FaultDescDaoImpl extends SimpleDaoImpl<FaultDesc, Long> implements FaultDescDao {
	
	@Override
	protected String[] getDbftSearchFields() {
		return new String[] {"appearanceSummary","apearanceDetail","faultType"};
	}

	public void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery) {
		List args = new ArrayList();
		String hql = "from " + this.entityClass.getSimpleName() + " _alias where 1=1 ";
		String fullTextSql = this.getDbftSearchCondition(this.getDbftSearchFields(), dbftSearchParams, "_alias", args);
		if(null != fullTextSql) {
			hql += "and " +fullTextSql;
		}
		if (null != searchQuery) {
			String sq = searchQuery.getQueryStatement("_alias", args);
			if (!StringUtils.isNullString(sq)) {
				hql += "and " + sq;
			}
		}
		this.getPage(page, hql, args.toArray(), "_alias", page.getOrder());
	}
}