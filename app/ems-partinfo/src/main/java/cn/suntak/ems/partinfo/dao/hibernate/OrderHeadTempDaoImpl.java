package cn.suntak.ems.partinfo.dao.hibernate;


import cn.oz.UserContextHolder;
import cn.oz.dao.Page;
import cn.oz.dao.hibernate.SimpleDaoImpl;
import cn.oz.util.StringUtils;
import cn.suntak.ems.partinfo.dao.OrderHeadTempDao;
import cn.suntak.ems.partinfo.domain.OrderHeadTemp;

import java.util.ArrayList;
import java.util.List;

/**
 * 
 * 
 * @author linking	
 * @version 1.0.0
 * @since 1.0.0
 */
public class OrderHeadTempDaoImpl extends SimpleDaoImpl<OrderHeadTemp, Long> implements OrderHeadTempDao {

	@Override
	public void getPage(Page page, String dbftSearchParams) {
		List<Object> args = new ArrayList<Object>();
		String hql = "from OrderHeadTemp orderHeadTemp where 1=1 ";
		String fullTextSql = this.getDbftSearchCondition(this.getDbftSearchFields(), dbftSearchParams, "orderHeadTemp", args);
		if(null != fullTextSql) {
			hql += "and " +fullTextSql;
		}
		hql += initOrgId();
		hql +=" order by orderHeadTemp.dateTime";
		this.getPage(page, hql, args.toArray(), "orderHeadTemp", page.getOrder());
	}

	private String initOrgId(){
		String orgId = UserContextHolder.getCurUserInfo().getUnit().getCode();
		return  " and orderHeadTemp.organizationId = " + orgId;
	}
	@Override
	protected String[] getDbftSearchFields() {
		return new String[] {"equipmentDetails.equipmentName","orderNo","useP.name"};
	}




}