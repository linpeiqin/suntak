package cn.suntak.ems.partinfo.service;

import cn.oz.dao.Page;
import cn.oz.search.SearchQuery;
import cn.oz.service.SimpleService;
import cn.suntak.ems.partinfo.domain.PartInfo;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public interface PartInfoService extends SimpleService<PartInfo, Long>{



    void getPage(Page page, String dbftSearchParams, SearchQuery searchQuery, Long orgId);
    
    PartInfo getPartInfoBy(long partId);
}
