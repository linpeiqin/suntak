package cn.suntak.ems.common.service;

import java.util.List;

import cn.oz.util.SelectOption;
import cn.suntak.ems.common.domain.VendorSitePersV;



/**
 * Created by Administrator on 2016/12/10.
 */
public interface VendorSitePersVService {


	VendorSitePersV getPeopleBy(String peopleNameId);

	List<SelectOption> getPeopleOption(Integer vendorId, String vendorSiteId,Integer orgId);
}
