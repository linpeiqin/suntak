package cn.suntak.ems.internaltransfer.service.impl;



import cn.oz.exception.OzException;
import cn.suntak.ems.common.service.impl.EMSCRUD2ServiceImpl;
import cn.suntak.ems.internaltransfer.dao.InternalTransferDao;
import cn.suntak.ems.internaltransfer.domain.InternalTransfer;
import cn.suntak.ems.internaltransfer.service.InternalTransferService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class InternalTransferServiceImpl extends EMSCRUD2ServiceImpl< InternalTransfer, Long,  InternalTransferDao> implements  InternalTransferService{

	@Override
	public InternalTransfer create() throws OzException {
		InternalTransfer internalTransfer = new InternalTransfer();
		internalTransfer.setType("internalTransfer");
		internalTransfer.setProcessState(0);
		return internalTransfer;
	}


}
