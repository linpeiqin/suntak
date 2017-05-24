package cn.suntak.ems.equipmentrepair.service;

import java.util.List;
import java.util.Map;

import cn.oz.service.SimpleService;
import cn.suntak.ems.equipmentrepair.domain.MonthPlanDetail;

public interface MonthPlanDetailService extends SimpleService<MonthPlanDetail, Long>{

	List<Map<String, String>> pakeDetails(Long monthPlanId);

	void delByPlanId(Long monthPlanId);

}
