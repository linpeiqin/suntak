package cn.suntak.ems.common.dao.hibernate;

import java.util.ArrayList;
import java.util.List;

import cn.oz.dao.Page;
import cn.oz.dao.hibernate.HibernateDao;
import cn.oz.search.SearchQuery;
import cn.oz.util.StringUtils;
import cn.suntak.ems.common.dao.EmployeeVDao;
import cn.suntak.ems.common.domain.EmployeeV;

/**
 * Created by Administrator on 2016/12/10.
 */
public class EmployeeVDaoImpl extends HibernateDao<EmployeeV, Long> implements EmployeeVDao {

	private String[] getDbftSearchFields() {
		return new String[] {"personName"};
	}

	public void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery) {
		List<Object> args = new ArrayList<Object>();
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

	@Override
	public EmployeeV getEmployeeBy(Long personId) {
		// TODO Auto-generated method stub
		return this.findUniqueBy("personId",personId);
	}
}
