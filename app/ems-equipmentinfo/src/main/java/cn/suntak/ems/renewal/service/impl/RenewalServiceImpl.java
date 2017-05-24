package cn.suntak.ems.renewal.service.impl;



import cn.oz.exception.OzException;
import cn.suntak.ems.common.service.impl.EMSCRUD2ServiceImpl;
import cn.suntak.ems.renewal.dao.RenewalDao;
import cn.suntak.ems.renewal.domain.Renewal;
import cn.suntak.ems.renewal.service.RenewalService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class RenewalServiceImpl extends EMSCRUD2ServiceImpl< Renewal, Long,  RenewalDao> implements  RenewalService{

	@Override
	public Renewal create() throws OzException {
		
		Renewal renewal = new Renewal();
		renewal.setType("renewal");
		renewal.setProcessState(0);
		return renewal;
	}


	
}
