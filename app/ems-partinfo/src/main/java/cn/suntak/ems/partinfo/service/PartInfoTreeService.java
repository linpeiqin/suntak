package cn.suntak.ems.partinfo.service;

import java.util.Date;
import java.util.List;

import cn.oz.config.service.DataDictService;
import cn.oz.dao.Page;
import cn.oz.search.SearchQuery;
import cn.oz.service.SimpleService;
import cn.suntak.ems.equipmentdetails.service.EquipmentDetailsService;
import cn.suntak.ems.partinfo.domain.PartInfoTree;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public interface PartInfoTreeService extends SimpleService<PartInfoTree, Long>{

    List<PartInfoTree> findByParent(long parentId);

    void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long parentId,Long equipmentId,boolean flag);
    
    Boolean updateReplaceDate(Date replanceDate,Long equipmentId,Long partId);

	Integer findDatePartNum(String beginDate, String endDate);

	List<PartInfoTree> getNextReplaceByDate(String beginDate, String endDate);

	PartInfoTree loadByEquipmentId(Long equipmentId);

	void synchroDataDict(Long parentId, String section,
			DataDictService dataDictService,EquipmentDetailsService equipmentDetailsService);

}
