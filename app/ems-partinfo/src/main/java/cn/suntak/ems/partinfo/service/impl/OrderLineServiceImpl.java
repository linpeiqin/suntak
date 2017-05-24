package cn.suntak.ems.partinfo.service.impl;



import cn.oz.dao.Page;
import cn.oz.exception.OzException;
import cn.oz.search.SearchQuery;
import cn.oz.service.CRUDServiceImpl;
import cn.suntak.ems.partinfo.dao.OrderLineDao;
import cn.suntak.ems.partinfo.domain.OrderLine;
import cn.suntak.ems.partinfo.service.OrderLineService;

import java.util.List;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class OrderLineServiceImpl extends CRUDServiceImpl< OrderLine, Long,  OrderLineDao> implements  OrderLineService{

	@Override
	public OrderLine create() throws OzException {
		
		return new OrderLine();
	}


	@Override
	public void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long partId) {
		this.getSimpleDao().getPage(page,dbftSearchParams, searchQuery,partId);
	}

	@Override
	public List<OrderLine> findByHeadId(Long id) {
		return this.simpleDao.findByHeadId(id);
	}
}
