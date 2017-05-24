package cn.suntak.ems.intofactory.service.impl;



import cn.oz.exception.OzException;
import cn.suntak.ems.common.service.impl.EMSCRUD2ServiceImpl;
import cn.suntak.ems.intofactory.dao.IntoFactoryDao;
import cn.suntak.ems.intofactory.domain.IntoFactory;
import cn.suntak.ems.intofactory.service.IntoFactoryService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class IntoFactoryServiceImpl extends EMSCRUD2ServiceImpl< IntoFactory, Long,  IntoFactoryDao> implements  IntoFactoryService{

	@Override
	public IntoFactory create() throws OzException {
		IntoFactory intoFactory = new IntoFactory();
		intoFactory.setType("intoFactory");
		intoFactory.setProcessState(0);
		intoFactory.setEstimateUsefulLife("120");
		
		return intoFactory;
	}
}
