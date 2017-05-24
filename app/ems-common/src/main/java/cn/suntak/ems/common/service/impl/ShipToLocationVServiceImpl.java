package cn.suntak.ems.common.service.impl;

import java.util.ArrayList;
import java.util.List;

import cn.oz.util.SelectOption;
import cn.suntak.ems.common.dao.ShipToLocationVDao;
import cn.suntak.ems.common.domain.ShipToLocationV;
import cn.suntak.ems.common.service.ShipToLocationVService;

/**
 * Created by Administrator on 2016/12/10.
 */
public class ShipToLocationVServiceImpl implements ShipToLocationVService {
    private ShipToLocationVDao shipToLocationVDao;

    public void setShipToLocationVDao(ShipToLocationVDao shipToLocationVDao) {
        this.shipToLocationVDao = shipToLocationVDao;
    }
	@Override
	public List<SelectOption> getShipToLocationOption() {
		// TODO Auto-generated method stub
        List<SelectOption> selectOptions = new ArrayList<SelectOption>();
        List<ShipToLocationV> shipToLocationVs = this.shipToLocationVDao.getShipToLocationList();
        selectOptions.add(new SelectOption("",""));
        for (ShipToLocationV shipToLocationV : shipToLocationVs){
            if(null!=shipToLocationV.getDescription())
            selectOptions.add(new SelectOption(shipToLocationV.getDescription(),shipToLocationV.getLocation()));
        }
        return  selectOptions;
	}

	@Override
	public ShipToLocationV getShipToLocationVBy(String location) {
		// TODO Auto-generated method stub
		return this.shipToLocationVDao.getShipToLocationBy(location);
	}
}
