package cn.suntak.ems.intofactoryandcheck.dao.hibernate;



import cn.suntak.ems.common.dao.hibernate.EMSCRUD2DaoImpl;
import cn.suntak.ems.intofactoryandcheck.dao.IntoFactoryAndCheckDao;
import cn.suntak.ems.intofactoryandcheck.domain.IntoFactoryAndCheck;

/**
 * 
 * 
 * @author linking	
 * @version 1.0.0
 * @since 1.0.0
 */
public class IntoFactoryAndCheckDaoImpl extends EMSCRUD2DaoImpl<IntoFactoryAndCheck, Long> implements IntoFactoryAndCheckDao {
	
	@Override
	protected String[] getDbftSearchFields() {
		return new String[] {};
	}
	

}