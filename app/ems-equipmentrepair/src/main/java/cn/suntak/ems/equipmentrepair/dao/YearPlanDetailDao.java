package cn.suntak.ems.equipmentrepair.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.oz.dao.SimpleDao;
import cn.suntak.ems.equipmentrepair.domain.YearPlanDetail;

public interface YearPlanDetailDao extends SimpleDao<YearPlanDetail, Long>{

	List<Map<String, String>> pakeDetails(Long yearPlanId);

	List<YearPlanDetail> getOrderDetails(Long yearPlanId);

	List<HashMap<String, String>> getGroupLevel(Long yearPlanId);

	void delByPlanId(Long yearPlanId);

}
