package cn.suntak.ems.renewal.dao.hibernate;



import cn.suntak.ems.common.dao.hibernate.EMSCRUD2DaoImpl;
import cn.suntak.ems.renewal.dao.RenewalDao;
import cn.suntak.ems.renewal.domain.Renewal;

/**
 * 
 * 
 * @author linking	
 * @version 1.0.0
 * @since 1.0.0
 */
public class RenewalDaoImpl extends EMSCRUD2DaoImpl<Renewal, Long> implements RenewalDao {
	
	@Override
	protected String[] getDbftSearchFields() {
		return new String[] {};
	}
	
	
	
}