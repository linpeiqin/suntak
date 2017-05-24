package cn.suntak.ems.partinfo.service.impl;



import java.util.Date;

import cn.oz.UserContextHolder;
import cn.oz.exception.OzException;
import cn.oz.service.CRUDServiceImpl;
import cn.suntak.ems.partinfo.dao.OrderHeadTempDao;
import cn.suntak.ems.partinfo.domain.OrderHeadTemp;
import cn.suntak.ems.partinfo.service.OrderHeadTempService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class OrderHeadTempServiceImpl extends CRUDServiceImpl<OrderHeadTemp, Long, OrderHeadTempDao> implements OrderHeadTempService {

	@Override
	public OrderHeadTemp create() throws OzException {
		OrderHeadTemp domain = new OrderHeadTemp();
		domain.setEbsState(OrderHeadTemp.NO);
		domain.setOrganizationId(Long.valueOf(UserContextHolder.getCurUserInfo().getUnit().getCode()));
		domain.setOperation(1);
		domain.setOperationType("领用出库");
		domain.setCreatedDate(new Date());
		domain.setDateTime(new Date());
		return domain;
	}


}
