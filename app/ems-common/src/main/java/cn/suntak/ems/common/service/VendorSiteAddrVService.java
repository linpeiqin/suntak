package cn.suntak.ems.common.service;

import java.util.List;

import cn.oz.util.SelectOption;
import cn.suntak.ems.common.domain.VendorSiteAddrV;



/**
 * Created by Administrator on 2016/12/10.
 */
public interface VendorSiteAddrVService {

    List<SelectOption> getAddressOption(Integer vendorId,Integer orgId);
    VendorSiteAddrV getAddressBy(String vendorSiteId);
}
