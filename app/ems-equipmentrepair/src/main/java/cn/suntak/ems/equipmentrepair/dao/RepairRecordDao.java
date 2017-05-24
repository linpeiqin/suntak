package cn.suntak.ems.equipmentrepair.dao;



import cn.oz.dao.Page;
import cn.oz.dao.SimpleDao;
import cn.oz.search.SearchQuery;
import cn.suntak.ems.equipmentrepair.domain.RepairRecord;

/**
 * 
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public interface RepairRecordDao extends SimpleDao<RepairRecord, Long> {
	
	void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long equipmentId,String classify);

    Integer findDateScapNum(String by, String repair);

    Boolean updateStatus(Long id, Integer status);

    void getSViewPage(Page page,  Long equipmentId);
}