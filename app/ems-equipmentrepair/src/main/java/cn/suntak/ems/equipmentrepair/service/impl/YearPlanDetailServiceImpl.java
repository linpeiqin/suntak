package cn.suntak.ems.equipmentrepair.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.oz.exception.OzException;
import cn.oz.service.CRUDServiceImpl;
import cn.suntak.ems.equipmentrepair.dao.YearPlanDetailDao;
import cn.suntak.ems.equipmentrepair.domain.YearPlanDetail;
import cn.suntak.ems.equipmentrepair.service.YearPlanDetailService;

public class YearPlanDetailServiceImpl extends CRUDServiceImpl< YearPlanDetail, Long,  YearPlanDetailDao> implements YearPlanDetailService{

	@Override
	public YearPlanDetail create() throws OzException {
		// TODO Auto-generated method stub
		return new YearPlanDetail();
	}

	@Override
	public List<Map<String, String>> pakeDetails(Long yearPlanId) {
		// TODO Auto-generated method stub
		return this.simpleDao.pakeDetails(yearPlanId);
	}

	@Override
	public List<YearPlanDetail> getOrderDetails(Long yearPlanId) {
		// TODO Auto-generated method stub
		return this.simpleDao.getOrderDetails(yearPlanId);
	}

	@Override
	public List<HashMap<String, String>> getGroupLevel(Long yearPlanId) {
		// TODO Auto-generated method stub
		return this.simpleDao.getGroupLevel(yearPlanId);
	}

	@Override
	public void delByPlanId(Long yearPlanId) {
		// TODO Auto-generated method stub
		this.simpleDao.delByPlanId(yearPlanId);
	}

}




