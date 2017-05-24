package cn.suntak.ems.equipmentrepair.service;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import cn.oz.dao.Page;
import cn.oz.search.SearchQuery;
import cn.oz.service.SimpleService;
import cn.suntak.ems.equipmentrepair.domain.RepairPlan;
import cn.suntak.ems.equipmentrepair.domain.RepairPlanTime;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public interface RepairPlanService extends SimpleService<RepairPlan, Long>{

	void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long equipmentId,  String classify);

    List<RepairPlanTime> findDateScap(Date startDate, Date endDate);

    Integer findDateScapNum(String oe, String repair);

	RepairPlan loadByEquipment(Long equipmentId,String type);

	void updateNextTime(Long equipmentId, String type);

	List<RepairPlan> loadAll();

	void getSViewPage(Page page, Long equipmentId);

    List<RepairPlanTime> findAllByPlanId(Long planId);

    void getPageTime(Page page, String dbftSearchParams, SearchQuery searchQuery, Long planId);
    /**
     * 生成某集团某年计划时间
     * @param repairPlan
     * @param year
     * @return
     */
    void setPlanTimeByYear(String year,String orgId);

	void newOrEdit(HttpServletRequest request, RepairPlan domain, boolean b);
	
	List<RepairPlan> loadAllByOrgId(String orgId);

}
