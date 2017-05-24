package cn.suntak.ems.equipmentdetails.service;

import cn.oz.dao.Page;
import cn.oz.json.JSONObject;
import cn.oz.search.SearchQuery;
import cn.oz.service.SimpleService;
import cn.suntak.ems.equipmentdetails.domain.TechnicalParams;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public interface TechnicalParamsService extends SimpleService<TechnicalParams, Long>{

	void getPage(Page page, SearchQuery searchQuery);

	void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long equipmentId);

	JSONObject getTechParaJson(String dbftSearchParams,
			SearchQuery searchQuery, Long equipmentId);
}
