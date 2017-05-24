package cn.suntak.ems.equipmentrepair.service;

import java.util.List;

import cn.oz.dao.Page;
import cn.oz.search.SearchQuery;
import cn.oz.service.SimpleService;
import cn.oz.util.SelectOption;
import cn.suntak.ems.equipmentrepair.domain.Maintain;

public interface MaintainService extends SimpleService<Maintain, Long>{

	List<SelectOption> getMaintenaceLevel();
	void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long equipmentId,String classify);
	void getSViewPage(Page page, Long equipmentId);

	Integer findDateScapNum(String by, String maintain);
	void pushMaintainByDate(String begindateStr,String enddateStr);
}
