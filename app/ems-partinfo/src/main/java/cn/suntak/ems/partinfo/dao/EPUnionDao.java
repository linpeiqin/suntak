package cn.suntak.ems.partinfo.dao;



import cn.oz.dao.Page;
import cn.oz.dao.SimpleDao;
import cn.oz.search.SearchQuery;
import cn.suntak.ems.partinfo.domain.EPUnion;

/**
 * 
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public interface EPUnionDao extends SimpleDao<EPUnion, Long> {
	void getPage(Page page, SearchQuery searchQuery);
}