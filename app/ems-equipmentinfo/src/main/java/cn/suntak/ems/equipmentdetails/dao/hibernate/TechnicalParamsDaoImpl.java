package cn.suntak.ems.equipmentdetails.dao.hibernate;



import java.util.ArrayList;
import java.util.List;

import cn.oz.dao.Page;
import cn.oz.dao.hibernate.SimpleDaoImpl;
import cn.oz.search.SearchQuery;
import cn.oz.util.StringUtils;
import cn.suntak.ems.equipmentdetails.dao.TechnicalParamsDao;
import cn.suntak.ems.equipmentdetails.domain.TechnicalParams;

/**
 * 
 * 
 * @author linking	
 * @version 1.0.0
 * @since 1.0.0
 */
public class TechnicalParamsDaoImpl extends SimpleDaoImpl<TechnicalParams, Long> implements TechnicalParamsDao {
	
	@Override
	protected String[] getDbftSearchFields() {
		return new String[] {};
	}
	
	@Override
	public void getPage(Page page,SearchQuery searchQuery) {
		List<Object> args = new ArrayList<Object>();
		String hql = "from technicalParams technicalParams where 1=1 ";
		// 添加其他检索条件
		if (null != searchQuery) {
			String sq = searchQuery.getQueryStatement("technicalParams", args);
			if (!StringUtils.isNullString(sq)){
				hql += "and " + sq;
			}
		}
        this.getPage(page, hql, args.toArray(), "technicalParams", page.getOrder());	
	}

	@Override
	public void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long equipmentId) {
		List<Object> args = new ArrayList<Object>();
		String hql = "from TechnicalParams technicalParams where 1=1 ";

		String fullTextSql = this.getDbftSearchCondition(this.getDbftSearchFields(), dbftSearchParams, "technicalParams", args);
		if(null != fullTextSql) {
			hql += "and " +fullTextSql;
		}
		// 添加其他检索条件
		if (null != searchQuery) {
			String sq = searchQuery.getQueryStatement("technicalParams", args);
			if (!StringUtils.isNullString(sq)){
				hql += "and " + sq;
			}
		}

		if (equipmentId!=-1){
			hql +="and technicalParams.equipmentDetails.id= ? ";
			args.add(equipmentId);
		}
		this.getPage(page, hql, args.toArray(), "technicalParams", page.getOrder());
	}

	@Override
	public List<TechnicalParams> getTechParaList(SearchQuery searchQuery,
			Long equipmentId) {
		List<Object> args = new ArrayList<Object>();
		String hql = "from TechnicalParams technicalParams where 1=1 ";
		// 添加其他检索条件
		if (null != searchQuery) {
			String sq = searchQuery.getQueryStatement("technicalParams", args);
			if (!StringUtils.isNullString(sq)){
				hql += "and " + sq;
			}
		}
		if (equipmentId!=null){
			hql +="and technicalParams.equipmentDetails.id= ? ";
			args.add(equipmentId);
		}
		return this.find(hql, args.toArray());
	}
}