package cn.suntak.ems.equipmentlifecycle.service;

import cn.oz.service.SimpleService;
import cn.suntak.ems.equipmentlifecycle.domain.EBSEntity;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public interface EbsViewService extends SimpleService<EBSEntity, Long>{

	EBSEntity loadByAssetId(String assetId);
}
