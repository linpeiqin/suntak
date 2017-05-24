package cn.suntak.ems.common.service.impl;

import java.util.ArrayList;
import java.util.List;

import cn.oz.util.SelectOption;
import cn.suntak.ems.common.dao.OrgVDao;
import cn.suntak.ems.common.domain.OrgV;
import cn.suntak.ems.common.service.OrgVService;

/**
 * Created by Administrator on 2016/12/10.
 */
public class OrgVServiceImpl implements OrgVService
{
	private OrgVDao orgVDao;

    public void setOrgVDao(OrgVDao orgVDao) {
        this.orgVDao = orgVDao;
    }
	@Override
	public List<SelectOption> getOrgOption() {
		// TODO Auto-generated method stub
        List<SelectOption> selectOptions = new ArrayList<SelectOption>();
        List<OrgV> orgVs = this.orgVDao.getOrgList();
        selectOptions.add(new SelectOption("",""));
        for (OrgV orgV : orgVs){
            selectOptions.add(new SelectOption(orgV.getOrgName(),orgV.getOrgId()));
        }
        return  selectOptions;
	}

	@Override
	public OrgV getOrgVBy(String orgId) {
		// TODO Auto-generated method stub
		return this.orgVDao.getOrgBy(orgId);
	}
	@Override
	public String getOrgNameBy(String orgId) {
		// TODO Auto-generated method stub
		return this.orgVDao.getOrgNameBy(orgId);
	}
}
