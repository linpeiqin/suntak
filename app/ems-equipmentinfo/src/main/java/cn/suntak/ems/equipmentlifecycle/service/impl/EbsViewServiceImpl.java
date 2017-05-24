package cn.suntak.ems.equipmentlifecycle.service.impl;


import cn.oz.exception.OzException;
import cn.oz.service.CRUDServiceImpl;
import cn.suntak.ems.equipmentlifecycle.dao.EbsViewDao;
import cn.suntak.ems.equipmentlifecycle.domain.EBSEntity;
import cn.suntak.ems.equipmentlifecycle.service.EbsViewService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class EbsViewServiceImpl extends CRUDServiceImpl<EBSEntity, Long,  EbsViewDao> implements  EbsViewService{


	@Override
	public EBSEntity create() throws OzException {
		return null;
	}

	@Override
	public EBSEntity loadByAssetId(String assetId) {
		return this.simpleDao.loadByAssetId(assetId);
	}
}
