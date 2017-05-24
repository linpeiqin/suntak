package cn.suntak.ems.common.dao.hibernate;

import java.util.List;

import cn.oz.dao.hibernate.HibernateDao;
import cn.suntak.ems.common.dao.ShipToLocationVDao;
import cn.suntak.ems.common.domain.ShipToLocationV;

/**
 * Created by Administrator on 2016/12/10.
 */
public class ShipToLocationVDaoImpl extends HibernateDao<ShipToLocationV, Long> implements ShipToLocationVDao {

	@Override
	public List<ShipToLocationV> getShipToLocationList() {
		// TODO Auto-generated method stub
        List<ShipToLocationV> shipToLocationVs = this.loadAll();
        return shipToLocationVs;
	}

	@Override
	public ShipToLocationV getShipToLocationBy(String location) {
		// TODO Auto-generated method stub
		return this.findUniqueBy("location",location);
	}
}
