package cn.suntak.ems.partinfo.service;

import cn.oz.dao.Page;
import cn.oz.search.SearchQuery;
import cn.oz.service.SimpleService;
import cn.suntak.ems.partinfo.domain.EPUnion;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public interface EPUnionService extends SimpleService<EPUnion, Long>{
	void getPage(Page page, SearchQuery searchQuery);
}
