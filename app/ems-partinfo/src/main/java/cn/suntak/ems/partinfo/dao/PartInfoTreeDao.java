package cn.suntak.ems.partinfo.dao;



import cn.oz.dao.Page;
import cn.oz.dao.SimpleDao;
import cn.oz.search.SearchQuery;
import cn.suntak.ems.partinfo.domain.PartInfoTree;

import java.util.List;

/**
 * 
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public interface PartInfoTreeDao extends SimpleDao<PartInfoTree, Long> {
    List<PartInfoTree> findByParent(long parentId);

    void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long parentId,Long equipmentId,boolean flag);

	PartInfoTree loadByEquipmentId(Long equipmentId);

	List<PartInfoTree> getNextReplaceByDate(String beginDate, String endDate);

}