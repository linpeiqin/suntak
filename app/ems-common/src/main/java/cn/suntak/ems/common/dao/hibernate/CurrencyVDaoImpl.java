package cn.suntak.ems.common.dao.hibernate;
import java.util.List;

import cn.oz.dao.hibernate.HibernateDao;
import cn.suntak.ems.common.dao.CurrencyVDao;
import cn.suntak.ems.common.domain.CurrencyV;
/**
 * Created by Administrator on 2016/12/10.
 */
public class CurrencyVDaoImpl extends HibernateDao<CurrencyV,Long> implements CurrencyVDao {

	@Override
	public List<CurrencyV> getCurrencyList() {
		// TODO Auto-generated method stub
		 List<CurrencyV> currencyVs = this.loadAll();
	     return currencyVs;
	}

	@Override
	public CurrencyV getCurrencyBy(String currencyCode) {
		// TODO Auto-generated method stub
		return this.findUniqueBy("currencyCode",currencyCode);
	}
}
