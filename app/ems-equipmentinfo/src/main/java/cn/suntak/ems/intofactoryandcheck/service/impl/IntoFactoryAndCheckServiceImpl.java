package cn.suntak.ems.intofactoryandcheck.service.impl;



import cn.oz.exception.OzException;
import cn.suntak.ems.common.service.impl.EMSCRUD2ServiceImpl;
import cn.suntak.ems.intofactoryandcheck.dao.IntoFactoryAndCheckDao;
import cn.suntak.ems.intofactoryandcheck.domain.IntoFactoryAndCheck;
import cn.suntak.ems.intofactoryandcheck.service.IntoFactoryAndCheckService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class IntoFactoryAndCheckServiceImpl extends EMSCRUD2ServiceImpl< IntoFactoryAndCheck, Long,  IntoFactoryAndCheckDao> implements  IntoFactoryAndCheckService{

	@Override
	public IntoFactoryAndCheck create() throws OzException {
		IntoFactoryAndCheck intoFactoryAndCheck = new IntoFactoryAndCheck();
		intoFactoryAndCheck.setType("intoFactoryAndCheck");
		intoFactoryAndCheck.setProcessState(0);
		intoFactoryAndCheck.setEstimateUsefulLife("120");
		
		return intoFactoryAndCheck;
	}
}
