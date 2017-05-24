package cn.suntak.ems.common.dao.hibernate;

import java.util.ArrayList;
import java.util.List;

import cn.oz.dao.hibernate.HibernateDao;
import cn.suntak.ems.common.dao.VendorSiteAddrVDao;
import cn.suntak.ems.common.domain.VendorSiteAddrV;

/**
 * Created by Administrator on 2016/12/10.
 */
public class VendorSiteAddrVDaoImpl extends HibernateDao<VendorSiteAddrV,Long> implements VendorSiteAddrVDao {

	@Override
	public List<VendorSiteAddrV> getAddressList(Integer vendorId, Integer orgId) {
		// TODO Auto-generated method stub
		List<Object> args = new ArrayList<Object>();
		String hql = "from VendorSiteAddrV vendorSiteAddrV where 1=1 ";
		hql += "and vendorSiteAddrV.vendorId = ? and org_id = ?";
		args.add(vendorId);
		args.add(orgId);
		return this.find(hql,args.toArray());
	}

	@Override
	public VendorSiteAddrV getAddressBy(String vendorSiteId) {
		// TODO Auto-generated method stub
		return this.findUniqueBy("vendorSiteId",vendorSiteId);
	}

}
