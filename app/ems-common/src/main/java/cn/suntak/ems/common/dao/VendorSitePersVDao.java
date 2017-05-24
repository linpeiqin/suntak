package cn.suntak.ems.common.dao;

import java.util.List;

import cn.suntak.ems.common.domain.VendorSitePersV;

/**
 * Created by Administrator on 2016/12/10.
 */
public interface VendorSitePersVDao {


	List<VendorSitePersV> getPeopleList(Integer vendorId, String vendorSiteId,
			Integer orgId);


	VendorSitePersV getPeopleBy(String peopleNameId);
}
