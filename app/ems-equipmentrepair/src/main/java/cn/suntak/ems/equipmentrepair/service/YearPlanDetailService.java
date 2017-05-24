package cn.suntak.ems.equipmentrepair.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.oz.service.SimpleService;
import cn.suntak.ems.equipmentrepair.domain.YearPlanDetail;

public interface YearPlanDetailService extends SimpleService<YearPlanDetail, Long>{

	List<Map<String, String>> pakeDetails(Long yearPlanId);

	List<YearPlanDetail> getOrderDetails(Long yearPlanId);

	List<HashMap<String, String>> getGroupLevel(Long yearPlanId);
	
	void delByPlanId(Long yearPlanId);

}
