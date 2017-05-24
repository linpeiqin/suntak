package cn.suntak.ems.equipmentrepair.service.impl;

import java.util.List;
import java.util.Map;

import cn.oz.exception.OzException;
import cn.oz.service.CRUDServiceImpl;
import cn.suntak.ems.equipmentrepair.dao.MonthPlanDetailDao;
import cn.suntak.ems.equipmentrepair.domain.MonthPlanDetail;
import cn.suntak.ems.equipmentrepair.service.MonthPlanDetailService;

public class MonthPlanDetailServiceImpl extends CRUDServiceImpl< MonthPlanDetail, Long,  MonthPlanDetailDao> implements  MonthPlanDetailService{

	@Override
	public MonthPlanDetail create() throws OzException {
		// TODO Auto-generated method stub
		return new MonthPlanDetail();
	}

	@Override
	public List<Map<String, String>> pakeDetails(Long monthPlanId) {
		// TODO Auto-generated method stub
		return this.simpleDao.pakeDetails(monthPlanId);
	}

	@Override
	public void delByPlanId(Long monthPlanId) {
		// TODO Auto-generated method stub
		this.simpleDao.delByPlanId(monthPlanId);
	}

}
