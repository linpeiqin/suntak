package cn.suntak.ems.equipmentrepair.service.impl;

import cn.oz.exception.OzException;
import cn.oz.service.CRUDServiceImpl;
import cn.suntak.ems.equipmentrepair.dao.MaintainContentDao;
import cn.suntak.ems.equipmentrepair.domain.MaintainContent;
import cn.suntak.ems.equipmentrepair.service.MaintainContentService;



public class MaintainContentServiceImpl extends CRUDServiceImpl< MaintainContent, Long,  MaintainContentDao> implements  MaintainContentService{

	@Override
	public MaintainContent create() throws OzException {
		// TODO Auto-generated method stub
		return new MaintainContent();
	}

	@Override
	public int delByMaintainId(Long maintainId) {
		// TODO Auto-generated method stub
		return this.simpleDao.delByMaintainId(maintainId);
	}

}
