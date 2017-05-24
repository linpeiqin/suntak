package cn.suntak.ems.partinfo.service;

import cn.oz.dao.Page;
import cn.oz.search.SearchQuery;
import cn.oz.service.SimpleService;
import cn.suntak.ems.partinfo.domain.OrderHead;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public interface OrderHeadService extends SimpleService<OrderHead, Long>{

	void getPage(Page page, SearchQuery searchQuery);
	
}
