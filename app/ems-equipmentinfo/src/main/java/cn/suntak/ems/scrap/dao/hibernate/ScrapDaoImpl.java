package cn.suntak.ems.scrap.dao.hibernate;



import cn.suntak.ems.common.dao.hibernate.EMSCRUD2DaoImpl;
import cn.suntak.ems.scrap.dao.ScrapDao;
import cn.suntak.ems.scrap.domain.Scrap;

/**
 * 
 * 
 * @author linking	
 * @version 1.0.0
 * @since 1.0.0
 */
public class ScrapDaoImpl extends EMSCRUD2DaoImpl<Scrap, Long> implements ScrapDao {
	
	@Override
	protected String[] getDbftSearchFields() {
		return new String[] {};
	}
	
	
}