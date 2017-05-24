package cn.suntak.ems.renewalcheck.service.impl;



import cn.oz.exception.OzException;
import cn.suntak.ems.common.service.impl.EMSCRUD2ServiceImpl;
import cn.suntak.ems.renewalcheck.dao.RenewalCheckDao;
import cn.suntak.ems.renewalcheck.domain.RenewalCheck;
import cn.suntak.ems.renewalcheck.service.RenewalCheckService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class RenewalCheckServiceImpl extends EMSCRUD2ServiceImpl< RenewalCheck, Long,  RenewalCheckDao> implements  RenewalCheckService{

	@Override
	public RenewalCheck create() throws OzException {
		
		RenewalCheck renewalCheck = new RenewalCheck();
		renewalCheck.setType("renewalCheck");
		renewalCheck.setProcessState(0);
		return renewalCheck;
	}
}
