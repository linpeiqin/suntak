package cn.suntak.ems.equipmentrepair.service;

import java.util.List;

import cn.oz.dao.Page;
import cn.oz.search.SearchQuery;
import cn.oz.service.SimpleService;
import cn.oz.util.SelectOption;
import cn.suntak.ems.equipmentrepair.domain.FaultDesc;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public interface FaultDescService extends SimpleService<FaultDesc, Long>{
	void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery);
	List<SelectOption> getFaultType();
}
