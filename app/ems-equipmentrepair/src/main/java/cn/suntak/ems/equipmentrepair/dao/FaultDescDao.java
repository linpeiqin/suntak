package cn.suntak.ems.equipmentrepair.dao;



import cn.oz.dao.Page;
import cn.oz.dao.SimpleDao;
import cn.oz.search.SearchQuery;
import cn.suntak.ems.equipmentrepair.domain.FaultDesc;

/**
 * 
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public interface FaultDescDao extends SimpleDao<FaultDesc, Long> {

    void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery);

}