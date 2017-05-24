package cn.suntak.ems.renewalandcheck.service.impl;



import cn.oz.exception.OzException;
import cn.suntak.ems.common.service.impl.EMSCRUD2ServiceImpl;
import cn.suntak.ems.renewalandcheck.dao.RenewalAndCheckDao;
import cn.suntak.ems.renewalandcheck.domain.RenewalAndCheck;
import cn.suntak.ems.renewalandcheck.service.RenewalAndCheckService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class RenewalAndCheckServiceImpl extends EMSCRUD2ServiceImpl< RenewalAndCheck, Long,  RenewalAndCheckDao> implements  RenewalAndCheckService{

	@Override
	public RenewalAndCheck create() throws OzException {
		
		RenewalAndCheck renewalandcheck = new RenewalAndCheck();
		renewalandcheck.setType("renewalAndCheck");
		renewalandcheck.setProcessState(0);
		return renewalandcheck;
	}


	
}
