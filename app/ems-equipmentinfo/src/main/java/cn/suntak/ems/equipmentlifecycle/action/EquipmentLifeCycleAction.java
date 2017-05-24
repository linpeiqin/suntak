package cn.suntak.ems.equipmentlifecycle.action;


import javax.servlet.http.HttpServletRequest;

import cn.oz.AppContext;
import cn.oz.FileEntity;
import cn.oz.UserContext;
import cn.oz.UserContextHolder;
import cn.oz.org.json.JSONObject;
import cn.oz.security.PermissionVerifier;
import cn.oz.service.SimpleService;
import cn.suntak.ems.equipmentlifecycle.domain.EMSEntity;
import org.apache.struts.action.ActionForm;

import cn.oz.config.helper.DataDictHelper;
import cn.oz.dao.Page;
import cn.oz.web.util.ActionUtils;
import cn.oz.web.util.RequestUtils;
import cn.suntak.ems.common.action.EMSCRUDAction;
import cn.suntak.ems.equipmentlifecycle.domain.EquipmentLifeCycle;
import cn.suntak.ems.equipmentlifecycle.service.EquipmentLifeCycleService;

import java.lang.reflect.Field;
import java.util.Date;

/**
 * 
 * @author linking
 * @version 1.0.0
 * @since 1.0.0
 */
public class EquipmentLifeCycleAction  extends EMSCRUDAction<EquipmentLifeCycle, EquipmentLifeCycleService>{

    @Override
    protected void beforeDisplay(HttpServletRequest request, ActionForm form)
            throws Exception {
        request.setAttribute("lifeCycleSelect", DataDictHelper.getOptions("LIFE-CYCLE",null,true,false));
    }

    @Override
    protected void getPageData(HttpServletRequest request, Page page) throws Exception {
        Long equipmentId = RequestUtils.getLongParameter(request,"equipmentId",-1L);
        if (equipmentId!=-1L)
            this.getService().getPage(page,ActionUtils.getDbftSearchParams(request),getSearchQuery(request),equipmentId);
    }

    @Override
    protected void afterSubmitEBS(Long id, String fileName, cn.oz.json.JSONObject json) {
        String serviceName = fileName+"Service";
        SimpleService service = AppContext.getServiceFactory().getService(serviceName);
        FileEntity entity = (FileEntity) service.load(id);
        if(entity instanceof EMSEntity){
            Field field = null ;
            try {
                field = entity.getClass().getDeclaredField("equipmentLifeCycle");
                field.setAccessible(true);
                EquipmentLifeCycle lifeCycle = (EquipmentLifeCycle) field.get(entity);
                lifeCycle.setEbsDate(new Date());
                lifeCycle.setEbsType(1);
                this.getService().save(lifeCycle);
            } catch (NoSuchFieldException e) {
                e.printStackTrace();
            } catch (SecurityException e) {
                e.printStackTrace();
            } catch (IllegalArgumentException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            }
        }

        super.afterSubmitEBS(id, fileName,json);
    }
    private PermissionVerifier eqAdminVerifier=null;

    @Override
    public void initAction() {
        this.eqAdminVerifier = this.getServiceBean("eqAdminVerifier");
        super.initAction();
    }

    @Override
    protected String getViewToolbarBtns(HttpServletRequest request, ActionForm form) {

        if (this.eqAdminVerifier.verify(UserContextHolder.get().getCurUser())){
            return "btnNewLifeCycleSelect,btnAddLifeCycle";
        }
        return "null";
    }
}