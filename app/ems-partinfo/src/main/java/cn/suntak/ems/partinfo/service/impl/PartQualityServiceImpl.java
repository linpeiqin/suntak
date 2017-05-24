package cn.suntak.ems.partinfo.service.impl;



import java.util.ArrayList;
import java.util.List;

import cn.oz.config.helper.DataDictHelper;
import cn.oz.dao.Page;
import cn.oz.exception.OzException;
import cn.oz.search.SearchQuery;
import cn.oz.service.CRUDServiceImpl;
import cn.oz.util.SelectOption;
import cn.suntak.ems.partinfo.dao.PartQualityDao;
import cn.suntak.ems.partinfo.domain.PartQuality;
import cn.suntak.ems.partinfo.service.PartQualityService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class PartQualityServiceImpl extends CRUDServiceImpl< PartQuality, Long, PartQualityDao> implements PartQualityService{

	@Override
	public PartQuality create() throws OzException {
		
		return new PartQuality();
	}
	public List<SelectOption> getQualityType() {
		List<SelectOption> selectOptions = new ArrayList<SelectOption>();
		SelectOption[] dict = DataDictHelper.getOptions("ZLPJ", null, true, true);
		for(int i=0;i<dict.length;i++)
		{
			selectOptions.add(dict[i]);
		}
		return selectOptions;
	}
	@Override
	public void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long partId) {
		this.getSimpleDao().getPage(page,dbftSearchParams, searchQuery,partId);
	}
}
