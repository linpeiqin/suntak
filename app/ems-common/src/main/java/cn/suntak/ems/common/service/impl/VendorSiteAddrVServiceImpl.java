package cn.suntak.ems.common.service.impl;

import java.util.ArrayList;
import java.util.List;

import cn.oz.util.SelectOption;
import cn.suntak.ems.common.dao.VendorSiteAddrVDao;
import cn.suntak.ems.common.domain.VendorSiteAddrV;
import cn.suntak.ems.common.service.VendorSiteAddrVService;

/**
 * Created by Administrator on 2016/12/10.
 */
public class VendorSiteAddrVServiceImpl implements VendorSiteAddrVService {


	private VendorSiteAddrVDao vendorSiteAddrVDao;

    public void setVendorSiteAddrVDao(VendorSiteAddrVDao vendorSiteAddrVDao) {
        this.vendorSiteAddrVDao = vendorSiteAddrVDao;
    }

	public List<SelectOption> getAddressOption(Integer vendorId,Integer orgId) {
		// TODO Auto-generated method stub
	    List<SelectOption> selectOptions = new ArrayList<SelectOption>();
        List<VendorSiteAddrV> vendorSiteAddrVs = this.vendorSiteAddrVDao.getAddressList(vendorId,orgId);
        for (VendorSiteAddrV vendorSiteAddrV : vendorSiteAddrVs){
        	selectOptions.add(new SelectOption(vendorSiteAddrV.getAddressShortName(),vendorSiteAddrV.getVendorSiteId()));
        }
        return  selectOptions;
	}

	@Override
	public VendorSiteAddrV getAddressBy(String vendorSiteId) {
		// TODO Auto-generated method stub
		return this.vendorSiteAddrVDao.getAddressBy(vendorSiteId);
	}
}
