package cn.suntak.ems.intofactorycheck.service.impl;



import cn.oz.exception.OzException;
import cn.suntak.ems.common.service.impl.EMSCRUD2ServiceImpl;
import cn.suntak.ems.equipmentdetails.domain.EquipmentDetails;
import cn.suntak.ems.intofactorycheck.dao.IntoFactoryCheckDao;
import cn.suntak.ems.intofactorycheck.domain.IntoFactoryCheck;
import cn.suntak.ems.intofactorycheck.service.IntoFactoryCheckService;

import java.util.Set;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class IntoFactoryCheckServiceImpl extends EMSCRUD2ServiceImpl< IntoFactoryCheck, Long,  IntoFactoryCheckDao> implements  IntoFactoryCheckService{

	@Override
	public IntoFactoryCheck create() throws OzException {
		
		IntoFactoryCheck intoFactoryCheck = new IntoFactoryCheck();
		intoFactoryCheck.setType("intoFactoryCheck");
		intoFactoryCheck.setProcessState(0);
		return intoFactoryCheck;
	}


}
