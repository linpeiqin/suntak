package cn.suntak.ems.equipmentrepair.dao;

import java.util.List;
import java.util.Map;

import cn.oz.dao.SimpleDao;
import cn.suntak.ems.equipmentrepair.domain.MonthPlanDetail;

public interface MonthPlanDetailDao extends SimpleDao<MonthPlanDetail, Long>{

	List<Map<String, String>> pakeDetails(Long monthPlanId);

	void delByPlanId(Long monthPlanId);

}
