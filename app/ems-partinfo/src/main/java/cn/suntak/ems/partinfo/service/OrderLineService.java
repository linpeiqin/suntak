package cn.suntak.ems.partinfo.service;

import cn.oz.dao.Page;
import cn.oz.search.SearchQuery;
import cn.oz.service.SimpleService;
import cn.suntak.ems.partinfo.domain.OrderLine;

import java.util.List;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public interface OrderLineService extends SimpleService<OrderLine, Long>{

	void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long partId);

    List<OrderLine> findByHeadId(Long id);
}
