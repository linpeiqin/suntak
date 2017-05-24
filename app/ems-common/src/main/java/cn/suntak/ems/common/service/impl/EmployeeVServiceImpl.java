package cn.suntak.ems.common.service.impl;


import cn.suntak.ems.common.dao.EmployeeVDao;
import cn.suntak.ems.common.domain.EmployeeV;
import cn.suntak.ems.common.service.EmployeeVService;
import cn.oz.dao.Page;
import cn.oz.search.SearchQuery;

/**
 * Created by Administrator on 2016/12/10.
 */
public class EmployeeVServiceImpl implements EmployeeVService {
	private EmployeeVDao employeeVDao;

	public void setEmployeeVDao(EmployeeVDao employeeVDao) {
		this.employeeVDao = employeeVDao;
	}

	public void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery) {
		this.employeeVDao.getPage(page,dbftSearchParams,searchQuery);
	}

	@Override
	public EmployeeV getEmployeeBy(Long personId) {
		// TODO Auto-generated method stub
		return this.employeeVDao.getEmployeeBy(personId);
	}
}
