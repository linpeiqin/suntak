package cn.suntak.ems.completioncheck.dao.hibernate;



import cn.suntak.ems.common.dao.hibernate.EMSCRUD2DaoImpl;
import cn.suntak.ems.completioncheck.dao.CompletionCheckDao;
import cn.suntak.ems.completioncheck.domain.CompletionCheck;

/**
 * 
 * 
 * @author linking	
 * @version 1.0.0
 * @since 1.0.0
 */
public class CompletionCheckDaoImpl extends EMSCRUD2DaoImpl<CompletionCheck, Long> implements CompletionCheckDao {
	
	@Override
	protected String[] getDbftSearchFields() {
		return new String[] {};
	}
	
	
}