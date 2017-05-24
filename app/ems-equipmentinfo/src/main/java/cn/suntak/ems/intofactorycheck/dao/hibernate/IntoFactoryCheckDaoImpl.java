package cn.suntak.ems.intofactorycheck.dao.hibernate;



import cn.suntak.ems.common.dao.hibernate.EMSCRUD2DaoImpl;
import cn.suntak.ems.intofactorycheck.dao.IntoFactoryCheckDao;
import cn.suntak.ems.intofactorycheck.domain.IntoFactoryCheck;

/**
 * 
 * 
 * @author linking	
 * @version 1.0.0
 * @since 1.0.0
 */
public class IntoFactoryCheckDaoImpl extends EMSCRUD2DaoImpl<IntoFactoryCheck, Long> implements IntoFactoryCheckDao {
	
	@Override
	protected String[] getDbftSearchFields() {
		return new String[] {};
	}
	
	
	
}