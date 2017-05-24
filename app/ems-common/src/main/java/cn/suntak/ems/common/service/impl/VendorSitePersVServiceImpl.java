package cn.suntak.ems.common.service.impl;

import java.util.ArrayList;
import java.util.List;

import cn.oz.util.SelectOption;
import cn.suntak.ems.common.dao.VendorSitePersVDao;
import cn.suntak.ems.common.domain.VendorSitePersV;
import cn.suntak.ems.common.service.VendorSitePersVService;

/**
 * Created by Administrator on 2016/12/10.
 */
public class VendorSitePersVServiceImpl implements VendorSitePersVService {


	private VendorSitePersVDao vendorSitePersVDao;

    public void setVendorSitePersVDao(VendorSitePersVDao vendorSitePersVDao) {
        this.vendorSitePersVDao = vendorSitePersVDao;
    }

	public VendorSitePersV getPeopleBy(String peopleNameId) {
		// TODO Auto-generated method stub
		VendorSitePersV vendorSitePersV =  this.vendorSitePersVDao.getPeopleBy(peopleNameId);
		if(vendorSitePersV!=null)
			return vendorSitePersV;
		return null;
	}

	public List<SelectOption> getPeopleOption(Integer vendorId,String vendorSiteId,Integer orgId) {
		// TODO Auto-generated method stub
		List<SelectOption> selectOptions = new ArrayList<SelectOption>();
        List<VendorSitePersV> vendorSitePersVs = this.vendorSitePersVDao.getPeopleList(vendorId,vendorSiteId,orgId);
        for (VendorSitePersV vendorSitePersV : vendorSitePersVs){
        	selectOptions.add(new SelectOption(vendorSitePersV.getPeopleName(),vendorSitePersV.getPeopleNameId()));
        }
        return  selectOptions;
	}
}
