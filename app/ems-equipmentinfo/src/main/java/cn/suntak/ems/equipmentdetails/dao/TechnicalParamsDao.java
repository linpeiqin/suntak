package cn.suntak.ems.equipmentdetails.dao;



import java.util.List;

import cn.oz.dao.Page;
import cn.oz.dao.SimpleDao;
import cn.oz.search.SearchQuery;
import cn.suntak.ems.equipmentdetails.domain.TechnicalParams;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public interface TechnicalParamsDao extends SimpleDao<TechnicalParams, Long> {
	
	void getPage(Page page, SearchQuery searchQuery);

    void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long equipmentId);

	List<TechnicalParams> getTechParaList(SearchQuery searchQuery,
			Long equipmentId);
}