package cn.suntak.ems.common.service;

import cn.oz.dao.Page;
import cn.oz.search.SearchQuery;


/**
 * Created by Administrator on 2016/12/10.
 */
public interface EmployeesVService {
    void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery);
}
