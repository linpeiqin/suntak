package cn.suntak.ems.partinfo.dao;



import cn.oz.dao.Page;
import cn.oz.dao.SimpleDao;
import cn.oz.search.SearchQuery;
import cn.suntak.ems.partinfo.domain.PartInfo;

/**
 * 
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public interface PartInfoDao extends SimpleDao<PartInfo, Long> {


    void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long orgId);

	PartInfo getPartInfoBy(long partId);
}