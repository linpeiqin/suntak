package cn.suntak.ems.renewalcheck.dao.hibernate;



import cn.suntak.ems.common.dao.hibernate.EMSCRUD2DaoImpl;
import cn.suntak.ems.renewalcheck.dao.RenewalCheckDao;
import cn.suntak.ems.renewalcheck.domain.RenewalCheck;

/**
 * 
 * 
 * @author linking	
 * @version 1.0.0
 * @since 1.0.0
 */
public class RenewalCheckDaoImpl extends EMSCRUD2DaoImpl<RenewalCheck, Long> implements RenewalCheckDao {
	
	@Override
	protected String[] getDbftSearchFields() {
		return new String[] {};
	}
	
	
	
}