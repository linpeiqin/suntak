package cn.suntak.ems.common.dao;

import java.util.List;

import cn.suntak.ems.common.domain.VendorSiteAddrV;

/**
 * Created by Administrator on 2016/12/10.
 */
public interface VendorSiteAddrVDao {


	List<VendorSiteAddrV> getAddressList(Integer vendorId, Integer orgId);

	VendorSiteAddrV getAddressBy(String vendorSiteId);
}
