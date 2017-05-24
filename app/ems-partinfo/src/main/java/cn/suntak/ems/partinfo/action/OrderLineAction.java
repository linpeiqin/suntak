package cn.suntak.ems.partinfo.action;


import cn.oz.dao.Page;
import cn.oz.web.util.ActionUtils;
import cn.oz.web.util.RequestUtils;
import cn.suntak.ems.common.action.EMSCRUDAction;
import cn.suntak.ems.partinfo.domain.OrderLine;
import cn.suntak.ems.partinfo.service.OrderLineService;

import javax.servlet.http.HttpServletRequest;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class OrderLineAction extends EMSCRUDAction<OrderLine, OrderLineService>{

    @Override
    protected void getPageData(HttpServletRequest request, Page page) throws Exception {
        Long partId = RequestUtils.getLongParameter(request,"partId",-1L);
        if (partId!=-1L)
            this.getService().getPage(page,ActionUtils.getDbftSearchParams(request),getSearchQuery(request),partId);
    }
}