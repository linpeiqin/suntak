package cn.suntak.ems.completion.dao.hibernate;



import cn.suntak.ems.common.dao.hibernate.EMSCRUD2DaoImpl;
import cn.suntak.ems.completion.dao.CompletionDao;
import cn.suntak.ems.completion.domain.Completion;

/**
 * 
 * 
 * @author linking	
 * @version 1.0.0
 * @since 1.0.0
 */
public class CompletionDaoImpl extends EMSCRUD2DaoImpl<Completion, Long> implements CompletionDao {
	
	@Override
	protected String[] getDbftSearchFields() {
		return new String[] {};
	}

	
	
}