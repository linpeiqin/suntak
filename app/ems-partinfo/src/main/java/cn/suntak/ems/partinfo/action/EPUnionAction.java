package cn.suntak.ems.partinfo.action;


import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;

import cn.oz.web.struts.action.CRUD2Action;
import cn.oz.web.util.RequestUtils;
import cn.suntak.ems.partinfo.domain.EPUnion;
import cn.suntak.ems.partinfo.service.EPUnionService;
import cn.suntak.ems.partinfo.service.PartInfoService;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class EPUnionAction extends CRUD2Action<EPUnion, EPUnionService> {
    private PartInfoService partInfoService;

    @Override
    public void initAction() {
        super.initAction();
        this.partInfoService =  this.getServiceBean("partInfoService");
    }

    @Override
    protected void save(HttpServletRequest request, ActionForm form, EPUnion domain) throws Exception {
        Long equipmentId = RequestUtils.getLongParameter(request,"equipmentId",-1L);
        Long parInfoId = RequestUtils.getLongParameter(request,"parInfoId",-1L);
        if (equipmentId!=-1L)
          domain.setEquipmentId(equipmentId);
        if (parInfoId!=-1L)
            domain.getPartInfos().add(this.partInfoService.load(parInfoId));
        this.getService().save(domain);
    }


}