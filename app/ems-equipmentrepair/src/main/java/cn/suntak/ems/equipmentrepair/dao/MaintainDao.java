package cn.suntak.ems.equipmentrepair.dao;

import cn.oz.dao.Page;
import cn.oz.dao.SimpleDao;
import cn.oz.search.SearchQuery;
import cn.suntak.ems.equipmentrepair.domain.Maintain;

public interface MaintainDao extends SimpleDao <Maintain, Long>{
    void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long equipmentId,String classify);
    void getSViewPage(Page page,  Long equipmentId);

    Integer findDateScapNum(String by, String maintain);
	boolean isExistByRepairTimeId(Long repairTimeId);
}
