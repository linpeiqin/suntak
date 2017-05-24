package cn.suntak.ems.common.dao.hibernate;

import java.util.ArrayList;
import java.util.List;

import cn.oz.UserContextHolder;
import cn.oz.dao.Page;
import cn.oz.dao.hibernate.HibernateDao;
import cn.oz.search.SearchQuery;
import cn.oz.util.StringUtils;
import cn.suntak.ems.common.dao.SuppliersVDao;
import cn.suntak.ems.common.domain.SuppliersV;

public class SuppliersVDaoImpl extends HibernateDao<SuppliersV,Long> implements SuppliersVDao{

	public List<SuppliersV> getSuppliersList() {
		// TODO Auto-generated method stub
		  List<SuppliersV> suppliersVs = this.loadAll();
	        return suppliersVs;
	}
	private String[] getDbftSearchFields() {
		return new String[] {"vendorName"};
	}

	@Override
	public void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery) {
		String code = UserContextHolder.getCurUserInfo().getUnit().getCode();
		List<Object> args = new ArrayList<Object>();
		String hql = "from " + this.entityClass.getSimpleName() + " _alias where 1=1 " + " and  ORG_ID = " + code;
		String fullTextSql = this.getDbftSearchCondition(this.getDbftSearchFields(), dbftSearchParams, "_alias", args);
		if(null != fullTextSql) {
			hql += "and " +fullTextSql;
		}
		if (null != searchQuery) {
			String sq = searchQuery.getQueryStatement("_alias", args);
			if (!StringUtils.isNullString(sq)) {
				hql += "and " + sq  ;
			}
		}
		this.getPage(page, hql, args.toArray(), "_alias", page.getOrder());
	}
	@Override
	public SuppliersV getSupplierVBy(Integer vendorId) {
		// TODO Auto-generated method stub
			return this.findUniqueBy("vendorId",vendorId);
		}
}
