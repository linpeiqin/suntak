package cn.suntak.ems.intofactory.dao.hibernate;



import cn.suntak.ems.common.dao.hibernate.EMSCRUD2DaoImpl;
import cn.suntak.ems.intofactory.dao.IntoFactoryDao;
import cn.suntak.ems.intofactory.domain.IntoFactory;

/**
 * 
 * 
 * @author linking	
 * @version 1.0.0
 * @since 1.0.0
 */
public class IntoFactoryDaoImpl extends EMSCRUD2DaoImpl<IntoFactory, Long> implements IntoFactoryDao {
	
	@Override
	protected String[] getDbftSearchFields() {
		return new String[] {};
	}
	

}