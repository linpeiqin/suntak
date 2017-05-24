package cn.suntak.ems.renewalandcheck.dao.hibernate;



import cn.suntak.ems.common.dao.hibernate.EMSCRUD2DaoImpl;
import cn.suntak.ems.renewalandcheck.dao.RenewalAndCheckDao;
import cn.suntak.ems.renewalandcheck.domain.RenewalAndCheck;

/**
 * 
 * 
 * @author linking	
 * @version 1.0.0
 * @since 1.0.0
 */
public class RenewalAndCheckDaoImpl extends EMSCRUD2DaoImpl<RenewalAndCheck, Long> implements RenewalAndCheckDao {
	
	@Override
	protected String[] getDbftSearchFields() {
		return new String[] {};
	}
	
	
	
}