package cn.suntak.ems.equipmentrepair.dao;



import java.util.Date;
import java.util.List;

import cn.oz.dao.Page;
import cn.oz.dao.SimpleDao;
import cn.oz.search.SearchQuery;
import cn.suntak.ems.equipmentrepair.domain.RepairPlan;
import cn.suntak.ems.equipmentrepair.domain.RepairPlanTime;

/**
 * 
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public interface RepairPlanDao extends SimpleDao<RepairPlan, Long> {
	
    List<RepairPlanTime> findDateScap(Date startDate, Date endDate);

    void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long equipmentId,  String classify);

    Integer findDateScapNum(String scap, String type);

	RepairPlan loadByEquipment(Long equipmentId,String type);

    void getSViewPage(Page page, Long equipmentId);

    List<RepairPlanTime> findAllByPlanId(Long planId);

    void getPageTime(Page page, String dbftSearchParams, SearchQuery searchQuery, Long planId);

	List<RepairPlan> loadAllByOrgId(String orgId);
}