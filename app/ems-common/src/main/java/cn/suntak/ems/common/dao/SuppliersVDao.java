package cn.suntak.ems.common.dao;

import cn.oz.dao.Page;
import cn.oz.search.SearchQuery;
import cn.suntak.ems.common.domain.SuppliersV;

import java.util.List;

public interface SuppliersVDao {
    List<SuppliersV> getSuppliersList();

    void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery);

	SuppliersV getSupplierVBy(Integer vendorId);

}

