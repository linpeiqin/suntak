package cn.suntak.ems.partinfo.dao.hibernate;



import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import cn.oz.UserContextHolder;
import cn.oz.dao.hibernate.SimpleDaoImpl;
import cn.suntak.ems.partinfo.dao.PRLineDao;
import cn.suntak.ems.partinfo.domain.PRLine;
import org.hibernate.Query;

/**
 * 
 * 
 * @author linking	
 * @version 1.0.0
 * @since 1.0.0
 */
public class PRLineDaoImpl extends SimpleDaoImpl<PRLine, Long> implements PRLineDao {
	
	@Override
	protected String[] getDbftSearchFields() {
		return new String[]{"itemName","itemNo","pRHead.applByName"};
	}

	@SuppressWarnings("unchecked")
	public Set<PRLine> loadByHeadId(Long headId) {
		// TODO Auto-generated method stub
		 return (Set<PRLine>) this.findBy("HeadId", headId);
	}
	@Override
	public List<PRLine> getPRLineList() {
		String hql="FROM PRLine pRLine WHERE  pRLine.needDate is null ";
		Query q = this.getSession().createQuery(hql);
		List<PRLine> pRLines = q.list();
		if(pRLines!=null)
			return pRLines;
		return null;
	}

	@Override
	public List<PRLine> getPRLineListByDate(String date) {
		String hql="FROM PRLine pRLine WHERE pRLine.pRHead.ebsState = ? and  pRLine.needDate is null  and pRLine.isUrgent = ? and to_char(promisedDate,'yyyy-MM-dd') < ? AND pRLine.pRHead.orgId = ?";
		List<Object> args = new ArrayList<Object>();
		args.add(1);
		args.add("Y");
		args.add(date);
		args.add(UserContextHolder.getCurUserInfo().getUnit().getCode());
		return this.find(hql, args.toArray());
	}


}