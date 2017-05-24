package cn.suntak.ems.partinfo.service.impl;



import cn.oz.dao.Page;
import cn.oz.exception.OzException;
import cn.oz.search.SearchQuery;
import cn.oz.service.CRUDServiceImpl;
import cn.suntak.ems.partinfo.dao.PartInfoDao;
import cn.suntak.ems.partinfo.domain.PartInfo;
import cn.suntak.ems.partinfo.service.PartInfoService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class PartInfoServiceImpl extends CRUDServiceImpl< PartInfo, Long,  PartInfoDao> implements  PartInfoService{

	@Override
	public PartInfo create() throws OzException {
		return new PartInfo();
	}



	@Override
	public void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long orgId) {
		this.getSimpleDao().getPage(page, dbftSearchParams,searchQuery,orgId);
	}



	@Override
	public PartInfo getPartInfoBy(long partId) {
		// TODO Auto-generated method stub
		return this.simpleDao.getPartInfoBy(partId);
	}
}
