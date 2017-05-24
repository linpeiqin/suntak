package cn.suntak.ems.common.service;


import cn.oz.dao.Page;
import cn.oz.search.SearchQuery;
import cn.suntak.ems.common.domain.SuppliersV;

public interface SuppliersVService {

    void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery);

	SuppliersV getSupplierVBy(Integer vendorId);
}
