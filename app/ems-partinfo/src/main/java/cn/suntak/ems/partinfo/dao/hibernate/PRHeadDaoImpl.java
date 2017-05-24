package cn.suntak.ems.partinfo.dao.hibernate;



import java.util.ArrayList;
import java.util.List;

import cn.oz.UserContextHolder;
import cn.oz.dao.Page;
import cn.oz.dao.hibernate.SimpleDaoImpl;
import cn.oz.search.SearchQuery;
import cn.oz.util.StringUtils;
import cn.suntak.ems.partinfo.dao.PRHeadDao;
import cn.suntak.ems.partinfo.domain.PRHead;

/**
 * 
 * 
 * @author linking	
 * @version 1.0.0
 * @since 1.0.0
 */
public class PRHeadDaoImpl extends SimpleDaoImpl<PRHead, Long> implements PRHeadDao {
	
	@Override
	protected String[] getDbftSearchFields() {
		return new String[]{};
	}


	@Override
	public void getPage(Page page, String dbftSearchParams) {
		List<Object> args = new ArrayList<Object>();
		String hql = "from PRHead pRHead where 1=1 ";
		String fullTextSql = this.getDbftSearchCondition(this.getDbftSearchFields(), dbftSearchParams, "pRHead", args);
		if(null != fullTextSql) {
			hql += "and " +fullTextSql;
		}
		hql += initOrgId();
		hql +=" order by pRHead.prDate";
		this.getPage(page, hql, args.toArray(), "pRHead", page.getOrder());
	}

	private String initOrgId(){
		String orgId = UserContextHolder.getCurUserInfo().getUnit().getCode();
		return  " and pRHead.orgId = " + orgId;
	}
}