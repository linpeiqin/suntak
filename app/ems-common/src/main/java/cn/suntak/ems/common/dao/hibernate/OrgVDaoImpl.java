package cn.suntak.ems.common.dao.hibernate;

import java.util.List;

import cn.oz.dao.hibernate.HibernateDao;
import cn.suntak.ems.common.dao.OrgVDao;
import cn.suntak.ems.common.domain.OrgV;
import cn.suntak.ems.common.domain.VendorSiteAddrV;

/**
 * Created by Administrator on 2016/12/10.
 */
public class OrgVDaoImpl extends HibernateDao<OrgV, Long> implements OrgVDao {

	@Override
	public List<OrgV> getOrgList() {
		// TODO Auto-generated method stub
        List<OrgV> orgVs = this.loadAll();
        return orgVs;
	}

	@Override
	public OrgV getOrgBy(String orgId) {
		// TODO Auto-generated method stub
		return this.findUniqueBy("orgId",orgId);
	}

	@Override
	public String getOrgNameBy(String orgId) {
		// TODO Auto-generated method stub
		List<OrgV> orgVs = this.loadAll();
		for (OrgV orgV : orgVs){
			if(orgV.getOrgId().equals(orgId))
			{
				return orgV.getOrgName();
			}
		}
		return null;
	}
}
