package cn.suntak.ems.partinfo.service;

import cn.oz.dao.Page;
import cn.oz.search.SearchQuery;
import cn.oz.service.SimpleService;
import cn.oz.util.SelectOption;
import cn.suntak.ems.partinfo.domain.GroupInventory;
import cn.suntak.ems.partinfo.domain.PartQuality;

import java.util.List;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public interface GroupInventoryService extends SimpleService<GroupInventory, Long>{
	void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, String part);
}
