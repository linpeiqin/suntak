package cn.suntak.ems.partinfo.service.impl;



import cn.oz.dao.Page;
import cn.oz.exception.OzException;
import cn.oz.search.SearchQuery;
import cn.oz.service.CRUDServiceImpl;
import cn.suntak.ems.partinfo.dao.OrderHeadDao;
import cn.suntak.ems.partinfo.domain.OrderHead;
import cn.suntak.ems.partinfo.service.OrderHeadService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class OrderHeadServiceImpl extends CRUDServiceImpl< OrderHead, Long,  OrderHeadDao> implements  OrderHeadService{

	@Override
	public OrderHead create() throws OzException {
		
		return new OrderHead();
	}

	@Override
	public void getPage(Page page, SearchQuery searchQuery) {

		this.getSimpleDao().getPage(page, searchQuery);
	}
	
}
