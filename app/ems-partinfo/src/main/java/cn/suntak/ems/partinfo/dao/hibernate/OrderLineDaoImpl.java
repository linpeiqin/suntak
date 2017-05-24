package cn.suntak.ems.partinfo.dao.hibernate;



import java.util.ArrayList;
import java.util.List;

import cn.oz.dao.Page;
import cn.oz.dao.hibernate.SimpleDaoImpl;
import cn.oz.search.SearchQuery;
import cn.oz.util.StringUtils;
import cn.suntak.ems.partinfo.dao.OrderLineDao;
import cn.suntak.ems.partinfo.domain.OrderLine;

/**
 * 
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class OrderLineDaoImpl extends SimpleDaoImpl<OrderLine, Long> implements OrderLineDao {
	
	@Override
	protected String[] getDbftSearchFields() {
		return new String[] {"partName","partNo","type","orderHead.supplier"};
	}
	
	@Override
	public void getPage(Page page,String dbftSearchParams,SearchQuery searchQuery,Long partId) {
		// TODO Auto-generated method stub
		List<Object> args = new ArrayList<Object>();
		String hql = "from OrderLine orderLine where 1=1 ";
		String fullTextSql = this.getDbftSearchCondition(this.getDbftSearchFields(), dbftSearchParams, "orderLine", args);
		if(null != fullTextSql) {
			hql += "and " +fullTextSql;
		}
		// 添加其他检索条件
		if (null != searchQuery) {
			String sq = searchQuery.getQueryStatement("orderLine", args);
			if (!StringUtils.isNullString(sq)){
				String shq = sq.replace('_','.');
				hql += "and " + shq;
			}
		}
		if (partId!=-1){
			hql +="and orderLine.partId= ? ";
			args.add(partId);
		}
        this.getPage(page, hql, args.toArray(), "orderLine", page.getOrder());
	}

	@Override
	public List<OrderLine> findByHeadId(Long id) {
		return this.findBy("orderHead.id",id);
	}


}