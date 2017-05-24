package cn.suntak.ems.common.service.impl;


import cn.oz.dao.Page;
import cn.oz.search.SearchQuery;
import cn.suntak.ems.common.dao.EmployeesVDao;
import cn.suntak.ems.common.service.EmployeesVService;

/**
 * Created by Administrator on 2016/12/10.
 */
public class EmployeesVServiceImpl implements EmployeesVService {
	private EmployeesVDao employeesVDao;

	public void setEmployeesVDao(EmployeesVDao employeesVDao) {
		this.employeesVDao = employeesVDao;
	}

	@Override
	public void getPage(Page page, String dbftSearchParams,SearchQuery searchQuery) {
		// TODO Auto-generated method stub
		this.employeesVDao.getPage(page,dbftSearchParams,searchQuery);
	}

}
