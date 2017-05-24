package cn.suntak.ems.partinfo.service;

import java.util.List;

import cn.oz.dao.Page;
import cn.oz.search.SearchQuery;
import cn.oz.service.SimpleService;
import cn.oz.util.SelectOption;
import cn.suntak.ems.partinfo.domain.PartQuality;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public interface PartQualityService extends SimpleService<PartQuality, Long>{
	public List<SelectOption> getQualityType();
	void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long partId);
}
