package cn.suntak.ems.equipmentrepair.service;

import java.util.List;
import java.util.Set;

import cn.oz.dao.Page;
import cn.oz.module.organize.domain.OzUserInfo;
import cn.oz.organize.UserInfo;
import cn.oz.search.SearchQuery;
import cn.oz.service.SimpleService;
import cn.oz.util.SelectOption;
import cn.suntak.ems.equipmentrepair.domain.RepairRecord;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public interface RepairRecordService extends SimpleService<RepairRecord, Long>{

	void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long equipmentId, String classify);
	List<SelectOption> getFaultClass();
	List<SelectOption> geteDegree();
	List<SelectOption> getMaintenaceLevel();
	List<SelectOption> getMaintenaceLevelM();
	List<UserInfo>  findAllByCode(String code);
    Integer findDateScapNum(String by, String repair);

	Boolean updateStatus(Long id, Integer status);

	List<SelectOption> getProjectName();

	void createOrderHeadTemp(RepairRecord repairRecord);
	
	List<SelectOption> getIntervalSelect();

	void getSViewPage(Page page, Long equipmentId);
}
