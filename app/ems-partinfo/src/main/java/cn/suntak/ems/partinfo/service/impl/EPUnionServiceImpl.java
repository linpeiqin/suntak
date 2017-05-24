package cn.suntak.ems.partinfo.service.impl;



import cn.oz.dao.Page;
import cn.oz.exception.OzException;
import cn.oz.search.SearchQuery;
import cn.oz.service.CRUDServiceImpl;
import cn.suntak.ems.partinfo.dao.EPUnionDao;
import cn.suntak.ems.partinfo.domain.EPUnion;
import cn.suntak.ems.partinfo.service.EPUnionService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class EPUnionServiceImpl extends CRUDServiceImpl< EPUnion, Long,  EPUnionDao> implements  EPUnionService{

	@Override
	public EPUnion create() throws OzException {
		
		return new EPUnion();
	}

	@Override
	public void getPage(Page page, SearchQuery searchQuery) {
		// TODO Auto-generated method stub
		this.getSimpleDao().getPage(page, searchQuery);
	}



}
