package cn.suntak.ems.partinfo.service.impl;



import cn.oz.exception.OzException;
import cn.oz.service.CRUDServiceImpl;
import cn.suntak.ems.partinfo.dao.PRHeadDao;
import cn.suntak.ems.partinfo.domain.PRHead;
import cn.suntak.ems.partinfo.service.PRHeadService;

import java.util.Date;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class PRHeadServiceImpl extends CRUDServiceImpl< PRHead, Long,  PRHeadDao> implements  PRHeadService{

	@Override
	public PRHead create() throws OzException {
		PRHead prHead = new PRHead();
		prHead.setPrDate(new Date());
		prHead.setEbsState(-1);
		return prHead;
	}




}
