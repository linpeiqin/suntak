package cn.suntak.ems.common.service;

import cn.oz.util.SelectOption;
import cn.suntak.ems.common.domain.OrgV;

import java.util.List;

/**
 * Created by Administrator on 2016/12/10.
 */
public interface OrgVService {
    List<SelectOption> getOrgOption();

    OrgV getOrgVBy(String orgId);
    
    String getOrgNameBy(String orgId);
}
