package cn.suntak.ems.common.dao.hibernate;

import java.util.List;

import cn.oz.dao.hibernate.HibernateDao;
import cn.suntak.ems.common.dao.PoMethodVDao;
import cn.suntak.ems.common.domain.PoMethodV;

/**
 * Created by Administrator on 2016/12/10.
 */
public class PoMethodVDaoImpl extends HibernateDao<PoMethodV, Long> implements PoMethodVDao {

	@Override
	public List<PoMethodV> getPoMethodList() {
		// TODO Auto-generated method stub
		List<PoMethodV> poMethodVs = this.loadAll();
		return poMethodVs;
	}
}
