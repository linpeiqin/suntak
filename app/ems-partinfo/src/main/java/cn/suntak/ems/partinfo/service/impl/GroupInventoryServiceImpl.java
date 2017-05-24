package cn.suntak.ems.partinfo.service.impl;


import cn.oz.config.helper.DataDictHelper;
import cn.oz.dao.Page;
import cn.oz.exception.OzException;
import cn.oz.search.SearchQuery;
import cn.oz.service.CRUDServiceImpl;
import cn.oz.util.SelectOption;
import cn.suntak.ems.partinfo.dao.GroupInventoryDao;
import cn.suntak.ems.partinfo.dao.PartQualityDao;
import cn.suntak.ems.partinfo.domain.GroupInventory;
import cn.suntak.ems.partinfo.domain.PartQuality;
import cn.suntak.ems.partinfo.service.GroupInventoryService;
import cn.suntak.ems.partinfo.service.PartQualityService;

import java.util.ArrayList;
import java.util.List;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class GroupInventoryServiceImpl extends CRUDServiceImpl<GroupInventory, Long, GroupInventoryDao> implements GroupInventoryService {

	@Override
	public GroupInventory create() throws OzException {
		return new GroupInventory();
	}

	@Override
	public void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, String partNo) {
		this.getSimpleDao().getPage(page,dbftSearchParams, searchQuery,partNo);
	}
}
