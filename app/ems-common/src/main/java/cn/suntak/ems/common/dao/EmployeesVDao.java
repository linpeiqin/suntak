package cn.suntak.ems.common.dao;

import cn.oz.dao.Page;
import cn.oz.search.SearchQuery;
import cn.suntak.ems.common.domain.EmployeeV;

/**
 * Created by Administrator on 2016/12/10.
 */
public interface EmployeesVDao {

	void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery);
}
