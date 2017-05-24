package cn.suntak.ems.common.service.impl;

import cn.oz.dao.Page;
import cn.oz.search.SearchQuery;
import cn.suntak.ems.common.dao.SuppliersVDao;
import cn.suntak.ems.common.domain.SuppliersV;
import cn.suntak.ems.common.service.SuppliersVService;

public class SuppliersVServiceImpl implements SuppliersVService {
    private SuppliersVDao suppliersVDao;

    public void setSuppliersVDao(SuppliersVDao suppliersVDao) {
        this.suppliersVDao = suppliersVDao;
    }

    @Override
    public void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery) {
        this.suppliersVDao.getPage(page,dbftSearchParams,searchQuery);
    }

	@Override
	public SuppliersV getSupplierVBy(Integer vendorId) {
		// TODO Auto-generated method stub
		return this.suppliersVDao.getSupplierVBy(vendorId);
	}
}
