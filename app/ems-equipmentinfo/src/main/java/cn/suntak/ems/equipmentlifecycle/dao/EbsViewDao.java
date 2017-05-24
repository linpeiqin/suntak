package cn.suntak.ems.equipmentlifecycle.dao;



import cn.oz.dao.Page;
import cn.oz.dao.SimpleDao;
import cn.oz.search.SearchQuery;
import cn.suntak.ems.equipmentlifecycle.domain.EBSEntity;
import cn.suntak.ems.equipmentlifecycle.domain.EBSEntity;

/**
 * 
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public interface EbsViewDao extends SimpleDao<EBSEntity, Long> {

	EBSEntity loadByAssetId(String assetId);
}