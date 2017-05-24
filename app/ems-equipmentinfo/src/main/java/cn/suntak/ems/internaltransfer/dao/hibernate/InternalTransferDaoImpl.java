package cn.suntak.ems.internaltransfer.dao.hibernate;



import cn.suntak.ems.common.dao.hibernate.EMSCRUD2DaoImpl;
import cn.suntak.ems.internaltransfer.dao.InternalTransferDao;
import cn.suntak.ems.internaltransfer.domain.InternalTransfer;

/**
 * 
 * 
 * @author linking	
 * @version 1.0.0
 * @since 1.0.0
 */
public class InternalTransferDaoImpl extends EMSCRUD2DaoImpl<InternalTransfer, Long> implements InternalTransferDao {
	
	@Override
	protected String[] getDbftSearchFields() {
		return new String[] {};
	}
	
	
	
	
}