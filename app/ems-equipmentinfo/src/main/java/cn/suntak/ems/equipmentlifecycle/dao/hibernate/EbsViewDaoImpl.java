package cn.suntak.ems.equipmentlifecycle.dao.hibernate;


import cn.oz.dao.hibernate.SimpleDaoImpl;
import cn.suntak.ems.equipmentlifecycle.dao.EbsViewDao;
import cn.suntak.ems.equipmentlifecycle.domain.EBSEntity;

import java.util.List;

/**
 * 
 * 
 * @author linking	
 * @version 1.0.0
 * @since 1.0.0
 */
public class EbsViewDaoImpl extends SimpleDaoImpl<EBSEntity, Long> implements EbsViewDao {


	@Override
	protected String[] getDbftSearchFields() {
		return new String[0];
	}

	@Override
	public EBSEntity loadByAssetId(String assetId) {
		List<EBSEntity> list = this.findBy("id",new Long(assetId));
		if(list!=null&&list.size()>0){
			return list.get(0);
		}
		return null;
	}
}