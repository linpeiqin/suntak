package cn.suntak.ems.equipmentrepair.service.impl;



import java.util.ArrayList;
import java.util.List;

import cn.oz.config.helper.DataDictHelper;
import cn.oz.dao.Page;
import cn.oz.exception.OzException;
import cn.oz.search.SearchQuery;
import cn.oz.service.CRUDServiceImpl;
import cn.oz.util.SelectOption;
import cn.suntak.ems.equipmentrepair.dao.FaultDescDao;
import cn.suntak.ems.equipmentrepair.domain.FaultDesc;
import cn.suntak.ems.equipmentrepair.service.FaultDescService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class FaultDescServiceImpl extends CRUDServiceImpl< FaultDesc, Long,  FaultDescDao> implements  FaultDescService{
	private FaultDescDao faultDescDao;

	public void setFaultDescDao(FaultDescDao faultDescDao) {
		this.faultDescDao = faultDescDao;
	}
	public FaultDesc create() throws OzException {
		
		return new FaultDesc();
	}

	@Override
	public List<SelectOption> getFaultType() {
		List<SelectOption> selectOptions = new ArrayList<SelectOption>();
		SelectOption[] dict = DataDictHelper.getOptions("GZLB", null, true, true);
		for(int i=0;i<dict.length;i++)
		{
			selectOptions.add(dict[i]);
		}
		return selectOptions;
	}

	@Override
	public void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery) {
		this.faultDescDao.getPage(page,dbftSearchParams,searchQuery);
	}
}
