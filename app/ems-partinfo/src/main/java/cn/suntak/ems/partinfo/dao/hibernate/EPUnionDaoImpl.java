package cn.suntak.ems.partinfo.dao.hibernate;



import java.util.ArrayList;
import java.util.List;

import cn.oz.dao.Page;
import cn.oz.dao.hibernate.SimpleDaoImpl;
import cn.oz.search.SearchQuery;
import cn.oz.util.StringUtils;
import cn.suntak.ems.partinfo.dao.EPUnionDao;
import cn.suntak.ems.partinfo.domain.EPUnion;

/**
 * 
 * 
 * @author linking	
 * @version 1.0.0
 * @since 1.0.0
 */
public class EPUnionDaoImpl extends SimpleDaoImpl<EPUnion, Long> implements EPUnionDao {
	
	@Override
	protected String[] getDbftSearchFields() {
		return new String[]{};
	}
	
	public void getPage(Page page,SearchQuery searchQuery) {
		// TODO Auto-generated method stub
		List<Object> args = new ArrayList<Object>();
		String hql = "from EPUnion ePUnion where 1=1 ";
		// 添加其他检索条件
		if (null != searchQuery) {
			String sq = searchQuery.getQueryStatement("ePUnion", args);
			if (!StringUtils.isNullString(sq)){
				hql += "and " + sq;
			}
		}
        this.getPage(page, hql, args.toArray(), "ePUnion", page.getOrder());	
	}



}