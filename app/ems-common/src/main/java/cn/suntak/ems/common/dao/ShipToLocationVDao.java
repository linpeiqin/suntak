package cn.suntak.ems.common.dao;

import java.util.List;

import cn.suntak.ems.common.domain.ShipToLocationV;

/**
 * Created by Administrator on 2016/12/10.
 */
public interface ShipToLocationVDao {

	List<ShipToLocationV> getShipToLocationList();

	ShipToLocationV getShipToLocationBy(String location);
}
