package cn.suntak.ems.common.dao.hibernate;

import java.util.ArrayList;
import java.util.List;

import cn.oz.dao.hibernate.HibernateDao;
import cn.suntak.ems.common.dao.VendorSitePersVDao;
import cn.suntak.ems.common.domain.VendorSitePersV;

/**
 * Created by Administrator on 2016/12/10.
 */
public class VendorSitePersVDaoImpl extends HibernateDao<VendorSitePersV,Long> implements VendorSitePersVDao {

	public List<VendorSitePersV> getPeopleList(Integer vendorId,
			String vendorSiteId, Integer orgId) {
		// TODO Auto-generated method stub
		List<Object> args = new ArrayList<Object>();
		String hql = "from VendorSitePersV vendorSitePersV where 1=1 ";
		hql += "and vendorSitePersV.vendorId = ? and org_id = ? and vendor_Site_Id=?";
		args.add(vendorId);
		args.add(orgId);
		args.add(vendorSiteId);
		return this.find(hql,args.toArray());
	}
	
	
	public VendorSitePersV getPeopleBy(String peopleNameId) {
		// TODO Auto-generated method stub
		return this.findUniqueBy("peopleNameId",peopleNameId);
	}
}
