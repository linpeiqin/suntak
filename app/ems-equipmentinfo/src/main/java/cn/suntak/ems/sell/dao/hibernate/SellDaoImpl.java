package cn.suntak.ems.sell.dao.hibernate;



import cn.suntak.ems.common.dao.hibernate.EMSCRUD2DaoImpl;
import cn.suntak.ems.sell.dao.SellDao;
import cn.suntak.ems.sell.domain.Sell;

/**
 * 
 * 
 * @author linking	
 * @version 1.0.0
 * @since 1.0.0
 */
public class SellDaoImpl extends EMSCRUD2DaoImpl<Sell, Long> implements SellDao {
	
	@Override
	protected String[] getDbftSearchFields() {
		return new String[] {};
	}
	
}