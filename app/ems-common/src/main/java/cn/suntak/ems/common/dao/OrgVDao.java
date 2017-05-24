package cn.suntak.ems.common.dao;

import java.util.List;

import cn.suntak.ems.common.domain.OrgV;

/**
 * Created by Administrator on 2016/12/10.
 */
public interface OrgVDao {

	List<OrgV> getOrgList();

	OrgV getOrgBy(String orgId);

	String getOrgNameBy(String orgId);
}
