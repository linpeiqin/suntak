package cn.suntak.ems.common.service;

import cn.oz.util.SelectOption;
import cn.suntak.ems.common.domain.ShipToLocationV;

import java.util.List;

/**
 * Created by Administrator on 2016/12/10.
 */
public interface ShipToLocationVService {

    List<SelectOption> getShipToLocationOption();

    ShipToLocationV getShipToLocationVBy(String location);
}
